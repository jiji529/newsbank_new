package com.dahami.newsbank.web.dto;

import java.util.Date;

public class CalculationDTO {

	private int seq;
	private String id; // 아이디(구매자)
	private String name; // 이름(구매자)
	private String compName; // 매체사(판매자)
	private int member_seq; // 매체사(회원고유번호)
	private String payType; // 결제종류
	private String uciCode; // UCI코드
	private int usage; // 사용용도 고유번호
	private int type; // 정산타입(0: 온라인, 1: 오프라인)
	private int price; // 가격
	private int status; // 정산상태(0: 기본값, 1: 정산 취소)
	private int fees; // 수수료
	private Date regDate; // 등록일
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
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
	
	public int getUsage() {
		return usage;
	}
	public void setUsage(int usage) {
		this.usage = usage;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getFees() {
		return fees;
	}
	public void setFees(int fees) {
		this.fees = fees;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	
	
	
}
