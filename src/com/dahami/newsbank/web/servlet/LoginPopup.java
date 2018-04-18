package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class LoginPopup
 */
@WebServlet("/login.pop")
public class LoginPopup extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public LoginPopup() {
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
		if (session.getAttribute("MemberInfo") != null) {
			MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
			if (MemberInfo.getId().length() < 4) {
				boolean nextChangeHide = false;
				String targetDate = "20180531";
				
				
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
				String thisDay = dateFormat.format(cal.getTime());
				if(thisDay.compareTo(targetDate)>0) {
					nextChangeHide = true;
				}
				
				request.setAttribute("id", MemberInfo.getId());
				request.setAttribute("nextChangeHide", nextChangeHide);
				

				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login_popup.jsp");
				dispatcher.forward(request, response);
			}
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
