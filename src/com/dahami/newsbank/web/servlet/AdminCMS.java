package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.CMSService;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

/**
 * Servlet implementation class CMSManage
 */
@WebServlet("/cms.manage")
public class AdminCMS extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminCMS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		if (MemberInfo != null) {
			MemberDAO mDao = new MemberDAO();
			MemberDTO memberDTO = new MemberDTO();
			List<MemberDTO> mediaList = mDao.listActiveMedia();
			request.setAttribute("mediaList", mediaList);
			
			SearchParameterBean parameterBean = new SearchParameterBean();
			String cms_keyword = request.getParameter("cms_keyword_current") == null ? "" : request.getParameter("cms_keyword_current");
			parameterBean.setPageVol(40);
			request.setAttribute("cms_keyword", cms_keyword);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin_cms.jsp");
			dispatcher.forward(request, response);
			
		} else {
			response.sendRedirect("/login");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
