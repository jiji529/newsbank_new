package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;


/**
 * Servlet implementation class Pay
 */
@WebServlet(
		urlPatterns = {"/pay"},
		loadOnStartup = 1
		)
public class Pay extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public Pay() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String data = request.getParameter("data");
		JSONObject retJson = (JSONObject) JSONValue.parse(data);
		System.out.println(data);
		System.out.println(retJson.toJSONString());
		
		/*String uciCode = request.getParameter("uciCode");
		String usageList_seq = request.getParameter("usageList_seq");
		
		System.out.println("uciCode : " + uciCode);
		System.out.println("usageList_seq : " + usageList_seq);*/
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pay.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
