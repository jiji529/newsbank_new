package com.dahami.newsbank.web.dto;

import java.util.Date;

public class CartDTO {

	private String uciCode; // UCI 코드
	private int price; // 가격
	private Date regDate; // 등록일시
	private String usage; // 용도
	private String divison1; // 구분1
	private String divison2; // 구분2
	private String divison3; // 구분3
	private String divison4; // 구분4
	
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

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getUsage() {
		return usage;
	}

	public void setUsage(String usage) {
		this.usage = usage;
	}

	public String getDivison1() {
		return divison1;
	}

	public void setDivison1(String divison1) {
		this.divison1 = divison1;
	}

	public String getDivison2() {
		return divison2;
	}

	public void setDivison2(String divison2) {
		this.divison2 = divison2;
	}

	public String getDivison3() {
		return divison3;
	}

	public void setDivison3(String divison3) {
		this.divison3 = divison3;
	}

	public String getDivison4() {
		return divison4;
	}

	public void setDivison4(String divison4) {
		this.divison4 = divison4;
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
