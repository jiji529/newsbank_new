package com.dahami.newsbank.web.dto;

import java.util.Date;
import java.util.List;

public class CartDTO {

	private String uciCode; // UCI 코드
	private int price; // 가격	
	private String copyright; // 저작권자
	private List<UsageDTO> usageList; // 사용용도 구분옵션
	
	public String getUciCode() {
		return uciCode;
	}

	public void setUciCode(String uciCode) {
		this.uciCode = uciCode;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCopyright() {
		return copyright;
	}

	public void setCopyright(String copyright) {
		this.copyright = copyright;
	}

	public List<UsageDTO> getUsageList() {
		return usageList;
	}

	public void setUsageList(List<UsageDTO> usageList) {
		this.usageList = usageList;
	}	

	public String getOriginPath() {
		return getPathBase() + ".jpg";
	}
	
	public String getListPath() {
		return getPathBase() + "_list.jpg";
	}
	
	public String getViewPath() {
		return getPathBase() + "_view.jpg";
	}
	
	/**
	 * @methodName  : getPathBase
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 10. 12. 오전 11:18:00
	 * @methodCommet: X1/01/01/01/00
	 * @return 
	 * @returnType  : String
	 */
	private String getPathBase() {
		String path = "/";
		String compCode = "";
		String code = this.uciCode;
		int sIdx = code.indexOf('-');
		if(sIdx != -1) {
			compCode = code.substring(0, sIdx);
			path += compCode + "/";
			code = code.substring(sIdx+1);
		}
		String mediaType = code.substring(0, 1);
		path += mediaType +"/";
		long codeNum = Long.parseLong(code.substring(1));
		
		long value = codeNum / 100000000;
		path += value + "/";
		
		codeNum %= 100000000;
		value = codeNum / 1000000;
		if(value < 10) {
			path += "0";
		}
		path += value + "/";
		
		codeNum %= 1000000;
		value = codeNum / 10000;
		if(value < 10) {
			path += "0";
		}
		path += value + "/";
		
		codeNum %= 10000;
		value = codeNum / 100;
		if(value < 10) {
			path += "0";
		}
		path += value + "/";
		
		path += this.uciCode;
		return path;
	}
}
