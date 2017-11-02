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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

				request.setAttribute("email", MemberInfo.getEmail());

				request.setAttribute("type", MemberInfo.getType());
				/**** 사업자 및 언론사 ****/
				request.setAttribute("compName", MemberInfo.getCompName());
				request.setAttribute("compNum", MemberInfo.getCompNum());
				if (MemberInfo.getCompNum() != null && MemberInfo.getCompNum().length() == 10) {
					MemberInfo.setCompNum(MemberInfo.getCompNum().replaceAll("-", ""));
					request.setAttribute("compNum1", MemberInfo.getCompNum().substring(0, 3));
					request.setAttribute("compNum2", MemberInfo.getCompNum().substring(3, 5));
					request.setAttribute("compNum3", MemberInfo.getCompNum().substring(MemberInfo.getCompNum().length() - 5, MemberInfo.getCompNum().length()));

				}
				request.setAttribute("compTel", MemberInfo.getCompTel());
				if (MemberInfo.getCompTel() != null && MemberInfo.getCompTel().length() >= 9) {
					MemberInfo.setCompTel(MemberInfo.getCompTel().replaceAll("-", ""));

					if (MemberInfo.getCompTel().substring(0, 2).equalsIgnoreCase("02")) {
						request.setAttribute("compTel1", MemberInfo.getCompTel().substring(0, 2));
						if (MemberInfo.getCompTel().length() == 9) {
							request.setAttribute("compTel2", MemberInfo.getCompTel().substring(2, 5));
						} else {
							request.setAttribute("compTel2", MemberInfo.getCompTel().substring(2, 6));
						}
					} else if (MemberInfo.getCompTel().substring(0, 4).equalsIgnoreCase("0130")) {
						request.setAttribute("compTel1", MemberInfo.getCompTel().substring(0, 4));
						if (MemberInfo.getCompTel().length() == 11) {
							request.setAttribute("compTel2", MemberInfo.getCompTel().substring(4, 7));
						} else {
							request.setAttribute("compTel2", MemberInfo.getCompTel().substring(4, 8));
						}
					} else {
						request.setAttribute("compTel1", MemberInfo.getCompTel().substring(0, 3));
						if (MemberInfo.getCompTel().length() == 10) {
							request.setAttribute("compTel2", MemberInfo.getCompTel().substring(3, 6));
						} else {
							request.setAttribute("compTel2", MemberInfo.getCompTel().substring(3, 7));
						}
					}

					request.setAttribute("compTel3", MemberInfo.getCompTel().substring(MemberInfo.getCompTel().length() - 4, MemberInfo.getCompTel().length()));

				}
				request.setAttribute("logo", MemberInfo.getLogo());

				request.setAttribute("compName", MemberInfo.getCompName());

				request.setAttribute("compNum", MemberInfo.getCompNum());
				request.setAttribute("compTel", MemberInfo.getCompTel());
				request.setAttribute("compDocPath", MemberInfo.getCompDocPath());
				request.setAttribute("compAddress", MemberInfo.getCompAddress());
				request.setAttribute("compAddDetail", MemberInfo.getCompAddDetail());
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
