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
	 * @methodName  : select
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

}
