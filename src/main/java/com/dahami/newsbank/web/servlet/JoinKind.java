package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet(urlPatterns = { "/kind.join", "/join" })
public class JoinKind extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public JoinKind() {
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
		session.invalidate(); //세션 삭제
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"join_kind.jsp");
		dispatcher.forward(request, response);
    }
}
