/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : DownloadDTO.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 11. 17. 오후 3:03:55
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 11. 17.     JEON,HYUNGGUK		최초작성
 * 2017. 11. 17.     
 *******************************************************************************/

package com.dahami.newsbank.web.dto;

import java.util.Date;

public class DownloadDTO {

	private int seq;
	private String uciCode;
	private int memberSeq;
	private String ipAddress;
	private Date regDate;
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUciCode() {
		return uciCode;
	}
	public void setUciCode(String uciCode) {
		this.uciCode = uciCode;
	}
	public int getMemberSeq() {
		return memberSeq;
	}
	public void setMemberSeq(int memberSeq) {
		this.memberSeq = memberSeq;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
}
