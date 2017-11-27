package com.dahami.newsbank.web.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

public class SearchCMSService extends ServiceBase{
	
	/* (non-Javadoc)
	 * @see com.dahami.newsbank.web.service.ServiceBase#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		Map<String, String[]> params = request.getParameterMap();
		SearchParameterBean sParam = new SearchParameterBean(params);
		// 모든 판매상태(삭제/완전삭제 제외) 보기
		sParam.setSaleState(SearchParameterBean.SALE_STATE_NOT | SearchParameterBean.SALE_STATE_OK | SearchParameterBean.SALE_STATE_STOP | SearchParameterBean.SALE_STATE_DEL_SOLD);
		
		// CMS 검색은 비활성 매체도 가능하도록 함
		sParam.setMediaInactive(SearchParameterBean.MEDIA_INACTIVE_NO | SearchParameterBean.MEDIA_INACTIVE_YES);
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		
		if (MemberInfo != null && !MemberInfo.getType().equals("A")) { // 세션값이 있을 때는 해당 매체만 보여주기
			String member_seq = String.valueOf(MemberInfo.getSeq());
			sParam.resetTargetUserList();
			sParam.addTargetUser(member_seq);
		} else { // 세션값이 없을 때 & 관리자 계정일 때는 전체 
			
		}
		
		SearchDAO searchDAO = new SearchDAO();
		Map<String, Object> photoList = searchDAO.search(sParam);
		JSONObject json = new JSONObject();
		
		
		List<PhotoDTO> list = (List<PhotoDTO>) photoList.get("result");
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		if(list != null && list.size() > 0) {
			for(PhotoDTO dto : list){
				try {
					jsonList.add(dto.convertToFullMap());
				} catch (Exception e) {
					logger.warn("", e);
				}
			}
		}
		
		json.put("count", photoList.get("count"));
		json.put("totalPage", photoList.get("totalPage"));
		json.put("result", jsonList);
		
		request.setAttribute("JSON", json.toJSONString());
	}

	

}
