package com.dahami.newsbank.web.dto;

public class StatsDTO {
	/*
	 * @fileName : StatsDTO
  	 * @author   : LEE.GWANGHO
  	 * @date     : 2017. 11. 09. 오후 04:28:20
  	 * @comment  : 사진관리 - 통계
	 */
	
	private String bookmarkCount; // 찜
	private String downCount; // 다운로드 
	private String hitCount; // 조회수
	private String saleCount; // 결제
	private String museumCount; // 뮤지엄 
	private String collectionCount; // 컬렉션
	
	public String getBookmarkCount() {
		return bookmarkCount;
	}
	public void setBookmarkCount(String bookmarkCount) {
		this.bookmarkCount = bookmarkCount;
	}
	public String getDownCount() {
		return downCount;
	}
	public void setDownCount(String downCount) {
		this.downCount = downCount;
	}
	public String getHitCount() {
		return hitCount;
	}
	public void setHitCount(String hitCount) {
		this.hitCount = hitCount;
	}
	public String getSaleCount() {
		return saleCount;
	}
	public void setSaleCount(String saleCount) {
		this.saleCount = saleCount;
	}
	public String getMuseumCount() {
		return museumCount;
	}
	public void setMuseumCount(String museumCount) {
		this.museumCount = museumCount;
	}
	public String getCollectionCount() {
		return collectionCount;
	}
	public void setCollectionCount(String collectionCount) {
		this.collectionCount = collectionCount;
	}

}
