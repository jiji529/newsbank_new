package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dto.DownloadDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

public class DownloadDAO extends DAOBase {

	/**
	 * @methodName  : downloadList
	 * @author      : HOYADEV
	 * @date        : 2018. 02. 14. 오전 08:34:35
	 * @methodCommet: 사용자별 다운로드 목록
	 * @param param
	 * @return 
	 */
	//public List<Map<String, String>> downloadList(int member_seq, Map<String,String[]> paramMaps) {
	public List<Map<String, String>> downloadList(List<Integer> memberList, Map<String,String[]> paramMaps) {
	
		SqlSession session = null;
		List<Map<String, String>> downList = new ArrayList<Map<String, String>>();
		
		int startPage = Integer.parseInt(paramMaps.get("page")[0]) - 1;
		int pageVol = Integer.parseInt(paramMaps.get("bundle")[0]);
		startPage = startPage*pageVol; 
		
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("memberList", memberList);
			param.put("year", paramMaps.get("year")[0] == null ? 0 : Integer.parseInt(paramMaps.get("year")[0]));
			param.put("startPage", startPage);
			param.put("pageVol", pageVol);
			
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
	 * @methodName  : downloadList
	 * @author      : JEAWOOLEE
	 * @date        : 2018. 04. 06. 오전 11:38:40
	 * @methodCommet: 사용자별 다운로드 목록 총합
	 * @param param
	 * @return 
	 */
	//public int downloadListTotal(int member_seq, Map<String,String[]> paramMaps) {
	public int downloadListTotal(List<Integer> memberList, Map<String,String[]> paramMaps) {
		SqlSession session = null;
		int count=0;
		
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("memberList", memberList);
			param.put("year", paramMaps.get("year")[0] == null ? 0 : Integer.parseInt(paramMaps.get("year")[0]));
			
			count = session.selectOne("Download.selDownListTotalCnt", param);
			
			return count;
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return 0;
	}
	
	/**
	 * @methodName  : totalDownloadList
	 * @author      : HOYADEV
	 * @date        : 2018. 03. 08. 오전 13:34:35
	 * @methodCommet: 전체 다운로드 내역 관리
	 * @param param
	 * @return 
	 */
	public List<Map<String, Object>> totalDownloadList(Map<Object, Object> searchOpt) {
		SqlSession session = null;
		List<Map<String, Object>> downList = new ArrayList<Map<String, Object>>();
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
	
	/**
	 * @methodName : notBuyList
	 * @author : Lee, Gwangho
	 * @date : 2018. 03. 13. 오후 04:35:13
	 * @methodCommet: 다운로드 후 비구매 계정
	 * @return
	 * @returnType : 
	 */
	public List<Map<String, Object>> notBuyList(Map<String, Object> searchOpt) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("Download.notSellList", searchOpt);
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
	}
	
	
	/**
	 * @methodName : notBuyListCount
	 * @author : Lee, Gwangho
	 * @date : 2018. 03. 13. 오후 04:35:13
	 * @methodCommet: 다운로드 후 비구매 계정 갯수
	 * @return
	 * @returnType : 
	 */
	public int notBuyListCount(Map<String, Object> searchOpt) {
		SqlSession session = null;		
		try {
			session = sf.getSession();
			return session.selectOne("Download.notSellListCount", searchOpt);
		} catch (Exception e) {
			logger.warn("", e);
			return 0;
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
	}

}
