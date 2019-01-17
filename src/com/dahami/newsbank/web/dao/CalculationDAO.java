package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.converters.IntegerArrayConverter;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.CalculationDTO;

public class CalculationDAO extends DAOBase {

	// 정산 매체 추가
	public int insertCalculation(CalculationDTO calculationDTO) {
		SqlSession session = null;
		
		try{
			session = sf.getSession();
			session.insert("calculation.insertCalculation", calculationDTO);
			return calculationDTO.getSeq();
		} catch(Exception e){
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
	 * @methodName : selectCalculation
	 * @author : Lee.GwangHo
	 * @date : 2018. 03. 20. 오후 03:01:43
	 * @methodCommet: 정산내역 목록
	 * @return
	 * @returnType : List<CalculationDTO>
	 */ 
	public List<CalculationDTO> selectCalculation(Map<String, Object> param) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("calculation.selectCalculation", param);
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
	 * @methodName : selectOfMonth
	 * @author : Lee.GwangHo
	 * @date : 2018. 03. 22. 오후 01:33:43
	 * @methodCommet: 정산내역 월별 통계
	 * @return
	 * @returnType : List<CalculationDTO>
	 */ 
	public List<Map<String, Object>> selectOfMonth(Map<String, Object> param) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			return session.selectList("calculation.selectOfMonth", param);
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
	 * @methodName : monthlyStats
	 * @author : Lee.GwangHo
	 * @date : 2018. 07. 22. 오후 01:33:43
	 * @methodCommet: 마이페이지 정산 내역 통계
	 * @return
	 * @returnType : List<Map<String, Object>>
	 */ 
	public List<Map<String, Object>> monthlyStats(Map<String, Object> param) {
		SqlSession session = null;
		List<Map<String, Object>> result = new ArrayList<>();
		
		try {
			session = sf.getSession();
			return session.selectList("calculation.monthlyStats", param);
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
	 * @methodName : statsList
	 * @author : Lee.GwangHo
	 * @date : 2018. 07. 22. 오후 03:01:43
	 * @methodCommet: 정산내역 목록
	 * @return
	 * @returnType : List<Map<String, Object>>
	 */ 
	public List<Map<String, Object>> statsList(Map<String, Object> param) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("calculation.statsList", param);
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
	 * @methodName : existsOfCalculation
	 * @author : Lee, Gwangho
	 * @date : 2019. 01. 17. 오후 01:25:43
	 * @methodCommet: 조건에 따른 정산내역 존재여부 (조건: id, uciCode, type, payType) 
	 * @return
	 * @returnType : 정산내역 갯수 반환
	 */
	public int existsOfCalculation(CalculationDTO calculationDTO) {
		SqlSession session = null;
		int count = 0;
		try {
			session = sf.getSession();
			count = session.selectOne("calculation.existsOfCalculation", calculationDTO);			
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
