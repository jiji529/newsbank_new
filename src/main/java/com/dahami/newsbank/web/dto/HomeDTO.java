package com.dahami.newsbank.web.dto;

public class HomeDTO {
	private String category;
	private String exName;
	private String exDes;
	private String uciCode;
	private String titleKr;
	private String titleEn;

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getExName() {
		return exName;
	}

	public void setExName(String exName) {
		this.exName = exName;
	}

	public String getExDes() {
		return exDes;
	}

	public void setExDes(String exDes) {
		this.exDes = exDes;
	}

	public String getUciCode() {
		return uciCode;
	}

	public void setUciCode(String uciCode) {
		this.uciCode = uciCode;
	}

	public String getTitleKr() {
		return titleKr;
	}

	public void setTitleKr(String titleKr) {
		this.titleKr = titleKr;
	}

	public String getTitleEn() {
		return titleEn;
	}

	public void setTitleEn(String titleEn) {
		this.titleEn = titleEn;
	}

}
