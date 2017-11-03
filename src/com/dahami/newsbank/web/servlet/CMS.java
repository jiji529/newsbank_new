package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.service.CMSService;
import com.dahami.newsbank.web.service.PhotoService;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

/**
 * Servlet implementation class CMS
 */
@WebServlet(
		urlPatterns = {"/cms"},
		loadOnStartup = 1
		)
public class CMS extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public CMS() {
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
		
		SearchParameterBean parameterBean = new SearchParameterBean();
		parameterBean.setPageVol(40);
		
		SearchDAO searchDAO = new SearchDAO();
		Map<String, Object> photoList = searchDAO.search(parameterBean);
		request.setAttribute("total", photoList.get("count"));
		request.setAttribute("picture", photoList.get("result"));
		
		request.setAttribute("CONTENT_TYPE_NEWS", SearchParameterBean.CONTENT_TYPE_NEWS);
		request.setAttribute("CONTENT_TYPE_MUSEUM", SearchParameterBean.CONTENT_TYPE_MUSEUM);
		request.setAttribute("CONTENT_TYPE_PERSONAL", SearchParameterBean.CONTENT_TYPE_PERSONAL);
		request.setAttribute("CONTENT_TYPE_COLLECTION", SearchParameterBean.CONTENT_TYPE_COLLECTION);
		
		request.setAttribute("PORTRAIT_RIGHT_ALL", SearchParameterBean.INCLUDE_PERSON_ALL);
		request.setAttribute("PORTRAIT_RIGHT_ACQUIRE", SearchParameterBean.PORTRAIT_RIGHT_ACQUIRE);
		request.setAttribute("PORTRAIT_RIGHT_NOT", SearchParameterBean.PORTRAIT_RIGHT_NOT);
		
		request.setAttribute("INCLUDE_PERSON_ALL", SearchParameterBean.INCLUDE_PERSON_ALL);
		request.setAttribute("INCLUDE_PERSON_YES", SearchParameterBean.INCLUDE_PERSON_YES);
		request.setAttribute("INCLUDE_PERSON_NO", SearchParameterBean.INCLUDE_PERSON_NO);
		
		//PhotoService ps = new PhotoService();
		//ps.execute(request, response);
		
		CMSService cs = new CMSService();
		cs.execute(request, response);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/cms.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
