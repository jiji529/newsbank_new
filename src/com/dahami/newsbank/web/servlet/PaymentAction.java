package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.CalculationDAO;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.CalculationDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

import lgdacom.XPayClient.XPayClient;

/**
 * Servlet implementation class PaymentAction
 */
@WebServlet(
		urlPatterns = {"/payment.api", "/payment.api.manage"},
		loadOnStartup = 1
		)
public class PaymentAction extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public PaymentAction() {
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
		
		CmdClass cmdClass = CmdClass.getInstance(request);

		// 로그인 정보 세션 체크
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		if (MemberInfo != null) {

			boolean result = false;
			String message = "";

			/**
			 * 결제정보
			 */
			// String configPath = "C:/lgdacom"; //LG유플러스에서 제공한
			// 환경파일("/conf/lgdacom.conf,/conf/mall.conf") 위치 지정.
			String realPath = request.getSession().getServletContext().getRealPath("/"); // request.getRealPath("/");
			String configPath = realPath + "lgdacom"; // LG텔레콤에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.

			String CST_PLATFORM = "service";// LG유플러스 결제서비스 선택(test:테스트, service:서비스)
			if(MemberInfo.getId().equalsIgnoreCase("dahami_test")) {
				CST_PLATFORM = "test";
			}
			String CST_MID = "dahaminewsbank"; // LG유플러스로 부터 발급받으신 상점아이디를 입력하세요.
			String LGD_MID = ("test".equals(CST_PLATFORM.trim()) ? "t" : "") + CST_MID; // 테스트 아이디는 't'를 제외하고 입력하세요.
																						// 상점아이디(자동생성)
			/********************************/

			String action = (request.getParameter("action") == null) ? "" : request.getParameter("action"); // api 구분 crud
			int paymentManage_seq = (request.getParameter("paymentManage_seq") == null) ? 0
					: Integer.parseInt(request.getParameter("paymentManage_seq")); // 구매기록 고유번호
			int paymentDetail_seq = (request.getParameter("paymentDetail_seq") == null) ? 0
					: Integer.parseInt(request.getParameter("paymentDetail_seq"));// 구매기록 상세 고유번호
			String LGD_OID = (request.getParameter("LGD_OID") == null) ? "" : request.getParameter("LGD_OID"); // 주문번호

			/*
			 * if (request.getParameter("paymentManage_seq") != null) { // 구매기록 고유번호
			 * paymentManage_seq =
			 * Integer.parseInt(request.getParameter("paymentManage_seq")); }
			 * 
			 * if (request.getParameter("paymentDetail_seq") != null) { // 구매기록 상세 고유번호
			 * paymentDetail_seq =
			 * Integer.parseInt(request.getParameter("paymentDetail_seq")); }
			 * 
			 * if (request.getParameter("LGD_OID") != null) { // 주문번호 LGD_OID =
			 * request.getParameter("LGD_OID"); }
			 */

			System.out.println("action => " + action);
			System.out.println("paymentManage_seq => " + paymentManage_seq);
			System.out.println("paymentManage_seq => " + paymentManage_seq);
			System.out.println("LGD_OID => " + LGD_OID);

			PaymentManageDTO paymentManageDTO = new PaymentManageDTO();
			PaymentDetailDTO paymentDetailDTO = new PaymentDetailDTO();
			PaymentDAO paymentDAO = new PaymentDAO();
			PhotoDAO photoDAO = new PhotoDAO();

			switch (action) {
			case "C": // 거래 취소 (Cancel)
				if(cmdClass.is1("manage")) {
					// 관리자 페이지에서 접근
					int member_seq = Integer.parseInt(request.getParameter("member_seq"));
					paymentManageDTO.setMember_seq(member_seq); // 결제한 사용자 정보를 전달
				}else {
					// 사용자 페이지에서 접근
					paymentManageDTO.setMember_seq(MemberInfo.getSeq());
				}			
				paymentManageDTO.setLGD_OID(LGD_OID);
				paymentManageDTO = paymentDAO.selectPaymentManage(paymentManageDTO);
				if (paymentManageDTO.getPaymentManage_seq() > 0) {
					SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
					String today = dayTime.format(new Date());
					String paydate = paymentManageDTO.getLGD_PAYDATE().substring(0, 8);
					int gap = Integer.parseInt(today) - Integer.parseInt(paydate); // 소요기간 7일 이내 확인
					
					
					
					if (gap <= 7 || cmdClass.is1("manage")) {
						// 결제 취소 모듈
						XPayClient xpay = new XPayClient();
						xpay.Init(configPath, CST_PLATFORM);
						xpay.Init_TX(LGD_MID);

						xpay.Set("LGD_TID", paymentManageDTO.getLGD_TID());
						if (paymentDetail_seq > 0) { // 개별 결제 취소건
							paymentDetailDTO.setPaymentDetail_seq(paymentDetail_seq);
							paymentDetailDTO = paymentManageDTO.getPaymentDetailItem(paymentDetailDTO);

							if (paymentDetailDTO.getDownCount().equalsIgnoreCase("0") || cmdClass.is1("manage")) {
								String LGD_CANCELAMOUNT = (paymentDetailDTO.getPrice() > 0)
										? Integer.toString(paymentDetailDTO.getPrice())
										: "0";
								// String LGD_REMAINAMOUNT =
								// Integer.toString(paymentManageDTO.getLGD_AMOUNT()-paymentDetailDTO.getPrice());
								String LGD_REMAINAMOUNT = Integer.toString(paymentManageDTO.getLGD_AMOUNT());

								xpay.Set("LGD_TXNAME", "PartialCancel");
								xpay.Set("LGD_CANCELAMOUNT", LGD_CANCELAMOUNT);// 부분취소 금액
								xpay.Set("LGD_REMAINAMOUNT", LGD_REMAINAMOUNT); // 남은 금액

								if (xpay.TX()) {
									// 1)결제 부분취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
									System.out.println("결제 부분취소 요청 이 완료되었습니다.  <br>");
									System.out.println("TX Response_code = " + xpay.m_szResCode + "<br>");
									System.out.println("TX Response_msg = " + xpay.m_szResMsg + "<p>");

									if (xpay.m_szResCode.equals("0000")) {
										int lGD_AMOUNT = paymentManageDTO.getLGD_AMOUNT() - paymentDetailDTO.getPrice();
										paymentManageDTO.setLGD_AMOUNT(lGD_AMOUNT); // 취소 금액 갱신
										paymentManageDTO.setLGD_PAYSTATUS(6); // 부분취소
										paymentManageDTO = paymentDAO.updatePaymentManage(paymentManageDTO);

										paymentDetailDTO.setPaymentManage_seq(paymentManageDTO.getPaymentManage_seq());
										paymentDetailDTO.setStatus("1"); // 결제취소
										paymentDetailDTO.setPaymentDetail_seq(paymentDetail_seq); // 결제취소
										result = paymentDAO.updatePaymentDetailStatus(paymentDetailDTO);
										
										PhotoDTO photoDTO = photoDAO.read(paymentDetailDTO.getPhoto_uciCode());
										
										
										CalculationDTO calculationDTO  = new CalculationDTO();
										calculationDTO.setId(paymentManageDTO.getLGD_BUYERID());
										calculationDTO.setUciCode(paymentDetailDTO.getPhoto_uciCode());
										calculationDTO.setUsage(paymentDetailDTO.getUsageList_seq());
										calculationDTO.setType(0);
										calculationDTO.setRate(photoDTO.getOwnerPreRate());
										calculationDTO.setPayType(paymentManageDTO.getLGD_PAYTYPE());
										calculationDTO.setPrice(-paymentDetailDTO.getPrice());
										calculationDTO.setFees(-paymentManageDTO.getLGD_FEES(paymentDetailDTO.getPrice()));
										calculationDTO.setStatus(0);
										CalculationDAO calculationDAO = new CalculationDAO();
										calculationDAO.insertCalculation(calculationDTO);

									} else {
										message = xpay.m_szResMsg;
									}

								} else {
									// 2)API 요청 실패 화면처리
									System.out.println("결제 부분취소 요청이 실패하였습니다.  <br>");
									System.out.println("TX Response_code = " + xpay.m_szResCode + "<br>");
									System.out.println("TX Response_msg = " + xpay.m_szResMsg + "<p>");
									message = "결제 부분취소 요청이 실패하였습니다. ";
								}
							} else {
								message = "다운로드 받은 내역이 있을 시, 환불이 불가능합니다.\n (환불가능기간은 결제일로부터 7일 이내입니다.)";
							}

						} else {
							boolean isNotDown = true;
							for (PaymentDetailDTO detail : paymentManageDTO.getPaymentDetailList()) {
								if (!detail.getDownCount().equalsIgnoreCase("0")) {
									isNotDown = false;
								}
							}

							if (isNotDown) {

								xpay.Set("LGD_TXNAME", "Cancel");
								if (xpay.TX()) {
									// 1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
									if (xpay.m_szResCode.equals("0000")) {
										paymentManageDTO.setLGD_AMOUNT(0); // 취소 금액 갱신
										paymentManageDTO.setLGD_RESPCODE("0000"); // 완료코드
										paymentManageDTO.setLGD_PAYSTATUS(5); // 결제취소
										paymentManageDTO = paymentDAO.updatePaymentManage(paymentManageDTO);

										paymentDetailDTO.setPaymentManage_seq(paymentManageDTO.getPaymentManage_seq());
										paymentDetailDTO.setStatus("1"); // 결제취소

										result = paymentDAO.updatePaymentDetailStatus(paymentDetailDTO);
										
										
										CalculationDAO calculationDAO = new CalculationDAO();
										for (PaymentDetailDTO detailDTO :paymentManageDTO.getPaymentDetailList() ) {
											
											
											PhotoDTO photoDTO = photoDAO.read(detailDTO.getPhoto_uciCode());
											
											
											CalculationDTO calculationDTO  = new CalculationDTO();
											calculationDTO.setId(paymentManageDTO.getLGD_BUYERID());
											calculationDTO.setUciCode(detailDTO.getPhoto_uciCode());
											calculationDTO.setUsage(detailDTO.getUsageList_seq());
											calculationDTO.setType(0);
											calculationDTO.setRate(photoDTO.getOwnerPreRate());
											calculationDTO.setPayType(paymentManageDTO.getLGD_PAYTYPE());
											calculationDTO.setPrice(-detailDTO.getPrice());
											calculationDTO.setFees(-paymentManageDTO.getLGD_FEES(detailDTO.getPrice()));
											calculationDTO.setStatus(0);
											calculationDAO.insertCalculation(calculationDTO);
										}	
									} else {
										message = xpay.m_szResMsg;
									}

									System.out.println(result);

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

			response.setContentType("application/json");
			response.getWriter().print(json);
		} else {
			response.getWriter().append(
					"<script type=\"text/javascript\">alert('로그인 페이지로 이동합니다.');location.replace('/login');</script>")
					.append(request.getContextPath());
		}

	}

}
