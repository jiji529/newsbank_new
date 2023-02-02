package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet("/success.join")
public class JoinSuccess extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public JoinSuccess() {
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
    	
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/join_success.jsp");
		dispatcher.forward(request, response);
	}
}