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

import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class MypageBuy
 */
@WebServlet(urlPatterns = { "/buy.mypage" }, loadOnStartup = 1)
public class MypageBuy extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public MypageBuy() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
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

				request.setAttribute("type", MemberInfo.getType());

				String LGD_OID = request.getParameter("LGD_OID"); // 주문번호 request
				
				//selectPaymentManage
				PaymentManageDTO paymentManageDTO = new PaymentManageDTO(); // 객체 생성
				paymentManageDTO.setMember_seq(MemberInfo.getSeq());
				paymentManageDTO.setLGD_OID(LGD_OID);
				//paymentManageDTO.setLGD_PAYSTATUS(1);
				
				PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
				paymentManageDTO = paymentDAO.selectPaymentManage(paymentManageDTO); // 회원정보 요청
				
				request.setAttribute("paymentManageDTO", paymentManageDTO);

				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_buy.jsp");
				dispatcher.forward(request, response);
			}

		} else {
			response.sendRedirect("/login");
		}
	}
}