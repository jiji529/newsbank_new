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

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

public class SearchService extends ServiceBase {

	/* (non-Javadoc)
	 * @see com.dahami.newsbank.web.service.ServiceBase#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		Map<String, String[]> params = request.getParameterMap();
		SearchParameterBean sParam = new SearchParameterBean(params);
		SearchDAO searchDAO = new SearchDAO();
		Map<String, Object> photoList = searchDAO.search(sParam);
		JSONObject json = new JSONObject();
		
		
		
		List<PhotoDTO> list = (List<PhotoDTO>) photoList.get("result");
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

}
