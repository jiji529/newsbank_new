package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class PrivateIntro
 */
//@WebServlet("/privacy.intro")
@WebServlet(
		urlPatterns = {"/privacy.intro", "/past.privacy.intro"}
		)
public class PrivacyIntro extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PrivacyIntro() {
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
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		if (MemberInfo != null) {
			request.setAttribute("MemberInfo", MemberInfo);
		}
		
		
		if(cmd.is3("past")) { // 이전 개인정보처리 방침
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/past_privacy_intro.jsp");
			dispatcher.forward(request, response);
			
		}else{
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/privacy_intro.jsp");
			dispatcher.forward(request, response);
		}
		
		
	}
}