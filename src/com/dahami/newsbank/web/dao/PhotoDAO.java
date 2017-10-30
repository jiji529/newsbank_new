package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import com.dahami.newsbank.dto.PhotoDTO;

public class PhotoDAO extends DAOBase {
	
	/**
	 * @methodName  : read
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 10. 30. 오후 4:19:56
	 * @methodCommet: UCI 코드를 사용하여 특정 이미지 정보를 읽어옴
	 * @param uciCode
	 * @return 
	 * @returnType  : PhotoDTO
	 */
	public PhotoDTO read(String uciCode) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			return session.selectOne("Photo.selPhoto", uciCode);
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
		return null;
	}
	
	/**
	 * @methodName  : update
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 19. 오전 08:54:35
	 * @methodCommet: CMS 상세페이지 사진 제목, 내용을 수정
	 * @param param
	 * @return 
	 */
	public void update(PhotoDTO photoDTO) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			session.update("Photo.updatePhoto", photoDTO);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
	}
	
	/**
	 * @methodName  : update_SaleState
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 24. 오후 05:13:23
	 * @methodCommet: CMS 상세페이지 옵션 변경
	 * @param param
	 * @return 
	 */
	public void update_SaleState(PhotoDTO photoDTO) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			session.update("Photo.updateSaleState", photoDTO);
			
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
	 * @methodName  : update_portraitRightState
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 24. 오후 05:13:23
	 * @methodCommet: CMS 상세페이지 옵션 변경
	 * @param param
	 * @return 
	 */
	public void update_PortraitRightState(PhotoDTO photoDTO) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			session.update("Photo.updateRightYN", photoDTO);
			
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
	 * @methodName  : dibsPhotoList
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 25. 오후 05:06:35
	 * @methodCommet: 사용자별 찜한 목록
	 * @param param
	 * @return 
	 */
	public List<PhotoDTO> dibsPhotoList(String member_seq, String bookmark_seq) {
		SqlSession session = null;
		List<PhotoDTO> photoList = new ArrayList<PhotoDTO>();
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("bookmark_seq", bookmark_seq);
			
			photoList = session.selectList("Photo.dibsPhoto", param);
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return photoList;
	}
	
}
