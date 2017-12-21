package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
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
	public void insert(int member_seq, String photo_uciCode, String bookName) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			Map<String, Object> bookmark = new HashMap<String, Object>();
			bookmark.put("member_seq", member_seq);
			bookmark.put("photo_uciCode", photo_uciCode);
			bookmark.put("bookName", bookName);
			
			session.insert("Bookmark.insertBookmarkPhoto", bookmark);
			
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
	 * @methodCommet: 사용자별 찜 사진 유무확인
	 * @param param
	 * @return 
	 */
	public BookmarkDTO select(int member_seq, String photo_uciCode) {
		SqlSession session = null;
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
	
	/**
	 * @methodName  : delete
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 26. 오후 2:40:10
	 * @methodCommet: 찜 사진 삭제
	 * @param param
	 * @return 
	 */
	public void delete(int member_seq, String photo_uciCode) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("photo_uciCode", photo_uciCode);
			
			session.delete("Bookmark.deleteBookmarkPhoto", param);		
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
	 * @methodName  : userBookmark
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 26. 오후 4:12:22
	 * @methodCommet: 사용자별 찜 그룹
	 * @param param
	 * @return 
	 */
	public List<BookmarkDTO> userBookmark(int member_seq) {
		SqlSession session = null;
		List<BookmarkDTO> bookmarkList = new ArrayList<BookmarkDTO>();
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			
			bookmarkList = session.selectList("Bookmark.selectBookmark", param);
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return bookmarkList;
	}
	
	/**
	 * @methodName  : insertFolder
	 * @author      : LEE, GWANGHO
	 * @date        : 2017. 11. 14. 오흐 03:02:12
	 * @methodCommet: 찜 폴더 추가
	 * @param param
	 * @return 
	 */
	public int insertFolder(int member_seq, String bookName) {
		SqlSession session = null;
		int bookmark_seq = 0;
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("bookName", bookName);
			
			session.insert("Bookmark.insertBookmark", param);
			bookmark_seq = (int) param.get("seq");
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return bookmark_seq;
	}
	
	/**
	 * @methodName  : updateFolder
	 * @author      : LEE, GWANGHO
	 * @date        : 2017. 10. 26. 오후 2:40:10
	 * @methodCommet: 찜 폴더 수정
	 * @param param
	 * @return 
	 */
	public void updateFolder(int member_seq, String bookName, int bookmark_seq) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("bookName", bookName);
			param.put("bookmark_seq", bookmark_seq);
			
			session.update("Bookmark.updateBookmark", param);		
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
	 * @methodName  : deleteFolder
	 * @author      : LEE, GWANGHO
	 * @date        : 2017. 10. 26. 오후 2:40:10
	 * @methodCommet: 찜 폴더 삭제
	 * @param param
	 * @return 
	 */
	public void deleteFolder(int member_seq, int bookmark_seq) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("bookmark_seq", bookmark_seq);
			
			session.delete("Bookmark.deleteBookmarkPhotoAll", param); // 해당 폴더에 저장된 사진 삭제
			session.delete("Bookmark.deleteBookmark", param); // 폴더 DB 삭제	
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
	 * @methodName  : updateBookmarkPhoto
	 * @author      : LEE, GWANGHO
	 * @date        : 2017. 10. 26. 오후 2:40:10
	 * @methodCommet: 선택항목 찜폴더 이동
	 * @param param
	 * @return 
	 */
	public void updateBookmarkPhoto(int bookmark_seq, String photo_uciCode) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("bookmark_seq", bookmark_seq);
			param.put("photo_uciCode", photo_uciCode);
			
			session.update("Bookmark.updateBookmarkPhoto", param);		
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
	 * @methodName  : selectBookmarkPhoto
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 21. 오후 05:14:20
	 * @methodCommet: 사용자별 찜 사진 목록
	 * @param param
	 * @return 
	 */
	public List<BookmarkDTO> selectBookmarkPhoto(int member_seq) {
		SqlSession session = null;
		List<BookmarkDTO> bookmarkList = new ArrayList<BookmarkDTO>();
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			bookmarkList = session.selectList("Bookmark.selectBookmarkPhoto", param);		
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return bookmarkList;
	}

}
