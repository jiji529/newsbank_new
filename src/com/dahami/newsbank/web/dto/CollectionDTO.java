package com.dahami.newsbank.web.dto;

public class CollectionDTO {

	private int seq; // 찜폴더 고유번호
	private int photo_count; // 폴더 안 이미지 갯수
	private String bookName; // 찜폴더 이름
	private String id; // 아이디
	private String uciCode; // UCI코드
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getPhoto_count() {
		return photo_count;
	}
	public void setPhoto_count(int photo_count) {
		this.photo_count = photo_count;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUciCode() {
		return uciCode;
	}
	public void setUciCode(String uciCode) {
		this.uciCode = uciCode;
	}

}
