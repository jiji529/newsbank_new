package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.DownloadService;
import com.dahami.newsbank.web.service.PhotoService;

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
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.addHeader("Cache-Control", "no-cache");
		
		/*HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		if (MemberInfo != null) {
			String member_seq = String.valueOf(MemberInfo.getSeq());
			request.setAttribute("member_seq", member_seq);
		}*/
		
		
		if (closed) {
			return;
		}
		
		if(cmd2 != null && cmd2.equals("down")) {
			DownloadService ds = new DownloadService(cmd3, getParam("uciCode"));
			ds.execute(request, response);
		} else {
			PhotoService ps = new PhotoService();
			ps.execute(request, response);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/photo.jsp");
			dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
