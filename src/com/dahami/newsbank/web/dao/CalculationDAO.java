package com.dahami.newsbank.web.dao;

import java.util.List;

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
	
	
	// 정산내역 목록
	/**
	 * @methodName : selectCalculation
	 * @author : Lee.GwangHo
	 * @date : 2018. 03. 20. 오후 03:01:43
	 * @methodCommet: 정산내역 목록
	 * @return
	 * @returnType : List<CalculationDTO>
	 */
	public List<CalculationDTO> selectCalculation(CalculationDTO calculationDTO) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("calculation.selectCalculation", calculationDTO);
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
