package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.MemberDAO;

/**
 * Servlet implementation class CheckId
 */
@WebServlet("/checkId")
public class CheckId extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public CheckId() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		boolean isMember = false;
		String id = request.getParameter("id"); // 아이디 request
		if(!id.isEmpty()) {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("id", id);
			
			MemberDAO memberDAO  = new MemberDAO(); // 회원정보 연결
			isMember = memberDAO.selectId(param); // 아이디 정보 요청
		}
		JSONObject json = new JSONObject();
		json.put("success", isMember);
		
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
