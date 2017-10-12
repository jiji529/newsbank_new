package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

/**
 * Servlet implementation class PictureView
 */
@WebServlet(
		urlPatterns = {"/view.picture"},
		loadOnStartup = 1
		)
public class PictureView extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public PictureView() {
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
		
		//SearchParameterBean parameterBean = new SearchParameterBean();
		//List<PhotoDTO> photoList = searchDAO.search(parameterBean);
		
		SearchDAO searchDAO = new SearchDAO();
		String uciCode = request.getParameter("uciCode");
		PhotoDTO photoDTO = searchDAO.read(uciCode);
		request.setAttribute("photoDTO", photoDTO);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/picture_view.jsp");
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
