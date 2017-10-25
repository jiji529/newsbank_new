package com.dahami.newsbank.web.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dto.BookmarkDTO;

public class BookmarkDAO extends DAOBase {

	/**
	 * @methodName  : insert
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 25. 오전 10:02:12
	 * @methodCommet: 찜 추가
	 * @param param
	 * @return 
	 */
	public void insert(String member_seq, String photo_uciCode, String bookName) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			Map<String, Object> bookmark = new HashMap<String, Object>();
			bookmark.put("member_seq", member_seq);
			bookmark.put("photo_uciCode", photo_uciCode);
			bookmark.put("bookName", bookName);
			
			session.insert("Bookmark.insertBookmark", bookmark);
			
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
	 * @methodName  : select
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 25. 오후 1:14:20
	 * @methodCommet: 사용자별 찜 기사 유무확인
	 * @param param
	 * @return 
	 */
	public BookmarkDTO select(int member_seq, String photo_uciCode) {
		SqlSession session = null;
		//List<BookmarkDTO> bookmarkList = null;
		BookmarkDTO bookmark = new BookmarkDTO();
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("photo_uciCode", photo_uciCode);
			
			bookmark = session.selectOne("Bookmark.selectOne_Bookmark", param);		
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return bookmark;
	}

}
