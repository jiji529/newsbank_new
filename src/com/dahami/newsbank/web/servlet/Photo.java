package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.service.DownloadService;
import com.dahami.newsbank.web.service.PhotoService;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class Photo
 */
@WebServlet(
		urlPatterns = {"/photo", "*.photo"},
		loadOnStartup = 1
		)
public class Photo extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    public Photo() {
        super();
    }

    public void init(ServletConfig config) throws ServletException {
    	super.init(config);
    	new SearchDAO().init();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		
		if(cmd.is2("down")) {
			DownloadService ds = new DownloadService();
			ds.execute(request, response);
		} else {
			PhotoService ps = new PhotoService();
			ps.execute(request, response);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/photo.jsp");
			dispatcher.forward(request, response);
		}
	}
}
