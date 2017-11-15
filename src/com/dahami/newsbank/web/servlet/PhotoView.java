package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.PhotoViewService;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

/**
 * Servlet implementation class PictureView
 */
@WebServlet(
		urlPatterns = {"/view.photo"},
		loadOnStartup = 1
		)
public class PhotoView extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public PhotoView() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		String member_seq = String.valueOf(MemberInfo.getSeq());
		request.setAttribute("member_seq", member_seq);
		
		PhotoViewService pvs = new PhotoViewService();
		pvs.execute(request, response);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/photo_view.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
