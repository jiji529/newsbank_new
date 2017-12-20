package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.web.service.SearchCMSService;
import com.dahami.newsbank.web.service.SearchService;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class CMSSearch
 */
@WebServlet("/cms.search")
public class CMSSearch extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public CMSSearch() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		
		SearchCMSService ss = new SearchCMSService();
		ss.execute(request, response);
		
		String jsonStr = (String) request.getAttribute("JSON");
		response.getWriter().print(jsonStr);
		response.flushBuffer();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
