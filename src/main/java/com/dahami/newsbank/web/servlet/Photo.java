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

    @Override
    public void init(ServletConfig config) throws ServletException {
    	super.init(config);
    	SearchDAO.init();
    }
    
    @Override
    public void destroy() {
    	SearchDAO.destroy();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		if(response.isCommitted()) {
			return;
		}
		
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		// Referer 헤더 가져오기
		String referer = request.getHeader("Referer");		
		
		IService service = null;
		if(cmd.is2("down")) {
			service = new DownloadService();
		} else {
			if(cmd.is2("view")) {
				if(referer.indexOf("Domestic.photo")!=-1) {
					service = new PhotoService(true, "Domestic");
				} else if(referer.indexOf("Foreign.photo")!=-1) {
					service = new PhotoService(true, "Foreign");
				} else {
					service = new PhotoService(true, "all");					
				}
				request.setAttribute("referer",referer);
			}
			else {
				if(cmd.is2("Domestic")) {
					service = new PhotoService(false, "Domestic");
				} else if(cmd.is2("Foreign")) {
					service = new PhotoService(false, "Foreign");
				} else {
					service = new PhotoService(false, "all");					
				}
			}
		}
		service.execute(request, response);
	}
}
