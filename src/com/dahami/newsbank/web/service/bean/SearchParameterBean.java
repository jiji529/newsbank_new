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

public class SearchParameterBean {
//	private String searchKey;
	private String keyword;
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
}
