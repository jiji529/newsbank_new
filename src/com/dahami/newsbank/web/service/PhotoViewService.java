/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : PhotoViewService.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 11. 14. 오후 10:28:00
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 11. 14.     JEON,HYUNGGUK		최초작성
 * 2017. 11. 14.     
 *******************************************************************************/

package com.dahami.newsbank.web.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

public class PhotoViewService extends ServiceBase {

	/* (non-Javadoc)
	 * @see com.dahami.newsbank.web.service.ServiceBase#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		//String member_seq = (MemberInfo != null) ? String.valueOf(MemberInfo.getSeq()) : "1002";
		// 찜 추가, 삭제에서 로그인 여부를 체크이후 기능 동작필요
		
		PhotoDAO photoDAO = new PhotoDAO();
		String uciCode = request.getParameter("uciCode");
		PhotoDTO photoDTO = photoDAO.read(uciCode);
		photoDAO.hit(uciCode);
		request.setAttribute("photoDTO", photoDTO);
		String action = request.getParameter("action") == null ? "" : request.getParameter("action");
		String photo_uciCode = request.getParameter("photo_uciCode");
		String bookName = request.getParameter("bookName");
		BookmarkDAO bookmarkDAO = new BookmarkDAO();
		
		MemberDAO mDao = new MemberDAO();
		List<MemberDTO> mediaList = mDao.listActiveMedia();
		request.setAttribute("mediaList", mediaList);
		
		if(MemberInfo != null) {
			String member_seq = String.valueOf(MemberInfo.getSeq());
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
		}
	}

}
