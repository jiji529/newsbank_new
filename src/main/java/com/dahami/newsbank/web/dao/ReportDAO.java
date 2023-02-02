package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;


public class ReportDAO extends DAOBase {
	/**
	 * @methodName  : reportRegister
	 * @author      : LEE. JEAWOO
	 * @date        : 2018. 04. 20. 오전 09:56:50
	 * @methodCommet: 사진 오류 신고하기	
	 * 				mailing - 0:받지 않음, 1:받음
	 * @param param
	 * @return 
	 */
	public int reportRegister(Map<String,Object> map) {
		SqlSession session = null;
		int result = 0;
						
		try {
			session = sf.getSession();
			session.selectOne("report.firstReportInsert", map);
						
		} catch (Exception e) {
			logger.warn("", e);
			result = -1;
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return result;
	}
	/**
	 * @methodName  : reportSelectList
	 * @author      : LEE. JEAWOO
	 * @date        : 2018. 04. 20. 오전 10:36:50
	 * @methodCommet: 오류 신고하기 내용 가져오기(개인 오류 신고 내역, 수정완료 메일에 참조)	
	 * 				status - 0:전체, 1:접수, 2:수정완료
	 * 				mailing - 0:받지 않음, 1:받음
	 * @param param
	 * @return 
	 */
	public List<Map<String,Object>> reportSelectList(Map<String,Object> map) {
		SqlSession session = null;
		List<Map<String, Object>> result = new ArrayList<Map<String,Object>>();
						
		try {
			session = sf.getSession();
			result = session.selectList("report.reportSelect", map);
						
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return result;
	}
	
	/**
	 * @methodName  : reportSelectListTotalCnt
	 * @author      : LEE. JEAWOO
	 * @date        : 2018. 04. 20. 오전 10:36:50
	 * @methodCommet: 오류 신고하기 내용 가져오기(개인 오류 신고 내역, 수정완료 메일에 참조) 리스트 총수
	 * @param param
	 * @return 
	 */
	public int reportSelectListTotalCnt(Map<String,Object> map) {
		SqlSession session = null;
		int result = 0;
						
		try {
			session = sf.getSession();
			result = session.selectOne("report.reportSelectTotalCnt", map);
						
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return result;
	}
	
	/**
	 * @methodName  : reportModifyComplete
	 * @author      : LEE. JEAWOO
	 * @date        : 2018. 04. 20. 오후 13:30:50
	 * @methodCommet: 수정완료 DB처리
	 * 				status - 0:전체, 1:접수, 2:수정완료
	 * @param param
	 * @return 
	 */
	public int reportModifyComplete(int seq) {
		SqlSession session = null;
		int result = 0;				
		
		try {
			session = sf.getSession();
			session.update("report.reportModifyComplete", seq);
						
		} catch (Exception e) {
			logger.warn("", e);
			result = -1;
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return result;
	}
	
	/**
	 * @methodName  : reportNotCompleteCnt
	 * @author      : LEE. JEAWOO
	 * @date        : 2018. 04. 20. 오후 13:30:50
	 * @methodCommet: 수정완료 DB처리
	 * 				status - 0:전체, 1:접수, 2:수정완료
	 * @param param
	 * @return 
	 */
	public int reportNotCompleteCnt(int member_seq) {
		SqlSession session = null;
		int result = 0;				
		
		try {
			session = sf.getSession();
			result = session.selectOne("report.reportNotCompleteCnt", member_seq);
						
		} catch (Exception e) {
			logger.warn("", e);
			result = -1;
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return result;
	}
	
	/**
	 * @methodName  : reportWriterEmail
	 * @author      : LEE. JEAWOO
	 * @date        : 2018. 04. 23. 오전 11:00:00
	 * @methodCommet: 오류 신고하기 작성자 Email 불러오기
	 * @param param
	 * @return 
	 */
	public String reportWriterEmail(int member_seq) {
		SqlSession session = null;
		String result = "";				
		
		try {
			session = sf.getSession();
			result = session.selectOne("report.reportWriterEmail", member_seq);
						
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return result;
	}
}
