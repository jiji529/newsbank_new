package com.dahami.newsbank.web.dao;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dto.CartDTO;
import com.dahami.newsbank.web.dto.UsageDTO;

public class PayDAO extends DAOBase {

	/**
	 * @methodName  : payList
	 * @author      : HOYADEV
	 * @date        : 2017. 11. 10. 오후 02:18:35
	 * @methodCommet: 결제 정보
	 * @param param
	 * @return 
	 */
	public CartDTO payList(String uciCode, String[] seqArry) {
		SqlSession session = null;
		
		try {
			session = sf.getSession();
			CartDTO cartDTO = new CartDTO();
			cartDTO.setUciCode(uciCode); // UCI 코드
			
			PhotoDAO photoDAO = new PhotoDAO();
			PhotoDTO photoDTO = photoDAO.read(uciCode);
			String copyright = photoDTO.getCopyright(); // 저작권자(판매자 회사명)
			cartDTO.setCopyright(copyright);
			
			UsageDAO usageDAO = new UsageDAO(); // 사용용도
			List<UsageDTO> usageList = usageDAO.selectOptions(seqArry); // 사용용도 상세정보
			cartDTO.setUsageList(usageList);
			int price = usageDAO.totalPrice(seqArry); // 총 결제 가격
			cartDTO.setPrice(price);
			
			return cartDTO;
			
		} catch (Exception e) {
			logger.warn("", e);
		} finally {
			try {
				session.commit();
				session.close();
			} catch (Exception e) {
			}
		}
		return null;
	}

}
