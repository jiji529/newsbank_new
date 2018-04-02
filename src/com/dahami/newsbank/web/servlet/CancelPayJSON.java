package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;

/**
 * Servlet implementation class CancelPurchaseJSON
 */
@WebServlet("/cancelPay.api")
public class CancelPayJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CancelPayJSON() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		boolean result = false;
		
		// 추가
		int LGD_PAYSTATUS = Integer.parseInt(request.getParameter("LGD_PAYSTATUS")); // 거래상태
		String status = request.getParameter("status"); // 
		
		int paymentManage_seq = Integer.parseInt(request.getParameter("paymentManage_seq"));
		String LGD_OID = request.getParameter("LGD_OID");

		PaymentManageDTO paymentManageDTO = new PaymentManageDTO();
		paymentManageDTO.setLGD_OID(LGD_OID);
		paymentManageDTO.setLGD_RESPCODE("0000"); // 완료코드
		paymentManageDTO.setLGD_PAYSTATUS(5); // 결제취소

		PaymentDetailDTO paymentDetailDTO = new PaymentDetailDTO();
		paymentDetailDTO.setPaymentManage_seq(paymentManage_seq);
		paymentDetailDTO.setStatus("1"); // 결제취소
		
		PaymentDAO paymentDAO = new PaymentDAO();
		paymentDAO.updatePaymentManage(paymentManageDTO);
		result = paymentDAO.updatePaymentDetailStatus(paymentDetailDTO);
				
		
		JSONObject json = new JSONObject();
		json.put("result", result);

		response.getWriter().print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

