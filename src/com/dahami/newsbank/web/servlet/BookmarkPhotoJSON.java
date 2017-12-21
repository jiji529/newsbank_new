package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class BookmarkPhotoJSON
 * 보도사진 목록 -사용자별 북마크 사진 목록을 가져오는 부분 (찜 아이콘 표시)
 */
@WebServlet("/bookmarkPhoto.api")
public class BookmarkPhotoJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public BookmarkPhotoJSON() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		// 로그인 여부에 따라서 북마크 목록 가져오기
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		JSONArray jArray = new JSONArray();//배열이 필요할때
		
		if (MemberInfo != null) { // 로그인 여부 확인
			int member_seq = MemberInfo.getSeq();
			BookmarkDAO bookmarkDAO = new BookmarkDAO();
			List<BookmarkDTO> bookmarkList = bookmarkDAO.selectBookmarkPhoto(member_seq);
			request.setAttribute("bookmarkList", bookmarkList);
			
			// 북마크 배열 크기 체크
			if (bookmarkList.size() > 0) {

				for (BookmarkDTO bookmark : bookmarkList) {
					JSONObject arr = new JSONObject();//배열 내에 들어갈 json
					arr.put("seq", bookmark.getSeq());
					arr.put("bookName", bookmark.getBookName());
					arr.put("uciCode", bookmark.getPhoto_uciCode());
					arr.put("member_seq", bookmark.getMember_seq());
					jArray.add(arr);
					
				}
			}
		}
		
		JSONObject json = new JSONObject();

		json.put("message", "");
		json.put("result", jArray);

		response.getWriter().print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
