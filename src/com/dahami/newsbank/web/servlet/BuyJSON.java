package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
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

/**
 * Servlet implementation class BuyJSON
 */
@WebServlet("/buy.api")
public class BuyJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public BuyJSON() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
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

			if (searchList != null) {
				success = true;
			} else {
				message = "데이터가 없습니다.";

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

		response.getWriter().print(json);
		response.flushBuffer();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
