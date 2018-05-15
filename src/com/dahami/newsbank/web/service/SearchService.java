/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : SearchService.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 11. 2. 오전 8:57:16
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 11. 2.     JEON,HYUNGGUK		최초작성
 * 2017. 11. 2.     
 *******************************************************************************/

package com.dahami.newsbank.web.service;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.common.util.XmlUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.dto.ActionLogDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;
import com.dahami.newsbank.web.util.ExcelUtil;

public class SearchService extends ServiceBase {
	private static final SimpleDateFormat regDf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public static final int SEARCH_MODE_USER = 0;
	public static final int SEARCH_MODE_OWNER = 1;
	public static final int SEARCH_MODE_ADMIN = 2;
	
	public static final int EXPORT_TYPE_JSON = 0;
	public static final int EXPORT_TYPE_XML = 1;
	public static final int EXPORT_TYPE_EXCEL = 2;
	
	private int searchMode;
	
	public SearchService(int searchMode) {
		this.searchMode = searchMode;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		Map<String, String[]> params = request.getParameterMap();
		SearchParameterBean sParam = new SearchParameterBean(params);
		
		int exportType = 0;
		try {
			exportType = (int)request.getAttribute("exportType");
		}catch(Exception e) {
			exportType = EXPORT_TYPE_JSON;
		}
		
		MemberDAO memberDao = new MemberDAO();
		if(exportType == EXPORT_TYPE_EXCEL) {
			sParam.setPageVol(100000);
		}
		
		Set<Integer> searchableMdSet = new HashSet<Integer>();	// 검색 가능한 매체 리스트 (모든 검색)
		Set<Integer> mngableMdSet = new HashSet<Integer>();		// 관리 가능한 전체 매체 리스트 (관리자 CMS)
		Set<Integer> ownedMdSet = new HashSet<Integer>();			//	소유한 (현재 회원인 승인받은) 매체 리스트 (매체 CMS)
		
		List<MemberDTO> activeMemberList = memberDao.listActiveMedia();
		for(MemberDTO mbr : activeMemberList) {
			searchableMdSet.add(mbr.getSeq());
		}
		
		HttpSession session = request.getSession();
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		if(searchMode > SEARCH_MODE_USER) {
			if(memberInfo != null) {
				List<MemberDTO> managableMemberList = memberDao.listManagableMedia();
				for(MemberDTO mbr : managableMemberList) {
					mngableMdSet.add(mbr.getSeq());
				}
				
				memberInfo = new MemberDAO().getMember(memberInfo);
				ownedMdSet.addAll(memberInfo.getOwnerGroupList());
			}
		}
		
		// 검색 대상 매체
		List<Integer> tgtUsrList = sParam.getTargetUserList();
		if(tgtUsrList.size() == 0) {	// 타겟 미지정
			if(searchMode == SEARCH_MODE_USER) {
				tgtUsrList.addAll(searchableMdSet);
			}
			else if(searchMode == SEARCH_MODE_OWNER) {
				tgtUsrList.addAll(ownedMdSet);
			}
			else if(searchMode == SEARCH_MODE_ADMIN) {
				tgtUsrList.addAll(mngableMdSet);
			}
		}
		else {	// 타겟 지정
			if(searchMode == SEARCH_MODE_USER) {
				// 지정된 대상이 모두 있지 않은 경우 / 검색 불가(불법적인 접근)
				if(!searchableMdSet.containsAll(tgtUsrList)) {
					logger.warn("Not Authorized Request.");
					tgtUsrList.clear();
				}
			}
			else if(searchMode == SEARCH_MODE_OWNER) {
				// 지정된 대상이 모두 있지 않은 경우 / 검색 불가(불법적인 접근)
				if(!ownedMdSet.containsAll(tgtUsrList)) {
					logger.warn("Not Authorized Request.");
					tgtUsrList.clear();
				}
			}
			else if(searchMode == SEARCH_MODE_ADMIN) {
				// 지정된 대상이 모두 있지 않은 경우 / 검색 불가(불법적인 접근)
				if(!mngableMdSet.containsAll(tgtUsrList)) {
					logger.warn("Not Authorized Request.");
					tgtUsrList.clear();
				}
			}
		}
		
		if(searchMode == SEARCH_MODE_USER) {
			// 사용자 검색은 판매 대상만 검색
			sParam.setSaleState(SearchParameterBean.SALE_STATE_OK);
		}
		else {
			if(sParam.getSaleState() == 0) {
				sParam.setSaleState(SearchParameterBean.SALE_STATE_DEFAULT);
			}
		}
		
		Map<String, Object> photoList = null;
		List<PhotoDTO> list = null;
		
		// 검색대상 매체가 확인된 경우에만 검색 실행
		if(tgtUsrList.size() > 0) {
			SearchDAO searchDAO = new SearchDAO();
			photoList = searchDAO.search(sParam);
			list = (List<PhotoDTO>) photoList.get("result");
		}
		
		if(exportType == EXPORT_TYPE_JSON) {
			JSONObject json = new JSONObject();
			List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
			if(photoList != null && list != null && list.size() > 0) {
				for(PhotoDTO dto : list){
					try {
						jsonList.add(dto.convertToFullMap());
					} catch (Exception e) {
						logger.warn("", e);
					}
				}
				json.put("count", photoList.get("count"));
				json.put("totalPage", photoList.get("totalPage"));
			}
			else {
				json.put("count", 0);
				json.put("totalPage", 0);	
			}
			json.put("result", jsonList);
		
			request.setAttribute("contentType", "text/json; charset=UTF-8");
			request.setAttribute("result", json.toJSONString());
		}
		else if(exportType == EXPORT_TYPE_XML) {
			Map<String, Object> root = new HashMap<String, Object>();
			Map<String, Object> photo = new HashMap<String, Object>();
			root.put("photo", photo);
			if(photoList != null) {
				int totalCount = (int) photoList.get("count");
				photo.put("totalCount", totalCount);
				int currentPage =  sParam.getPageNo();
				int pageSize = sParam.getPageVol();
				int totalPage = (totalCount / pageSize) + 1;
				photo.put("currentPage",currentPage);
				photo.put("pageSize",pageSize);
				photo.put("totalPage",totalPage);
				List<Map<String, Object>> itemList = new ArrayList<Map<String, Object>>();
				photo.put("Item", itemList);
				if(list != null && list.size() > 0) {
					for(PhotoDTO dto : list){
						String uciCode = dto.getUciCode();
						Map<String, Object> itemMap = new HashMap<String, Object>();
						itemList.add(itemMap);
						itemMap.put("link", dto.getViewUrl());
						itemMap.put("copyright", dto.getCopyright());
						itemMap.put("ownerName", dto.getOwnerName());
						String title = dto.getTitle();
						if(title != null) {
							itemMap.put("title", title.trim());
						}
						String description = dto.getDescription();
						if(description != null) {
							description = description.replaceAll("((\\r)?\\n)+", "\n").trim();
						}
						itemMap.put("caption", description);
						
						Date pubDate = dto.getPublishDate();
						if(pubDate != null) {
							itemMap.put("pubDate", regDf.format(pubDate));
						}
						Date shotDate = dto.getShotDate();
						if(shotDate != null) {
							itemMap.put("shotDate", regDf.format(shotDate));
						}
						
						itemMap.put("link", "/view.photo?uciCode="+uciCode+"&corp=gt");
						itemMap.put("thumbSrc", "/thumbSrc.down.photo?uciCode="+uciCode+"&corp=gt");
						itemMap.put("viewSrc", "/view.down.photo?uciCode="+uciCode+"&corp=gt");
						itemMap.put("outlineSrc", "/outline.down.photo?uciCode="+uciCode+"&corp=gt");
						itemMap.put("orgSrc", "/service.down.photo?uciCode="+uciCode+"&corp=gt");
						itemMap.put("imageSrc", "추가협의 필요");
						
						itemMap.put("width", dto.getWidthPx());
						itemMap.put("height", dto.getHeightPx());
						itemMap.put("size", dto.getFileSizeMBStr() + "MB");
						itemMap.put("photoId", uciCode);
					}
				}
			}
			request.setAttribute("contentType", "text/xml; charset=UTF-8");
			request.setAttribute("result", XmlUtil.MapToXmlString(root));
		}
		else if(exportType == EXPORT_TYPE_EXCEL) {
			List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
			PhotoDAO photoDAO = new PhotoDAO();
			if(photoList != null && list != null && list.size() > 0) {
				for(PhotoDTO dto : list){
					try {
						Map<String, Object> object = new HashMap<String, Object>();
						object.put("ownerName", dto.getOwnerName());
						object.put("uciCode", dto.getUciCode());
						object.put("compCode", dto.getCompCode());
						object.put("strSaleState", strSaleState(dto.getSaleState()));
						
						// 업로드 일자(DB등록 일자)
						SimpleDateFormat dateforamt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String uploadDate = dateforamt.format(dto.getRegDate()); 
						object.put("uploadDate", uploadDate);
						
						// 블라인드/삭제 등 변경 날짜, 내역 변경 아이디
						ActionLogDTO logDTO = photoDAO.lastActionLog(dto.getUciCode());
						if(logDTO == null) { // 변경 이력이 없을 경우
							object.put("regDate", "-");
							object.put("name", "-");
						}else {
							object.put("regDate", logDTO.getRegStrDate());
							object.put("name", logDTO.getMemberName());
						}
						
						jsonList.add(object);
						
					} catch (Exception e) {
						logger.warn("", e);
					}
				}
			}
			
			List<String> headList = Arrays.asList("언론사명", "UCI코드", "언론사코드", "사진상태", "업로드 날짜", "블라인드/삭제 등 변경 날짜", "내역 변경 아이디"); //  테이블 상단 제목
			List<Integer> columnSize = Arrays.asList(10, 20, 30, 10, 30, 30, 15); //  컬럼별 길이정보
			List<String> columnList = Arrays.asList("ownerName", "uciCode", "compCode", "strSaleState", "uploadDate", "regDate", "name"); // 컬럼명
			
			Date today = new Date();
		    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
			String orgFileName = "사진관리_" + dateforamt.format(today); // 파일명
			ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, jsonList, orgFileName);
		}
	}
	
	// 사진상태 반환
	private String strSaleState(int saleState) {
		String strSaleState = "";
		
		switch(saleState) {
			case 0:
				strSaleState = "미판매";
				break;
				
			case 1:
				strSaleState = "판매중";
				break;
				
			case 2:
				strSaleState = "판매중지";
				break;
				
			case 3:
				strSaleState = "삭제";
				break;
				
			case 4:
				strSaleState = "삭제(판매건)";
				break;
				
			case 5:
				strSaleState = "완전삭제";
				break;
		}
		
		return strSaleState;
	}
	
	 // 발행날짜 반환
	private String dateFormat(Date date) {
		String strDate = "";
		if(date != null) {
			strDate = new SimpleDateFormat("yyyy-MM-dd").format(date);
		}
		
		return strDate;
	}

}
