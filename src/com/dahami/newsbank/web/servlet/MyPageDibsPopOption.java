package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class MyPageDibsPopup
 */
@WebServlet("/dibs.popOption")
public class MyPageDibsPopOption extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public MyPageDibsPopOption() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		
		String action = (request.getParameter("action") == null) ? "" : request.getParameter("action");
		String bookName = request.getParameter("bookName");
		int bookmark_seq = (request.getParameter("bookmark_seq") == null) ? 0 : Integer.parseInt(request.getParameter("bookmark_seq"));
		
		int member_seq = MemberInfo.getSeq();
		
		BookmarkDAO bookmarkDAO = new BookmarkDAO();
		List<BookmarkDTO> bookmarkList = bookmarkDAO.userBookmark(member_seq);
		
		if(action.equals("insertBookmark")) {
			bookmark_seq = bookmarkDAO.insertFolder(member_seq, bookName);
			request.setAttribute("bookmark_seq", bookmark_seq);
			
		}else if(action.equals("updateBookmark")) {
			bookmarkDAO.updateFolder(member_seq, bookName, bookmark_seq);
			
		}else if(action.equals("deleteBookmark")) {
			bookmarkDAO.deleteFolder(member_seq, bookmark_seq);
		}
		
		request.setAttribute("bookmarkList", bookmarkList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pop_zzim.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
