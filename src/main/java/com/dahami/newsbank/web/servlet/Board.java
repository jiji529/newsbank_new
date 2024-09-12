package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.BoardDAO;
import com.dahami.newsbank.web.dto.BoardDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class Board
 */
@WebServlet("/board")
public class Board extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public Board() {
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
		
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String action = request.getParameter("action") == null ? "" : request.getParameter("action");
		String keyword = request.getParameter("keyword");
		//String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
		
		BoardDAO boardDAO = new BoardDAO();
		List<BoardDTO> boardList = boardDAO.noticeList(keyword);
		request.setAttribute("boardList", boardList);
		
		if(action.equals("hit")) {
			int board_seq = Integer.parseInt(request.getParameter("board_seq"));
			boardDAO.hitNotice(board_seq);
			
		}/*else if(action.equals("search")) {
			String keyword = request.getParameter("keyword");
			
		}*/
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"board.jsp");
		dispatcher.forward(request, response);
	}
}
