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
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
	

		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		String prevPage = (String) session.getAttribute("prevPage");
		String refererUrl = request.getHeader("referer");
		if (refererUrl == null || !refererUrl.equals("/login")) {
			refererUrl = "/home";
		} else {
			URL aURL = new URL(refererUrl);
			refererUrl = aURL.getFile();
		}

		if (prevPage == null) {
			// 이전 페이지 정보 없음
			session.setAttribute("prevPage", refererUrl);
			prevPage = refererUrl;
		} else {
			prevPage = "/home";
		}
		
		

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

			String id = request.getParameter("id"); // 아이디 request
			String pw = request.getParameter("pw"); // 패스워드 request
			String login_chk = request.getParameter("login_chk"); // 아이디 저장 request
			if (id != null || pw != null) {
				// 로그인 정보 요청
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("id", id);
				param.put("pw", pw);

				MemberDAO memberDAO  = new MemberDAO(); // 회원정보 연결
				MemberDTO memberDTO = memberDAO.selectMember(param); // 회원정보 요청
				if (memberDTO != null) {
					// 로그인 성공
					session.setAttribute("MemberInfo", memberDTO); // 회원정보 세션 저장
					session.setMaxInactiveInterval(60 * 60 * 25 * 7);// 유효기간 7일

					// 자동로그인 쿠키 저장
					if (login_chk != null && login_chk.trim().equals("on")) {
						Cookie cookie = new Cookie("id", URLEncoder.encode(id, "UTF-8"));
						cookie.setMaxAge(60 * 60 * 25 * 7);//세션 유효기간 1주일
						response.addCookie(cookie);
					} else {
						Cookie cookie = new Cookie("id", null);
						cookie.setMaxAge(0);// 유효기간 0
						response.addCookie(cookie);
					}
					session.removeAttribute("prevPage");
					//RequestDispatcher dispatcher = request.getRequestDispatcher(prevPage);
					//dispatcher.forward(request, response);
					 response.sendRedirect(prevPage);
				} else {
					// 로그인 실패
					request.setAttribute("msg", "0");
					//request.setAttribute("id", id);
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
					dispatcher.forward(request, response);
					
					//response.sendRedirect("/login");
				}
			} else {
				// 초기화면 또는 아이디 패스워드 누락
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
				dispatcher.forward(request, response);


			}

		} else {
			// 로그인 정보 있음
			session.removeAttribute("prevPage");
			//RequestDispatcher dispatcher = request.getRequestDispatcher(prevPage);
			//dispatcher.forward(request, response);
			response.sendRedirect(prevPage);

		}

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
