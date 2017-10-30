package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.service.DownloadService;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

/**
 * Servlet implementation class Picture
 */
@WebServlet(
		urlPatterns = {"/picture", "*.picture"},
		loadOnStartup = 1
		)
public class Picture extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Picture() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void init(ServletConfig config) throws ServletException {
    	super.init(config);
    	new SearchDAO().init();
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		if (closed) {
			return;
		}
		
		if(cmd2 != null && cmd2.equals("down")) {
			DownloadService ds = new DownloadService(cmd3, getParam("uciCode"));
			ds.execute(response);
		}
		else {
			SearchParameterBean parameterBean = new SearchParameterBean();
			parameterBean.setPageVol(40);
			
			SearchDAO searchDAO = new SearchDAO();
			Map<String, Object> photoList = searchDAO.search(parameterBean);		
			request.setAttribute("total", photoList.get("count"));
			request.setAttribute("picture", photoList.get("result"));
			request.setAttribute("CONTENT_TYPE_NEWS", SearchParameterBean.CONTENT_TYPE_NEWS);
			request.setAttribute("CONTENT_TYPE_MUSEUM", SearchParameterBean.CONTENT_TYPE_MUSEUM);
			request.setAttribute("CONTENT_TYPE_PERSONAL", SearchParameterBean.CONTENT_TYPE_PERSONAL);
			
			request.setAttribute("COLOR_ALL", SearchParameterBean.COLOR_ALL);
			request.setAttribute("COLOR_YES", SearchParameterBean.COLOR_YES);
			request.setAttribute("COLOR_NO", SearchParameterBean.COLOR_NO);
			
			request.setAttribute("HORIZONTAL_ALL", SearchParameterBean.HORIZONTAL_ALL);
			request.setAttribute("HORIZONTAL_YES", SearchParameterBean.HORIZONTAL_YES);
			request.setAttribute("HORIZONTAL_NO", SearchParameterBean.HORIZONTAL_NO);
			
			request.setAttribute("SIZE_ALL", SearchParameterBean.SIZE_ALL);
			request.setAttribute("SIZE_LARGE", SearchParameterBean.SIZE_LARGE);
			request.setAttribute("SIZE_MEDIUM", SearchParameterBean.SIZE_MEDIUM);
			request.setAttribute("SIZE_SMALL", SearchParameterBean.SIZE_SMALL);
			
			request.setAttribute("PORTRAIT_RIGHT_ALL", SearchParameterBean.INCLUDE_PERSON_ALL);
			request.setAttribute("PORTRAIT_RIGHT_ACQUIRE", SearchParameterBean.PORTRAIT_RIGHT_ACQUIRE);
			request.setAttribute("PORTRAIT_RIGHT_NOT", SearchParameterBean.PORTRAIT_RIGHT_NOT);
			
			request.setAttribute("INCLUDE_PERSON_ALL", SearchParameterBean.INCLUDE_PERSON_ALL);
			request.setAttribute("INCLUDE_PERSON_YES", SearchParameterBean.INCLUDE_PERSON_YES);
			request.setAttribute("INCLUDE_PERSON_NO", SearchParameterBean.INCLUDE_PERSON_NO);
			
			request.setAttribute("GROUP_IMAGE_ALL", SearchParameterBean.GROUP_IMAGE_ALL);
			request.setAttribute("GROUP_IMAGE_REP", SearchParameterBean.GROUP_IMAGE_REP);	
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/picture.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String limit = request.getParameter("limit");
		System.out.println("limit : "+limit);
		doGet(request, response);
	}
	
	private void showListCount(String count) {
		System.out.println("count : "+count);
	}

}
