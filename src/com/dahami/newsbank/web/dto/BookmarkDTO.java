package com.dahami.newsbank.web.dto;

public class BookmarkDTO {
	private int seq; // 북마크 고유번호
	private int member_seq; // 회원고유번호
	private String photo_uciCode; // UCI 코드
	private String bookName; // 찜 폴더 이름
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	public String getPhoto_uciCode() {
		return photo_uciCode;
	}
	public void setPhoto_uciCode(String photo_uciCode) {
		this.photo_uciCode = photo_uciCode;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

}
