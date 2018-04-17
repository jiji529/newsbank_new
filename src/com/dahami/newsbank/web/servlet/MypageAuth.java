package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.util.CommonUtil;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet("/auth.mypage")
public class MypageAuth extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public MypageAuth() {
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
		// 임시 넣기
		HttpSession session = request.getSession();
		String pw = request.getParameter("pw"); // 패스워드 request

		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		boolean mypageAuth = false;
		if (session.getAttribute("mypageAuth") != null) {
			mypageAuth = (boolean) session.getAttribute("mypageAuth");
		}

		if (MemberInfo == null) {
			// 이전에 로그인이 안된경우
			response.sendRedirect("/login");
			
		} else {
			// 이미 로그인 되어있는지 체크
			if (mypageAuth) {
				// 이전에 my page 비밀번호 입력했는지 체크
				if(MemberInfo.getType().equals("M") && MemberInfo.getAdmission().equals("Y")) {
					// 매체사 회원은 사진관리로 이동(단, 관리자로부터 매체사 가입승인 받아야함)
					response.sendRedirect("/cms"); 
				}else {
					// 나머지 회원은 회원정보 관리로 이동
					response.sendRedirect("/info.mypage");
				}
			} else {
				if (pw == null) {
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_auth.jsp");
					dispatcher.forward(request, response);
				} else {

					// 로그인 정보 요청
					/*Map<String, Object> param = new HashMap<String, Object>();
					param.put("id", MemberInfo.getId());
					param.put("pw", pw);*/
					
					MemberDTO memberDTO = new MemberDTO(); // 객체 생성
					memberDTO.setId(MemberInfo.getId());
					memberDTO.setPw(CommonUtil.sha1(pw));
					
					

					MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결
					memberDTO = memberDAO.selectMember(memberDTO); // 회원정보 요청
					if (memberDTO != null) {
						// 로그인 성공
						session.setAttribute("mypageAuth", true);
						
						if(memberDTO.getType().equals("M") && MemberInfo.getAdmission().equals("Y")) {
							// 매체사 회원은 사진관리로 이동(단, 관리자로부터 매체사 가입승인 받아야함)
							response.sendRedirect("/cms"); 
						}else {
							// 나머지 회원은 회원정보 관리로 이동
							response.sendRedirect("/info.mypage");
						}
					} else {
						// 로그인 실패
						session.setAttribute("mypageAuth", false);

						request.setAttribute("msg", "0");
						RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_auth.jsp");
						dispatcher.forward(request, response);
					}
				}
			}
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
