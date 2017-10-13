/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : SearchDAO.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 10. 10. 오후 3:39:50
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 10. 10.     JEON,HYUNGGUK		최초작성
 * 2017. 10. 10.     
 *******************************************************************************/

package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dahami.common.util.ObjectUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

public class SearchDAO extends DAOBase {

	/**
	 * @methodName  : search
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 10. 12. 오전 11:11:31
	 * @methodCommet: 주어진 조건으로 검색하여 결과리스트 리턴
	 * @param param
	 * @return 
	 * @returnType  : Map<String, Object> / count:결과 숫자(Integer) / result:결과물 리스트(List<PhotoDTO>)
	 */
	public Map<String, Object> search(SearchParameterBean param) {
		Map<String, Object> ret = new HashMap<String, Object>();
		
		List<PhotoDTO> photoList = new ArrayList<PhotoDTO>();
		List<PhotoDTO> totalList = (List<PhotoDTO>) ObjectUtil.loadObject(PhotoDTO.class.getResourceAsStream("photoList.obj"));
		
		int pageVol = param.getPageVol();
		int pageNo = param.getPageNo();
		
		int start = (pageNo-1) * pageVol;
		
		if(start >= 0 && start < totalList.size()) {
			for(int i = 0; i < pageVol; i++) {
				PhotoDTO cur = null;
				try {
					cur = totalList.get(start + i);
					if(cur != null) {
						photoList.add(cur);
					}
				}catch(Exception e) {
					break;
				}
			}
		}
		
		ret.put("count", totalList.size());
		ret.put("result", photoList);
		
		return ret;
	}
	
	/**
	 * @methodName  : read
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 10. 12. 오전 11:11:00
	 * @methodCommet: UCI 코드를 사용하여 특정 이미지 정보를 읽어옴
	 * @param uciCode
	 * @return 
	 * @returnType  : PhotoDTO
	 */
	public PhotoDTO read(String uciCode) {
		
		List<PhotoDTO> totalList = (List<PhotoDTO>) ObjectUtil.loadObject(PhotoDTO.class.getResourceAsStream("photoList.obj"));
		for(PhotoDTO cur : totalList) {
			if(cur.getUciCode().equals(uciCode)) {
				return cur;
			}
		}
		return null;
	}
}
