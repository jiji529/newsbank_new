package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.CMSService;
import com.dahami.newsbank.web.service.IService;
import com.dahami.newsbank.web.service.LogService;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class CMS
 */
@WebServlet(
		urlPatterns = {"/cms", "/view.cms", "/modLog.cms", "/upload.cms", "/cms.manage", "/view.cms.manage", "/modLog.cms.manage", "/upload.cms.manage"},
		loadOnStartup = 1
		)
public class CMS extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public CMS() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		if(response.isCommitted()) {
			return;
		}
		
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		
		HttpSession session = request.getSession();
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		// 로그인 체크
		if(memberInfo == null) {
			processNotLoginAccess(request, response);
			return;
		}
		
		boolean isView = false;
		boolean isModLog = false;
		boolean isAdmin = false;
		boolean isUpload = false;
		
		// 관리자 CMS
		if(cmd.is1("manage")) {
			if(!memberInfo.getType().equals(MemberDTO.TYPE_ADMIN)) {
				processNotAdminAccess(request, response);
				return;
			}
			isAdmin = true;
			if(cmd.is3("view")) {
				isView = true;
			}
			else if(cmd.is3("modLog")) {
				isModLog = true;
			}
			else if(cmd.is3("upload")) {
				isUpload = true;
			}
		}
		// 사용자 CMS
		else {
			// 마이페이지 비밀번호 중복확인 체크
			boolean mypageAuth = false;
			if (session.getAttribute("mypageAuth") != null) {
				mypageAuth = (boolean) session.getAttribute("mypageAuth");
			}
			if (!mypageAuth) {
				response.sendRedirect("/auth.mypage");
				return;
			}
			if(cmd.is2("view")) {
				isView = true;
			}
			else if(cmd.is2("modLog")) {
				isModLog = true;
			}
			else if(cmd.is2("upload")) {
				isUpload = true;
			}
		}
		
		// 요청사항 처리
		IService service = null;
		
		if(isModLog) {
			service = new LogService();
		}
		else {
			service = new CMSService(isView, isAdmin, isUpload);
		}
		service.execute(request, response);
	}
}
