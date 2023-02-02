package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.CalculationDAO;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.CalculationDTO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

import lgdacom.XPayClient.XPayClient;

/**
 * Servlet implementation class XpayReturnurl
 */
@WebServlet("/Payres.Xpay")
public class XpayPayres extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public XpayPayres() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		if(response.isCommitted()) {
			return;
		}

		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		/*
		 * [최종결제요청 페이지(STEP2-2)]
		 *
		 * 매뉴얼 "5.1. XPay 결제 요청 페이지 개발"의 "단계 5. 최종 결제 요청 및 요청 결과 처리" 참조
		 *
		 * LG유플러스으로 부터 내려받은 LGD_PAYKEY(인증Key)를 가지고 최종 결제요청.(파라미터 전달시 POST를 사용하세요)
		 */

		/*
		 * ※ 중요 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다. 해당 환경파일이 외부에 노출이 되는 경우 해킹의
		 * 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 예) [Window 계열]
		 * C:\inetpub\wwwroot\lgdacom ==> 절대불가(웹 디렉토리)
		 */

		// String configPath = "C:/lgdacom"; //LG유플러스에서 제공한
		// 환경파일("/conf/lgdacom.conf,/conf/mall.conf") 위치 지정.
		String realPath = request.getSession().getServletContext().getRealPath("/"); // request.getRealPath("/");
		String configPath = realPath + "lgdacom"; // LG텔레콤에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.

		/*
		 *************************************************
		 * 1.최종결제 요청 - BEGIN (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
		 *************************************************
		 */

		String CST_PLATFORM = request.getParameter("CST_PLATFORM");
		String CST_MID = request.getParameter("CST_MID");
		String LGD_MID = ("test".equals(CST_PLATFORM.trim()) ? "t" : "") + CST_MID;
		String LGD_PAYKEY = request.getParameter("LGD_PAYKEY");

		String orderType = request.getParameter("ORDER_TYPE");

		int PAYSTATUS = 0;

		// 해당 API를 사용하기 위해 WEB-INF/lib/XPayClient.jar 를 Classpath 로 등록하셔야 합니다.
		// (1) XpayClient의 사용을 위한 xpay 객체 생성
		XPayClient xpay = new XPayClient();

		// (2) Init: XPayClient 초기화(환경설정 파일 로드)
		// configPath: 설정파일
		// CST_PLATFORM: - test, service 값에 따라 lgdacom.conf의 test_url(test) 또는
		// url(srvice) 사용
		// - test, service 값에 따라 테스트용 또는 서비스용 아이디 생성
		boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);

		if (!isInitOK) {
			// API 초기화 실패 화면처리
			System.out.println("결제요청을 초기화 하는데 실패하였습니다.<br>");
			System.out.println("LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.<br>");
			System.out.println("mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.<br><br>");
			System.out.println("문의전화 LG유플러스 1544-7772<br>");
			return;

		} else {
			try {

				// (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
				xpay.Init_TX(LGD_MID);
				xpay.Set("LGD_TXNAME", "PaymentByKey");
				xpay.Set("LGD_PAYKEY", LGD_PAYKEY);

				// 금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
				// String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
				// xpay.Set("LGD_AMOUNTCHECKYN", "Y");
				// xpay.Set("LGD_AMOUNT", DB_AMOUNT);

			} catch (Exception e) {
				System.out.println("LG유플러스 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
				System.out.println("" + e.getMessage());
				return;
			}
		}
		/*
		 *************************************************
		 * 1.최종결제 요청(수정하지 마세요) - END
		 *************************************************
		 */

		/*
		 * 2. 최종결제 요청 결과처리
		 *
		 * 최종 결제요청 결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
		 */
		// (4) TX: lgdacom.conf에 설정된 URL로 소켓 통신하여 최종 인증요청, 결과값으로 true, false 리턴
		if (xpay.TX()) {
			// 1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
			System.out.println("결제요청이 완료되었습니다.  <br>");
			System.out.println("TX 결제요청 통신 응답코드 = " + xpay.m_szResCode + "<br>"); // 통신 응답코드("0000" 일 때 통신 성공)
			System.out.println("TX 결제요청 통신 응답메시지 = " + xpay.m_szResMsg + "<p>"); // 통신 응답메시지

			System.out.println("거래번호 : " + xpay.Response("LGD_TID", 0) + "<br>");
			System.out.println("상점아이디 : " + xpay.Response("LGD_MID", 0) + "<br>");
			System.out.println("상점주문번호 : " + xpay.Response("LGD_OID", 0) + "<br>");
			System.out.println("결제금액 : " + xpay.Response("LGD_AMOUNT", 0) + "<br>");
			System.out.println("결과코드 : " + xpay.Response("LGD_RESPCODE", 0) + "<br>"); // LGD_RESPCODE 가 반드시 "0000" 일때만 결제 성공, 그 외는 모두 실패
			System.out.println("결과메세지 : " + xpay.Response("LGD_RESPMSG", 0) + "<p>");

			for (int i = 0; i < xpay.ResponseNameCount(); i++) {
				System.out.println(xpay.ResponseName(i) + " = ");
				for (int j = 0; j < xpay.ResponseCount(); j++) {
					System.out.println("\t" + xpay.Response(xpay.ResponseName(i), j) + "<br>");
				}
			}
			System.out.println("<p>");

			// (5) DB에 인증요청 결과 처리
			if ("0000".equals(xpay.m_szResCode)) {
				// 통신상의 문제가 없을시
				// 최종결제요청 결과 성공 DB처리(LGD_RESPCODE 값에 따라 결제가 성공인지, 실패인지 DB처리)
				System.out.println("최종결제요청 성공, DB처리하시기 바랍니다.<br>");

				// 최종결제요청 결과를 DB처리합니다. (결제성공 또는 실패 모두 DB처리 가능)
				// 상점내 DB에 어떠한 이유로 처리를 하지 못한경우 false로 변경해 주세요.
				boolean isDBOK = true;
				if (xpay.Response("LGD_PAYTYPE", 0).equals("SC0040") && xpay.Response("LGD_CASFLAG", 0).equals("R")) { // 무통장입금 계좌번호 발급

					if (isDBOK) {
						PAYSTATUS = 3;
						PaymentManageDTO payment = new PaymentManageDTO();
						payment.setLGD_BUYERID(xpay.Response("LGD_BUYERID", 0));// 아이디
						payment.setLGD_OID(xpay.Response("LGD_OID", 0)); // 주문번호
						payment.setLGD_PAYSTATUS(PAYSTATUS);// 1:결제성공 0:결제실패 2:결제대기중 3:무통장입금 대기중
						payment.setLGD_RESPCODE(xpay.m_szResCode); // 결제상태
						payment.setLGD_RESPMSG(xpay.m_szResMsg); // 결제메세지
						payment.setLGD_TID(xpay.Response("LGD_TID", 0)); // 거래번호
						payment.setLGD_FINANCENAME(xpay.Response("LGD_FINANCENAME", 0)); // 은행명
						payment.setLGD_ACCOUNTNUM(xpay.Response("LGD_ACCOUNTNUM", 0)); // 은행계좌번호

						PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
						paymentDAO.updatePaymentManage(payment);
						// PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
						// int paymentManage_seq = paymentDAO.insertPaymentManage(payment,DetailList);
						// PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결

					}
				} else { // 신용카드,계좌이체
					if (isDBOK) {
						PAYSTATUS = 1;
						// #########5.payment 결제성공으로 update
						PaymentManageDTO payment = new PaymentManageDTO();
						payment.setLGD_BUYERID(xpay.Response("LGD_BUYERID", 0));// 아이디
						payment.setLGD_OID(xpay.Response("LGD_OID", 0)); // 주문번호
						payment.setLGD_PAYSTATUS(PAYSTATUS);// 1:결제성공 0:결제실패 2:결제대기중 3:무통장입금 대기중
						payment.setLGD_RESPCODE(xpay.m_szResCode); // 결제상태
						payment.setLGD_RESPMSG(xpay.m_szResMsg); // 결제메세지
						payment.setLGD_TID(xpay.Response("LGD_TID", 0)); // 거래번호

						PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
						payment = paymentDAO.updatePaymentManage(payment);

						PaymentDetailDTO paymentDetail = new PaymentDetailDTO();
						paymentDetail.setPaymentManage_seq(payment.getPaymentManage_seq());

						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						Calendar Cal = Calendar.getInstance();
						String startDate = df.format(Cal.getTime());
						Cal.add(Calendar.DATE, 1); // 오늘 포함 일주일
						String endDate = df.format(Cal.getTime());

						paymentDetail.setDownStart(startDate); // 다운로드 start date
						paymentDetail.setDownEnd(endDate); // 다운로드 end date
						paymentDAO.updateDownloadDate(paymentDetail);

						if (orderType != null && orderType.equalsIgnoreCase("cart")) {
							paymentDAO.deletePaymentCart(payment);
						}
						
						
						if(payment.getPaymentDetailList().size()>0) {
							CalculationDAO calculationDAO = new CalculationDAO();
							PhotoDAO photoDAO = new PhotoDAO();
							for (PaymentDetailDTO detailDTO :payment.getPaymentDetailList() ) {
								
								PhotoDTO photoDTO = photoDAO.read(detailDTO.getPhoto_uciCode());
								
								CalculationDTO calculationDTO  = new CalculationDTO();
								calculationDTO.setId(payment.getLGD_BUYERID());
								calculationDTO.setUciCode(detailDTO.getPhoto_uciCode());
								calculationDTO.setUsage(detailDTO.getUsageList_seq());
								calculationDTO.setType(0);
								calculationDTO.setRate(photoDTO.getOwnerPreRate());
								calculationDTO.setPayType(payment.getLGD_PAYTYPE());
								calculationDTO.setPrice(detailDTO.getPrice());
								calculationDTO.setFees(payment.getLGD_FEES(detailDTO.getPrice()));
								calculationDTO.setStatus(0);
								calculationDAO.insertCalculation(calculationDTO);
							}	
						}
					}

				}

				if (!isDBOK) {

					xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" + xpay.Response("LGD_TID", 0) + ",MID:" + xpay.Response("LGD_MID", 0) + ",OID:" + xpay.Response("LGD_OID", 0) + "]");

					System.out.println("TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE", 0) + "<br>");
					System.out.println("TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG", 0) + "<p>");

					if ("0000".equals(xpay.m_szResCode)) {
						PaymentManageDTO payment = new PaymentManageDTO();
						payment.setLGD_BUYERID(xpay.Response("LGD_BUYERID", 0));// 아이디
						payment.setLGD_OID(xpay.Response("LGD_OID", 0)); // 주문번호
						payment.setLGD_PAYSTATUS(PAYSTATUS);// 1:결제성공 0:결제실패 2:결제대기중 3:무통장입금 대기중
						payment.setLGD_RESPCODE(xpay.m_szResCode); // 결제상태
						payment.setLGD_RESPMSG(xpay.m_szResMsg); // 결제메세지
						payment.setLGD_TID(xpay.Response("LGD_TID", 0)); // 거래번호

						PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
						payment = paymentDAO.updatePaymentManage(payment);

						System.out.println("자동취소가 정상적으로 완료 되었습니다.<br>");
					} else {
						System.out.println("자동취소가 정상적으로 처리되지 않았습니다.<br>");
					}
				}

			} else {
				// 통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
				System.out.println("최종결제요청 결과 실패, DB처리하시기 바랍니다.<br>");
				PaymentManageDTO payment = new PaymentManageDTO();
				payment.setLGD_BUYERID(xpay.Response("LGD_BUYERID", 0));// 아이디
				payment.setLGD_OID(xpay.Response("LGD_OID", 0)); // 주문번호
				payment.setLGD_PAYSTATUS(PAYSTATUS);// 1:결제성공 0:결제실패 2:결제대기중 3:무통장입금 대기중
				payment.setLGD_RESPCODE(xpay.m_szResCode); // 결제상태
				payment.setLGD_RESPMSG(xpay.m_szResMsg); // 결제메세지
				payment.setLGD_TID(xpay.Response("LGD_TID", 0)); // 거래번호

				PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
				payment = paymentDAO.updatePaymentManage(payment);

			}
		} else {
			// 2)API 요청실패 화면처리
			System.out.println("결제요청이 실패하였습니다.  <br>");
			System.out.println("TX 결제요청 Response_code = " + xpay.m_szResCode + "<br>");
			System.out.println("TX 결제요청 Response_msg = " + xpay.m_szResMsg + "<p>");

			// 최종결제요청 결과 실패 DB처리
			System.out.println("최종결제요청 결과 실패 DB처리하시기 바랍니다.<br>");

			PaymentManageDTO payment = new PaymentManageDTO();
			payment.setLGD_BUYERID(xpay.Response("LGD_BUYERID", 0));// 아이디
			payment.setLGD_OID(xpay.Response("LGD_OID", 0)); // 주문번호
			payment.setLGD_PAYSTATUS(PAYSTATUS);// 1:결제성공 0:결제실패 2:결제대기중 3:무통장입금 대기중
			payment.setLGD_RESPCODE(xpay.m_szResCode); // 결제상태
			payment.setLGD_RESPMSG(xpay.m_szResMsg); // 결제메세지
			payment.setLGD_TID(xpay.Response("LGD_TID", 0)); // 거래번호

			PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
			payment = paymentDAO.updatePaymentManage(payment);

		}

//		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pay_result.jsp");
	//	dispatcher.forward(request, response);
		 response.sendRedirect("/result.pay?orderNo="+xpay.Response("LGD_OID", 0));
	}
}