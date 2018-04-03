package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.CMSService;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class CMS
 */
@WebServlet(
		urlPatterns = {"/cms", "/view.cms"},
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
		CmdClass cmd = CmdClass.getInstance(request);
		
		HttpSession session = request.getSession();
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		// 로그인 체크
		if(memberInfo == null) {
			response.sendRedirect("/login");
			return;
		}
		
		// 마이페이지 비밀번호 중복확인 체크
		boolean mypageAuth = false;
		if (session.getAttribute("mypageAuth") != null) {
			mypageAuth = (boolean) session.getAttribute("mypageAuth");
		}
		if (!mypageAuth) {
			response.sendRedirect("/auth.mypage");
			return;
		}
		
		// 요청사항 처리
		CMSService cs = null;
		if(cmd.is2("view")) {
			cs = new CMSService(true);
		}
		else {
			cs = new CMSService(false);
		}
		cs.execute(request, response);
	}
}
