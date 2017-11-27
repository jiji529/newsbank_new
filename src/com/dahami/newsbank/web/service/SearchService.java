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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.dahami.common.util.XmlUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

public class SearchService extends ServiceBase {

	private static final SimpleDateFormat regDf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public static final int EXPORT_TYPE_JSON = 0;
	public static final int EXPORT_TYPE_XML = 1;
	
	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		Map<String, String[]> params = request.getParameterMap();
		SearchParameterBean sParam = new SearchParameterBean(params);
		
		// 사용자 검색은 활성 매체만을 대상으로 함
		sParam.setMediaInactive(SearchParameterBean.MEDIA_INACTIVE_NO);
		
		SearchDAO searchDAO = new SearchDAO();
		Map<String, Object> photoList = searchDAO.search(sParam);
		
		List<PhotoDTO> list = (List<PhotoDTO>) photoList.get("result");
		
		int exportType = 0;
		try {
			exportType = (int)request.getAttribute("exportType");
		}catch(Exception e) {
			exportType = EXPORT_TYPE_JSON;
		}
		
		if(exportType == EXPORT_TYPE_JSON) {
			JSONObject json = new JSONObject();
			List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
			if(list != null && list.size() > 0) {
				for(PhotoDTO dto : list){
					try {
						jsonList.add(dto.convertToFullMap());
					} catch (Exception e) {
						logger.warn("", e);
					}
				}
			}
			
			json.put("count", photoList.get("count"));
			json.put("totalPage", photoList.get("totalPage"));
			json.put("result", jsonList);
		
			request.setAttribute("JSON", json.toJSONString());
		}
		else if(exportType == EXPORT_TYPE_XML) {
			Map<String, Object> root = new HashMap<String, Object>();
			Map<String, Object> photo = new HashMap<String, Object>();
			root.put("photo", photo);
			
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
					Map<String, Object> itemMap = new HashMap<String, Object>();
					itemList.add(itemMap);
					itemMap.put("link", dto.getViewUrl());
					itemMap.put("copyright", dto.getCopyright());
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
					
					itemMap.put("flash", "추가협의 필요");
					itemMap.put("imageSrc", "추가협의 필요");
					
					itemMap.put("width", dto.getWidthPx());
					itemMap.put("height", dto.getHeightPx());
					itemMap.put("size", dto.getFileSizeMBStr() + "MB");
					itemMap.put("photoId", dto.getUciCode());
				}
			}
			
			request.setAttribute("XML", XmlUtil.MapToXmlString(root));
		}
	}

}
