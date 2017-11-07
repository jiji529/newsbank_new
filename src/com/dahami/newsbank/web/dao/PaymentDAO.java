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
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;

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

	public boolean insertPaymentManage(PaymentManageDTO paymentManageDTO) {
		boolean result = false;
		SqlSession session = null;
		try {
			session = sf.getSession();
			if ((int) session.selectOne("payment.selectPaymentMaange", paymentManageDTO) > 0) {
				result = false;
			} else {
				session.insert("payment.insertPaymentMaange", paymentManageDTO);

				result = true;
			}
			System.out.println(session);
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
