package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dto.DownloadDTO;

public class DownloadDAO extends DAOBase {

	/**
	 * @methodName  : downloadList
	 * @author      : HOYADEV
	 * @date        : 2018. 02. 14. 오전 08:34:35
	 * @methodCommet: 사용자별 다운로드 목록
	 * @param param
	 * @return 
	 */
	/*
	public List<DownloadDTO> downloadList(int member_seq) {
		SqlSession session = null;
		List<DownloadDTO> downList = new ArrayList<DownloadDTO>();
		
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			
			downList = session.selectList("Download.selDownList", param);
			
			return downList;
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return null;
	}
	*/
	
	public List<Map<String, String>> downloadList(int member_seq) {
		SqlSession session = null;
		List<Map<String, String>> downList = new ArrayList<Map<String, String>>();
		
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			
			downList = session.selectList("Download.selDownList", param);
			
			return downList;
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return null;
	}

}
