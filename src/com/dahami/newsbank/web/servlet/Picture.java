package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.SearchDAO;
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

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(request, response);
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		if (closed) {
			return;
		}
		
		SearchParameterBean parameterBean = new SearchParameterBean();
		SearchDAO searchDAO = new SearchDAO();
		List<PhotoDTO> photoList = searchDAO.search(parameterBean);
		
		request.setAttribute("picture", photoList);
		System.out.println(photoList);

		/*for(int idx=0; idx<photoList.size(); idx++) {
			String compCode = photoList.get(idx).getCompCode();
			System.out.println(compCode);
		}*/
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/picture.jsp");
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
