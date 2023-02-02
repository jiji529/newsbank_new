/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : SearchParameterBean.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 10. 10. 오후 3:40:28
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 10. 10.     JEON,HYUNGGUK		최초작성
 * 2017. 10. 10.     
 *******************************************************************************/

package com.dahami.newsbank.web.service.bean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.solr.client.solrj.SolrQuery.ORDER;

import com.dahami.newsbank.dto.PhotoDTO;

public class SearchParameterBean {
	private static final int ALL = 0;
	private String photoId;;
	private String keyword;
	private String uciCode;
	
	/** 관리자가 모든(비제휴 포함) 매체를 검색할 때 사용하는 상태 : true-모든 매체(제휴+비제휴) / false-제휴매체사만 */
	private boolean fullSearch = false;
	
	public static final String OWNER_SELF = PhotoDTO.OWNER_SELF;
	public static final String OWNER_COOP = PhotoDTO.OWNER_COOP;
	public static final String OWNER_MEDIA = PhotoDTO.OWNER_MEDIA;
	public static final String OWNER_PERSONAL = PhotoDTO.OWNER_PERSONAL;
	private String[] ownerType;
	
	/** 판매 상태 1:미판매 / 2:판매중 / 4:판매중지 / 8:삭제(플래그,판매건) */
	private int saleState;
//	public static final int SALE_STATE_NOT = 1;
	public static final int SALE_STATE_OK = 2;
	public static final int SALE_STATE_BLIND = 4;
	public static final int SALE_STATE_DEL = 8;
	// 조합
	public static final int SALE_STATE_ALL = SALE_STATE_OK | SALE_STATE_BLIND | SALE_STATE_DEL;
	public static final int SALE_STATE_OK_BLIND = SALE_STATE_OK | SALE_STATE_BLIND;
	public static final int SALE_STATE_BLIND_DEL = SALE_STATE_BLIND | SALE_STATE_DEL;
	public static final int SALE_STATE_DEFAULT = SALE_STATE_OK_BLIND;	// 기본값
	
	/** 컨텐츠 종류 / 0전체 1보도 2뮤지엄 4개인사진 8컬렉션*/
	private int contentType;
	public static final int CONTENT_TYPE_ALL = ALL;
	public static final int CONTENT_TYPE_NEWS = 1;
	public static final int CONTENT_TYPE_MUSEUM = 2;
	public static final int CONTENT_TYPE_PERSONAL = 4;
	public static final int CONTENT_TYPE_COLLECTION = 8;
	
	/** 대상 매체(유저 Seq) 지정 / 없거나 공백값이면 전체 */
	private List<Integer> targetUserList;
	
	/** 검색 가능한 매체 리스트 / 자동세팅됨 */
	private List<Integer> searchableUserList;
	
	/** 검색기간 D일/W주/M달/Y년 내 검색 / yyyyMMdd~yyyyMMdd*/
	private String duration;
	
	/** 등록일 D일/W주/M달/Y년 내 검색 / yyyyMMdd~yyyyMMdd*/
	private String durationReg;
	
	/** 촬영일 D일/W주/M달/Y년 내 검색 / yyyyMMdd~yyyyMMdd*/
	private String durationTake;
	
	/** 색상영역 : 0전체 / 1컬러 / 2모노 */
	private int colorMode;
	public static final int COLOR_ALL = ALL;
	public static final int COLOR_YES = Integer.parseInt(PhotoDTO.MONO_NO);
	public static final int COLOR_NO = Integer.parseInt(PhotoDTO.MONO_YES);
	
	/** 가로세로 선택 : 0전체 1가로 2세로 */
	private int horiVertChoice;
	public static final int HORIZONTAL_ALL = ALL;
	public static final int HORIZONTAL_YES = 1;
	public static final int HORIZONTAL_NO = 2;
	
	/** 이미지 크기 : 0:전체 1큰 2중간 4작은*/
	private int size;
	public static final int SIZE_ALL = ALL;
	public static final int SIZE_LARGE = 1;	// 3000 이상(가로세로 모두)
	public static final int SIZE_SMALL = 4;	// 1000 이하(가로세로 모두)
	public static final int SIZE_MEDIUM = 2;	// 위 두가지 이외
	
	/** 초상권해결여부 0전체 1해결 2미해결 */
	private int portRight;
	public static final int PORTRAIT_RIGHT_ALL = ALL;
	public static final int PORTRAIT_RIGHT_ACQUIRE  = Integer.parseInt(PhotoDTO.PORTRAITRIGHTSTATE_ACQUIRE);
	public static final int PORTRAIT_RIGHT_NOT  = Integer.parseInt(PhotoDTO.PORTRAITRIGHTSTATE_NOT);
	
	/** 인물포함 여부 / 0전체 1포함 2미포함*/
	private int includePerson;
	public static final int INCLUDE_PERSON_ALL = ALL;
	public static final int INCLUDE_PERSON_YES = Integer.parseInt(PhotoDTO.INCLUDEPERSON_YES);
	public static final int INCLUDE_PERSON_NO = Integer.parseInt(PhotoDTO.INCLUDEPERSON_NO);
	
	/** 그룹화 여부 0전체 1대표 ?? */
	private int group;
	public static final int GROUP_IMAGE_ALL = ALL;
	public static final int GROUP_IMAGE_REP = 1;
	
	private int pageVol;
	private int pageNo;
	
	public static final String SORT_FLD_SCORE = "score";
	public static final String SORT_FLD_ID = "id";
	public static final String SORT_FLD_TITLE = "title";
	public static final String SORT_FLD_OWNER = "owner";
	public static final String SORT_FLD_REGDATE = "rdate";
	public static final String SORT_FLD_SHOTDATE = "sdate";
	public static final String SORT_FLD_FILESIZE = "fsize";
	private String sortField;
	private ORDER sortOrder;
	
	public SearchParameterBean() {
		this.ownerType = new String[] {
			OWNER_MEDIA	
		};
		pageVol = 20;
		pageNo = 1;
	}
	
	public SearchParameterBean(Map<String, String[]> params) {
		this();
		try{this.photoId = params.get("photoId")[0];}catch(Exception e){}
		try{this.keyword = params.get("keyword")[0];}catch(Exception e){}
		try{this.uciCode = params.get("uciCode")[0];}catch(Exception e){}
		try{this.pageNo = Integer.parseInt(params.get("pageNo")[0]);}catch(Exception e){this.pageNo = 1;}
		try{
			this.pageVol = Integer.parseInt(params.get("pageVol")[0]);
		}catch(Exception e){
			try {
				this.pageVol = Integer.parseInt(params.get("pageSize")[0]);	
			}catch(Exception e2) {
				this.pageVol = 40;
			}
		}
		try{this.contentType = Integer.parseInt(params.get("contentType")[0]);}catch(Exception e){}
		try{
			String[] mediaArry = params.get("media");
			for(String cur : mediaArry) {
				if(cur.trim().length() > 0 && !cur.trim().equals("0"))
				this.addTargetUser(Integer.parseInt(cur));
			}
		}catch(Exception e){}
		try{this.duration = params.get("duration")[0];}catch(Exception e){}
		try{this.durationReg = params.get("durationReg")[0];}catch(Exception e){}
		try{this.durationTake = params.get("durationTake")[0];}catch(Exception e){}
		try{this.colorMode = Integer.parseInt(params.get("colorMode")[0]);}catch(Exception e){}
		try{this.horiVertChoice = Integer.parseInt(params.get("horiVertChoice")[0]);}catch(Exception e){}
		try{this.saleState = Integer.parseInt(params.get("saleState")[0]);}catch(Exception e){}
		try{this.size = Integer.parseInt(params.get("size")[0]);}catch(Exception e){}
		try{this.portRight = Integer.parseInt(params.get("portRight")[0]);}catch(Exception e){}
		try{this.includePerson = Integer.parseInt(params.get("includePerson")[0]);}catch(Exception e){}
		try{this.group = Integer.parseInt(params.get("group")[0]);}catch(Exception e){}
		try{this.fullSearch = Boolean.valueOf(params.get("fullSearch")[0]).booleanValue();}catch(Exception e){}
		
		setOrder(params);
	}
	
	private void setOrder(Map<String, String[]> params) {
		String sort = null;
		try{ sort = params.get("sort")[0];}catch(Exception e){}
		if(sort == null || sort.trim().length() == 0) {
			sort = SORT_FLD_REGDATE;
		}
		if(sort.indexOf(":") == -1) {
			sort += ":d";
		}
		
		String [] sortArry = sort.split("\\:");
		
		switch(sortArry[0]) {
		case SORT_FLD_SCORE:
			sortField = "score";
			break;
		case SORT_FLD_ID:
			sortField = "uciCode";
			break;
		case SORT_FLD_TITLE:
			sortField = "title_sort";
			break;
		case SORT_FLD_OWNER:
			sortField = "copyright";
			break;
		case SORT_FLD_REGDATE:
			sortField = "regDate";
			break;
		case SORT_FLD_SHOTDATE:
			sortField = "shotDate";
			break;
		case SORT_FLD_FILESIZE:
			sortField = "fileSize";
			break;
		}
		
		switch(sortArry[1]) {
		case "a":
			sortOrder = ORDER.asc;
			break;
		case "d":
			sortOrder = ORDER.desc;
			break;
		}
	}
	
	public SearchParameterBean nextPage() {
		this.pageNo++;
		return this;
	}
	
	public String getPhotoId() {
		if(photoId == null || photoId.trim().length() == 0) {
			return "";
		}
		return photoId.trim();
	}
	public String getKeyword() {
		if(keyword == null || keyword.trim().length() == 0) {
			return "*:*";
		}
		return keyword;
	}
	public String getUciCode() {
		return uciCode;
	}
	public void setUciCode(String uciCode) {
		this.uciCode = uciCode;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getSaleState() {
		return saleState;
	}

	public void setSaleState(int saleState) {
		this.saleState = saleState;
	}
	public int getPageVol() {
		return pageVol;
	}
	public void setPageVol(int pageVol) {
		this.pageVol = pageVol;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getContentType() {
		return contentType;
	}

	public void setContentType(int contentType) {
		this.contentType = contentType;
	}

	public List<Integer> getTargetUserList() {
		if(this.targetUserList == null) {
			this.targetUserList = new ArrayList<Integer>();
		}
		return targetUserList;
	}

	public void setTargetUserList(List<Integer> targetUserList) {
		this.targetUserList = targetUserList;
	}
	
	public void resetTargetUserList() {
		if(this.targetUserList == null) {
			this.targetUserList = new ArrayList<Integer>();
		}
		this.targetUserList.clear();
	}
	
	public void addTargetUser(Integer targetUser) {
		if(this.targetUserList == null) {
			this.targetUserList = new ArrayList<Integer>();
		}
		this.targetUserList.add(targetUser);
	}
	
	public List<Integer> getSearchableUserList() {
		if(searchableUserList == null) {
			synchronized(this) {
				searchableUserList = new ArrayList<Integer>();
			}
		}
		return searchableUserList;
	}

	public void setSearchableUserList(List<Integer> searchableUserList) {
		this.searchableUserList = searchableUserList;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public String getDurationReg() {
		return durationReg;
	}

	public void setDurationReg(String durationReg) {
		this.durationReg = durationReg;
	}

	public String getDurationTake() {
		return durationTake;
	}

	public void setDurationTake(String durationTake) {
		this.durationTake = durationTake;
	}

	public int getColorMode() {
		return colorMode;
	}

	public void setColorMode(int colorMode) {
		this.colorMode = colorMode;
	}

	public int getHoriVertChoice() {
		return horiVertChoice;
	}

	public void setHoriVertChoice(int horiVertChoice) {
		this.horiVertChoice = horiVertChoice;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getPortRight() {
		return portRight;
	}

	public void setPortRight(int portRight) {
		this.portRight = portRight;
	}

	public int getIncludePerson() {
		return includePerson;
	}

	public void setIncludePerson(int includePerson) {
		this.includePerson = includePerson;
	}

	public int getGroup() {
		return group;
	}

	public void setGroup(int group) {
		this.group = group;
	}

	public String[] getOwnerType() {
		return ownerType;
	}

	public void setOwnerType(String[] ownerType) {
		this.ownerType = ownerType;
	}

	public String getSortField() {
		return sortField;
	}

	public ORDER getSortOrder() {
		return sortOrder;
	}

	public boolean isFullSearch() {
		return fullSearch;
	}

	public void setFullSearch(boolean fullSearch) {
		this.fullSearch = fullSearch;
	}
	
	
}
