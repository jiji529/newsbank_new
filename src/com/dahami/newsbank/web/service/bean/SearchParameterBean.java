/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : SearchParameterBean.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 10. 10. 오후 3:40:28
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 10. 10.     JEON,HYUNGGUK		최초작성
 * 2017. 10. 10.     
 *******************************************************************************/

package com.dahami.newsbank.web.service.bean;

import java.util.ArrayList;
import java.util.List;

public class SearchParameterBean {
//	private String searchKey;
	private String keyword;
	
	/** 컨텐츠 종류 */
	private int contentType;
	
	/** 대상 매체(유저ID) 지정 / 없거나 공백값이면 전체 */
	private List<String> targetUserList;
	
	/** 검색기간 D일/W주/M달/Y년 내 검색 / yyyyMMdd~yyyyMMdd*/
	private String duration;
	
	/** 색상영역 : 0전체 / 1컬러 / 2모노 */
	private int colorMode;
	
	/** 가로세로 선택 : 0전체 1가로 2세로 */
	private int horiVertChoice;
	
	/** 이미지 크기 : 0:전체 1큰 2중간 3작은*/
	private int size;
	
	/** 초상권해결여부 0전체 1해결 2미해결 */
	private int portRight;
	
	/** 그룹화 여부 0전체 1대표 ?? */
	private int group;
	
	private int pageVol;
	private int pageNo;
	
	public SearchParameterBean() {
		pageVol = 20;
		pageNo = 1;
	}
	
	public SearchParameterBean nextPage() {
		this.pageNo++;
		return this;
	}
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getPageVol() {
		return pageVol;
	}
	public void setPageVol(int pageVol) {
		this.pageVol = pageVol;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getContentType() {
		return contentType;
	}

	public void setContentType(int contentType) {
		this.contentType = contentType;
	}

	public List<String> getTargetUserList() {
		return targetUserList;
	}

	public void setTargetUserList(List<String> targetUserList) {
		this.targetUserList = targetUserList;
	}
	
	public void resetTargetUserList() {
		if(this.targetUserList == null) {
			this.targetUserList = new ArrayList<String>();
		}
		this.targetUserList.clear();
	}
	
	public void addTargetUser(String targetUser) {
		if(this.targetUserList == null) {
			this.targetUserList = new ArrayList<String>();
		}
		this.targetUserList.add(targetUser);
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public int getColorMode() {
		return colorMode;
	}

	public void setColorMode(int colorMode) {
		this.colorMode = colorMode;
	}

	public int getHoriVertChoice() {
		return horiVertChoice;
	}

	public void setHoriVertChoice(int horiVertChoice) {
		this.horiVertChoice = horiVertChoice;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getPortRight() {
		return portRight;
	}

	public void setPortRight(int portRight) {
		this.portRight = portRight;
	}

	public int getGroup() {
		return group;
	}

	public void setGroup(int group) {
		this.group = group;
	}
	
}
