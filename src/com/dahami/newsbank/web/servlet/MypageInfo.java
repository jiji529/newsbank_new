package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class MypageInfo
 */
@WebServlet(urlPatterns = { "/info.mypage" }, loadOnStartup = 1)
public class MypageInfo extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public MypageInfo() {
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

		// 임시 넣기
		HttpSession session = request.getSession();

		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		if (MemberInfo != null) {

			boolean mypageAuth = false;
			if (session.getAttribute("mypageAuth") != null) {
				mypageAuth = (boolean) session.getAttribute("mypageAuth");
			}
			if (mypageAuth == false) {
				// 이전에 my page 비밀번호 입력했는지 체크
				response.sendRedirect("/auth.mypage");
			} else {
				request.setAttribute("id", MemberInfo.getId());
				request.setAttribute("name", MemberInfo.getName());
				request.setAttribute("phone", MemberInfo.getPhone());
				request.setAttribute("email", MemberInfo.getEmail());
				
				request.setAttribute("type", MemberInfo.getType());
				/**** 사업자 및 언론사 ****/
				request.setAttribute("compName", MemberInfo.getCompName());
				request.setAttribute("compNum", MemberInfo.getCompNum());
				request.setAttribute("compTel", MemberInfo.getCompTel());
				request.setAttribute("logo", MemberInfo.getLogo());

				request.setAttribute("compName", MemberInfo.getCompName());

				request.setAttribute("compNum", MemberInfo.getCompNum());
				request.setAttribute("compTel", MemberInfo.getCompTel());
				request.setAttribute("compDocPath", MemberInfo.getCompDocPath());
				request.setAttribute("compAddress", MemberInfo.getCompAddress());
				request.setAttribute("compZipcode", MemberInfo.getCompZipcode());
				request.setAttribute("compBankName", MemberInfo.getCompBankName());
				request.setAttribute("compBankAcc", MemberInfo.getCompBankAcc());
				request.setAttribute("compBankPath", MemberInfo.getCompBankPath());

				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_info.jsp");
				dispatcher.forward(request, response);
			}

		} else {
			response.sendRedirect("/login");
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
