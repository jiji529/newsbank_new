package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.CMSService;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet("/account.mypage")
public class MypageAccountInfo extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public MypageAccountInfo() {
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
				//request.setAttribute("type", MemberInfo.getType());
				if(!MemberInfo.getType().equalsIgnoreCase("M")) {
					response.sendRedirect("/info.mypage");
					return;
				}
				
				request.setAttribute("MemberInfo", MemberInfo);
				if (MemberInfo.getPhone() != null && MemberInfo.getPhone().length() >= 10) {
					MemberInfo.setPhone(MemberInfo.getPhone().replaceAll("-", ""));
					request.setAttribute("phone1", MemberInfo.getPhone().substring(0, 3));
					if (MemberInfo.getPhone().length() == 11) {
						request.setAttribute("phone2", MemberInfo.getPhone().substring(3, 7));
					} else {
						request.setAttribute("phone2", MemberInfo.getPhone().substring(3, 6));
					}
					request.setAttribute("phone3", MemberInfo.getPhone().substring(MemberInfo.getPhone().length() - 4, MemberInfo.getPhone().length()));

				}
				/*
				// 세금계산서 전화번호, 이메일
				if (MemberInfo.getTaxPhone() != null && MemberInfo.getTaxPhone().length() >= 9) {
					MemberInfo.setTaxPhone(MemberInfo.getTaxPhone().replaceAll("-", ""));

					if (MemberInfo.getTaxPhone().substring(0, 2).equalsIgnoreCase("02")) {
						request.setAttribute("taxPhone1", MemberInfo.getTaxPhone().substring(0, 2));
						if (MemberInfo.getTaxPhone().length() == 9) {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(2, 5));
						} else {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(2, 6));
						}
					} else if (MemberInfo.getTaxPhone().substring(0, 4).equalsIgnoreCase("0130")) {
						request.setAttribute("taxPhone1", MemberInfo.getTaxPhone().substring(0, 4));
						if (MemberInfo.getTaxPhone().length() == 11) {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(4, 7));
						} else {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(4, 8));
						}
					} else {
						request.setAttribute("taxPhone1", MemberInfo.getTaxPhone().substring(0, 3));
						if (MemberInfo.getTaxPhone().length() == 10) {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(3, 6));
						} else {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(3, 7));
						}
					}

					request.setAttribute("taxPhone3", MemberInfo.getTaxPhone().substring(MemberInfo.getTaxPhone().length() - 4, MemberInfo.getTaxPhone().length()));
				}
				*/
				
				//매체목록 세팅
				request.setAttribute("mediaList", new MemberDAO().listAdjustMedia(MemberInfo));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_account_info.jsp");
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
