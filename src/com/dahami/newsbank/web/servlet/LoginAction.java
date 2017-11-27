package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.util.CommonUtil;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet("/login.api")
public class LoginAction extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
	private static String cmd = null;
	private static HttpSession session = null;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public LoginAction() {
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
		session = request.getSession();
		MemberDTO MemberInfo = null;
		if (session.getAttribute("MemberInfo") != null) {
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		}

		boolean check = true;
		boolean result = false;
		String message = null;

		String id = request.getParameter("id"); // 아이디 request
		String pw = request.getParameter("pw"); // 비밀번호 request
		String login_chk = request.getParameter("login_chk"); // 아이디 저장 request
		check = check && isValidNull(id);
		check = check && isValidNull(pw);
		if (check) {
			MemberDTO memberDTO = new MemberDTO(); // 객체 생성
			MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결
			memberDTO.setId(id);
			memberDTO.setPw(CommonUtil.sha1(pw));
			System.out.println(memberDTO.getPw());

			memberDTO = memberDAO.selectMember(memberDTO); // 회원정보 요청
			if (memberDTO != null) {
				// 로그인 성공
				session.setAttribute("MemberInfo", memberDTO); // 회원정보 세션 저장
				session.setMaxInactiveInterval(60 * 60 * 25 * 7);// 유효기간 7일

				// 자동로그인 쿠키 저장
				if (login_chk != null && login_chk.trim().equals("on")) {
					Cookie cookie = new Cookie("id", URLEncoder.encode(id, "UTF-8"));
					cookie.setMaxAge(60 * 60 * 25 * 7);// 쿠기 유효기간 1주일
					response.addCookie(cookie);
				} else {
					Cookie cookie = new Cookie("id", null);
					cookie.setMaxAge(0);// 유효기간 0
					response.addCookie(cookie);
				}
				result = true;
			}else {
				message = "아이디 또는 패스워드를 확인하세요.";
			}
		}else{
			message = "아이디 또는 패스워드를 확인하세요.";
		}

		JSONObject json = new JSONObject();
		json.put("success", result);
		json.put("message", message);

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

	public static boolean isValidNull(String str) {
		boolean err = false;
		if (str != null && !str.isEmpty()) {
			err = true;
		}
		return err;
	}

}
