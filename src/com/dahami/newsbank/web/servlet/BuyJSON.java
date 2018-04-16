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

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUtil;

/**
 * Servlet implementation class BuyJSON
 */
@WebServlet(
		urlPatterns = {"/buy.api", "/excel.buy.api"},
		loadOnStartup = 1
		)
public class BuyJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public BuyJSON() {
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

		JSONObject json = new JSONObject();
		boolean success = false;
		String message = "";
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String keywordType = request.getParameter("keywordType"); // 키워드 검색 타입
		String keyword = request.getParameter("keyword");
		String status = request.getParameter("status");
		String media_code = request.getParameter("media_code");
		String result_type = request.getParameter("cmd");
		int pageVol = Integer.parseInt(request.getParameter("pageVol"));
		int startPage = Integer.parseInt(request.getParameter("startPage"));
		int totalCnt = 0; // 총 갯수
		int pageCnt = 0; // 페이지 갯수
		int totalPrice = 0; // 총 판매금액

		String[] media = request.getParameterValues("media_code");
		media_code = StringUtils.join(media, ",");

		List<Map<String, Object>> searchList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> totalList = new ArrayList<Map<String, Object>>();
		
		if (MemberInfo != null) {
			Map<String, Object> params = new HashMap<String, Object>();
			Map<String, Object> totalParams = new HashMap<String, Object>();
			
			params.put("member_seq", MemberInfo.getSeq());
			if (start_date != null && start_date.length() > 0) {
				start_date = start_date.replaceAll("-", "");
				params.put("start_date", start_date);
				totalParams.put("start_date", start_date);
			}
			if (end_date != null && end_date.length() > 0) {
				end_date = end_date.replaceAll("-", "");
				params.put("end_date", end_date);
				totalParams.put("end_date", end_date);
			}
			
			if (keywordType != null && keywordType.length() > 0) {
				params.put("keywordType", keywordType);
				totalParams.put("keywordType", keywordType);
			}

			if (keyword != null && keyword.length() > 0) {
				params.put("keyword", keyword);
				totalParams.put("keyword", keyword);
			}

			if (status != null && status.length() > 0) {
				params.put("status", status);
				totalParams.put("status", status);
			}
			
			params.put("pageVol", pageVol);
			params.put("startPage", startPage);

			PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
			
			searchList = paymentDAO.buyList(params); 
			totalList = paymentDAO.buyList(totalParams);
			
			totalPrice = paymentDAO.getBuyPrice(params); 
			totalCnt = paymentDAO.getBuyCount(params);
			pageCnt = (totalCnt / pageVol) + 1;	
			
			CmdClass cmd = CmdClass.getInstance(request);
			if (cmd.isInvalid()) {
				response.sendRedirect("/invlidPage.jsp");
				return;
			}
			
			if(cmd.is3("excel")) {
				// 목록 엑셀다운로드
				
				List<String> headList = Arrays.asList("회사/기관명", "아이디", "이름", "구매 신청일", "상태", "매체", "UCI코드", "언론사 사진번호", "용도", "금액"); //  테이블 상단 제목
				List<Integer> columnSize = Arrays.asList(10, 10, 10, 25, 10, 15, 20, 25, 10, 10); //  컬럼별 길이정보
				List<String> columnList = Arrays.asList("compName", "id", "name", "LGD_PAYDATE", "LGD_PAYSTATUS", "copyright", "photo_uciCode", "compCode", "usuage", "price"); // 컬럼명
				
				Date today = new Date();
			    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
				String orgFileName = "구매 내역_오프라인결제_" + dateforamt.format(today); // 파일명
				ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, searchList, orgFileName);
			}else {
				
				if (searchList != null) {
					success = true;
				} else {
					message = "데이터가 없습니다.";

				}
			}
			
		} else {
			message = "다시 로그인해주세요.";
		}
		
		json.put("success", success);
		json.put("pageCnt", pageCnt);
		json.put("totalCnt", totalCnt);
		json.put("totalPrice", totalPrice);
		json.put("totalList", totalList);
		json.put("result", searchList);
		
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
