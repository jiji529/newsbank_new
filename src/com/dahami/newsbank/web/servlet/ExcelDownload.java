package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ExcelDownload
 */
@WebServlet("/excelDown.api")
public class ExcelDownload extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public ExcelDownload() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String excelHtml = request.getParameter("excelHtml");
		request.setAttribute("excelHtml", excelHtml);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/excelDownload.jsp");
		dispatcher.forward(request, response);
	}
}
