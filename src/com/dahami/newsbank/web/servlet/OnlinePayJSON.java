package com.dahami.newsbank.web.servlet;

import java.io.IOException;
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
		//List<Map<String, Object>> searchList = new ArrayList<Map<String, Object>>(); // 검색 결과
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>(); // json 전달변수
		List<PaymentManageDTO> searchList = new ArrayList<PaymentManageDTO>(); // 검색 결과
		
		if (MemberInfo != null) { // 세션값이 있을 때는 해당 매체만 보여주기
			String member_seq = String.valueOf(MemberInfo.getSeq());
			
			if (start_date != null && start_date.length() > 0) {
				start_date = start_date.replaceAll("-", "");
				params.put("start_date", start_date + "000000");
			}
			if (end_date != null && end_date.length() > 0) {
				end_date = end_date.replaceAll("-", "");
				params.put("end_date", end_date + "240000");
			}
			if(keywordType != null && keywordType.length() > 0){
				params.put("keywordType", keywordType);
			}
			if (keyword != null && keyword.length() > 0) {
				params.put("keyword", keyword);
			}
			if (paytype != null && paytype.length() > 0) {
				params.put("LGD_PAYTYPE", paytype);
			}
			if (paystatus != null && paystatus.length() > 0) {
				params.put("LGD_PAYSTATUS", paystatus);
			}
			
			params.put("pageVol", pageVol);
			params.put("startPage", startPage);
			
			PaymentDAO payDAO = new PaymentDAO();		
			searchList = payDAO.onlinePayList(params);
			
			
			List<PaymentManageDTO> list = (List<PaymentManageDTO>) searchList;
			for(PaymentManageDTO dto : list){
				try {
					jsonList.add(dto.convertToMap());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			totalCnt = payDAO.getOnlineCount(params);
			totalPrice = payDAO.getOnlinePrice(params);
			pageCnt = (totalCnt / pageVol) + 1; 
			
			CmdClass cmd = CmdClass.getInstance(request);
			if (cmd.isInvalid()) {
				response.sendRedirect("/invlidPage.jsp");
				return;
			}
			
			if(cmd.is3("excel")) {
				// 목록 엑셀다운로드
				
				List<String> headList = Arrays.asList("주문일자", "아이디", "이름", "주문번호", "결제방법", "결제상황", "결제금액"); //  테이블 상단 제목
				List<Integer> columnSize = Arrays.asList(25, 10, 10, 25, 10, 10, 15); //  컬럼별 길이정보
				List<String> columnList = Arrays.asList("LGD_PAYDATE", "LGD_BUYERID", "LGD_BUYER", "LGD_OID", "LGD_PAYTYPE", "LGD_PAYSTATUS_STR", "LGD_AMOUNT"); // 컬럼명
				
				Date today = new Date();
			    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
				String orgFileName = "온라인결제관리_" + dateforamt.format(today); // 파일명
				ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, jsonList, orgFileName);
			
			}else {
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

		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(json);
		response.flushBuffer();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
