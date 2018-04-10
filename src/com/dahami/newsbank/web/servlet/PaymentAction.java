package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;

/**
 * Servlet implementation class PaymentAction
 */
@WebServlet("/payment.api")
public class PaymentAction extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public PaymentAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		// 로그인 정보 세션 체크
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		if (MemberInfo != null) {

			boolean result = false;
			String cmd = null;		
			int paymentManage_seq = 0;
			int paymentDetail_seq = 0;
			String LGD_OID = null;
			
			if (request.getParameter("cmd") != null) { // 구분
				cmd = request.getParameter("cmd"); // api 구분 crud
			}
			System.out.println("cmd => " + cmd);
			
			if (request.getParameter("paymentManage_seq") != null) { // 구매기록 고유번호
				paymentManage_seq = Integer.parseInt(request.getParameter("paymentManage_seq"));
			}
			System.out.println("paymentManage_seq => " + paymentManage_seq);
			
			if (request.getParameter("paymentDetail_seq") != null) { // 구매기록 상세 고유번호
				paymentDetail_seq = Integer.parseInt(request.getParameter("paymentDetail_seq"));
			}
			System.out.println("paymentManage_seq => " + paymentManage_seq);
			
			if (request.getParameter("LGD_OID") != null) { // 주문번호
				LGD_OID = request.getParameter("LGD_OID");
			}
			System.out.println("LGD_OID => " + LGD_OID);
			
			PaymentManageDTO paymentManageDTO = new PaymentManageDTO();
			PaymentDetailDTO paymentDetailDTO = new PaymentDetailDTO();
			PaymentDAO paymentDAO = new PaymentDAO();
			
			switch(cmd) {
				case "C": // 거래 취소 (Cancel)				
					paymentManageDTO.setMember_seq(MemberInfo.getSeq());
					paymentManageDTO.setLGD_OID(LGD_OID);
					paymentManageDTO.setLGD_RESPCODE("0000"); // 완료코드
					paymentManageDTO.setLGD_PAYSTATUS(5); // 결제취소
					paymentManageDTO = paymentDAO.updatePaymentManage(paymentManageDTO);
					if(paymentManageDTO.getPaymentManage_seq() >0) {
						paymentDetailDTO.setPaymentManage_seq(paymentManageDTO.getPaymentManage_seq());
						paymentDetailDTO.setStatus("1"); // 결제취소
						if(paymentDetail_seq>0) {
							paymentDetailDTO.setPaymentDetail_seq(paymentDetail_seq); // 결제취소
						}
						result = paymentDAO.updatePaymentDetailStatus(paymentDetailDTO);
					}
					
			
					
					break;
					
				case "U":
					break;
					
				case "D": // 개별 다운로드 (Download)
					paymentDetailDTO.setPaymentDetail_seq(paymentDetail_seq);
					paymentDAO.updateDownloadCount(paymentDetailDTO);
					result = true;
					
					break;
			}
			
			JSONObject json = new JSONObject();
			json.put("result", result);
			
			response.getWriter().print(json);
		} else {
			response.getWriter().append(
					"<script type=\"text/javascript\">alert('로그인 페이지로 이동합니다.');location.replace('/login');</script>")
					.append(request.getContextPath());
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
