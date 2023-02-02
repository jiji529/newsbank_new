package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.CartDTO;
import com.dahami.newsbank.web.dto.UsageDTO;

public class UsageDAO extends DAOBase {

	/**
	 * @methodName  : usageList
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 30. 오전 11:12:32
	 * @methodCommet: 사용용도 옵션
	 * @param param : individual (0: 공통 사용용도)
	 * @return 
	 */
	public List<UsageDTO> usageList(int individual) {
		SqlSession session = null;
		List<UsageDTO> usageList = new ArrayList<UsageDTO>();
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("individual", individual);
			
			usageList = session.selectList("Usage.selectList", param);
					
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
	 * @methodName  : usageList
	 * @author      : HOYADEV
	 * @date        : 2018. 04. 03. 오전 11:12:32
	 * @methodCommet: 사용용도 옵션(전체)
	 * @param param : individual
	 * @return 
	 */
	public List<UsageDTO> usageList() {
		SqlSession session = null;
		List<UsageDTO> usageList = new ArrayList<UsageDTO>();
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			
			usageList = session.selectList("Usage.selectList", param);
					
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
	public List<UsageDTO> uciCodeOfUsage(String uciCode, int member_seq) {
		SqlSession session = null;
		List<UsageDTO> usageList = new ArrayList<UsageDTO>();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("member_seq", member_seq);
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
	 * @methodName  : selectOptions
	 * @author      : LEE. GWANGHO
	 * @date        : 2017. 11. 10. 오후 11:204:32
	 * @methodCommet: 사용용도 개별항목 
	 * @param param
	 * @return 
	 */
	public List<UsageDTO> selectOptions(String[] seqArry) {
		SqlSession session = null;
		List<UsageDTO> usageList = new ArrayList<UsageDTO>();
		
		try {
			session = sf.getSession();
			// 선택용도 갯수만큼 반복
			for(String seq : seqArry) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("seq", seq);
				UsageDTO dto = session.selectOne("Usage.selectOptions", param);
				usageList.add(dto);
			}
			return usageList;
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			session.commit();
			session.close();
		}
		return null;
	}
	
	/**
	 * @methodName  : totalPrice
	 * @author      : LEE. GWANGHO
	 * @date        : 2017. 11. 10. 오후 11:204:32
	 * @methodCommet: 사용용도 총 가격 
	 * @param param
	 * @return 
	 */
	public int totalPrice(String[] seqArry) {
		SqlSession session = null;
		int sum = 0; // 총 금액
		try {
			session = sf.getSession();
			// 선택용도 갯수만큼 반복
			for(String seq : seqArry) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("seq", seq);
				int price = session.selectOne("Usage.selectPrice", param);
				sum += price;
			}
			return sum;
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			session.commit();
			session.close();
		}
		return 0;
	}
		
	/**
	 * @methodName  : insertUsage
	 * @author      : LEE. GWANGHO
	 * @date        : 2018. 01. 19. 오후 16:24:32
	 * @methodCommet: 사용용도 추가(오프라인 별도 요금)
	 * @param param : ArrayList<UsageDTO>, seq(회원 고유번호)
	 * @return 
	 */
	public void insertUsage(List<UsageDTO> usageList, int seq) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			
			for(int idx = 0; idx < usageList.size(); idx++) {
				String usage = usageList.get(idx).getUsage();
				String price = String.valueOf(usageList.get(idx).getPrice());
				String individual = String.valueOf(seq);	// 회원 고유 member_seq
				
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("usage", usage);
				param.put("price", price);
				param.put("individual", individual);
				
				session.insert("Usage.insertUsage", param);
			}
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			session.commit();
			session.close();
		}
	}
	
	/**
	 * @methodName  : usageListOfuser
	 * @author      : HOYADEV
	 * @date        : 2018. 01. 22. 오전 09:21:32
	 * @methodCommet: 사용자별 사용용도 옵션
	 * @param param
	 * @return 
	 */
	public List<UsageDTO> usageListOfuser(int seq) {
		SqlSession session = null;
		List<UsageDTO> usageList = new ArrayList<UsageDTO>();
				
		try {
			session = sf.getSession();
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("individual", seq);
			usageList = session.selectList("Usage.selectList", param);
					
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
	 * @methodName  : disableUsage
	 * @author      : LEE. GWANGHO
	 * @date        : 2018. 01. 23. 오전 09:42:32
	 * @methodCommet: 사용용도 비활성화(오프라인 별도 요금)
	 * @param param : ArrayList<UsageDTO>, seq(회원 고유번호)
	 * @return 
	 */
	public void disableUsage(List<UsageDTO> usageList, int seq) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			
			for(int idx = 0; idx < usageList.size(); idx++) {
				int usageList_seq = usageList.get(idx).getUsageList_seq();
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("usageList_seq", usageList_seq);
				
				session.insert("Usage.disableUsage", param);
			}
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			session.commit();
			session.close();
		}
	}
	
	/**
	 * @methodName  : updateUsage
	 * @author      : LEE. GWANGHO
	 * @date        : 2018. 01. 23. 오전 09:42:32
	 * @methodCommet: 사용용도 변경 (오프라인 별도 요금)
	 * @param param : ArrayList<UsageDTO>, seq(회원 고유번호)
	 * @return 
	 */
	public void updateUsage(List<UsageDTO> usageList, int seq) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			
			for(int idx = 0; idx < usageList.size(); idx++) {
				int usageList_seq = usageList.get(idx).getUsageList_seq();
				String usage = usageList.get(idx).getUsage();
				int price = usageList.get(idx).getPrice();
				
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("usageList_seq", usageList_seq);
				param.put("usage", usage);
				param.put("price", price);
				
				session.insert("Usage.updateUsage", param);
			}
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			session.commit();
			session.close();
		}
	}
}