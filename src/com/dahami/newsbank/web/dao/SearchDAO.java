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
import java.util.List;

import com.dahami.common.util.ObjectUtil;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

public class SearchDAO {

	public List<PhotoDTO> search(SearchParameterBean param) {
		List<PhotoDTO> ret = new ArrayList<PhotoDTO>();
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
						ret.add(cur);
					}
				}catch(Exception e) {
					break;
				}
			}
		}
		
		return ret;
	}
}
