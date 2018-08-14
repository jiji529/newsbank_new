package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.BoardDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUtil;

/**
 * Servlet implementation class OnlinePayJSON
 */
@WebServlet(
		urlPatterns = {"/onlinePay.api", "/excel.onlinePay.api"},
		loadOnStartup = 1
		)
public class OnlinePayJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public OnlinePayJSON() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
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
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = null;
		if (session.getAttribute("MemberInfo") != null) {
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		}
		
		boolean success = false;
		String message = "";
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String keywordType = request.getParameter("keywordType");
		String keyword = request.getParameter("keyword");
		String paytype = request.getParameter("paytype"); // 결제방법
		String paystatus = request.getParameter("paystatus"); // 결제상황
		int pageVol = Integer.parseInt(request.getParameter("pageVol"));
		int startPage = Integer.parseInt(request.getParameter("startPage"));
		int totalCnt = 0; // 총 갯수
		int pageCnt = 0; // 페이지 갯수
		int totalPrice = 0; // 총 판매금액
		
		Map<String, Object> params = new HashMap<String, Object>(); // 검색옵션
		Map<String, Object> totalParams = new HashMap<String, Object>();
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>(); // json 전달변수
		List<Map<String, Object>> totalList = new ArrayList<Map<String, Object>>();
		List<PaymentManageDTO> searchList = new ArrayList<PaymentManageDTO>(); // 검색 결과
		List<PaymentManageDTO> searchAllList = new ArrayList<PaymentManageDTO>(); // 전체목록 
		
		if (MemberInfo != null) { // 세션값이 있을 때는 해당 매체만 보여주기
			String member_seq = String.valueOf(MemberInfo.getSeq());
			
			if (start_date != null && start_date.length() > 0) {
				start_date = start_date.replaceAll("-", "");
				params.put("start_date", start_date + "000000");
				totalParams.put("start_date", start_date + "000000");
			}
			if (end_date != null && end_date.length() > 0) {
				end_date = end_date.replaceAll("-", "");
				params.put("end_date", end_date + "240000");
				totalParams.put("end_date", end_date + "240000");
			}
			if(keywordType != null && keywordType.length() > 0){
				params.put("keywordType", keywordType);
				totalParams.put("keywordType", keywordType);
			}
			if (keyword != null && keyword.length() > 0) {
				params.put("keyword", keyword);
				totalParams.put("keyword", keyword);
			}
			if (paytype != null && paytype.length() > 0) {
				params.put("LGD_PAYTYPE", paytype);
				totalParams.put("LGD_PAYTYPE", paytype);
			}
			if (paystatus != null && paystatus.length() > 0) {
				params.put("LGD_PAYSTATUS", paystatus);
				totalParams.put("LGD_PAYSTATUS", paystatus);
			}
			
			params.put("pageVol", pageVol);
			params.put("startPage", startPage);
			
			PaymentDAO payDAO = new PaymentDAO();		
			searchList = payDAO.onlinePayList(params);
			searchAllList = payDAO.onlinePayList(totalParams);
			
			
			List<PaymentManageDTO> list = (List<PaymentManageDTO>) searchList;
			
			
			totalCnt = payDAO.getOnlineCount(params);
			totalPrice = payDAO.getOnlinePrice(params);
			pageCnt = (totalCnt / pageVol) + 1; 
			
			if(cmd.is3("excel")) {
				// 목록 엑셀다운로드
				for(PaymentManageDTO dto : list){
					try {
						//jsonList.add(dto.convertToMap());
						Map<String, Object> object = new HashMap<String, Object>();
						object.put("LGD_PAYDATE", dateFormat(dto.getLGD_PAYDATE()));
						object.put("LGD_BUYERID", dto.getLGD_BUYERID());
						object.put("LGD_BUYER", dto.getLGD_BUYER());
						object.put("LGD_OID", dto.getLGD_OID());
						object.put("LGD_PAYTYPE_STR", dto.getLGD_PAYTYPE_STR());
						object.put("LGD_PAYSTATUS_STR", dto.getLGD_PAYSTATUS_STR());
						object.put("LGD_AMOUNT", dto.getLGD_AMOUNT_Str());
						
						jsonList.add(object);
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				List<String> headList = Arrays.asList("주문일자", "아이디", "이름", "주문번호", "결제방법", "결제상황", "결제금액"); //  테이블 상단 제목
				List<Integer> columnSize = Arrays.asList(25, 10, 10, 25, 10, 10, 15); //  컬럼별 길이정보
				List<String> columnList = Arrays.asList("LGD_PAYDATE", "LGD_BUYERID", "LGD_BUYER", "LGD_OID", "LGD_PAYTYPE_STR", "LGD_PAYSTATUS_STR", "LGD_AMOUNT"); // 컬럼명
				
				Date today = new Date();
			    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
				String orgFileName = "온라인결제관리_" + dateforamt.format(today); // 파일명
				ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, jsonList, orgFileName);
			
			}else {
				for(PaymentManageDTO dto : list){
					try {
						jsonList.add(dto.convertToMap());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				for(PaymentManageDTO dto : searchAllList){
					try {
						totalList.add(dto.convertToMap());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				if (searchList != null) {
					success = true;
				} else {
					message = "데이터가 없습니다.";
				}
			}
			
			
		} else { // 세션값이 없을 때 
			message = "다시 로그인해주세요.";
		}
		
		JSONObject json = new JSONObject();
		
		json.put("success", success);
		json.put("message", message);
		json.put("pageCnt", pageCnt);
		json.put("totalCnt", totalCnt);
		json.put("totalPrice", totalPrice);
		json.put("result", jsonList);
		json.put("totalList", totalList);

		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(json);
		response.flushBuffer();
		
	}
	
	// 날짜 변환
	private String dateFormat(String DATE) {
		String strDate = "";
		if(!DATE.isEmpty()) {
			try {
				SimpleDateFormat dt = new SimpleDateFormat("yyyyMMddHHmmss");
				Date parseDate;
				parseDate = dt.parse(DATE);
				strDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(parseDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
		}
		return strDate;
	}

}
