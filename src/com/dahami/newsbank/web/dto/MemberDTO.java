package com.dahami.newsbank.web.dto;

/**
 * @author p153-1706
 *
 */

public class MemberDTO {
	private int member_seq; // 시퀀스
	private String id; // 아이디
	private String pw; // 패스워드
	private String email; // 이메일
	private String name; // 이름
	private String phone; // 핸드폰번호
	/** 회원타입: 매체 */
	public static final String TYPE_MEDIA = "M";
	/** 회원타입: 개인 */
	public static final String TYPE_PERSON = "P";
	/** 회원타입: 기업 */
	public static final String TYPE_COOP = "C";
	private String type; // 타입 ( 매체사, 개인, 기업)
	private String permission; // 권한
	private String compNum;// 사업자 등록 번호
	private String compZipcode;// 우편번호
	private String compDocPath; // 등록증 경로
	private String compName;// 회사명
	private String compAddress;// 회사주소
	private String compBankName;// 정산은행명
	private String compBankAcc;// 정산계좌
	private String compBankPath;// 정산통장 사본 경
	private String compTel; // 회사 전화번호
	private String contractPath;// 계약서 사본경로
	private String contractStart; // 계약시작일
	private String contractEnd;// 계약종료일
	private String contractAuto;// 자동갱신여부
	private Double preRate; // 온라인결제요율
	private Double postRate; // 후불결제요율
	private String taxName; // 계산서 담당자
	private String taxPhone; // 계산서 담당자 전화번호
	private String taxEmail; // 계산서 담당자 메일
	private String regDate; // 등록일
	private String logo; // 로고
	
	public static final int ACTIVATE_TRUE = 1;
	public static final int ACTIVATE_FALSE = 2;
	private int activate;
	private int master_seq; // 마스터 시퀀스
	private int group_seq; // 그룹 시퀀스

	/**
	 * @comment 시퀀스
	 * @return
	 */
	public int getMember_seq() {
		return member_seq;
	}

	/**
	 * 
	 * @param member_seq
	 */
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}

	/**
	 * @return
	 */
	public int getMaster_seq() {
		return master_seq;
	}

	/**
	 * @param master_seq
	 */
	public void setMaster_seq(int master_seq) {
		this.master_seq = master_seq;
	}

	/**
	 * @comment 아이디
	 * @return
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * @param phone
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * @return
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return
	 */
	public String getPermission() {
		return permission;
	}

	/**
	 * @param permission
	 */
	public void setPermission(String permission) {
		this.permission = permission;
	}

	/**
	 * @return
	 */
	public String getCompNum() {
		return compNum;
	}

	/**
	 * @param compNum
	 */
	public void setCompNum(String compNum) {
		this.compNum = compNum;
	}

	/**
	 * @return
	 */
	public String getCompDocPath() {
		return compDocPath;
	}

	/**
	 * @param comDocPath
	 */
	public void setComDocPath(String compDocPath) {
		this.compDocPath = compDocPath;
	}

	/**
	 * @return
	 */
	public String getCompName() {
		return compName;
	}

	/**
	 * @param compName
	 */
	public void setCompName(String compName) {
		this.compName = compName;
	}

	/**
	 * @return
	 */
	public String getCompAddress() {
		return compAddress;
	}

	/**
	 * @param compAddress
	 */
	public void setCompAddress(String compAddress) {
		this.compAddress = compAddress;
	}

	/**
	 * @return
	 */
	public String getCompBankName() {
		return compBankName;
	}

	/**
	 * @param compBankName
	 */
	public void setCompBankName(String compBankName) {
		this.compBankName = compBankName;
	}

	/**
	 * @return
	 */
	public String getCompBankAcc() {
		return compBankAcc;
	}

	/**
	 * @param compBankAcc
	 */
	public void setCompBankAcc(String compBankAcc) {
		this.compBankAcc = compBankAcc;
	}

	/**
	 * @return
	 */
	public String getCompBankPath() {
		return compBankPath;
	}

	/**
	 * @param compBankPath
	 */
	public void setCompBankPath(String compBankPath) {
		this.compBankPath = compBankPath;
	}

	/**
	 * @return
	 */
	public String getCompTel() {
		return compTel;
	}

	/**
	 * @param compTel
	 */
	public void setCompTel(String compTel) {
		this.compTel = compTel;
	}

	/**
	 * @return
	 */
	public String getContractPath() {
		return contractPath;
	}

	/**
	 * @param contractPath
	 */
	public void setContractPath(String contractPath) {
		this.contractPath = contractPath;
	}

	/**
	 * @return
	 */
	public String getContractStart() {
		return contractStart;
	}

	/**
	 * @param contractStart
	 */
	public void setContractStart(String contractStart) {
		this.contractStart = contractStart;
	}

	/**
	 * @return
	 */
	public String getContractEnd() {
		return contractEnd;
	}

	/**
	 * @param contractEnd
	 */
	public void setContractEnd(String contractEnd) {
		this.contractEnd = contractEnd;
	}

	/**
	 * @return
	 */
	public String getContractAuto() {
		return contractAuto;
	}

	/**
	 * @param contractAuto
	 */
	public void setContractAuto(String contractAuto) {
		this.contractAuto = contractAuto;
	}

	/**
	 * @return
	 */
	public Double getPreRate() {
		return preRate;
	}

	/**
	 * @param preRate
	 */
	public void setPreRate(Double preRate) {
		this.preRate = preRate;
	}

	/**
	 * @return
	 */
	public Double getPostRate() {
		return postRate;
	}

	/**
	 * @param postRate
	 */
	public void setPostRate(Double postRate) {
		this.postRate = postRate;
	}

	/**
	 * @return
	 */
	public String getTaxName() {
		return taxName;
	}

	/**
	 * @param taxName
	 */
	public void setTaxName(String taxName) {
		this.taxName = taxName;
	}

	/**
	 * @return
	 */
	public String getTaxPhone() {
		return taxPhone;
	}

	/**
	 * @param taxPhone
	 */
	public void setTaxPhone(String taxPhone) {
		this.taxPhone = taxPhone;
	}

	/**
	 * @return
	 */
	public String getTaxEmail() {
		return taxEmail;
	}

	/**
	 * @param taxEmail
	 */
	public void setTaxEmail(String taxEmail) {
		this.taxEmail = taxEmail;
	}

	/**
	 * @return
	 */
	public String getRegDate() {
		return regDate;
	}

	/**
	 * @param regDate
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	/**
	 * @return
	 */
	public String getLogo() {
		return logo;
	}

	/**
	 * @param logo
	 */
	public void setLogo(String logo) {
		this.logo = logo;
	}

	/**
	 * @return
	 */
	public int getGroup_seq() {
		return group_seq;
	}

	/**
	 * @param group_seq
	 */
	public void setGroup_seq(int group_seq) {
		this.group_seq = group_seq;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getCompZipcode() {
		return compZipcode;
	}

	public void setCompZipcode(String compZipcode) {
		this.compZipcode = compZipcode;
	}

	public int getActivate() {
		return activate;
	}

	public void setActivate(int activate) {
		this.activate = activate;
	}

	public boolean isMember() {
		if (this.getId()==null)
			return false;
		else
			return true;
	}

}
