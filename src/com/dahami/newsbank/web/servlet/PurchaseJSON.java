package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.dahami.common.util.HttpUtil;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dao.UsageDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.dto.UsageDTO;

/**
 * Servlet implementation class PurchaseJSON 결제 정보 호출
 */
@WebServlet("/purchase.api")
public class PurchaseJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
	public static final SimpleDateFormat DATE_TIME_FORMAT = new SimpleDateFormat("yyyyMMddHHmmss");

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public PurchaseJSON() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();

		MemberDTO MemberInfo = null;

		JSONObject json = new JSONObject();
		boolean result = true;
		String message = null;

		if (session.getAttribute("MemberInfo") == null) {
			result = false;
			message = "로그인이 필요합니다.";
		}

		Map<String, Object> LGD_DATA = new HashMap<String, Object>();

		
		List<PaymentDetailDTO> DetailList =new ArrayList<PaymentDetailDTO>();

		int LGD_AMOUNT = 0;
		String LGD_CUSTOM_USABLEPAY = "";
		String ORDER_TYPE = "";

		if (request.getParameter("orderJson") != null) {
			String orderJson = request.getParameter("orderJson"); // json

			UsageDAO usageDAO = new UsageDAO();
			//List<UsageDTO> usageList = usageDAO.usageList(0); // 주문 가능 제품 전체
			List<UsageDTO> usageList = usageDAO.usageList(); // 주문 가능 제품 전체 (사용용도: 일반회원+후불회원)

			try {
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObj = (JSONObject) jsonParser.parse(orderJson);
				JSONArray orderArray = (JSONArray) jsonObj.get("order");

				if (jsonObj.get("LGD_CUSTOM_USABLEPAY") != null) {
					LGD_CUSTOM_USABLEPAY = jsonObj.get("LGD_CUSTOM_USABLEPAY").toString();
					System.out.println("LGD_CUSTOM_USABLEPAY : " + jsonObj.get("LGD_CUSTOM_USABLEPAY"));
				}
				
				if (jsonObj.get("orderType") != null) {
					ORDER_TYPE = jsonObj.get("orderType").toString();
				}

				if (orderArray != null) {
					for (int i = 0; i < orderArray.size(); i++) {
						JSONObject tempObj = (JSONObject) orderArray.get(i);
						PaymentDetailDTO paymentDetail = new PaymentDetailDTO();
						paymentDetail.setPhoto_uciCode(tempObj.get("uciCode").toString());
						paymentDetail.setPrice(Integer.parseInt(tempObj.get("price").toString()));
						paymentDetail.setUsageList_seq(Integer.parseInt(tempObj.get("usage").toString()));
						DetailList.add(paymentDetail);
						int index = Integer.parseInt(tempObj.get("usage").toString());
						int AMOUNT = Integer.parseInt(tempObj.get("price").toString());
						LGD_AMOUNT += AMOUNT;
						System.out.println("" + (i + 1) + "uciCode : " + tempObj.get("uciCode"));
						System.out.println("" + (i + 1) + "price : " + tempObj.get("price"));
						System.out.println("" + (i + 1) + "copyright : " + tempObj.get("copyright"));
						System.out.println("" + (i + 1) + "usage : " + tempObj.get("usage"));
						System.out.println("----------------------------");
						System.out.println(LGD_AMOUNT + " : " + usageList.get(index - 1).getPrice());
						
						int usagePrice = getUsagePrice(usageList, index);
						
						if (AMOUNT != usagePrice) {
							result = false;
							message = "요청한 금액이 올바르지 않습니다.";
						}

					}
				} else {
					result = false;
					message = "요청한 결제 정보가 올바르지 않습니다.";
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			result = false;
			message = "필요한 요청변수가 없습니다.";
		}

		if (result) {
			// 로그인중 처리
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
			Date today = new Date();
			Date tomorrow = new Date(new Date().getTime() + 60*60*24*1000);
			String LGD_TIMESTAMP = DATE_TIME_FORMAT.format(today);// 타임스탬프
			String LGD_CLOSEDATE = DATE_TIME_FORMAT.format(tomorrow);
			
			String LGD_BUYERIP =getClientIP(request); //request.getRemoteAddr(); // 구매자 아이피
			String LGD_BUYERID = MemberInfo.getId(); // 구매자 아이디
			String LGD_BUYER = MemberInfo.getName(); // 구매자 명
			String LGD_BUYEREMAIL = MemberInfo.getEmail(); // 구매자 이메일
			String LGD_BUYERPHONE = MemberInfo.getPhone(); // 구매자 이메일
			String LGD_OID = LGD_BUYERID + "_" + LGD_TIMESTAMP; // 주문번호(상점정의 유니크한 주문번호를 입력하세요)
			String LGD_PRODUCTINFO = LGD_BUYER + "(" + LGD_BUYERID + ")_" + LGD_AMOUNT + "_구매"; // 상품명

			String CST_PLATFORM = "test";// LG유플러스 결제서비스 선택(test:테스트, service:서비스)
			String CST_MID = "dahaminewsbank"; // LG유플러스로 부터 발급받으신 상점아이디를 입력하세요.
			String LGD_MID = ("test".equals(CST_PLATFORM.trim()) ? "t" : "") + CST_MID; // 테스트 아이디는 't'를 제외하고 입력하세요.
			String LGD_MERTKEY = "49bd4da3b4414d8396a591a1c9565bbd";// 상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)

			String LGD_ENCODING = "UTF-8";

			/*
			 *************************************************
			 * 2. MD5 해쉬암호화 (수정하지 마세요) - BEGIN
			 *
			 * MD5 해쉬암호화는 거래 위변조를 막기위한 방법입니다.
			 *************************************************
			 *
			 * 해쉬 암호화 적용( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
			 * LGD_MID : 상점아이디 LGD_OID : 주문번호 LGD_AMOUNT : 금액 LGD_TIMESTAMP : 타임스탬프
			 * LGD_MERTKEY : 상점MertKey (mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
			 *
			 * MD5 해쉬데이터 암호화 검증을 위해 LG유플러스에서 발급한 상점키(MertKey)를 환경설정
			 * 파일(lgdacom/conf/mall.conf)에 반드시 입력하여 주시기 바랍니다.
			 */

			String LGD_HASHDATA = md5(LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY);
			
			//String SERVER_HOST  ="www.dev.newsbank.co.kr";//"localhost:8080";//www.newsbank.co.kr//www.dev.newsbank.co.kr
			String SERVER_HOST  =request.getServerName()+":"+request.getServerPort();

			/*
			 * 가상계좌(무통장) 결제 연동을 하시는 경우 아래 LGD_CASNOTEURL 을 설정하여 주시기 바랍니다.
			 */
			// String LGD_CASNOTEURL = "http://www.newsbank.co.kr/Noteurl.Xpay";
			String LGD_CASNOTEURL = "http://"+SERVER_HOST+"/Noteurl.Xpay";

			/*
			 * LGD_RETURNURL 을 설정하여 주시기 바랍니다. 반드시 현재 페이지와 동일한 프로트콜 및 호스트이어야 합니다. 아래 부분을 반드시
			 * 수정하십시요.
			 */
			// String LGD_RETURNURL = "http://www.newsbank.co.kr/Returnurl.Xpay";// FOR
			// MANUAL
			String LGD_RETURNURL = "http://"+SERVER_HOST+"/Returnurl.Xpay";// FOR MANUAL

			LGD_DATA.put("CST_MID", CST_MID); // *LG U+와 계약시 설정한 상점아이디
			LGD_DATA.put("LGD_VERSION", "JSP_Non-ActiveX_Standard"); // 사용 모듈 정보
			LGD_DATA.put("LGD_PAYKEY", ""); // LG유플러스 PAYKEY(인증후 자동셋팅)
			LGD_DATA.put("LGD_BUYEREMAIL", LGD_BUYEREMAIL); // 구매자 이메일
			LGD_DATA.put("LGD_CUSTOM_USABLEPAY", LGD_CUSTOM_USABLEPAY); // 상점정의 결제 가능 수단
			LGD_DATA.put("CST_PLATFORM", CST_PLATFORM); // *테스트, 서비스 구분
			LGD_DATA.put("LGD_WINDOW_TYPE", "iframe"); // 결제창 호출 방식
			LGD_DATA.put("LGD_TIMESTAMP", LGD_TIMESTAMP); // * 타임 스탬프 거래 위변조 방지용
			LGD_DATA.put("LGD_RETURNURL", LGD_RETURNURL); // *인증결과 응답수신페이지 URL
			LGD_DATA.put("LGD_RESPMSG", ""); // 응답 메시지
			LGD_DATA.put("LGD_BUYER", LGD_BUYER); // * 구매자명
			LGD_DATA.put("LGD_CUSTOM_SWITCHINGTYPE", "IFRAME"); //
			LGD_DATA.put("LGD_PRODUCTINFO", LGD_PRODUCTINFO); // * 제품정보
			
			LGD_DATA.put("LGD_CASNOTEURL", LGD_CASNOTEURL); // 무통장입금 결과 수신페이지
			LGD_DATA.put("LGD_CLOSEDATE", LGD_CLOSEDATE); // 무통장입금 마감시간
			
			LGD_DATA.put("LGD_OID", LGD_OID); // * 상점 거래번호
			LGD_DATA.put("LGD_HASHDATA", LGD_HASHDATA); // *해쉬데이터 거래 위변조 방지
			LGD_DATA.put("LGD_OSTYPE_CHECK", "P"); // LGD_OSTYPE_CHECK
			LGD_DATA.put("LGD_RESPCODE", ""); // 응답코드
			LGD_DATA.put("LGD_AMOUNT", LGD_AMOUNT); // *결제금액
			LGD_DATA.put("LGD_MID", LGD_MID); // *회사 코드

			LGD_DATA.put("LGD_WINDOW_TYPE", "iframe"); // 창 띄우기 타입
			LGD_DATA.put("LGD_CUSTOM_PROCESSTYPE", "TWOTR"); // 상점정의 프로세스 타입

			LGD_DATA.put("LGD_ESCROW_USEYN", "N"); // 에스크로 사용안함
			LGD_DATA.put("LGD_ACTIVEXYN", "N"); // 엑티브 x 사용여부

			LGD_DATA.put("LGD_BUYERID", LGD_BUYERID); // *구매자 아이디
			LGD_DATA.put("LGD_BUYERIP", LGD_BUYERIP); // *구매자 아이피

			LGD_DATA.put("LGD_ENCODING", LGD_ENCODING);
			LGD_DATA.put("LGD_ENCODING_NOTEURL", LGD_ENCODING);
			LGD_DATA.put("LGD_ENCODING_RETURNURL", LGD_ENCODING);
			
			LGD_DATA.put("ORDER_TYPE", ORDER_TYPE);
			
			
			
			

			//결제 정보 요청 저장
			PaymentManageDTO payment = new PaymentManageDTO();
			payment.setMember_seq(MemberInfo.getSeq());
			payment.setLGD_BUYER(LGD_BUYER);
			payment.setLGD_BUYERID(LGD_BUYERID);
			payment.setLGD_BUYERPHONE(LGD_BUYERPHONE);
			payment.setLGD_OID(LGD_OID);
			payment.setLGD_RESPCODE("9999");
			payment.setLGD_RESPMSG("결제요청");
			payment.setLGD_AMOUNT(LGD_AMOUNT);
			payment.setLGD_PAYSTATUS(2);
			payment.setLGD_PRODUCTINFO(LGD_PRODUCTINFO);
			payment.setLGD_PAYDATE(LGD_TIMESTAMP);
			payment.setLGD_PAYTYPE(LGD_CUSTOM_USABLEPAY);
			PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
			int paymentManage_seq = paymentDAO.insertPaymentManage(payment,DetailList);
			System.out.println(paymentManage_seq);
			if (paymentManage_seq > 0) {
				// 등록 성공

			}

		}

		json.put("success", result);
		json.put("message", message);
		json.put("data", LGD_DATA);

		response.getWriter().print(json);

	}
	
	// usageList_seq에 대한 price 반환
	public static int getUsagePrice(List<UsageDTO> usageList, int index) {
		int price = 0;
		
		for(UsageDTO usage : usageList) {
			if(usage.getUsageList_seq() == index) {
				price = usage.getPrice();
			}
		}
		
		return price;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	/*
	 * 
	 * MD5 암호화
	 * 
	 */
	public static final String md5(final String s) {
		try {
			// Create MD5 Hash
			MessageDigest digest = java.security.MessageDigest.getInstance("MD5");
			digest.update(s.getBytes());
			byte messageDigest[] = digest.digest();

			// Create Hex String
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < messageDigest.length; i++) {
				String h = Integer.toHexString(0xFF & messageDigest[i]);
				while (h.length() < 2)
					h = "0" + h;
				hexString.append(h);
			}
			return hexString.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
	}

	public static Date parseDateTime(String dateStr) {
		try {
			return DATE_TIME_FORMAT.parse(dateStr);
		} catch (ParseException e) {
			return null;
		}
	}
	
	 public String getClientIP(HttpServletRequest request) {

	     String ip = request.getHeader("X-FORWARDED-FOR"); 
	     
	     if (ip == null || ip.length() == 0) {
	         ip = request.getHeader("Proxy-Client-IP");
	     }

	     if (ip == null || ip.length() == 0) {
	         ip = request.getHeader("WL-Proxy-Client-IP");  // 웹로직
	     }

	     if (ip == null || ip.length() == 0) {
	         ip = request.getRemoteAddr() ;
	     }
	     
	     return ip;

	 }



}
