package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.dto.PhotoTagDTO;

public class TagDAO extends DAOBase {

	/**
	 * @methodName  : select
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 20. 오후 02:50:25
	 * @methodCommet: PhotoTag 데이터
	 * @param param
	 * @return 
	 * @returnType  : 
	 */
	public List<PhotoTagDTO> select_PhotoTag(String uciCode) {
		SqlSession session = null;
		List<PhotoTagDTO> photoTag = null; 				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("uciCode", uciCode);
			photoTag = session.selectList("PhotoTag.selectPhotoTag", param);
						
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return photoTag;
	}

}
