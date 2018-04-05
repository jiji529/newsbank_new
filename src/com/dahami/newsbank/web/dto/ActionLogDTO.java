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
import java.util.HashMap;
import java.util.Map;

public class ActionLogDTO {
	
	public static final int ACTION_TYPE_MOD_ILLIGAL = 0;
	public static final int ACTION_TYPE_MOD_TITLE = 1;
	public static final int ACTION_TYPE_MOD_CONTENT = 2;
	public static final int ACTION_TYPE_ADD_TAG = 4;
	public static final int ACTION_TYPE_DEL_TAG = 8;
	public static final int ACTION_TYPE_SET_BLIND = 16;
	public static final int ACTION_TYPE_UNSET_BLIND = 32;
	public static final int ACTION_TYPE_SET_DELETE = 64;
	public static final int ACTION_TYPE_UNSET_DELETE = 128;
	public static final int ACTION_TYPE_SET_PRIGHT = 256;
	public static final int ACTION_TYPE_UNSET_PRIGHT = 512;
	
	/** 세팅 최고값(메시지 생성 자동화(루프)를 위해 필요) */
	private static final int ACTION_TYPE_MAX = ACTION_TYPE_UNSET_PRIGHT;
	private static final Map<Integer, String> ACTION_TYPE_MSG;
	
	static {
		ACTION_TYPE_MSG = new HashMap<Integer, String>();
		ACTION_TYPE_MSG.put(ACTION_TYPE_MOD_ILLIGAL, "정의되지 않음");
		ACTION_TYPE_MSG.put(ACTION_TYPE_MOD_TITLE, "제목 수정");
		ACTION_TYPE_MSG.put(ACTION_TYPE_MOD_CONTENT, "내용 수정");
		ACTION_TYPE_MSG.put(ACTION_TYPE_ADD_TAG, "태그 추가");
		ACTION_TYPE_MSG.put(ACTION_TYPE_DEL_TAG, "태그 삭제");
		ACTION_TYPE_MSG.put(ACTION_TYPE_SET_BLIND, "숨김");
		ACTION_TYPE_MSG.put(ACTION_TYPE_UNSET_BLIND, "숨김 해제");
		ACTION_TYPE_MSG.put(ACTION_TYPE_SET_DELETE, "삭제");
		ACTION_TYPE_MSG.put(ACTION_TYPE_UNSET_DELETE, "삭제 복구");
		ACTION_TYPE_MSG.put(ACTION_TYPE_SET_PRIGHT, "초상권 획득");
		ACTION_TYPE_MSG.put(ACTION_TYPE_UNSET_PRIGHT, "초상권 상실");
	}
	
	private int seq;
	private String uciCode;
	private int memberSeq;
	private String memberName;
	private int actionType;
	private String actionTypeStr;
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
		this.setActionTypeStr(actionType);
	}
	public String getActionTypeStr() {
		return actionTypeStr;
	}
	private void setActionTypeStr(int actionType) {
		this.actionTypeStr = "";
		if(actionType == ACTION_TYPE_MOD_ILLIGAL) {
			this.actionTypeStr = ACTION_TYPE_MSG.get(ACTION_TYPE_MOD_ILLIGAL);
		}
		else {
			for(int i = 0; ; i++) {
				int val = (int)Math.pow(2,  i);
				if(val > ACTION_TYPE_MAX) {
					break;
				}
				if((actionType & val) == val) {
					if(this.actionTypeStr.length() > 0) {
						this.actionTypeStr += ", ";
					}
					this.actionTypeStr += ACTION_TYPE_MSG.get(val); 
				}
			}
		}
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