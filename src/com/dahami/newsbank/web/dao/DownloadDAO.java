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
	public List<Map<String, String>> downloadList(int member_seq, int year) {
		SqlSession session = null;
		List<Map<String, String>> downList = new ArrayList<Map<String, String>>();
		
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("year", year);
			
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
	
	/**
	 * @methodName  : totalDownloadList
	 * @author      : HOYADEV
	 * @date        : 2018. 03. 08. 오전 13:34:35
	 * @methodCommet: 전체 다운로드 내역 관리
	 * @param param
	 * @return 
	 */
	public List<Map<String, String>> totalDownloadList(Map<Object, Object> searchOpt) {
		SqlSession session = null;
		List<Map<String, String>> downList = new ArrayList<Map<String, String>>();
		System.out.println(searchOpt);
		
		try {
			session = sf.getSession();
			downList = session.selectList("Download.TotalDownlist", searchOpt);
			
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
	
	/**
	 * @methodName : getDownloadCount
	 * @author : Lee, Gwangho
	 * @date : 2018. 03. 08. 오후 04:35:13
	 * @methodCommet: 조건에 따른 다운로드 갯수
	 * @return
	 * @returnType : 
	 */
	public int getDownloadCount(Map<Object, Object> searchOpt) {
		SqlSession session = null;
		int count = 0;
		try {
			session = sf.getSession();
			count = session.selectOne("Download.totalCnt", searchOpt);
			return count;
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
		return count;
	}

}
