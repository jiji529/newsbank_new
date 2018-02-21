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
@WebServlet("/bookmark.api")
public class BookmarkAction extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public BookmarkAction() {
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
		boolean success = true;
		String message = "";
		String bookName = request.getParameter("bookName");
		String uciCode = request.getParameter("uciCode");
		int bookmark_seq = 0;
		
		if (MemberInfo != null) { // 로그인 여부 확인
			int member_seq = MemberInfo.getSeq();
			BookmarkDAO bookmarkDAO = new BookmarkDAO();			
			String action = request.getParameter("action");
			
			if(action.equals("list")){ // 북마크 목록
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
				
			} else if(action.equals("insertBookmark")) { // 찜 추가
				BookmarkDTO bookmark = bookmarkDAO.select(member_seq, uciCode);
				if(bookmark == null) { // 중복 데이터 확인
					bookName = "기본폴더";
					bookmarkDAO.insert(member_seq, uciCode, bookName);
				} else {
					message = "이미 찜폴더에 존재합니다.";
					success = false;
				}
				
			} else if(action.equals("deleteBookmark")) { // 찜 삭제
				
				if(uciCode.contains("|")) {
					String[] photo_uciCode = uciCode.split("\\|");
					for (String code : photo_uciCode) {
						bookmarkDAO.delete(member_seq, code);
					}
				} else { // 단일 선택
					bookmarkDAO.delete(member_seq, uciCode);
				}
				
			} else if(action.equals("updateBookmark")) { // 찜 폴더 위치 수정
				bookmark_seq = Integer.parseInt(request.getParameter("bookmark_seq"));
				
				if(uciCode.contains("|")) {
					String[] photo_uciCode = uciCode.split("\\|");
					for (String code : photo_uciCode) {
						bookmarkDAO.updateBookmarkPhoto(bookmark_seq, code);
					}
				} else { // 단일 선택
					bookmarkDAO.updateBookmarkPhoto(bookmark_seq, uciCode);
				}
				
			} else if(action.equals("insertFolder")) { // 폴더 추가
				bookmarkDAO.insertFolder(member_seq, bookName);
				
			} else if(action.equals("deleteFolder")) { // 폴더 삭제
				bookmark_seq = Integer.parseInt(request.getParameter("bookmark_seq"));
				bookmarkDAO.deleteFolder(member_seq, bookmark_seq);
				
			} else if(action.equals("updateFolder")) { // 폴더명 수정
				bookmark_seq = Integer.parseInt(request.getParameter("bookmark_seq"));
				bookmarkDAO.updateFolder(member_seq, bookName, bookmark_seq);
			}
			
			
		}
		
		JSONObject json = new JSONObject();

		json.put("success", success);
		json.put("message", message);
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
