package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.BoardDTO;

public class BoardDAO extends DAOBase {

	/**
	 * @methodName  : noticeList
	 * @author      : LEE. GWANGHO
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
	 * @author      : LEE. GWANGHO
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
	
	/**
	 * @methodName  : getNotice
	 * @author      : LEE. GWANGHO
	 * @date        : 2017. 12. 13. 오전 10:51:35
	 * @methodCommet: 공지사항 정보 가져오기
	 * @param param : seq
	 * @return 
	 */
	public BoardDTO getNotice(int board_seq) {
		SqlSession session = null;
		BoardDTO boardDTO = new BoardDTO();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("seq", board_seq);
				
		try {
			session = sf.getSession();
			boardDTO = session.selectOne("Notice.selectNotice", param);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return boardDTO;
	}
	
	/**
	 * @methodName  : updateNotice
	 * @author      : LEE. GWANGHO
	 * @date        : 2017. 12. 13. 오전 11:41:35
	 * @methodCommet: 공지사항 수정
	 * @param param : seq
	 * @return 
	 */
	public void updateNotice(BoardDTO boardDTO) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			session.update("Notice.updateNotice", boardDTO);
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

	/**
	 * @methodName  : deleteNotice
	 * @author      : LEE. GWANGHO
	 * @date        : 2017. 12. 13. 오전 11:41:35
	 * @methodCommet: 공지사항 삭제
	 * @param param : seq
	 * @return 
	 */
	public void deleteNotice(BoardDTO boardDTO) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			session.update("Notice.deleteNotice", boardDTO);
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
	
	/**
	 * @methodName  : insertNotice
	 * @author      : LEE. GWANGHO
	 * @date        : 2017. 12. 13. 오후 03:06:35
	 * @methodCommet: 공지사항 추가
	 * @param param : 
	 * @return 
	 */
	public int insertNotice(BoardDTO boardDTO) {
		SqlSession session = null;
		int seq = 0;
		try {
			session = sf.getSession();
			session.insert("Notice.insertNotice", boardDTO);
			seq = boardDTO.getSeq();
			System.out.println("insert seq : " + seq);
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return seq;
	}
}
