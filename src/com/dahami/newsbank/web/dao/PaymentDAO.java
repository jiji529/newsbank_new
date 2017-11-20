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
	 * @methodName : listPaymentManage
	 * @author : Choi, SeongHyeon
	 * @date : 2017. 11. 3. 오전 10:01:43
	 * @methodCommet: 검색된 사용자 정보
	 * @return
	 * @returnType : List<MemberDTO>
	 */
	public List<PaymentManageDTO> listPaymentManage(PaymentManageDTO paymentManageDTO) {
		SqlSession session = null;
		List<PaymentManageDTO> list = new ArrayList<PaymentManageDTO>();
		try {

			session = sf.getSession();
			list = session.selectList("payment.selectPaymentManage", paymentManageDTO);

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

		// Map<String, Object> ret = new HashMap<String, Object>();
		SqlSession session = null;
		// PaymentManageDTO paymentInfo = null;
		try {

			session = sf.getSession();
			// System.out.println(session.getConfiguration().getMappedStatement("payment.selectToTalAccountList").getSqlSource().getBoundSql(param).getSql());
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
			// System.out.println(session.getConfiguration().getMappedStatement("payment.selectTotalPrice").getSqlSource().getBoundSql(param).getSql());
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
			paymentManageDTO = session.selectOne("payment.selectPaymentOID", paymentManageDTO);
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

}
