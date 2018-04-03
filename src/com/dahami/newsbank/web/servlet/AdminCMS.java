package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.CMSService;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class CMSManage
 */
@WebServlet(
		urlPatterns = {"/cms.manage", "/view.cms.manage"},
		loadOnStartup = 1
		)
public class AdminCMS extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminCMS() {
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

		// 관리자 권한만 접근
		if(!memberInfo.getType().equals(MemberDTO.TYPE_ADMIN)) {
			JOptionPane.showMessageDialog(null, "해당페이지는 관리자만 접근할 수 있습니다.\n 메인페이지로 이동합니다.");
			response.sendRedirect("/home");
		}
		else {
			// 요청사항 처리
			CMSService cs = null;
			if(cmd.is3("view")) {
				cs = new CMSService(true, true);
			}
			else {
				cs = new CMSService(false, true);
			}
			cs.execute(request, response);
//			
//			MemberDAO mDao = new MemberDAO();
//			MemberDTO memberDTO = new MemberDTO();
//			List<MemberDTO> mediaList = mDao.listActiveMedia();
//			request.setAttribute("mediaList", mediaList);
//			
//			SearchParameterBean parameterBean = new SearchParameterBean();
//			String cms_keyword = request.getParameter("cms_keyword_current") == null ? "" : request.getParameter("cms_keyword_current");
//			parameterBean.setPageVol(40);
//			request.setAttribute("cms_keyword", cms_keyword);
//			
//			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin_cms.jsp");
//			dispatcher.forward(request, response);
		}
	}
}
