package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.BoardService;

/**
 * Servlet implementation class AdminBoard
 */
@WebServlet("/board.manage")
public class AdminBoard extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminBoard() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		if (MemberInfo != null) {
			
			if(MemberInfo.getType().equals("A")) { // 관리자 권한만 접근
				
				BoardService boardService = new BoardService();
				boardService.execute(request, response);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin_board.jsp");
				dispatcher.forward(request, response);
				
			} else {
				processNotAdminAccess(request, response);
				return;
			}			
		} else {
			processNotLoginAccess(request, response);
		}
	}
}
