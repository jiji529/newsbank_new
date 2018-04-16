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

import com.dahami.newsbank.web.dao.BoardDAO;
import com.dahami.newsbank.web.dto.BoardDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.BoardService;

/**
 * Servlet implementation class AdminBoardView
 */
@WebServlet("/view.board.manage")
public class AdminBoardView extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminBoardView() {
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
				
				BoardDTO boardDTO = new BoardDTO();
				
				if(request.getParameter("seq") != ""){ // 수정 페이지
					int seq = Integer.parseInt(request.getParameter("seq"));
					BoardDAO boardDAO = new BoardDAO();	
					boardDTO = boardDAO.getNotice(seq);
					
					request.setAttribute("boardDTO", boardDTO);
				}
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin_board_view.jsp");
				dispatcher.forward(request, response);
				
			} else {
				JOptionPane.showMessageDialog(null, "해당페이지는 관리자만 접근할 수 있습니다.\n 메인페이지로 이동합니다.");
				response.sendRedirect("/home");
			}			
			
			
		} else {
			response.sendRedirect("/login");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
