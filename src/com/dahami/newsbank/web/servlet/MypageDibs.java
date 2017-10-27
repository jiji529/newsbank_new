package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;

/**
 * Servlet implementation class MypageDibs
 */
@WebServlet(
		urlPatterns = {"/dibs.myPage"},
		loadOnStartup = 1
		)
public class MypageDibs extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public MypageDibs() {
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
		
		String member_seq = "1002"; // 사용자 정보 쿠키나 세션에서 정보 가져오기 (현재 임시로 지정)
		String bookmark_seq = request.getParameter("bookmark_seq");
		PhotoDAO photoDAO = new PhotoDAO();
		List<PhotoDTO> dibsPhotoList = photoDAO.dibsPhotoList(member_seq, bookmark_seq);
		request.setAttribute("dibsPhotoList", dibsPhotoList);
		
		BookmarkDAO bookmarkDAO = new BookmarkDAO();
		List<BookmarkDTO> bookmarkList = bookmarkDAO.userBookmark(Integer.parseInt(member_seq));
		request.setAttribute("bookmarkList", bookmarkList);
		
		String action = (request.getParameter("action") == null) ? "" : request.getParameter("action");
		String photo_uciCode = request.getParameter("photo_uciCode");
		
		if(action.equals("delete")) {
			bookmarkDAO.delete(Integer.parseInt(member_seq), photo_uciCode);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_dibs.jsp");
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
