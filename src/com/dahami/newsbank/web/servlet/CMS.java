package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.CMSService;
import com.dahami.newsbank.web.service.IService;
import com.dahami.newsbank.web.service.LogService;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class CMS
 */
@WebServlet(
		urlPatterns = {"/cms", "/view.cms", "/modLog.cms", "/cms.manage", "/view.cms.manage", "/modLog.cms.manage"},
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
		
		boolean isView = false;
		boolean isModLog = false;
		boolean isAdmin = false;
		
		// 관리자 CMS
		if(cmd.is1("manage")) {
			if(!memberInfo.getType().equals(MemberDTO.TYPE_ADMIN)) {
				JOptionPane.showMessageDialog(null, "해당페이지는 관리자만 접근할 수 있습니다.\n 메인 페이지로 이동합니다.");
				response.sendRedirect("/home");
				return;
			}
			isAdmin = true;
			if(cmd.is3("view")) {
				isView = true;
			}
			else if(cmd.is3("modLog")) {
				isModLog = true;
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
				JOptionPane.showMessageDialog(null, "해당페이지는 로그인 하여야 접근할 수 있습니다.\n메인 페이지로 이동합니다.");
				response.sendRedirect("/auth.mypage");
				return;
			}
			if(cmd.is2("view")) {
				isView = true;
			}
			else if(cmd.is2("modLog")) {
				isModLog = true;
			}
		}
		
		// 요청사항 처리
		IService service = null;
		
		if(isModLog) {
			service = new LogService();
		}
		else {
			service = new CMSService(isView, isAdmin);
		}
		service.execute(request, response);
	}
}
