/*******************************************************************************
 * Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : MediaService.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2018. 5. 15. 오후 12:19:30
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2018. 5. 15.     JEON,HYUNGGUK		최초작성
 * 2018. 5. 15.     
 *******************************************************************************/

package com.dahami.newsbank.web.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.common.util.XmlUtil;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

public class MediaService extends ServiceBase {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<MemberDTO> activeMemberList = new MemberDAO().listActiveMedia();
		
		Map<String, Object> root = new HashMap<String, Object>();
		Map<String, Object> mediaMap = new HashMap<String, Object>();
		root.put("mediaList", mediaMap);
		List<Map<String, Object>> mediaList = new ArrayList<Map<String, Object>>();
		mediaMap.put("media", mediaList);
		for(MemberDTO cur : activeMemberList) {
			Map<String, Object> curMap = new HashMap<String, Object>();
			mediaList.add(curMap);
			curMap.put("seq", cur.getSeq());
			curMap.put("name", cur.getCompName());
		}
		
		request.setAttribute("contentType", "text/xml; charset=UTF-8");
		request.setAttribute("result", XmlUtil.MapToXmlString(root));
	}

}
