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
			
			//usageList = session.selectList("Usage.selectList");
			usageList = session.selectList("Usage.usageOption");
					
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

}
