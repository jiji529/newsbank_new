/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : PhotoService.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 11. 1. 오후 3:01:47
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 11. 1.     JEON,HYUNGGUK		최초작성
 * 2017. 11. 1.     
 *******************************************************************************/

package com.dahami.newsbank.web.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

public class PhotoService extends ServiceBase {
	private boolean isViewMode;
	private String mediaRange;
	
	public PhotoService(boolean isViewMode, String mediaRange) {
		this.isViewMode = isViewMode;
		this.mediaRange = mediaRange;
	}
	
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 활성 매체사 세팅
		MemberDAO mDao = new MemberDAO();
		List<MemberDTO> mediaList = new ArrayList<MemberDTO>();
		if(this.mediaRange.equals("all")) {
			mediaList = mDao.listActiveMedia();			
		} else if(this.mediaRange.equals("Domestic")) {
			mediaList = mDao.listActiveMedia();
			mediaList.removeIf(data -> data.getSeq() == 999);
		} else if(this.mediaRange.equals("Foreign")) {
			mediaList = mDao.listActiveMedia();
			mediaList.removeIf(data -> data.getSeq() != 999);
		}
		request.setAttribute("mediaList", mediaList);
		
		// 넘어온 파라메터 세팅
		request.setAttribute("sParam", makeSearchParamMap(request.getParameterMap()));
		
		String forward = null;
		if(isViewMode) {
			PhotoDAO photoDAO = new PhotoDAO();
			String uciCode = request.getParameter("uciCode");
			PhotoDTO photoDTO = photoDAO.read(uciCode);
			request.setAttribute("photoDTO", photoDTO);
			
			// photoDTO 있음
			if(!photoDTO.getUciCode().equals(PhotoDTO.UCI_ORGAN_CODEPREFIX_DAHAMI)) {
				photoDAO.hit(uciCode);
				
				HttpSession session = request.getSession();
				MemberDTO memberInfo = (MemberDTO) session.getAttribute("MemberInfo");
				if(memberInfo != null) {
					request.setAttribute("bookmark", new BookmarkDAO().select(memberInfo.getSeq(), uciCode));
				}
			}
			forward = "/WEB-INF/jsp"+Constants.JSP_BASHPATH+"photo_view.jsp";
		}
		else {
			// 필터에서 관리자/소유자용 항목 표시 안하기 위해
			request.setAttribute("serviceMode", true);
			
			// 선택 언론사 카테고리를 전달받았을 때
			if(request.getParameter("seq") != null) {
				
				MemberDAO memberDAO = new MemberDAO();
				int seq = Integer.parseInt(request.getParameter("seq"));
				MemberDTO memberDTO = memberDAO.getMember(seq);
				
				request.setAttribute("seq", seq);
				request.setAttribute("compName", memberDTO.getCompName());
			}
			
			forward = "/WEB-INF/jsp"+Constants.JSP_BASHPATH+"photo.jsp";
		}
		forward(request, response, forward);
	}
}
