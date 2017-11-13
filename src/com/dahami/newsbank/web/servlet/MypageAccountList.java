package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.ForEach;

import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.CMSService;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet("/accountlist.mypage")
public class MypageAccountList extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public MypageAccountList() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		// 임시 넣기
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
				if(!MemberInfo.getType().equalsIgnoreCase("M")) {
					response.sendRedirect("/info.mypage");
					return;
				}
				
				request.setAttribute("MemberInfo", MemberInfo);
				
				
				CMSService cs = new CMSService(); //매체목록
				cs.execute(request, response);
				
				List<Map<String, Object>> selectTotalPrice = new ArrayList<Map<String, Object>>();
				Map<String, Object> params = new HashMap<String, Object>();
				Calendar cal = Calendar.getInstance();
				int year = cal.get(Calendar.YEAR);

				params.put("member_seq", MemberInfo.getSeq());
				params.put("start_date", year+"0101");
				params.put("end_date", year+"1231");
				
				PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
				selectTotalPrice = paymentDAO.selectTotalPrice(params); // 회원정보 요청
				request.setAttribute("totalPrice", selectTotalPrice);
				
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_account_list.jsp");
				dispatcher.forward(request, response);
			}
			
		} else {
			response.sendRedirect("/login");
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}