package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.BoardDTO;

public class BoardDAO extends DAOBase {

	/**
	 * @methodName  : noticeList
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 08. 오전 08:34:35
	 * @methodCommet: 공지사항 목록
	 * @param param
	 * @return 
	 */
	public List<BoardDTO> noticeList(String keyword) {
		SqlSession session = null;
		List<BoardDTO> noticeList = new ArrayList<BoardDTO>();
		//Map<String, Object> param = new HashMap<String, Object>();
		//param.put("keyword", keyword);
				
		try {
			session = sf.getSession();
			noticeList = session.selectList("Notice.selectNoticeList", keyword);
						
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return noticeList;
	}
	
	/**
	 * @methodName  : hitNotice
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 08. 오전 08:34:35
	 * @methodCommet: 공지사항 조회수 증가
	 * @param param
	 * @return 
	 */
	public void hitNotice(int board_seq) {
		SqlSession session = null;
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("seq", board_seq);
				
		try {
			session = sf.getSession();
			session.update("Notice.hitNotice", param);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
	}

}
