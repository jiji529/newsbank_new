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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;

public class PhotoViewService extends ServiceBase {

	/* (non-Javadoc)
	 * @see com.dahami.newsbank.web.service.ServiceBase#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PhotoDAO photoDAO = new PhotoDAO();
		String uciCode = request.getParameter("uciCode");
		PhotoDTO photoDTO = photoDAO.read(uciCode);
		photoDAO.hit(uciCode);
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
	}

}
