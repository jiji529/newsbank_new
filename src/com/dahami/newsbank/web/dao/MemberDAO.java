
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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.MemberDTO;

public class MemberDAO extends DAOBase {

	/**
	 * @methodName : listActiveMedia
	 * @author : JEON,HYUNGGUK
	 * @date : 2017. 11. 1. 오전 10:01:43
	 * @methodCommet: 활성(검색서비스 가능) 매체사 리스트
	 * @return
	 * @returnType : List<MemberDTO>
	 */
	public List<MemberDTO> listActiveMedia() {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("Member.listActiveMedia");
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {session.close();} catch (Exception e) {}
		}
	}
	
	/**
	 * @methodName  : listManagableMedia
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2018. 5. 15. 오전 9:31:41
	 * @methodCommet: 관리 가능 매체사 리스트
	 * @return 
	 * @returnType  : List<MemberDTO>
	 */
	public List<MemberDTO> listManagableMedia() {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("Member.listManagableMedia");
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {session.close();} catch (Exception e) {}
		}
	}
	
	/**
	 * @methodName  : getMember
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 11. 21. 오전 11:20:49
	 * @methodCommet: 해당 쿼리로 사용자 정보를 읽어온다(연계 계정을 위해 필요)
	 * @param qryMap
	 * @return 
	 * @returnType  : MemberDTO
	 */
	public MemberDTO getMember(String qryMap) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectOne(qryMap);
		}catch(Exception e) {
			logger.warn("", e);
			return null;
		}finally{
			try {session.close();}catch(Exception e){}
		}
	}
	
	/**
	 * @methodName  : getMember
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2018. 3. 30. 오후 3:01:26
	 * @methodCommet: 멤버정보를 갱신한다. 마지막 갱신 후 5초 이내인 경우 무시한다
	 * @param member
	 * @return 
	 * @returnType  : MemberDTO
	 */
	public MemberDTO getMember(MemberDTO member) {
		if(member.getLastModifiedTime() + 1000 <= System.currentTimeMillis()) {
			return getMember(member.getSeq());
		}
		return member;
	}
	
	public MemberDTO getMember(int memberSeq) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			MemberDTO member = session.selectOne("Member.selMamberBySeq", memberSeq);
			if(member != null) {
				member.setLastModifiedTime(System.currentTimeMillis());
				List<Integer> subAdj = session.selectList("Member.listSlaveAdj", memberSeq);
				member.getSubAdjSet().addAll(subAdj);
				
				List<Integer> subRep = session.selectList("Member.listSlaveRep", memberSeq);
				member.getSubRepSet().addAll(subRep);
				
				if(member.getGroup_seq() > 0) {
					List<Integer> groupList = session.selectList("Member.listGroupMember", member.getGroup_seq());
					member.getGroupSet().addAll(groupList);
				}
			}
			return member;
		}catch(Exception e) {
			logger.warn("", e);
			return null;
		}finally{
			try {session.close();}catch(Exception e){}
		}
	}

	public MemberDTO selectMember(MemberDTO memberDTO) {
		SqlSession session = null;
		MemberDTO memberInfo = null;
		try {

			session = sf.getSession();
			memberInfo = session.selectOne("Member.selectLogin", memberDTO);

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return memberInfo;

	}

	public boolean selectId(MemberDTO memberDTO) {
		SqlSession session = null;
		boolean result = false;
		try {

			session = sf.getSession();
			if ((int) session.selectOne("Member.selectId", memberDTO) > 0) {
				result = true;
			}

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return result;
	}

	public MemberDTO insertMember(MemberDTO memberDTO) {
		
		SqlSession session = null;
		try {
			session = sf.getSession();
			if ((int) session.selectOne("Member.selectId", memberDTO) > 0) {
			} else {
				session.insert("Member.insertMember", memberDTO);

				// 회원가입시 기본 북마크 그룹 생성
				Map<String, Object> bookmark = new HashMap<String, Object>();
				bookmark.put("member_seq", memberDTO.getSeq());
				bookmark.put("bookName", "기본폴더");
				session.insert("Bookmark.insertBookmark", bookmark);

			}
			session.commit();
			// result = memberDTO.isMember();

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		System.out.println("insert(" + memberDTO + ") --> " + memberDTO.getEmail());
		System.out.println(memberDTO.getName());

		return memberDTO;
	}

	public boolean updateMember(MemberDTO memberDTO) {
		boolean result = false;
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.update("Member.updateMember", memberDTO);
			result = true;
			session.commit();
			// result = memberDTO.isMember();

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		//System.out.println("insert(" + memberDTO + ") --> " + memberDTO.getEmail());
		//System.out.println(memberDTO.getName());

		return result;
	}

	/**
	 * @methodName : listMember
	 * @author : Choi, SeongHyeon
	 * @date : 2017. 11. 3. 오전 10:01:43
	 * @methodCommet: 검색된 사용자 정보
	 * @return
	 * @returnType : List<MemberDTO>
	 */
	public List<MemberDTO> listMember(MemberDTO memberDTO) {
		SqlSession session = null;
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();
		try {

			session = sf.getSession();
			memberList = session.selectList("Member.selectLogin", memberDTO);

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return memberList;
	}

	/**
	 * @methodName : listAdjustMedia
	 * @author : JEON,HYUNGGUK
	 * @date : 2017. 11. 1. 오전 10:01:43
	 * @methodCommet: 정산 매체사 리스트
	 * @return
	 * @returnType : List<MemberDTO>
	 */
	public List<MemberDTO> listAdjustMedia(MemberDTO memberDTO) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("Member.listAdjustMedia", memberDTO);
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {session.close();} catch (Exception e) {}
		}
	}
	
	/**
	 * @methodName : adminAdjustMedia
	 * @author : LEE,GWAGNHO
	 * @date : 2018. 03. 05.  오후 16:01:43
	 * @methodCommet: 관리자 정산정보
	 * @return
	 * @returnType : List<MemberDTO>
	 */
	public List<MemberDTO> adminAdjustMedia(MemberDTO memberDTO) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("Member.adminAdjustMedia", memberDTO);
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * @methodName : adjustMediaInfo
	 * @author : LEE,GWAGNHO
	 * @date : 2018. 03. 05.  오후 16:01:43
	 * @methodCommet: 관리자 정산정보
	 * @return
	 * @returnType : List<MemberDTO>
	 */
	public MemberDTO adjustMediaInfo(MemberDTO memberDTO) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectOne("Member.adjustMediaInfo", memberDTO);
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * @methodName : adjSlaveMedia
	 * @author : LEE,GWAGNHO
	 * @date : 2018. 03. 22.  오후 16:01:43
	 * @methodCommet: 정산정보(주정산에 따른 피정산 매체목록)
	 * @return
	 * @returnType : List<MemberDTO>
	 */
	public List<MemberDTO> adjSlaveMedia(MemberDTO memberDTO) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("Member.adjSlaveMedia", memberDTO);
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * @methodName : selectMemberList
	 * @author : Lee, Gwangho
	 * @date : 2017. 11. 23. 오전 10:27:13
	 * @methodCommet: 회원 현황 (조건절 : 타입, 결제, 그룹)
	 * @return
	 * @returnType : List<MemberDTO>
	 */
	public List<MemberDTO> selectMemberList(Map<Object, Object> searchOpt) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("Member.selMemberList", searchOpt);
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * @methodName : insertGroup
	 * @author : Lee, Gwangho
	 * @date : 2017. 11. 24. 오후 04:02:13
	 * @methodCommet: 그룹 추가
	 * @return
	 * @returnType : 
	 */
	public void insertGroup(Map<Object, Object> param) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.insert("Member.insertGroup", param);
			
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
	 * @methodName : updateMemberGroup
	 * @author : Lee, Gwangho
	 * @date : 2017. 11. 24. 오후 04:02:13
	 * @methodCommet: 회원 그룹정보 수정
	 * @return
	 * @returnType : 
	 */
	public void updateMemberGroup(Map<Object, Object> param) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.update("Member.updateMemberGroup", param);
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
	 * @methodName : getMemberCount
	 * @author : Lee, Gwangho
	 * @date : 2017. 11. 27. 오후 01:02:13
	 * @methodCommet: 조건에 따른 회원 인원수
	 * @return
	 * @returnType : 
	 */
	public int getMemberCount(Map<Object, Object> param) {
		SqlSession session = null;
		int count = 0;
		try {
			session = sf.getSession();
			count = session.selectOne("Member.memberCnt", param);
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
	
	/**
	 * @methodName : selectMediaList
	 * @author : Lee, Gwangho
	 * @date : 2018. 01. 02. 오후 03:27:13
	 * @methodCommet: 회원 현황 (조건절 : 타입, 결제, 그룹)
	 * @return
	 * @returnType : List<MemberDTO>
	 */
	public List<Map<String, Object>> selectMediaList(Map<Object, Object> searchOpt) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("Member.selMediaList", searchOpt);
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * @methodName : getMediaCount
	 * @author : Lee, Gwangho
	 * @date : 2018. 01. 02. 오후 03:35:13
	 * @methodCommet: 조건에 따른 정산 매체사 수
	 * @return
	 * @returnType : 
	 */
	public int getMediaCount(Map<Object, Object> param) {
		SqlSession session = null;
		int count = 0;
		try {
			session = sf.getSession();
			count = session.selectOne("Member.mediaCnt", param);
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
	
	/**
	 * @methodName : getCountContents
	 * @author : Lee, Gwangho
	 * @date : 2018. 01. 03. 오후 03:35:13
	 * @methodCommet: 매체사별 블라인드 / 전체 컨텐츠 갯수
	 * @return
	 * @returnType : 
	 */
	public List<Map<String, String>> getContentAmount(Map<Object, Object> param) {
		SqlSession session = null;
		int count = 0;
		try {
			session = sf.getSession();
			return session.selectList("Member.countContents", param);
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}		
	}	
	
	/**
	 * @methodName : leaveMember
	 * @author : Lee, Gwangho
	 * @date : 2018. 01. 19. 오전 10:09:13
	 * @methodCommet: 회원 탈퇴
	 * @return
	 * @returnType : 
	 */
	public boolean leaveMember(MemberDTO memberDTO) {
		boolean result = false;
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.update("Member.leaveMember", memberDTO);
			result = true;
			session.commit();
			// result = memberDTO.isMember();

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return result;
	}
	
	/**
	 * @methodName  : listOldMembert
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2018. 4. 27. 오후 1:29:37
	 * @methodCommet: 장기간 로그인 하지 않은 사용자 쿼리 TODO 활성 사용자만 쿼리하도록 변경
	 * @return 
	 * @returnType  : List<MemberDTO>
	 */
	public List<MemberDTO> listOldMembert() {
		SqlSession session = null;
		try {
			session = sf.getSession();
			return session.selectList("Member.listOldMember");
		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
	}

	/**
	 * @methodName  : setOldMailSend
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2018. 4. 27. 오후 1:29:53
	 * @methodCommet: 장기 로그인 하지 않은 사용자 메일전송 처리
	 * @param memberSeq
	 * @return 
	 * @returnType  : boolean
	 */
	public boolean setOldMailSend(int memberSeq) {
		boolean result = false;
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.update("Member.setOldMailSend", memberSeq);
			result = true;
			session.commit();

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return result;
	}

}
