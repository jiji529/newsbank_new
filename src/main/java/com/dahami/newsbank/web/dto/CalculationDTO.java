package com.dahami.newsbank.web.dto;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class CalculationDTO {

	private int seq;
	private String id; // 아이디(구매자)
	private String name; // 이름(구매자)
	private String compName; // 기관/회사명
	private String copyright; // 저작권자(판매자)
	private int member_seq; // 매체사(회원고유번호)
	private String payType; // 결제종류
	private String uciCode; // UCI코드
	private String shotDate; // 촬영일
	private int usage; // 사용용도 고유번호
	private int type; // 정산타입(0: 온라인, 1: 오프라인)
	private int price; // 가격
	private int status; // 정산상태(0: 기본값, 1: 정산 취소)
	private int fees; // 수수료
	private int rate; // 온라인|오프라인 요율
	private String regDate; // 등록일
	private MemberDTO memberDTO; // UCI코드 소유자의 회원정보
	private UsageDTO usageDTO; // UCI코드별 용도정보
	
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
	
	public UsageDTO getUsageDTO() {
		return usageDTO;
	}
	public void setUsageDTO(UsageDTO usageDTO) {
		this.usageDTO = usageDTO;
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
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCopyright() {
		return copyright;
	}
	public void setCopyright(String copyright) {
		this.copyright = copyright;
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
	public String getPayType_Str() {
		String PAYTYPE = payType;
		switch (payType) {
		case "SC0010":
			PAYTYPE = "신용카드";
			break;
		case "SC0030":
			PAYTYPE = "계좌이체";
			break;
		case "SC0040":
			PAYTYPE = "무통장";
			break;
		case "SC0060":
			PAYTYPE = "휴대폰";
			break;
		case "SC0070":
			PAYTYPE = "유선전화결제";
			break;
		case "SC0090":
			PAYTYPE = "OK캐쉬백";
			break;
		case "SC0111":
			PAYTYPE = "문화상품권";
			break;
		case "SC0112":
			PAYTYPE = "게임문화상품권";
			break;
		case "SC0113":
			PAYTYPE = "도서문화상품권";
			break;
		case "SC0220":
			PAYTYPE = "모바일T머니";
			break;
		case "SC9999":
			PAYTYPE = "후불";
			break;
		}
		return PAYTYPE;
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
	
	public MemberDTO getMemberDTO() {
		return memberDTO;
	}

	public void setMemberDTO(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}
	
	public String getShotDate() {
		return shotDate;
	}
	public void setShotDate(String shotDate) {
		this.shotDate = shotDate;
	}
	/**
	 * @methodName  : convertToMap
	 * @author      : LEE, GWAGNHO
	 * @date        : 2018. 04. 11. 오전 09:28:03
	 * @methodCommet: 
	 * @return
	 * @throws Exception 
	 * @returnType  : Map<String,Object>
	 */
	public Map<String, Object> convertToMap() throws Exception {
		Field[] fields = this.getClass().getDeclaredFields();
		Map<String, Object> result = new HashMap<String, Object>();
		
		for(Field cur : fields) {
			int modifier = cur.getModifiers();
			if((modifier & Modifier.STATIC) == Modifier.STATIC) {
				continue;
			}	
			
			result.put(cur.getName(), cur.get(this));
			
		}
		return result;
	}
	
}