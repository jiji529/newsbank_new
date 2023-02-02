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
	
	/**
	 * @methodName  : insert_Tag
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 24. 오전 09:14:25
	 * @methodCommet: Tag 추가
	 * @param param : uciCode, tagName
	 * @return 
	 * @returnType  : 
	 */
	public void insert_Tag(String uciCode, String tagName) {
		SqlSession session = null;
		List<PhotoTagDTO> photoTag = null; 				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("photo_uciCode", uciCode);
			param.put("tagName", tagName);
			photoTag = session.selectList("PhotoTag.selectTagSeq", param);
			int count = photoTag.size();
			
			if(count != 0) { 
				// 이미 존재하는 태그
				int tag_seq = photoTag.get(0).getSeq();
				param.put("tag_seq", tag_seq);
				session.insert("PhotoTag.insertPhotoTag", param);
			}else {
				// 새로운 태그 추가
				session.insert("PhotoTag.insertTag", param);				
				int last_insert_seq = (int) param.get("seq");
				param.put("tag_seq", last_insert_seq);
				session.insert("PhotoTag.insertPhotoTag", param);
			}
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * @methodName  : delete_PhotoTag
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 24. 오후 03:36:19
	 * @methodCommet: 태그 삭제
	 * @param param : uciCode, tagName
	 * @return 
	 * @returnType  : 
	 */
	public void delete_PhotoTag(String uciCode, String tagName) {
		SqlSession session = null;
		List<PhotoTagDTO> photoTag = null; 				
		try {
			session = sf.getSession();
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("photo_uciCode", uciCode);
			param.put("tagName", tagName);
			session.delete("deletePhotoTag", param);
						
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
	}

}
