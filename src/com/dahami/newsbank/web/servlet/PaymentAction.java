package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

import lgdacom.XPayClient.XPayClient;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
			String message = "";

			/**
			 * 결제정보
			 */
			// String configPath = "C:/lgdacom"; //LG유플러스에서 제공한
			// 환경파일("/conf/lgdacom.conf,/conf/mall.conf") 위치 지정.
			String realPath = request.getSession().getServletContext().getRealPath("/"); // request.getRealPath("/");
			String configPath = realPath + "lgdacom"; // LG텔레콤에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.

			String CST_PLATFORM = "test";// LG유플러스 결제서비스 선택(test:테스트, service:서비스)
			String CST_MID = "dahaminewsbank"; // LG유플러스로 부터 발급받으신 상점아이디를 입력하세요.
			String LGD_MID = ("test".equals(CST_PLATFORM.trim()) ? "t" : "") + CST_MID; // 테스트 아이디는 't'를 제외하고 입력하세요.
																						// 상점아이디(자동생성)
			/********************************/

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

			switch (cmd) {
			case "C": // 거래 취소 (Cancel)
				paymentManageDTO.setMember_seq(MemberInfo.getSeq());
				paymentManageDTO.setLGD_OID(LGD_OID);
				paymentManageDTO = paymentDAO.selectPaymentManage(paymentManageDTO);
				if (paymentManageDTO.getPaymentManage_seq() > 0) {
					long time = System.currentTimeMillis();
					SimpleDateFormat dayTime = new SimpleDateFormat("yyyymmdd");
					String today = dayTime.format(new Date(time));
					String paydate = paymentManageDTO.getLGD_PAYDATE();
					int gap = Integer.parseInt(today) - Integer.parseInt(paydate); // 소요기간
					if (gap <= 7) {
						/**
						 * 결제 취소 모듈
						 */
						XPayClient xpay = new XPayClient();
						xpay.Init(configPath, CST_PLATFORM);
						xpay.Init_TX(LGD_MID);
						xpay.Set("LGD_TXNAME", "Cancel");
						xpay.Set("LGD_TID", paymentManageDTO.getLGD_TID());
						if (xpay.TX()) {
							// 1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)

							paymentManageDTO.setLGD_RESPCODE("0000"); // 완료코드
							paymentManageDTO.setLGD_PAYSTATUS(5); // 결제취소
							paymentManageDTO = paymentDAO.updatePaymentManage(paymentManageDTO);

							paymentDetailDTO.setPaymentManage_seq(paymentManageDTO.getPaymentManage_seq());
							paymentDetailDTO.setStatus("1"); // 결제취소
							if (paymentDetail_seq > 0) {
								// 개별 결제 취소건
								paymentDetailDTO.setPaymentDetail_seq(paymentDetail_seq); // 결제취소
							}
							result = paymentDAO.updatePaymentDetailStatus(paymentDetailDTO);

						} else {
							// 2)API 요청 실패 화면처리
							System.out.println("결제 취소요청이 실패하였습니다.  <br>");
							System.out.println("TX Response_code = " + xpay.m_szResCode + "<br>");
							System.out.println("TX Response_msg = " + xpay.m_szResMsg + "<p>");
							message = "결제 취소요청이 실패하였습니다. ";
						}

					} else {
						message = "다운로드 받은 내역이 있을 시, 환불이 불가능합니다.\n (환불가능기간은 결제일로부터 7일 이내입니다.)";
					}
				} else {
					message = "결제 정보를 찾을 수 없습니다.";
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
			json.put("message", message);

			response.getWriter().print(json);
		} else {
			response.getWriter().append(
					"<script type=\"text/javascript\">alert('로그인 페이지로 이동합니다.');location.replace('/login');</script>")
					.append(request.getContextPath());
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
