package com.dahami.newsbank.web.dto;

import java.util.Date;

public class CartDTO {

	private String uciCode; // UCI 코드
	private int price; // 가격
	private Date regDate; // 등록일시
	private String usage; // 용도
	private String division1; // 구분1
	private String division2; // 구분2
	private String division3; // 구분3
	private String division4; // 구분4
	
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

	public String getDivision1() {
		return division1;
	}

	public void setDivision1(String division1) {
		this.division1 = division1;
	}

	public String getDivision2() {
		return division2;
	}

	public void setDivision2(String division2) {
		this.division2 = division2;
	}

	public String getDivision3() {
		return division3;
	}

	public void setDivision3(String division3) {
		this.division3 = division3;
	}

	public String getDivision4() {
		return division4;
	}

	public void setDivision4(String division4) {
		this.division4 = division4;
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
