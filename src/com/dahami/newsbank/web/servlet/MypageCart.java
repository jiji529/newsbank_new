package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dao.CartDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;
import com.dahami.newsbank.web.dto.CartDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

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
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		if (MemberInfo != null) {
			
			boolean mypageAuth = false;
			if (session.getAttribute("mypageAuth") != null) {
				mypageAuth = (boolean) session.getAttribute("mypageAuth");
			}
			if (mypageAuth == false) {
				// 이전에 my page 비밀번호 입력했는지 체크
				response.sendRedirect("/auth.mypage");
			} else {
				
				String action = request.getParameter("action") == null ? "" : request.getParameter("action");
				String member_seq = String.valueOf(MemberInfo.getSeq());
				String uciCode = request.getParameter("uciCode");
				CartDAO cartDAO = new CartDAO();
				List<CartDTO> cartList = cartDAO.cartList(member_seq);
				request.setAttribute("cartList", cartList);
				
				if(action.equals("delete")) {
					cartDAO.deleteCart(member_seq, uciCode);
				}else if(action.equals("bookmark")) {
					String bookName = "기본그룹"; // 기본값
					BookmarkDAO bookmarkDAO = new BookmarkDAO();
					BookmarkDTO bookmark = bookmarkDAO.select(Integer.parseInt(member_seq), uciCode);
					if(bookmark == null) { // 중복 데이터 확인
						bookmarkDAO.insert(member_seq, uciCode, bookName);
					}
					
				}
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_cart.jsp");
				dispatcher.forward(request, response);
			}
		}else {
			response.sendRedirect("/login");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
