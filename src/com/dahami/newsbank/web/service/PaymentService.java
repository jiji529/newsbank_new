package com.dahami.newsbank.web.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

public class PaymentService extends ServiceBase {
	
	/*
	 * (non-Javadoc)
	 * @see com.dahami.newsbank.web.service.ServiceBase#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 * 사용 페이지 : 관리자(온라인 결제 관리)
	 */
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		//Map<String, String[]> params = request.getParameterMap();
		Map<String, Object> params = new HashMap<String, Object>();
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
				
		if (MemberInfo != null && !MemberInfo.getType().equals("A")) { // 세션값이 있을 때는 해당 매체만 보여주기
			String member_seq = String.valueOf(MemberInfo.getSeq());
			
			
		} else { // 세션값이 없을 때 & 관리자 계정일 때는 전체 
			
		}
		
		PaymentDAO payDAO = new PaymentDAO();		
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		JSONObject json = new JSONObject();
		
		payDAO.onlinePayList(params);
		
	}

}
