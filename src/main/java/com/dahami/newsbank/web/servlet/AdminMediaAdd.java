package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class AdminMediaAdd
 */
@WebServlet("/add.media.manage")
public class AdminMediaAdd extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminMediaAdd() {
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
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		
		if (MemberInfo != null) {
			if(MemberInfo.getType().equals("A")) { // 관리자 권한만 접근
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"admin_media_add.jsp");
				dispatcher.forward(request, response);
				
			} else {
				processNotAdminAccess(request, response);
				return;
			}
		} else {
			response.sendRedirect("/login");
		}
	}

}
