package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.BookmarkDAO;
import com.dahami.newsbank.web.dao.CartDAO;
import com.dahami.newsbank.web.dto.BookmarkDTO;
import com.dahami.newsbank.web.dto.CartDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

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
			
			boolean mypageAuth = false;
			if (session.getAttribute("mypageAuth") != null) {
				mypageAuth = (boolean) session.getAttribute("mypageAuth");
			}
			if (mypageAuth == false) {
				// 이전에 my page 비밀번호 입력했는지 체크
				response.sendRedirect("/auth.mypage");
				
			} else {						
				int member_seq = MemberInfo.getSeq();
				CartDAO cartDAO = new CartDAO();
				List<CartDTO> cartList = cartDAO.cartList(String.valueOf(member_seq));
				request.setAttribute("cartList", cartList);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"mypage_cart.jsp");
				dispatcher.forward(request, response);					
			}
		}else {
			response.sendRedirect("/login");
		}
	}
}
