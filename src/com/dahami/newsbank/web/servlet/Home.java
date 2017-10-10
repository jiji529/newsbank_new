package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

@WebServlet(
	urlPatterns = {"/home", "*.home"},
	loadOnStartup = 1
)
public class Home extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public Home() {
        super();
    }

    public void init(ServletConfig config) throws ServletException {
    	super.init(config);
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		if(closed) {
			return;
		}
		SearchDAO searcher = new SearchDAO();
		SearchParameterBean sParam = new SearchParameterBean();
		List<PhotoDTO> photoList = searcher.search(sParam);
		
		List<PhotoDTO> photoList2 = searcher.search(sParam.nextPage());
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/main.jsp");
		dispatcher.forward(request, response); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
