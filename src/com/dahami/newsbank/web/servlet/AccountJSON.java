package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.BoardDTO;
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

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_seq", MemberInfo.getSeq());
		params.put("start_date", "20170101");
		params.put("end_date", "20171231");

		PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결

		List<PaymentManageDTO> searchAccountList = new ArrayList<PaymentManageDTO>();
		searchAccountList = paymentDAO.searchAccountList(params); // 회원정보 요청

		if (searchAccountList != null) {
			success = true;
		} else {
			message = "데이터가 없습니다.";

		}

	

		json.put("success", success);
		if (message != "") {
			json.put("message", message);
		}
		json.put("data", searchAccountList);

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
