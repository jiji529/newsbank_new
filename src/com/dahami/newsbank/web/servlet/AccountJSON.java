package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;

/**
 * Servlet implementation class AccountJSON
 */
@WebServlet("/account.api")
public class AccountJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public AccountJSON() {
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
		if (session.getAttribute("MemberInfo") != null) {
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		}

		JSONObject json = new JSONObject();
		boolean success = false;
		String message = "";
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String keyword = request.getParameter("keyword");
		String paytype = request.getParameter("paytype");
		String media_code = request.getParameter("media_code");
		String result_type = request.getParameter("cmd");

		String[] media = request.getParameterValues("media_code");
		media_code = StringUtils.join(media, ",");
		System.out.println(media);

		List<Map<String, Object>> searchList = new ArrayList<Map<String, Object>>();
		/*
		 * if (start_date == null || end_date == null) { Calendar cal =
		 * Calendar.getInstance(); int year = cal.get(cal.YEAR); start_date = year +
		 * "0101"; end_date = year + "1231"; }
		 */
		if (MemberInfo != null) {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("member_seq", MemberInfo.getSeq());
			if (start_date != null && start_date.length() > 0) {
				start_date = start_date.replaceAll("-", "");
				params.put("start_date", start_date);
			}
			if (end_date != null && end_date.length() > 0) {
				end_date = end_date.replaceAll("-", "");
				params.put("end_date", end_date);
			}

			if (keyword != null && keyword.length() > 0) {
				params.put("keyword", keyword);
			}

			if (paytype != null && paytype.length() > 0) {
				params.put("paytype", paytype);
			}
			if (media_code != null && media_code.length() > 0) {
				params.put("media", media_code);
			}

			PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결

			if (result_type != null && result_type.equalsIgnoreCase("total")) {
				searchList = paymentDAO.selectTotalPrice(params); // 전체
			} else {
				searchList = paymentDAO.searchAccountList(params); // 개별
			}

			if (searchList != null) {
				success = true;
			} else {
				message = "데이터가 없습니다.";

			}
		} else {
			message = "다시 로그인해주세요.";
		}

		json.put("success", success);
		if (message != "") {
			json.put("message", message);
		}
		json.put("data", searchList);

		response.getWriter().print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
