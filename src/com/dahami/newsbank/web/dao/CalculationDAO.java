package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.CalculationDTO;

public class CalculationDAO extends DAOBase {

	// 정산 매체 추가
	public int insertCalculation(CalculationDTO calculationDTO) {
		SqlSession session = null;
		
		try{
			session = sf.getSession();
			session.insert("calculation.insertCalculation", calculationDTO);
			
		} catch(Exception e){
			logger.warn("", e);
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
		//String sDate = param.get("start_date").toString();
		//String eDate = param.get("end_date").toString();
		
		//int sMonth = Integer.parseInt(sDate.substring(sDate.length()-2, sDate.length()));
		//int eMonth = Integer.parseInt(eDate.substring(eDate.length()-2, eDate.length()));
		
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
}
