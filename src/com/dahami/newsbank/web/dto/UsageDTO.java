package com.dahami.newsbank.web.dto;

public class UsageDTO {

	private String usage; // 사용 용도
	private String division1; // 구분1
	private String division2; // 구분2
	private String division3; // 구분3
	private String division4; // 구분4
	private String usageDate; // 사용기한
	private int price; // 가격
	
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
	public String getUsageDate() {
		return usageDate;
	}
	public void setUsageDate(String usageDate) {
		this.usageDate = usageDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}	
}
