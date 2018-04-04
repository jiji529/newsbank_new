/*******************************************************************************
 * Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : ActionLogDTO.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2018. 4. 4. 오후 5:10:37
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2018. 4. 4.     JEON,HYUNGGUK		최초작성
 * 2018. 4. 4.     
 *******************************************************************************/

package com.dahami.newsbank.web.dto;

import java.util.Date;

public class ActionLogDTO {
	
	public static final int ACTION_TYPE_MOD_ILLIGAL = 0;
	public static final int ACTION_TYPE_MOD_TITLE = 1;
	public static final int ACTION_TYPE_MOD_CONTENT = 2;
	public static final int ACTION_TYPE_MOD_ADDTAG = 4;
	public static final int ACTION_TYPE_MOD_DELTAG = 8;
	public static final int ACTION_TYPE_MOD_BLIND = 16;
	public static final int ACTION_TYPE_MOD_UNBLIND = 32;
	public static final int ACTION_TYPE_MOD_DELETE = 64;
	public static final int ACTION_TYPE_MOD_UNDELETE = 128;
	public static final int ACTION_TYPE_MOD_PRIGHT = 256;
	public static final int ACTION_TYPE_MOD_UNPRIGHT = 512;
	
	private int seq;
	private String uciCode;
	private int memberSeq;
	private String memberName;
	private int actionType;
	private String description;
	private String ip;
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
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public int getActionType() {
		return actionType;
	}
	public void setActionType(int actionType) {
		this.actionType = actionType;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
}
