package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.web.dto.CartDTO;
import com.dahami.newsbank.web.dto.UsageDTO;

public class CartDAO extends DAOBase {
	
	
	/**
	 * @methodName  : insertCart
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 01. 오전 11:204:32
	 * @methodCommet: 장바구니 - 사용용도별 옵션 추가
	 * @param param
	 * @return 
	 */
	public void insertCart(int member_seq, String uciCode, String usageList_seq, String price) {
		SqlSession session = null;
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("uciCode", uciCode);
			param.put("usageList_seq", usageList_seq);
			param.put("price", price);
			
			session.insert("Cart.insert", param);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			session.commit();
			session.close();
		}
	}
	
	/**
	 * @methodName  : cartList
	 * @author      : HOYADEV
	 * @date        : 2017. 10. 27. 오후 02:18:35
	 * @methodCommet: 장바구니 목록
	 * @param param
	 * @return 
	 */
	public List<CartDTO> cartList(String member_seq) {
		SqlSession session = null;
		List<CartDTO> cartList = new ArrayList<CartDTO>();
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			
			cartList = session.selectList("Cart.selectCartList", param);
			for(CartDTO cartDTO : cartList) {
				String uciCode = cartDTO.getUciCode();
				param.put("uciCode", uciCode);
				List<UsageDTO> usageList = session.selectList("Cart.selectUsageList", param);
				cartDTO.setUsageList(usageList);
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
		return cartList;
	}
	
	/**
	 * @methodName  : deleteCart
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 01. 오후 03:38:35
	 * @methodCommet: 장바구니 항목 삭제
	 * @param param
	 * @return 
	 */
	public void deleteCart(int member_seq, String uciCode) {
		SqlSession session = null;
				
		try {
			session = sf.getSession();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("member_seq", member_seq);
			param.put("uciCode", uciCode);		
			
			session.delete("Cart.delete", param);
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			session.commit();
			session.close();
		}
	}
}
