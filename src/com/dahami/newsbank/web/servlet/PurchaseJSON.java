package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class PurchaseJSON
 * 결제 정보 호출
 */
@WebServlet("/purchase.api")
public class PurchaseJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public PurchaseJSON() {
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
		
		JSONObject json = new JSONObject();
		boolean result = false;
		String message = null;
		
		if (session.getAttribute("MemberInfo") != null) {
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		}

		if (MemberInfo != null) {
			//로그인중 처리
			String cmd  = request.getParameter("cmd"); // 
		}else {
			message = "로그인이 필요합니다.";
		}
		
		
		json.put("success", result);
		json.put("message", message);

		response.getWriter().print(json);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
