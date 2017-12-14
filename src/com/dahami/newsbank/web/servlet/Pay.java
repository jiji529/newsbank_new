package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.PayDAO;
import com.dahami.newsbank.web.dto.CartDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class Pay
 */
@WebServlet(urlPatterns = { "/pay" }, loadOnStartup = 1)
public class Pay extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public Pay() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		System.setProperty("jsse.enableSNIExtension", "false"); //handshake alert: unrecognized_name 에러

		// 로그인 정보 세션 체크
		HttpSession session = request.getSession();

		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		if (MemberInfo != null) {

 			String cartArry = request.getParameter("cartArry");
			if (cartArry != null && !cartArry.isEmpty()) {
				List<CartDTO> payList = new ArrayList<CartDTO>();
				String[] splitCart = cartArry.split(",");
				System.out.println(splitCart.length);
				for (int num = 0; num < splitCart.length; num++) {
					String[] items = splitCart[num].split("\\|");
					String[] usageList = new String[items.length - 1];
					String uciCode = "";

					for (int idx = 0; idx < items.length; idx++) {
						if (idx == 0) {
							uciCode = items[idx];
						} else {
							String usageList_seq = items[idx];
							usageList[idx - 1] = usageList_seq;
						}
					}
					PayDAO payDAO = new PayDAO();
					payList.add(payDAO.payList(uciCode, usageList));
				}
				request.setAttribute("payList", payList);

				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pay.jsp");
				dispatcher.forward(request, response);
			} else {
				response.getWriter().append("<script type=\"text/javascript\">alert('결제할 사진을 선택해 주세요.');history.back(-1);</script>").append(request.getContextPath());
			}

		} else {
			response.getWriter().append("<script type=\"text/javascript\">alert('로그인 페이지로 이동합니다.');location.replace('/login');</script>").append(request.getContextPath());
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
