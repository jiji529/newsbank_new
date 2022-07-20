package com.dahami.newsbank.web.dao;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.ImportLogDTO;

public class ImportLogDAO extends DAOBase {
	
	/**
	 * @methodName  : selectImportLog
	 * @author      : HA.J.S
	 * @date        : 2022. 07. 20. 오전 10:12:00
	 * @methodCommet: ImportLog에서 기존에 받아왔던 srcXml, srcImg 정보를 받아온다.
	 * @param uciCode
	 * @return 
	 * @returnType  : ImportLogDto
	 */
	
	public ImportLogDTO selectImportLog(String uciCode) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			ImportLogDTO dto = session.selectOne("ImportLog.selectImportLog", uciCode);

			return dto;
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
		return null;
	}
	
}
