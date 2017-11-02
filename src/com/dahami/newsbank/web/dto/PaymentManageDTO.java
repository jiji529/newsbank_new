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

/**
 * @author p153-1706
 *
 */
public class PaymentManageDTO implements Serializable {

	private int seq;
	private int member_seq;
	private String LGD_BUYER;
	private String LGD_BUYERID;
	private String LGD_BUYERPHONE;
	private String LGD_RESPCODE;
	private String LGD_RESPMSG;
	private String LGD_OID;
	private int LGD_AMOUNT;
	private String LGD_TID;
	private String LGD_PAYTYPE;
	private String LGD_PAYDATE;
	private String LGD_PRODUCTINFO;
	private String LGD_ACCOUNTNUM;
	private String regDate;

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

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
		return LGD_PAYTYPE;
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

}
