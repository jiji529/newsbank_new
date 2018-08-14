package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.CalculationDAO;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.CalculationDTO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;

/**
 * Servlet implementation class XpayNoteurl
 */
@WebServlet("/Noteurl.Xpay")
public class XpayNoteurl extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public XpayNoteurl() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		/*
		 * [상점 결제결과처리(DB) 페이지]
		 *
		 * 1) 위변조 방지를 위한 hashdata값 검증은 반드시 적용하셔야 합니다.
		 *
		 */

		String LGD_RESPCODE = ""; // 응답코드: 0000(성공) 그외 실패
		String LGD_RESPMSG = ""; // 응답메세지
		String LGD_MID = ""; // 상점아이디
		String LGD_OID = ""; // 주문번호
		String LGD_AMOUNT = ""; // 거래금액
		String LGD_TID = ""; // LG유플러스에서 부여한 거래번호
		String LGD_PAYTYPE = ""; // 결제수단코드
		String LGD_PAYDATE = ""; // 거래일시(승인일시/이체일시)
		String LGD_HASHDATA = ""; // 해쉬값
		String LGD_FINANCECODE = ""; // 결제기관코드(은행코드)
		String LGD_FINANCENAME = ""; // 결제기관이름(은행이름)
		String LGD_ESCROWYN = ""; // 에스크로 적용여부
		String LGD_TIMESTAMP = ""; // 타임스탬프
		String LGD_ACCOUNTNUM = ""; // 계좌번호(무통장입금)
		String LGD_CASTAMOUNT = ""; // 입금총액(무통장입금)
		String LGD_CASCAMOUNT = ""; // 현입금액(무통장입금)
		String LGD_CASFLAG = ""; // 무통장입금 플래그(무통장입금) - 'R':계좌할당, 'I':입금, 'C':입금취소
		String LGD_CASSEQNO = ""; // 입금순서(무통장입금)
		String LGD_CASHRECEIPTNUM = ""; // 현금영수증 승인번호
		String LGD_CASHRECEIPTSELFYN = ""; // 현금영수증자진발급제유무 Y: 자진발급제 적용, 그외 : 미적용
		String LGD_CASHRECEIPTKIND = ""; // 현금영수증 종류 0: 소득공제용 , 1: 지출증빙용
		String LGD_PAYER = ""; // 임금자명

		/*
		 * 구매정보
		 */
		String LGD_BUYER = ""; // 구매자
		String LGD_PRODUCTINFO = ""; // 상품명
		String LGD_BUYERID = ""; // 구매자 ID
		String LGD_BUYERADDRESS = ""; // 구매자 주소
		String LGD_BUYERPHONE = ""; // 구매자 전화번호
		String LGD_BUYEREMAIL = ""; // 구매자 이메일
		String LGD_BUYERSSN = ""; // 구매자 주민번호
		String LGD_PRODUCTCODE = ""; // 상품코드
		String LGD_RECEIVER = ""; // 수취인
		String LGD_RECEIVERPHONE = ""; // 수취인 전화번호
		String LGD_DELIVERYINFO = ""; // 배송지

		LGD_RESPCODE = request.getParameter("LGD_RESPCODE");
		LGD_RESPMSG = request.getParameter("LGD_RESPMSG");
		LGD_MID = request.getParameter("LGD_MID");
		LGD_OID = request.getParameter("LGD_OID");
		LGD_AMOUNT = request.getParameter("LGD_AMOUNT");
		LGD_TID = request.getParameter("LGD_TID");
		LGD_PAYTYPE = request.getParameter("LGD_PAYTYPE");
		LGD_PAYDATE = request.getParameter("LGD_PAYDATE");
		LGD_HASHDATA = request.getParameter("LGD_HASHDATA");
		LGD_FINANCECODE = request.getParameter("LGD_FINANCECODE");
		LGD_FINANCENAME = request.getParameter("LGD_FINANCENAME");
		LGD_ESCROWYN = request.getParameter("LGD_ESCROWYN");
		LGD_TIMESTAMP = request.getParameter("LGD_TIMESTAMP");
		LGD_ACCOUNTNUM = request.getParameter("LGD_ACCOUNTNUM");
		LGD_CASTAMOUNT = request.getParameter("LGD_CASTAMOUNT");
		LGD_CASCAMOUNT = request.getParameter("LGD_CASCAMOUNT");
		LGD_CASFLAG = request.getParameter("LGD_CASFLAG");
		LGD_CASSEQNO = request.getParameter("LGD_CASSEQNO");
		LGD_CASHRECEIPTNUM = request.getParameter("LGD_CASHRECEIPTNUM");
		LGD_CASHRECEIPTSELFYN = request.getParameter("LGD_CASHRECEIPTSELFYN");
		LGD_CASHRECEIPTKIND = request.getParameter("LGD_CASHRECEIPTKIND");
		LGD_PAYER = request.getParameter("LGD_PAYER");

		LGD_BUYER = request.getParameter("LGD_BUYER");
		LGD_PRODUCTINFO = request.getParameter("LGD_PRODUCTINFO");
		LGD_BUYERID = request.getParameter("LGD_BUYERID");
		LGD_BUYERADDRESS = request.getParameter("LGD_BUYERADDRESS");
		LGD_BUYERPHONE = request.getParameter("LGD_BUYERPHONE");
		LGD_BUYEREMAIL = request.getParameter("LGD_BUYEREMAIL");
		LGD_BUYERSSN = request.getParameter("LGD_BUYERSSN");
		LGD_PRODUCTCODE = request.getParameter("LGD_PRODUCTCODE");
		LGD_RECEIVER = request.getParameter("LGD_RECEIVER");
		LGD_RECEIVERPHONE = request.getParameter("LGD_RECEIVERPHONE");
		LGD_DELIVERYINFO = request.getParameter("LGD_DELIVERYINFO");

		/*
		 * hashdata 검증을 위한 mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다. LG유플러스에서 발급한
		 * 상점키로 반드시변경해 주시기 바랍니다.
		 */
		String LGD_MERTKEY = "49bd4da3b4414d8396a591a1c9565bbd"; // mertkey

		StringBuffer sb = new StringBuffer();
		sb.append(LGD_MID);
		sb.append(LGD_OID);
		sb.append(LGD_AMOUNT);
		sb.append(LGD_RESPCODE);
		sb.append(LGD_TIMESTAMP);
		sb.append(LGD_MERTKEY);

		String LGD_HASHDATA2 = "";
		byte[] bNoti = sb.toString().getBytes();
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("MD5");
			byte[] digest = md.digest(bNoti);

			StringBuffer strBuf = new StringBuffer();
			for (int i = 0; i < digest.length; i++) {
				int c = digest[i] & 0xff;
				if (c <= 15) {
					strBuf.append("0");
				}
				strBuf.append(Integer.toHexString(c));
			}

			LGD_HASHDATA2 = strBuf.toString(); // 상점검증 해쉬값
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		/*
		 * 상점 처리결과 리턴메세지
		 *
		 * OK : 상점 처리결과 성공 그외 : 상점 처리결과 실패
		 *
		 * ※ 주의사항 : 성공시 'OK' 문자이외의 다른문자열이 포함되면 실패처리 되오니 주의하시기 바랍니다.
		 */
		String resultMSG = "결제결과 상점 DB처리(LGD_CASNOTEURL) 결과값을 입력해 주시기 바랍니다.";

		if (LGD_HASHDATA2.trim().equals(LGD_HASHDATA)) { // 해쉬값 검증이 성공이면
			if (("0000".equals(LGD_RESPCODE.trim()))) { // 결제가 성공이면
				if ("R".equals(LGD_CASFLAG.trim())) {
					/*
					 * 무통장 할당 성공 결과 상점 처리(DB) 부분 상점 결과 처리가 정상이면 "OK"
					 */
					// if( 무통장 할당 성공 상점처리결과 성공 )
					resultMSG = "OK";

				} else if ("I".equals(LGD_CASFLAG.trim())) {
					/*
					 * 무통장 입금 성공 결과 상점 처리(DB) 부분 상점 결과 처리가 정상이면 "OK"
					 */
					// if( 무통장 입금 성공 상점처리결과 성공 )
					
					PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
					PaymentManageDTO payment = new PaymentManageDTO();
					payment.setLGD_OID(LGD_OID); // 주문번호
					PaymentManageDTO selectPaymentOID =paymentDAO.selectPaymentOID(payment);
					
					if(!selectPaymentOID.getLGD_PAYSTATUS().equals("1")) {
						payment.setLGD_BUYERID(LGD_BUYERID);// 아이디
						payment.setLGD_PAYSTATUS(1);// 1:결제성공 0:결제실패 2:결제대기중 3:무통장입금 대기중
						payment.setLGD_RESPCODE(LGD_RESPCODE); // 결제상태
						payment.setLGD_RESPMSG(LGD_RESPMSG); // 결제메세지
						payment.setLGD_TID(LGD_TID); // 거래번호

						
						payment = paymentDAO.updatePaymentManage(payment);
						
						
						PaymentDetailDTO paymentDetail = new PaymentDetailDTO();
						paymentDetail.setPaymentManage_seq(payment.getPaymentManage_seq());

						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						Calendar Cal = Calendar.getInstance();
						String startDate = df.format(Cal.getTime());
						Cal.add(Calendar.DATE, 1); // 오늘 포함 일주일
						String endDate = df.format(Cal.getTime());

						paymentDetail.setDownStart(startDate); // 다운로드 start date
						paymentDetail.setDownEnd(endDate); // 다운로드 end date
						paymentDAO.updateDownloadDate(paymentDetail);
						
						
						
						if(payment.getPaymentDetailList().size()>0) {
							CalculationDAO calculationDAO = new CalculationDAO();
							PhotoDAO photoDAO = new PhotoDAO();
							for (PaymentDetailDTO detailDTO :payment.getPaymentDetailList() ) {
								
								PhotoDTO photoDTO = photoDAO.read(detailDTO.getPhoto_uciCode());
								System.out.println(photoDTO.getOwnerPreRate());
								
								
								CalculationDTO calculationDTO  = new CalculationDTO();
								calculationDTO.setId(LGD_BUYERID);
								calculationDTO.setUciCode(detailDTO.getPhoto_uciCode());
								calculationDTO.setUsage(detailDTO.getUsageList_seq());
								calculationDTO.setType(0);
								calculationDTO.setRate(photoDTO.getOwnerPreRate());
								calculationDTO.setPayType(payment.getLGD_PAYTYPE());
								calculationDTO.setPrice(detailDTO.getPrice());
								calculationDTO.setFees(payment.getLGD_FEES(detailDTO.getPrice()));
								calculationDTO.setStatus(0);
								calculationDAO.insertCalculation(calculationDTO);
							}	
						}
					}
					
					
					
					
					resultMSG = "OK";
				} else if ("C".equals(LGD_CASFLAG.trim())) {
					/*
					 * 무통장 입금취소 성공 결과 상점 처리(DB) 부분 상점 결과 처리가 정상이면 "OK"
					 */
					// if( 무통장 입금취소 성공 상점처리결과 성공 )
					PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
					PaymentManageDTO payment = new PaymentManageDTO();
					payment.setLGD_OID(LGD_OID); // 주문번호
					
					
					PaymentManageDTO selectPaymentOID =paymentDAO.selectPaymentOID(payment);
					
					if(!selectPaymentOID.getLGD_PAYSTATUS().equals("5")) {
						payment.setLGD_BUYERID(LGD_BUYERID);// 아이디
						payment.setLGD_AMOUNT(0); // 취소 금액 갱신
						payment.setLGD_PAYSTATUS(5);// 1:결제성공 0:결제실패 2:결제대기중 3:무통장입금 대기중
						payment.setLGD_RESPCODE(LGD_RESPCODE); // 결제상태
						payment.setLGD_RESPMSG(LGD_RESPMSG); // 결제메세지
						payment.setLGD_TID(LGD_TID); // 거래번호

						
						payment = paymentDAO.updatePaymentManage(payment);
						PhotoDAO photoDAO = new PhotoDAO();
						
						if(payment.getPaymentDetailList().size()>0) {
							CalculationDAO calculationDAO = new CalculationDAO();
							for (PaymentDetailDTO detailDTO :payment.getPaymentDetailList() ) {
								
								PhotoDTO photoDTO = photoDAO.read(detailDTO.getPhoto_uciCode());
								System.out.println(photoDTO.getOwnerPreRate());
								
								
								CalculationDTO calculationDTO  = new CalculationDTO();
								calculationDTO.setId(LGD_BUYERID);
								calculationDTO.setUciCode(detailDTO.getPhoto_uciCode());
								calculationDTO.setUsage(detailDTO.getUsageList_seq());
								calculationDTO.setType(0);
								calculationDTO.setRate(photoDTO.getOwnerPreRate());
								calculationDTO.setPayType(payment.getLGD_PAYTYPE());
								calculationDTO.setPrice(-detailDTO.getPrice());
								calculationDTO.setFees(-payment.getLGD_FEES(detailDTO.getPrice()));
								calculationDTO.setStatus(0);
								calculationDAO.insertCalculation(calculationDTO);
							}	
						}
					}
					
					
					
					resultMSG = "OK";
				}
			} else { // 결제가 실패이면
				/*
				 * 거래실패 결과 상점 처리(DB) 부분 상점결과 처리가 정상이면 "OK"
				 */
				// if( 결제실패 상점처리결과 성공 )
				
				PaymentManageDTO payment = new PaymentManageDTO();
				payment.setLGD_BUYERID(LGD_BUYERID);// 아이디
				payment.setLGD_OID(LGD_OID); // 주문번호
				payment.setLGD_PAYSTATUS(0);// 1:결제성공 0:결제실패 2:결제대기중 3:무통장입금 대기중
				payment.setLGD_RESPCODE(LGD_RESPCODE); // 결제상태
				payment.setLGD_RESPMSG(LGD_RESPMSG); // 결제메세지
				payment.setLGD_TID(LGD_TID); // 거래번호

				PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
				payment = paymentDAO.updatePaymentManage(payment);
				resultMSG = "OK";
			}
		} else { // 해쉬값이 검증이 실패이면
			/*
			 * hashdata검증 실패 로그를 처리하시기 바랍니다.
			 */
			
			PaymentManageDTO payment = new PaymentManageDTO();
			payment.setLGD_BUYERID(LGD_BUYERID);// 아이디
			payment.setLGD_OID(LGD_OID); // 주문번호
			payment.setLGD_PAYSTATUS(0);// 1:결제성공 0:결제실패 2:결제대기중 3:무통장입금 대기중
			payment.setLGD_RESPCODE(LGD_RESPCODE); // 결제상태
			payment.setLGD_RESPMSG(LGD_RESPMSG); // 결제메세지
			payment.setLGD_TID(LGD_TID); // 거래번호

			PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
			payment = paymentDAO.updatePaymentManage(payment);
			resultMSG = "결제결과 상점 DB처리(LGD_CASNOTEURL) 해쉬값 검증이 실패하였습니다.";
		}

		System.out.println(resultMSG.toString());
	}
}
