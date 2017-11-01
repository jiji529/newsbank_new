package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.UsageDTO;

public class UsageDAO extends DAOBase {

	/**
	 * @methodName  : usageList
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 30. 오전 11:12:32
	 * @methodCommet: 사용용도 옵션
	 * @param param
	 * @return 
	 */
	public List<UsageDTO> usageList() {
		SqlSession session = null;
		List<UsageDTO> usageList = new ArrayList<UsageDTO>();
				
		try {
			session = sf.getSession();
			
			usageList = session.selectList("Usage.selectList");
			//usageList = session.selectList("Usage.usageOption");
					
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return usageList;
	}
	
	/**
	 * @methodName  : uciCodeOfUsage
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 31. 오후 04:12:32
	 * @methodCommet: uciCode별 사용용도 
	 * @param param
	 * @return 
	 */
	public List<UsageDTO> uciCodeOfUsage(String uciCode) {
		SqlSession session = null;
		List<UsageDTO> usageList = new ArrayList<UsageDTO>();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("member_seq", 1002);
		param.put("uciCode", uciCode);
		
		try {
			session = sf.getSession();
			
			usageList = session.selectList("Usage.uciCodeOfUsage", param);
					
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return usageList;
	}
	
	/**
	 * @methodName  : deleteOfUsage
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 01. 오전 11:204:32
	 * @methodCommet: 장바구니 - 사용용도별 옵션 삭제
	 * @param param
	 * @return 
	 */
	public void deleteOfUsage(String member_seq, String uciCode) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("uciCode", uciCode);
			
			session.delete("Cart.delete", param);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			session.commit();
			session.close();
		}
	}
	
	/**
	 * @methodName  : insertOfUsage
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 01. 오전 11:204:32
	 * @methodCommet: 장바구니 - 사용용도별 옵션 추가
	 * @param param
	 * @return 
	 */
	public void insertOfUsage(String member_seq, String uciCode, String usageList_seq, String price) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("uciCode", uciCode);
			param.put("usageList_seq", usageList_seq);
			param.put("price", price);
			
			session.insert("Cart.insert", param);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			session.commit();
			session.close();
		}
	}
}
