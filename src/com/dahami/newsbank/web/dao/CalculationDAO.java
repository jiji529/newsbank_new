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
		List<Map<String, Object>> result = new ArrayList<>();
		
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
	 * @methodName : mypageCal
	 * @author : Lee.GwangHo
	 * @date : 2018. 03. 22. 오후 01:33:43
	 * @methodCommet: 마이페이지 정산 내역 통계
	 * @return
	 * @returnType : List<CalculationDTO>
	 */ 
	public List<Map<String, Object>> mypageCal(Map<String, Object> param) {
		SqlSession session = null;
		List<Map<String, Object>> result = new ArrayList<>();
		
		try {
			session = sf.getSession();
			return session.selectList("calculation.mypageCal", param);
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
	
	/*public static String getQuery(SqlSession sqlSession, String queryId , Object sqlParam){

		BoundSql boundSql = sqlSession.getConfiguration().getMappedStatement(queryId).getSqlSource().getBoundSql(sqlParam);
		String query1 = boundSql.getSql();
		Object paramObj = boundSql.getParameterObject();

		if(paramObj != null){              // 파라미터가 아무것도 없을 경우
			List<ParameterMapping> paramMapping = boundSql.getParameterMappings();
			for(ParameterMapping mapping : paramMapping){
				String propValue = mapping.getProperty();       
				query1=query1.replaceFirst("\\?", "#{"+propValue+"}");
			}
		}
		return query1; 
	}
	
	public static String getQuery_Str(SqlSession sqlSession, String queryId , Object sqlParam){
		return sqlSession.getConfiguration().getMappedStatement(queryId).getSqlSource().getBoundSql(sqlParam).getSql();
	}*/


	/**
	 * @methodName : mypageCalList
	 * @author : Lee.GwangHo
	 * @date : 2018. 03. 20. 오후 03:01:43
	 * @methodCommet: 정산내역 목록
	 * @return
	 * @returnType : List<CalculationDTO>
	 */ 
	public List<Map<String, Object>> mypageCalList(Map<String, Object> param) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("calculation.mypageCalList", param);
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
}
