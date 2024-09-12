package com.dahami.newsbank.web.servlet;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
//import com.oreilly.servlet.MultipartRequest;
//import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.dahami.newsbank.web.service.CMSService;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet("/form.join")
public class JoinForm extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public JoinForm() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
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
		
		String type = request.getParameter("type"); // 회원 구분
		request.setAttribute("type", type);
		
		//매체목록 세팅
//		request.setAttribute("mediaList", new MemberDAO().listActiveMedia());
		
		if (type == null) {
			response.sendRedirect("/kind.join");
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"join_form.jsp");
			dispatcher.forward(request, response);
		}
	}
}
