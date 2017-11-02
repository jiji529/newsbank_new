
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

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.MemberDTO;

public class MemberDAO extends DAOBase {

	/**
	 * @methodName  : listActiveMedia
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 11. 1. 오전 10:01:43
	 * @methodCommet: 활성 매체사 리스트
	 * @return 
	 * @returnType  : List<MemberDTO>
	 */
	public List<MemberDTO> listActiveMedia() {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("Member.listActiveMedia");
		}catch(Exception e) {
			logger.warn("", e);
			return null;
		}finally{
			try{session.close();}catch(Exception e){}
		}
	}

	public MemberDTO selectMember(Map<String, Object> param) {
		SqlSession session = null;
		MemberDTO memberInfo = null;
		try {

			session = sf.getSession();
			memberInfo = session.selectOne("Member.selectLogin", param);

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
	
	public boolean selectId(Map<String, Object> param) {
		SqlSession session = null;
		MemberDTO memberInfo = null;
		boolean result = false;
		try {

			session = sf.getSession();
			memberInfo = session.selectOne("Member.selectId", param);
			result = memberInfo.isMember();

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}

		return result;
	}
}
