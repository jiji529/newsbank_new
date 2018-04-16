package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public Login() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
	

		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		//String prevPage = (String) session.getAttribute("prevPage");
		String refererUrl = request.getHeader("referer");
		if (refererUrl == null || refererUrl.equals("/login")) {
			refererUrl = "/home";
		} else {
			URL aURL = new URL(refererUrl);
			refererUrl = aURL.getFile();
		}

		/*if (prevPage == null) {
			// 이전 페이지 정보 없음
			session.setAttribute("prevPage", refererUrl);
			prevPage = refererUrl;
		} 
		*/
		

		if (MemberInfo == null) {
			// 로그인 정보 없음
			//session.invalidate();//세션 초기화
			
			Cookie[] getCookie = request.getCookies();
			if (getCookie != null) {
				for (int i = 0; i < getCookie.length; i++) {
					if (getCookie[i].getName().trim().equals("id")) {
						//System.out.println(cookie[i].getValue());
						request.setAttribute("id", getCookie[i].getValue());
					}
				}
			}

			// 초기화면 또는 아이디 패스워드 누락
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
			dispatcher.forward(request, response);

		} else {
			// 로그인 정보 있음
			//session.removeAttribute("prevPage");
			//RequestDispatcher dispatcher = request.getRequestDispatcher(prevPage);
			//dispatcher.forward(request, response);
			response.sendRedirect("/home");
			//response.getWriter().append("<script type=\"text/javascript\">alert('" + message + "');history.back(-1);</script>").append(request.getContextPath());

		}

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
