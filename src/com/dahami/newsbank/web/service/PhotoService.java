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

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

public class PhotoService extends ServiceBase {
	
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		MemberDAO mDao = new MemberDAO();
		List<MemberDTO> mediaList = mDao.listActiveMedia();
		
		request.setAttribute("mediaList", mediaList);
	
		String keyword = request.getParameter("keyword");
		if(keyword != null && keyword.trim().length() > 0) {
			request.setAttribute("keyword", keyword.trim());
		}
		else {
			request.setAttribute("keyword", "");
		}
	}
}
