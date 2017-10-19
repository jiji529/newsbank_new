
/**
 * <%---------------------------------------------------------------------------
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @Package Name   : com.dahami.newsbank.web.dao
 * @fileName : memberDAO.java
 * @author   : CHOI, SEONG HYEON
 * @date     : 2017. 10. 17.
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 10. 17.   	  tealight        memberDAO.java
 *--------------------------------------------------------------------------%>
 */
package com.dahami.newsbank.web.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.MemberDTO;

public class MemberDAO extends DAOBase {
	

	public MemberDTO selectMember(String ID) {
		SqlSession session = null;
		MemberDTO memberInfo = null;
		try {

			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("id", ID);
			memberInfo = session.selectOne("Member.selectId", param);

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}

		return memberInfo;

	}
}
