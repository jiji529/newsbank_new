package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

/**
 * Servlet implementation class PictureView
 */
@WebServlet(
		urlPatterns = {"/view.picture"},
		loadOnStartup = 1
		)
public class PhotoView extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public PhotoView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		//SearchParameterBean parameterBean = new SearchParameterBean();
		//List<PhotoDTO> photoList = searchDAO.search(parameterBean);
		
		PhotoDAO photoDAO = new PhotoDAO();
		String uciCode = request.getParameter("uciCode");
		PhotoDTO photoDTO = photoDAO.read(uciCode);
		request.setAttribute("photoDTO", photoDTO);
		
		int member_seq = 1002;
		
		BookmarkDAO bookmarkDAO = new BookmarkDAO();
		BookmarkDTO bookmark = bookmarkDAO.select(member_seq, uciCode);
		if(bookmark == null) {
			System.out.println("북마크 없음");
			request.setAttribute("bookmark", null);
		}else {
			request.setAttribute("bookmark", bookmark);
			System.out.println("북마크 존재");
		}
		
		//System.out.println("bookmark seq : "+bookmark.getSeq());
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/picture_view.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		String action = request.getParameter("action");
		String member_seq = request.getParameter("member_seq");
		String photo_uciCode = request.getParameter("photo_uciCode");
		String bookName = request.getParameter("bookName");
		
		if(action.equals("bookmark")) {
			BookmarkDAO bookmarkDAO = new BookmarkDAO();
			bookmarkDAO.insert(member_seq, photo_uciCode, bookName);
		}else {
			System.out.println("ACTION parameter error");
		}
	}

}
