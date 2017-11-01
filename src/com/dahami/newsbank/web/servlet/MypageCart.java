package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dao.CartDAO;
import com.dahami.newsbank.web.dto.CartDTO;

/**
 * Servlet implementation class MypageCart
 */
@WebServlet(
		urlPatterns = {"/cart.myPage"},
		loadOnStartup = 1
		)
public class MypageCart extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public MypageCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String action = request.getParameter("action") == null ? "" : request.getParameter("action");
		String member_seq = "1002";		
		String uciCode = request.getParameter("uciCode");
		CartDAO cartDAO = new CartDAO();
		List<CartDTO> cartList = cartDAO.cartList(member_seq);
		request.setAttribute("cartList", cartList);
		
		if(action.equals("delete")) {
			cartDAO.deleteCart(member_seq, uciCode);
		}else if(action.equals("bookmark")) {
			String bookName = "기본그룹"; // 기본값
			BookmarkDAO bookmarkDAO = new BookmarkDAO();
			bookmarkDAO.insert(member_seq, uciCode, bookName);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_cart.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
