/**
 * <%---------------------------------------------------------------------------
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @Package Name   : com.dahami.newsbank.web.dto
 * @fileName : PaymentManageDTO.java
 * @author   : CHOI, SEONG HYEON
 * @date     : 2017. 11. 2.
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 11. 2.   	  tealight        PaymentManageDTO.java
 *--------------------------------------------------------------------------%>
 */
package com.dahami.newsbank.web.dto;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author p153-1706
 *
 */
public class PaymentManageDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int  paymentManage_seq = 0; // seq
	private int member_seq; // member 시퀀스
	private String LGD_BUYER; // 구매자명
	private String LGD_BUYERID; // 구매자 아이디
	private String LGD_BUYERPHONE; // 구매자 핸드폰번호
	private String LGD_RESPCODE; // 응답코드
	private String LGD_RESPMSG; // 응답메시지
	private String LGD_OID; // 상점주문번호
	private int LGD_AMOUNT; // 결제금액
	private String LGD_PAYSTATUS;// 상태값 /0:결제실패  1:결제성공  2:결제대기중  3:무통장입금 대기중, 4: 후불결제, 5: 결제취소
	private String LGD_TID; // 거래 번호
	private String LGD_PAYTYPE; // 결제수단 코드
	private String LGD_PAYDATE; // 결제 일시
	private String LGD_PRODUCTINFO; // 구매내역
	private String LGD_FINANCENAME; //은행
	private String LGD_ACCOUNTNUM; // 입금계좌번호
	private String regDate; // 등록일
	private List<PaymentDetailDTO> paymentDetailList; // 구매 상세 목록
	private MemberDTO memberDTO; // 구매 회원 정보


	public int getMember_seq() {
		return member_seq;
	}

	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}

	public String getLGD_BUYER() {
		return LGD_BUYER;
	}

	public void setLGD_BUYER(String lGD_BUYER) {
		LGD_BUYER = lGD_BUYER;
	}

	public String getLGD_BUYERID() {
		return LGD_BUYERID;
	}

	public void setLGD_BUYERID(String lGD_BUYERID) {
		LGD_BUYERID = lGD_BUYERID;
	}

	public String getLGD_BUYERPHONE() {
		return LGD_BUYERPHONE;
	}

	public void setLGD_BUYERPHONE(String lGD_BUYERPHONE) {
		LGD_BUYERPHONE = lGD_BUYERPHONE;
	}

	public String getLGD_RESPCODE() {
		return LGD_RESPCODE;
	}

	public void setLGD_RESPCODE(String lGD_RESPCODE) {
		LGD_RESPCODE = lGD_RESPCODE;
	}

	public String getLGD_RESPMSG() {
		return LGD_RESPMSG;
	}

	public void setLGD_RESPMSG(String lGD_RESPMSG) {
		LGD_RESPMSG = lGD_RESPMSG;
	}

	public String getLGD_OID() {
		return LGD_OID;
	}

	public void setLGD_OID(String lGD_OID) {
		LGD_OID = lGD_OID;
	}

	public int getLGD_AMOUNT() {
		return LGD_AMOUNT;
	}
	
	public String getLGD_AMOUNT_Str() {
		DecimalFormat df = new DecimalFormat("#,##0");
		return "\\" + df.format(LGD_AMOUNT); // 가격 출력 포멧
	}

	public void setLGD_AMOUNT(int lGD_AMOUNT) {
		LGD_AMOUNT = lGD_AMOUNT;
	}

	public String getLGD_TID() {
		return LGD_TID;
	}

	public void setLGD_TID(String lGD_TID) {
		LGD_TID = lGD_TID;
	}

	public String getLGD_PAYTYPE() {
		/*switch (LGD_PAYTYPE) {
		case "SC0010":
			LGD_PAYTYPE = "신용카드";
			break;
		case "SC0030":
			LGD_PAYTYPE = "계좌이체";
			break;
		case "SC0040":
			LGD_PAYTYPE = "무통장";
			break;
		case "SC0060":
			LGD_PAYTYPE = "휴대폰";
			break;
		case "SC0070":
			LGD_PAYTYPE = "유선전화결제";
			break;
		case "SC0090":
			LGD_PAYTYPE = "OK캐쉬백";
			break;
		case "SC0111":
			LGD_PAYTYPE = "문화상품권";
			break;
		case "SC0112":
			LGD_PAYTYPE = "게임문화상품권";
			break;
		case "SC0113":
			LGD_PAYTYPE = "도서문화상품권";
			break;
		case "SC0220":
			LGD_PAYTYPE = "모바일T머니";
			break;
		case "000000":
			LGD_PAYTYPE = "후불";
			break;
		}*/
		return LGD_PAYTYPE;
	}
	
	public String getPayType() {
		String PAYTYPE="";
		switch (LGD_PAYTYPE) {
		case "SC0010":
			PAYTYPE = "신용카드";
			break;
		case "SC0030":
			PAYTYPE = "계좌이체";
			break;
		case "SC0040":
			PAYTYPE = "무통장";
			break;
		case "SC0060":
			PAYTYPE = "휴대폰";
			break;
		case "SC0070":
			PAYTYPE = "유선전화결제";
			break;
		case "SC0090":
			PAYTYPE = "OK캐쉬백";
			break;
		case "SC0111":
			PAYTYPE = "문화상품권";
			break;
		case "SC0112":
			PAYTYPE = "게임문화상품권";
			break;
		case "SC0113":
			PAYTYPE = "도서문화상품권";
			break;
		case "SC0220":
			PAYTYPE = "모바일T머니";
			break;
		case "000000":
			PAYTYPE = "후불";
			break;
		}
		return PAYTYPE;
	}

	public void setLGD_PAYTYPE(String lGD_PAYTYPE) {
		LGD_PAYTYPE = lGD_PAYTYPE;
	}

	public String getLGD_PAYDATE() {
		return LGD_PAYDATE;
	}

	public void setLGD_PAYDATE(String lGD_PAYDATE) {
		LGD_PAYDATE = lGD_PAYDATE;
	}

	public String getLGD_PRODUCTINFO() {
		return LGD_PRODUCTINFO;
	}

	public void setLGD_PRODUCTINFO(String lGD_PRODUCTINFO) {
		LGD_PRODUCTINFO = lGD_PRODUCTINFO;
	}

	public String getLGD_ACCOUNTNUM() {
		return LGD_ACCOUNTNUM;
	}

	public void setLGD_ACCOUNTNUM(String lGD_ACCOUNTNUM) {
		LGD_ACCOUNTNUM = lGD_ACCOUNTNUM;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public List<PaymentDetailDTO> getPaymentDetailList() {
		return paymentDetailList;
	}

	public void setPaymentDetailList(List<PaymentDetailDTO> paymentDetailList) {
		this.paymentDetailList = paymentDetailList;
	}

	public String getLGD_FINANCENAME() {
		return LGD_FINANCENAME;
	}

	public void setLGD_FINANCENAME(String lGD_FINANCENAME) {
		LGD_FINANCENAME = lGD_FINANCENAME;
	}

	public int getPaymentManage_seq() {
		return paymentManage_seq;
	}

	public void setPaymentManage_seq(int paymentManage_seq) {
		this.paymentManage_seq = paymentManage_seq;
	}

	public String getLGD_PAYSTATUS() {
		return LGD_PAYSTATUS;
	}
	

	public MemberDTO getMemberDTO() {
		return memberDTO;
	}

	public void setMemberDTO(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}

	public void setLGD_PAYSTATUS(int lGD_PAYSTATUS) {
		
		LGD_PAYSTATUS = Integer.toString(lGD_PAYSTATUS);
	}
	public int getDetailSize() {
		return paymentDetailList.size();
	}
	
	

}
