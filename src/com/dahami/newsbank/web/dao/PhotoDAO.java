package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dto.ActionLogDTO;
import com.dahami.newsbank.web.dto.DownloadDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.StatsDTO;

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
			PhotoDTO dto = session.selectOne("Photo.selPhoto", uciCode);
			if(dto == null) {
				dto = new PhotoDTO();
				dto.setUciCode(PhotoDTO.UCI_ORGAN_CODEPREFIX_DAHAMI);
				dto.setSaleState(PhotoDTO.SALE_STATE_DEL);
			}
			return dto;
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
		return null;
	}
	
	/**
	 * @methodName  : getUciCodeByOldCode
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2018. 8. 9. 오후 3:33:42
	 * @methodCommet: 구 코드를 사용하여 새로운 UCI 코드를 판별한다
	 * @param oldCode
	 * @return 
	 * @returnType  : String
	 */
	public String getUciCodeByOldCode(String oldCode) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectOne("Photo.selUciCodeByOld", oldCode);
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
	public void updateTitDesc(PhotoDTO photoDTO) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			session.update("Photo.updatePhotoTitDesc", photoDTO);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
	}
	
	public void updatePic(PhotoDTO photoDTO) {
		
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.update("Photo.updatePhotoPic", photoDTO);
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
			logger.info("UpdateSaleState: " + photoDTO.getUciCode() + " / " + photoDTO.getSaleState());
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
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
	public List<PhotoDTO> dibsPhotoList(int member_seq, int bookmark_seq, int pageVol, int start) {
		SqlSession session = null;
		List<PhotoDTO> photoList = new ArrayList<PhotoDTO>();
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("bookmark_seq", bookmark_seq);
			param.put("pageVol", pageVol);
			param.put("start", start);
			
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
	
	/**
	 * @methodName  : hit
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 19. 오전 08:54:35
	 * @methodCommet: 사진 조회수
	 * @param param
	 * @return 
	 */
	public void hit(String uciCode) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			session.update("Photo.hitPhoto", uciCode);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
	}
	
	/**
	 * @methodName  : editorPhotoList
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 07. 오전 08:46:35
	 * @methodCommet: 에디터가 선정한 사진
	 * @param param
	 * @return 
	 */
	public List<PhotoDTO> editorPhotoList() {
		SqlSession session = null;
		List<PhotoDTO> photoList = new ArrayList<PhotoDTO>();
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("exhName", "에디터");
			
			MemberDAO memberDAO = new MemberDAO();
			List<MemberDTO> mediaList = memberDAO.listActiveMedia(); // 활성 매체사 불러오기
			int[] mediaSeq = new int[mediaList.size()]; // 활성 매체사 SEQ 배열
			
			for(int idx=0; idx<mediaList.size(); idx++) {
				mediaSeq[idx] = mediaList.get(idx).getSeq();
			}		
			param.put("mediaSeq", mediaSeq);
			
			photoList = session.selectList("Photo.selectPhotoExh", param);
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
	
	/**
	 * @methodName  : downloadPhotoList
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 07. 오전 08:46:35
	 * @methodCommet: 다운로드별 인기사진
	 * @param param
	 * @return 
	 */
	public List<PhotoDTO> downloadPhotoList(Map<String, Object> params) {
		SqlSession session = null;
		List<PhotoDTO> photoList = new ArrayList<PhotoDTO>();
				
		MemberDAO memberDAO = new MemberDAO();
		List<MemberDTO> mediaList = memberDAO.listActiveMedia(); // 활성 매체사 불러오기
		int[] mediaSeq = new int[mediaList.size()]; // 활성 매체사 SEQ 배열
		
		for(int idx=0; idx<mediaList.size(); idx++) {
			mediaSeq[idx] = mediaList.get(idx).getSeq();
		}		
		params.put("mediaSeq", mediaSeq);
		
		try {
			session = sf.getSession();
			photoList = session.selectList("Photo.selectDownloadRank", params);
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
	
	/**
	 * @methodName  : basketPhotoList
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 07. 오전 08:46:35
	 * @methodCommet: 찜별 인기사진
	 * @param param
	 * @return 
	 */
	public List<PhotoDTO> basketPhotoList(Map<String, Object> params) {
		SqlSession session = null;
		List<PhotoDTO> photoList = new ArrayList<PhotoDTO>();
		
		MemberDAO memberDAO = new MemberDAO();
		List<MemberDTO> mediaList = memberDAO.listActiveMedia(); // 활성 매체사 불러오기
		int[] mediaSeq = new int[mediaList.size()]; // 활성 매체사 SEQ 배열
		
		for(int idx=0; idx<mediaList.size(); idx++) {
			mediaSeq[idx] = mediaList.get(idx).getSeq();
		}		
		params.put("mediaSeq", mediaSeq);
		
		try {
			session = sf.getSession();
			photoList = session.selectList("Photo.selectBasketRank", params);
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
	
	/**
	 * @methodName  : hitsPhotoList
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 07. 오전 08:46:35
	 * @methodCommet: 상세보기별 인기사진
	 * @param param
	 * @return 
	 */
	public List<PhotoDTO> hitsPhotoList(Map<String, Object> params) {
		SqlSession session = null;
		List<PhotoDTO> photoList = new ArrayList<PhotoDTO>();
		
		MemberDAO memberDAO = new MemberDAO();
		List<MemberDTO> mediaList = memberDAO.listActiveMedia(); // 활성 매체사 불러오기
		int[] mediaSeq = new int[mediaList.size()]; // 활성 매체사 SEQ 배열
		
		for(int idx=0; idx<mediaList.size(); idx++) {
			mediaSeq[idx] = mediaList.get(idx).getSeq();
		}		
		params.put("mediaSeq", mediaSeq);
		
		try {
			session = sf.getSession();
			photoList = session.selectList("Photo.selectHitsRank", params);
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
	
	/**
	 * @methodName  : getStats
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 11. 13. 오전 8:33:56
	 * @methodCommet: UCI 코드를 사용하여 이미지 통계정보 확인(찜, 다운로드, 결제, 조회수, 뮤지엄, 컬렉션)
	 * @param uciCode
	 * @return 
	 * @returnType  : StatsDTO
	 */
	public StatsDTO getStats(String uciCode) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			return session.selectOne("Photo.selectStats", uciCode);
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
		return null;
	}
	
	/**
	 * @methodName  : insDownLog
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 11. 21. 오전 11:26:03
	 * @methodCommet: 다운로드 기록 생성
	 * @param downLog 
	 * @returnType  : void
	 */
	public void insDownLog(DownloadDTO downLog) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			session.insert("Download.insDownload", downLog);
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
	}
	
	/**
	 * @methodName  : checkPayDownloadable
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 11. 21. 오후 5:31:10
	 * @methodCommet: 
	 * @param uciCode
	 * @param memberSeq
	 * @return 
	 * @returnType  : boolean
	 */
	public boolean checkPayDownloadable(String uciCode, List<Integer> memberList) {
		SqlSession session = null;
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("uciCode", uciCode);
		String memberListStr = "";
		for(int cur : memberList) {
			if(memberListStr.length() > 0) {
				memberListStr += ",";
			}
			memberListStr += cur;
		}
		param.put("memberListStr", memberListStr);
		try {
			session = sf.getSession();
			if(session.selectOne("Download.selDownloadable", param) != null) {
				return true;
			}
			return false;
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
		return false;
	}
	
	/**
	 * @methodName  : getExhibition
	 * @author      : LEE. GWANGHO
	 * @date        : 2018. 03. 29. 오전 08:26:35
	 * @methodCommet: 전시 정보
	 * @param param
	 * @return 
	 */
	public Map<String, Object> getExhibition(Map<String, Object> params) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			return session.selectOne("Photo.selectExhibition", params);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
		return null;
	}
	
	/**
	 * @methodName  : deletePhotoExh
	 * @author      : LEE. GWANGHO
	 * @date        : 2018. 03. 29. 오전 08:26:35
	 * @methodCommet: 엄선한 사진 삭제
	 * @param param
	 * @return 
	 */
	public void deletePhotoExh(Map<String, Object> params) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			session.delete("Photo.deletePhotoExh", params);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
	}
	
	/**
	 * @methodName  : insertPhotoExh
	 * @author      : LEE. GWANGHO
	 * @date        : 2018. 03. 29. 오전 08:26:35
	 * @methodCommet: 엄선한 사진 추가
	 * @param param
	 * @return 
	 */
	public void insertPhotoExh(Map<String, Object> params) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			session.delete("Photo.insertPhotoExh", params);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
	}
	
	/**
	 * @methodName  : insertPhotoBlock
	 * @author      : LEE. GWANGHO
	 * @date        : 2018. 03. 29. 오전 08:26:35
	 * @methodCommet: 블랙리스트 추가
	 * @param param
	 * @return 
	 */
	public void insertPhotoBlock(Map<String, Object> params) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			session.insert("Photo.insertPhotoBlock", params);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
	}
	
	public void insertActionLog(ActionLogDTO dto) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			session.insert("Photo.insertActionLog", dto);
			logger.info("ActionLog: " + dto.getUciCode() + " / " + dto.getActionTypeStr() + " / memberSeq: " + dto.getMemberSeq());
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
	}
	
	public List<ActionLogDTO> listActionLog(String uciCode) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			return session.selectList("Photo.listActionLog", uciCode);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
		return new ArrayList<ActionLogDTO>();
	}
	
	/**
	 * @methodName  : searchActionLog
	 * @author      : LEE. GWANGHO
	 * @date        : 2021. 11. 10. 오후 16:30:35
	 * @methodCommet: 수정이력관리 검색
	 * @param param
	 * @return 
	 */
	public List<ActionLogDTO> searchActionLog(Map<String, Object> params) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			return session.selectList("Photo.searchActionLog", params);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
		return new ArrayList<ActionLogDTO>();
	}
	
	/**
	 * @methodName  : getActionLogCount
	 * @author      : LEE. GWANGHO
	 * @date        : 2021. 11. 10. 오후 16:30:35
	 * @methodCommet: 수정이력관리 갯수
	 * @param param
	 * @return 
	 */
	public int getActionLogCount(Map<String, Object> params) {
		SqlSession session = null;
		int count = 0;
		try {
			session = sf.getSession();
			count = session.selectOne("Photo.countActionLog", params);
			return count;
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
		return count;
	}
	
	
	
	// uciCode 가장 최근 수정내역
	public ActionLogDTO lastActionLog(String uciCode) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			return session.selectOne("Photo.lastActionLog", uciCode);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
		return null;
	}
}
