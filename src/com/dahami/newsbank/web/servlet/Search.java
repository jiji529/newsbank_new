package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.web.service.SearchService;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

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
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		
		boolean isCmsSearch = false;
		boolean isAdminSearch = false;
		
		try {
			if(cmd.is2("xml")) {
				request.setAttribute("exportType", SearchService.EXPORT_TYPE_XML);
			}
			else if(cmd.is2("cms")) {
				isCmsSearch = true;
				if(cmd.is3("xml")) {
					request.setAttribute("exportType", SearchService.EXPORT_TYPE_XML);	
				}
			}
			else if(cmd.is2("admin")) {
				isAdminSearch = true;
				if(cmd.is3("xml")) {
					request.setAttribute("exportType", SearchService.EXPORT_TYPE_XML);	
				}
				else if(cmd.is3("excel")) {
					request.setAttribute("exportType", SearchService.EXPORT_TYPE_EXCEL);
				}
			}
		}catch(Exception e){
			request.setAttribute("exportType", SearchService.EXPORT_TYPE_JSON);
		}
		
		SearchService ss = null;
		if(isCmsSearch) {
			ss = new SearchService(SearchService.SEARCH_MODE_OWNER);
		}
		else if(isAdminSearch) {
			ss = new SearchService(SearchService.SEARCH_MODE_ADMIN);
		}
		else {
			ss = new SearchService(SearchService.SEARCH_MODE_USER);
		}
		ss.execute(request, response);
		
		String contentType = (String) request.getAttribute("contentType");
		String result = (String) request.getAttribute("result");
		
		response.setContentType(contentType);
		response.getWriter().print(result);	
		response.flushBuffer();
	}
}
