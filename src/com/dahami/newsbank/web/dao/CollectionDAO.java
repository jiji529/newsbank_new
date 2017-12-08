package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.CollectionDTO;

public class CollectionDAO extends DAOBase {

	/**
	 * @methodName  : selectCollectionList
	 * @author      : LEE. GWANGHO
	 * @date        : 2017. 12. 08. 오전 10:14:20
	 * @methodCommet: 공개된 찜폴더 사진 목록
	 * @param param
	 * @return 
	 */
	public List<CollectionDTO> selectCollectionList() {
		SqlSession session = null;
		List<CollectionDTO> collectionList = new ArrayList<CollectionDTO>();
		
		try {
			session = sf.getSession();
			collectionList = session.selectList("Collection.selectCollection");		
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return collectionList;
	}
	
	/**
	 * @methodName  : selectBackgroundPhoto
	 * @author      : LEE. GWANGHO
	 * @date        : 2017. 12. 08. 오후 02:14:20
	 * @methodCommet: 찜폴더의 대표 배경사진 출력
	 * @param param
	 * @return 
	 */
	public CollectionDTO selectBackgroundPhoto(int bookmark_seq) {
		SqlSession session = null;
		CollectionDTO collection = new CollectionDTO();
		
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("bookmark_seq", bookmark_seq);
			
			collection = session.selectOne("Collection.selectBackgroundPhoto", param);
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return collection;
	}

}
