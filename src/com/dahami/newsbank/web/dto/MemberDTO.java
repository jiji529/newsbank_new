package com.dahami.newsbank.web.dto;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author p153-1706
 *
 */

public class MemberDTO implements Serializable {
	private static final long serialVersionUID = 4264810335499478080L;

	/** 최종 생성시간 / 빈번한 읽기를 피하기 위해서 사용함 */
	private long lastModifiedTime;
	
	private int seq; // 시퀀스
	
	private String id; // 아이디
	private String pw; // 리뉴뱅 패스워드
	private String pwCurrent;//신뉴뱅 패스워드
	private String pwPast ; // 구뉴뱅 패스워드
	
	private String email; // 이메일
	private String name; // 이름
	private String phone; // 핸드폰번호
	/** 회원타입: 관리자 */
	public static final String TYPE_ADMIN = "A";
	/** 회원타입: 매체 */
	public static final String TYPE_MEDIA = "M";
	/** 회원타입: 개인 */
	public static final String TYPE_PERSON = "P";
	/** 회원타입: 기업 */
	public static final String TYPE_COOP = "C";
	private String type; // 타입 ( 매체사, 개인, 기업)
	private String permission; // 권한
	/** 후불 : 아님 / 온라인가격 */
	public static final int DEFERRED_NORMAL = 0;
	/** 후불 : 온라인가격 적용 */
	public static final int DEFERRED_ONLINE = 1;
	/** 후불 : 별도가격 적용 */
	public static final int DEFERRED_OTHER = 2;
	private int deferred; // 후불코드
	private String compNum;// 사업자 등록 번호
	private String compZipcode;// 우편번호
	private String compDocPath; // 등록증 경로
	private String compName;// 회사명
	private String compAddress;// 회사주소
	private String compAddDetail;//회사 주소 상세
	private String compBankName;// 정산은행명
	private String compBankAcc;// 정산계좌
	private String compBankPath;// 정산통장 사본 경
	private String compTel; // 회사 전화번호
	private String compExtTel; // 회사 내선번호
	private String contractPath;// 계약서 사본경로
	private String contractStart; // 계약시작일
	private String contractEnd;// 계약종료일
	private String contractAuto;// 자동갱신여부
	private Double preRate; // 온라인결제요율
	private Double postRate; // 후불결제요율
	private String taxName; // 계산서 담당자
	private String taxPhone; // 계산서 담당자 전화번호
	private String taxEmail; // 계산서 담당자 메일
	private String taxExtTell; // 계산서 담당자 내선번호
	private String regDate; // 최초 생성일
	private String updDate; // 최근 데이터 업데이트 시간
	private String loginDate; // 마지막 로그인시간
	private String logo; // 로고
	private int withdraw; // 회원 상태(0: 정상, 1: 탈퇴)
	private String admission; // 승인(N: 비승인, Y: 승인)
	
	public static final int ACTIVATE_TRUE = 1;
	public static final int ACTIVATE_FALSE = 2;
	private String activate;
	private int master_seq; // 마스터 시퀀스
	private int group_seq; // 그룹 시퀀스
	private String groupName; // 그룹명
	
	public long getLastModifiedTime() {
		return lastModifiedTime;
	}

	public void setLastModifiedTime(long lastModifiedTime) {
		this.lastModifiedTime = lastModifiedTime;
	}

	/**
	 * @comment 시퀀스
	 * @return
	 */
	public int getSeq() {
		return seq;
	}

	/**
	 * 
	 * @param member_seq
	 */
	public void setSeq(int seq) {
		this.seq = seq;
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
	 * @return strType
	 */
	public String getStrType() {
		String strType = "";
		switch(type) {
			case "A":
				strType = "관리자";
			break;
			
			case "M":
				strType = "매체";
			break;
			
			
			case "P":
				strType = "개인";
			break;
			
			case "C":
				strType = "기업";
			break;
		}
		return strType;
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
	public String getcompExtTel() {
		return compExtTel;
	}

	/**
	 * @param compExtTel
	 */
	public void setcompExtTel(String compExtTel) {
		this.compExtTel = compExtTel;
	}
	
	/**
	 * @return
	 */
	public String getTaxExtTell() {
		return taxExtTell;
	}
	
	/**
	 * @param taxExtTell
	 */
	public void setTaxExtTell(String taxExtTell) {
		this.taxExtTell = taxExtTell;
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
	public int getWithdraw() {
		return withdraw;
	}

	/**
	 * @param withdraw
	 */	
	public void setWithdraw(int withdraw) {
		this.withdraw = withdraw;
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
	
	/**
	 * @return
	 */
	public String getGroupName() {
		return groupName;
	}
	
	/**
	 * @param groupName
	 */
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	/**
	 * @return
	 */
	public String getAdmission() {
		return admission;
	}
	
	/**
	 * @param admission
	 */
	public void setAdmission(String admission) {
		this.admission = admission;
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

	public String getActivate() {
		return activate;
	}

	public void setActivate(String activate) {
		this.activate = activate;
	}

	public boolean isMember() {
		if (this.getSeq()>0)
			return true;
		else
			return false;
	}

	public String getCompAddDetail() {
		return compAddDetail;
	}

	public void setCompAddDetail(String compAddDetail) {
		this.compAddDetail = compAddDetail;
	}

	public int getDeferred() {
		return deferred;
	}

	public void setDeferred(int deferred) {
		this.deferred = deferred;
	}

	public Set<Integer> getSubAdjSet() {
		if(this.subAdjSet == null) {
			synchronized(this) {
				if(this.subAdjSet == null) {
					this.subAdjSet = new HashSet<Integer>();
				}
			}
		}
		return subAdjSet;
	}

	public void setSubAdjSet(Set<Integer> subAdjSet) {
		this.subAdjSet = subAdjSet;
	}

	public Set<Integer> getSubRepSet() {
		if(this.subRepSet == null) {
			synchronized(this) {
				if(this.subRepSet == null) {
					this.subRepSet = new HashSet<Integer>();
				}
			}
		}
		return subRepSet;
	}

	public void setSubRepSet(Set<Integer> subRepSet) {
		this.subRepSet = subRepSet;
	}

	public Set<Integer> getGroupSet() {
		if(this.groupSet == null) {
			synchronized(this) {
				if(this.groupSet == null) {
					this.groupSet = new HashSet<Integer>();
				}
			}
		}
		return groupSet;
	}

	public void setGroupSet(Set<Integer> groupSet) {
		this.groupSet = groupSet;
	}
	
	public String getPwPast() {
		return pwPast;
	}

	public void setPwPast(String pwPast) {
		this.pwPast = pwPast;
	}
	public String getPwCurrent() {
		return pwCurrent;
	}

	public void setPwCurrent(String pwCurrent) {
		this.pwCurrent = pwCurrent;
	}
	
	/*
	adj : 마스터(매체)가 슬레이브(매체)의 정산을 신청할 수 있음
	ex) 조선일보가 스포츠조선, 여성조선 사진들도 같이 정산함
	
	repPay : 마스터(사용자)가 슬레이브(사용자)의 다운로드 확인, 결제 신청을 할 수 있음
	ex) 천재교육 마스터 아이디가  각 과목별 아이디들의 다운로드 내역 확인, 결제를 신청할 수 있음 
	
	group : 그룹 구성원들은 서로 결제 및 다운로드 내역을 공유함
	ex) A,B,C가 동일한 그룹 구성원일 때 A가 산 사진을 B와 C가 다운로드 할 수 있음
	 */
	private Set<Integer> subAdjSet;	// 소속 사용자 셋 /adjustment : 하위의 소유자로 볼 수 있음
	private Set<Integer> subRepSet;	// 소속 사용자 셋 / repPayment	: 하위에서 구매한 것의 구매자로 볼 수 있음
	private Set<Integer> groupSet;	// 속한 그룹의 사용자 전체	: 그룹에서 구매한 것의 구매자로 볼 수 있음

	/**
	 * @methodName  : getOwnerGroupList
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2018. 3. 30. 오후 2:19:01
	 * @methodCommet: 소유권을 공유하는 사용자 리스트
	 * @return 
	 * @returnType  : List<Integer>
	 */
	public List<Integer> getOwnerGroupList() {
		List<Integer> list = new ArrayList<Integer>();
		list.add(this.seq);
		if(subAdjSet != null) {
			for(int subSeq : subAdjSet) {
				if(!list.contains(subSeq)) {
					list.add(subSeq);
				}
			}
		}
		return list;
	}
	
	/**
	 * @methodName  : getDownloadGroupList
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2018. 3. 30. 오후 2:24:36
	 * @methodCommet: 다운로드를 공유하는 사용자 리스트
	 * @return 
	 * @returnType  : List<Integer>
	 */
	public List<Integer> getDownloadGroupList() {
		List<Integer> list = new ArrayList<Integer>();
		list.add(this.seq);
		if(subRepSet != null) {
			for(int subSeq : subRepSet) {
				if(!list.contains(subSeq)) {
					list.add(subSeq);
				}
			}
		}
		if(groupSet != null) {
			for(int subSeq : groupSet) {
				if(!list.contains(subSeq)) {
					list.add(subSeq);
				}
			}
		}
		return list;
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

	public String getUpdDate() {
		return updDate;
	}

	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}

	public String getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}
}