package com.dahami.newsbank.web.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

public class CMSService extends ServiceBase {	

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		int member_seq = 0;
		
		if (MemberInfo != null) { 
			member_seq = MemberInfo.getSeq();
		} else {
			
		}
		
		MemberDAO mDao = new MemberDAO();
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setSeq(member_seq);
		List<MemberDTO> mediaList = mDao.listAdjustMedia(memberDTO);
		
		request.setAttribute("mediaList", mediaList);

	}

}
