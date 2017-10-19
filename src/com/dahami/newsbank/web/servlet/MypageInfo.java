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
		response.getWriter().append("Served at: ").append(request.getContextPath());

		// 임시 넣기
		HttpSession session = request.getSession();
		MemberDAO memberDAO = new MemberDAO();
		MemberDTO memberDTO = memberDAO.selectMember("dev");

		session.setAttribute("MemberInfo", memberDTO);

		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		if (MemberInfo.getId() != null) {

			request.setAttribute("id", MemberInfo.getId());
			request.setAttribute("name", MemberInfo.getName());
			request.setAttribute("phone", MemberInfo.getPhone());
			request.setAttribute("email", MemberInfo.getEmail());
			request.setAttribute("compName", MemberInfo.getCompName());
			request.setAttribute("compNum", MemberInfo.getCompNum());
			request.setAttribute("compTel", MemberInfo.getCompTel());
			request.setAttribute("logo", MemberInfo.getLogo());

			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_info.jsp");
			dispatcher.forward(request, response);
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/invalidPage.jsp");
			dispatcher.forward(request, response);
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
