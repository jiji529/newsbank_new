/**
 * <%---------------------------------------------------------------------------
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @Package Name   : com.dahami.newsbank.web.dao
 * @fileName : PaymentDAO.java
 * @author   : CHOI, SEONG HYEON
 * @date     : 2017. 11. 6.
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 11. 6.   	  tealight        PaymentDAO.java
 *--------------------------------------------------------------------------%>
 */
package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

/**
 * @author p153-1706
 *
 */
public class PaymentDAO extends DAOBase {

	public PaymentManageDTO selectPaymentManage(PaymentManageDTO paymentManageDTO) {
		SqlSession session = null;
		PaymentManageDTO paymentInfo = null;
		try {

			session = sf.getSession();
			paymentInfo = session.selectOne("payment.selectPaymentDetail", paymentManageDTO);

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return paymentInfo;

	}
	
	/**
	 * @methodName : selectPaymentList
	 * @author : Lee, Gwang ho
	 * @date : 2018. 03. 22. 오후 03:45:43
	 * @methodCommet: 구매내역 리스트
	 * @return
	 * @returnType : List<PaymentDetailDTO>
	 */
	public List<PaymentDetailDTO> selectPaymentList(List<Integer> memberList, Map<String,String[]> paramMaps) {
		SqlSession session = null;
		List<PaymentDetailDTO> paylist = null;
		
		int startPage = Integer.parseInt(paramMaps.get("page")[0]) - 1;
		int pageVol = Integer.parseInt(paramMaps.get("bundle")[0]);
		
		try {

			session = sf.getSession();
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("memberList", memberList);
			param.put("year", paramMaps.get("year")[0] == null ? 0 : Integer.parseInt(paramMaps.get("year")[0]));
			param.put("month", (paramMaps.get("month")[0] == null || paramMaps.get("month")[0].equals("")) ? 0 : Integer.parseInt(paramMaps.get("month")[0]));
			param.put("startPage", startPage * pageVol);
			param.put("pageVol", pageVol);
			
			paylist = session.selectList("payment.selectPaymentDetailList", param);

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return paylist;
	}
	
	/**
	 * @methodName : selectPaymentListTotal
	 * @author : Lee, Gwang ho
	 * @date : 2018. 09. 12. 오후 02:09:43
	 * @methodCommet: 구매내역 총 갯수, 금액
	 * @return
	 * @returnType : 
	 */
	public Map<String, Object> selectPaymentListTotal(List<Integer> memberList, Map<String,String[]> paramMaps) {
		SqlSession session = null;
		Map<String, Object> totalObject = new HashMap<>();
		int count = 0;		
		int startPage = Integer.parseInt(paramMaps.get("page")[0]) - 1;
		int pageVol = Integer.parseInt(paramMaps.get("bundle")[0]);
		
		try {

			session = sf.getSession();
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("memberList", memberList);
			param.put("year", paramMaps.get("year")[0] == null ? 0 : Integer.parseInt(paramMaps.get("year")[0]));
			param.put("month", (paramMaps.get("month")[0] == null || paramMaps.get("month")[0].equals("")) ? 0 : Integer.parseInt(paramMaps.get("month")[0]));
			
			totalObject = session.selectOne("payment.selectPaymentDetailListTotal", param);

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return totalObject;
	}
	
	/**
	 * @methodName : selectPaymentManageList
	 * @author : Lee, Gwang ho
	 * @date : 2018. 03. 16. 오전 09:24:43
	 * @methodCommet: 사용자 상세 정보
	 * @return
	 * @returnType : PaymentManageDTO
	 */
	public PaymentManageDTO selectPaymentManageList(PaymentManageDTO paymentManageDTO) {
		SqlSession session = null;
		PaymentManageDTO paymentInfo = null;
		try {

			session = sf.getSession();
			paymentInfo = session.selectOne("payment.selectWherePaymentDetail", paymentManageDTO);

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return paymentInfo;
	}

	/**
	 * @methodName : listPaymentManage
	 * @author : Choi, SeongHyeon
	 * @date : 2017. 11. 3. 오전 10:01:43
	 * @methodCommet: 검색된 사용자 정보
	 * @return
	 * @returnType : List<MemberDTO>
	 */
	public List<PaymentManageDTO> listPaymentManage(Map<String,String[]> paramMaps) {
		SqlSession session = null;
		List<PaymentManageDTO> list = new ArrayList<PaymentManageDTO>();
		
		int member_seq = Integer.parseInt(paramMaps.get("member_seq")[0]);
		int startPage = Integer.parseInt(paramMaps.get("page")[0]) - 1;
		int pageVol = Integer.parseInt(paramMaps.get("bundle")[0]);
		
		try {
			session = sf.getSession();
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("startPage", startPage * pageVol);
			param.put("pageVol", pageVol);
			
			list = session.selectList("payment.selectPaymentManage", param);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return list;
	}
	
	/**
	 * @methodName : listPaymentManageTotal
	 * @author : Lee, Gwang ho
	 * @date : 2018. 09. 13. 오전 09:13:43
	 * @methodCommet: 구매내역 총 갯수, 금액
	 * @return
	 * @returnType : 
	 */
	public Map<String, Object> listPaymentManageTotal(Map<String,String[]> paramMaps) {
		SqlSession session = null;
		Map<String, Object> totalObject = new HashMap<>();
		int member_seq = Integer.parseInt(paramMaps.get("member_seq")[0]);
		
		try {
			session = sf.getSession();
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			
			totalObject = session.selectOne("payment.selectPaymentManageTotal", param);

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return totalObject;
	}
	
	/**
	 * 
	 * @param paymentManageDTO
	 * @author : Choi, SeongHyeon
	 * @date : 2018. 07. 10. 오후 16:01:43
	 * @methodCommet: 결제 코드로만 결제 정보 호출
	 */
	public PaymentManageDTO selectPaymentOID(PaymentManageDTO paymentManageDTO) {
		SqlSession session = null;
		PaymentManageDTO dto = new PaymentManageDTO();
		try {

			session = sf.getSession();
			dto = session.selectOne("payment.selectPaymentOID", paymentManageDTO);

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return dto;
	}

	/**
	 * @methodName : insertPaymentManage
	 * @author : Choi, SeongHyeon
	 * @date : 2017. 11. 20. 오전 10:01:43
	 * @methodCommet: 결제 정보 입력
	 * @return
	 * @returnType : int
	 */
	public int insertPaymentManage(PaymentManageDTO paymentManageDTO,List<PaymentDetailDTO> DetailList) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.insert("payment.insertPaymentManage", paymentManageDTO);
			for (PaymentDetailDTO paymentDetailDTO : DetailList) {
				paymentDetailDTO.setPaymentManage_seq(paymentManageDTO.getPaymentManage_seq());
				session.insert("payment.insertPaymentDetail", paymentDetailDTO);
			}
			return paymentManageDTO.getPaymentManage_seq();
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return 0;
	}

	public List<Map<String, Object>> searchAccountList(Map<String, Object> param) {

		SqlSession session = null;
		try {

			session = sf.getSession();
			return session.selectList("payment.selectToTalAccountList", param);

		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

	}

	public List<Map<String, Object>> selectTotalPrice(Map<String, Object> param) {

		SqlSession session = null;
		try {

			session = sf.getSession();
			return session.selectList("payment.selectTotalPrice", param);

		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

	}
	
	/**
	 * 
	 * @param paymentDetailDTO
	 * @return
	 * 결제 성공 후 다운로드 날짜 갱신 //시작일 종료일
	 */
	public boolean updateDownloadDate(PaymentDetailDTO paymentDetailDTO) {
		boolean result = false;
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.update("payment.updateDownloadDate", paymentDetailDTO);
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
	
	/**
	 * 
	 * @param paymentDetailDTO
	 * @return
	 * 결제 정보 이미지별 정보 업데이트 // 날짜 다운로드 수 가격 
	 */
	public boolean updatePaymentDetail(PaymentDetailDTO paymentDetailDTO) {
		boolean result = false;
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.update("payment.updatePaymentDetail", paymentDetailDTO);
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
	 * 
	 * @param paymentDetailDTO
	 * @return
	 * 사용자별 결제 이미지 다운로드 횟수 증가 
	 */
	public boolean updateDownloadCount(PaymentDetailDTO paymentDetailDTO) {
		boolean result = false;
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.update("payment.paymentDetailDownCount", paymentDetailDTO);
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
	
	/**
	 * 
	 * @param paymentDetailDTO
	 * @return
	 * 결제취소 
	 */
	public boolean updatePaymentDetailStatus(PaymentDetailDTO paymentDetailDTO) {
		boolean result = false;
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.update("payment.updatePaymentDetailStatus", paymentDetailDTO);
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
	 * 
	 * @param paymentManageDTO
	 * @return
	 * 
	 * 결제정보 업데이트
	 */
	
	public PaymentManageDTO updatePaymentManage(PaymentManageDTO paymentManageDTO) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			session.update("payment.updatePaymentManage", paymentManageDTO);
			session.commit();
			paymentManageDTO = session.selectOne("payment.selectWherePaymentDetail", paymentManageDTO);
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				
				session.close();
			} catch (Exception e) {
			}
		}
		return paymentManageDTO;
	}
	
	
/**
 * 
 * @param photoDTO
 * 결제 완료 후 결제된 아이템 카트 삭제
 * 
 */
	public void deletePaymentCart(PaymentManageDTO paymentManageDTO) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			session.delete("payment.deletePaymentCart", paymentManageDTO);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {session.commit();} catch (Exception e) {}
			try {session.close();} catch (Exception e) {}
		}
	}
	
	
	/**
	 * @methodName : buyList
	 * @author : LEE. GWANGHO
	 * @date : 2018. 03. 09. 오후 10:01:43
	 * @methodCommet: 관리자 페이지 - 구매내역(전체 사용자)
	 * @return
	 * @returnType :  List<Map<String, Object>>
	 */
	public List<Map<String, Object>> buyList(Map<String, Object> param) {
		SqlSession session = null;
		try {

			session = sf.getSession();
			return session.selectList("payment.selectAllPaymentDetail", param);

		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * @methodName : getBuyCount
	 * @author : Lee, Gwangho
	 * @date : 2018. 03. 08. 오후 04:35:13
	 * @methodCommet: 조건에 따른 구매내역 갯수
	 * @return
	 * @returnType : 
	 */
	public int getBuyCount(Map<String, Object> searchOpt) {
		SqlSession session = null;
		int count = 0;
		try {
			session = sf.getSession();
			count = session.selectOne("payment.AllPaymentDetailCnt", searchOpt);
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
	 * @methodName : getBuyPrice
	 * @author : Lee, Gwangho
	 * @date : 2018. 03. 13. 오전 09:35:13
	 * @methodCommet: 조건에 따른 총 판매금액
	 * @return
	 * @returnType : 
	 */
	public int getBuyPrice(Map<String, Object> searchOpt) {
		SqlSession session = null;
		int price = 0;
		try {
			session = sf.getSession();
			price = session.selectOne("payment.AllPaymentDetailPrice", searchOpt);			
			return price;
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
		return price;
	}
	
	/**
	 * @methodName : onlinePayList
	 * @author : LEE. GWANGHO
	 * @date : 2018. 03. 09. 오후 10:01:43
	 * @methodCommet: 관리자 페이지 - 온라인 결제 내역
	 * @return
	 * @returnType :  List<Map<String, Object>>
	 */
	public List<PaymentManageDTO> onlinePayList(Map<String, Object> param) {
		SqlSession session = null;
		try {

			session = sf.getSession();
			return session.selectList("payment.onlinePayResult", param);

		} catch (Exception e) {
			logger.warn("", e);
			return null;
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * @methodName : getOnlineCount
	 * @author : Lee, Gwangho
	 * @date : 2018. 03. 09. 오후 10:01:43
	 * @methodCommet: 조건에 따른 결제내역 갯수
	 * @return
	 * @returnType : 온라인 결제 관리 (총 갯수)
	 */
	public int getOnlineCount(Map<String, Object> searchOpt) {
		SqlSession session = null;
		int count = 0;
		try {
			session = sf.getSession();
			count = session.selectOne("payment.onlinePayCount", searchOpt);
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
	 * @methodName : getOnlinePrice
	 * @author : Lee, Gwangho
	 * @date : 2018. 03. 09. 오후 10:01:43
	 * @methodCommet: 조건에 따른 총 금액 
	 * @return
	 * @returnType : 온라인 결제 관리 (총 금액)
	 */
	public int getOnlinePrice(Map<String, Object> searchOpt) {
		SqlSession session = null;
		int price = 0;
		try {
			session = sf.getSession();
			price = session.selectOne("payment.onlinePayPrice", searchOpt);			
			return price;
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.close();
			} catch (Exception e) {
			}
		}
		return price;
	}
	
	/**
	 * @methodName : selectOfflinePay
	 * @author : Lee, Gwang ho
	 * @date : 2018. 10. 19. 오전 09:14:43
	 * @methodCommet: 오프라인 결제정보
	 * @return
	 * @returnType : PaymentManageDTO
	 */
	public PaymentManageDTO selectOfflinePay(PaymentDetailDTO paymentDetailDTO) {
		SqlSession session = null;
		PaymentManageDTO paymentInfo = null;
		try {

			session = sf.getSession();
			paymentInfo = session.selectOne("payment.selectOfflinePay", paymentDetailDTO);

		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}

		return paymentInfo;
	}
	
	/**
	 * @methodName : getOfflineAllState
	 * @author : Lee, Gwang ho
	 * @date : 2018. 10. 19. 오전 09:14:43
	 * @methodCommet: 오프라인 결제 모든 상세내역 승인상태 반환
	 * @return
	 * @returnType : boolean
	 */
	
	public boolean getOfflineAllState(PaymentDetailDTO paymentManageDTO) {
		boolean result = false;
		int unapprove_cnt = 0;
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			unapprove_cnt = session.selectOne("payment.selectUnArrovePaymentDeatilCnt", paymentManageDTO);
			
			if(unapprove_cnt == 0) { // 미승인 내역이 없을 경우만 반환
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
	

}
