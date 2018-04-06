package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.service.DownloadService;
import com.dahami.newsbank.web.service.IService;
import com.dahami.newsbank.web.service.PhotoService;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class Photo
 */
@WebServlet(
		urlPatterns = {"/photo", "/view.photo", "*.photo"},
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
		
		IService service = null;
		if(cmd.is2("down")) {
			service = new DownloadService();
		} else {
			if(cmd.is2("view")) {
				service = new PhotoService(true);
			}
			else {
				service = new PhotoService(false);
			}
		}
		service.execute(request, response);
	}
}
