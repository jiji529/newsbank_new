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
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

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
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		if (MemberInfo != null) {
			
			boolean mypageAuth = false;
			if (session.getAttribute("mypageAuth") != null) {
				mypageAuth = (boolean) session.getAttribute("mypageAuth");
			}
			if (mypageAuth == false) {
				// 이전에 my page 비밀번호 입력했는지 체크
				response.sendRedirect("/auth.mypage");
			} else {
				
				int pageVol = 40; // 페이지당 표현 갯수
				int pageNo = 0; // 시작 인덱스
				int member_seq = MemberInfo.getSeq();
				int bookmark_seq = request.getParameter("bookmark_seq") == null ? 0 : Integer.parseInt(request.getParameter("bookmark_seq"));
				PhotoDAO photoDAO = new PhotoDAO();
				
				List<PhotoDTO> dibsPhotoList = photoDAO.dibsPhotoList(member_seq, bookmark_seq, pageVol, pageNo);
				List<PhotoDTO> totalList = photoDAO.dibsPhotoList(member_seq, bookmark_seq, 0, 0); // 전체 목록
				
				request.setAttribute("dibsPhotoList", dibsPhotoList); // 북마크한 사진 목록
				
				BookmarkDAO bookmarkDAO = new BookmarkDAO();
				List<BookmarkDTO> bookmarkList = bookmarkDAO.userBookmark(member_seq);
				request.setAttribute("bookmarkList", bookmarkList); // 북마크 폴더목록
				
				int totalCount = totalList.size(); // 전체 갯수
				int totalPage = (totalCount / pageVol) + 1; // 페이지 갯수
				
				request.setAttribute("totalCount", totalCount);
				request.setAttribute("totalPage", totalPage);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_dibs.jsp");
				dispatcher.forward(request, response);
			}
			
		}else {
			response.sendRedirect("/login");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);		
	}

}
