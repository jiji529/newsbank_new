package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.web.service.SearchService;

/**
 * Servlet implementation class Search
 */
@WebServlet(
		urlPatterns = {"/search", "*.search"}
		)
public class Search extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		request.setCharacterEncoding("UTF-8");
		if (closed) {
			return;
		}
		
		try {
			if(cmd2.equals("xml")) {
				request.setAttribute("exportType", SearchService.EXPORT_TYPE_XML);
			}
		}catch(Exception e){
			request.setAttribute("exportType", SearchService.EXPORT_TYPE_JSON);
		}
		
		SearchService ss = new SearchService();
		ss.execute(request, response);
		
		String jsonStr = (String) request.getAttribute("JSON");
		String xmlStr = (String) request.getAttribute("XML");
		if(jsonStr != null) {
			response.setContentType("text/json; charset=UTF-8");
			response.getWriter().print(jsonStr);
		}
		else if(xmlStr != null) {
			response.setContentType("text/xml; charset=UTF-8");
			response.getWriter().print(xmlStr);
		}
		
		response.flushBuffer();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
