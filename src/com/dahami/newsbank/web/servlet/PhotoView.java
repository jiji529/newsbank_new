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
		String action = request.getParameter("action") == null ? "" : request.getParameter("action");
		String member_seq = request.getParameter("member_seq") == null ? "1002" : request.getParameter("member_seq");
		String photo_uciCode = request.getParameter("photo_uciCode");
		String bookName = request.getParameter("bookName");
		BookmarkDAO bookmarkDAO = new BookmarkDAO();
		
		if(action.equals("insertBookmark")) {
			bookmarkDAO.insert(member_seq, photo_uciCode, bookName);
		}else if(action.equals("deleteBookmark")) {
			bookmarkDAO.delete(Integer.parseInt(member_seq), photo_uciCode);
		}
		
		BookmarkDTO bookmark = bookmarkDAO.select(Integer.parseInt(member_seq), uciCode);
		if(bookmark == null) {
			request.setAttribute("bookmark", bookmark);		
		}else {
			request.setAttribute("bookmark", bookmark);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/photo_view.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
