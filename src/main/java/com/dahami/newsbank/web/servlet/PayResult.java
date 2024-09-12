package com.dahami.newsbank.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class PayResult
 */
@WebServlet("/result.pay")
public class PayResult extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PayResult() {
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
		
		String lGD_OID;

		// 로그인 정보 세션 체크
		HttpSession session = request.getSession();

		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		if (MemberInfo != null) {
			lGD_OID = request.getParameter("orderNo");

			PaymentManageDTO paymentManageDTO = new PaymentManageDTO();
			paymentManageDTO.setLGD_OID(lGD_OID);
			paymentManageDTO.setMember_seq(MemberInfo.getSeq());

			PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
			paymentManageDTO = paymentDAO.selectPaymentManage(paymentManageDTO);
			request.setAttribute("paymentManageDTO", paymentManageDTO);
		}

		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"pay_result.jsp");
		dispatcher.forward(request, response);			
	}
}
