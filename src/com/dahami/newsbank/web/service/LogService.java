/*******************************************************************************
 * Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : LogService.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2018. 4. 5. 오전 8:51:03
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2018. 4. 5.     JEON,HYUNGGUK		최초작성
 * 2018. 4. 5.     
 *******************************************************************************/

package com.dahami.newsbank.web.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

//import com.dahami.common.util.ObjectUtil;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.ActionLogDTO;

public class LogService extends ServiceBase {

	private static final SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PhotoDAO photoDAO = new PhotoDAO();
		String uciCode = request.getParameter("uciCode");
		List<ActionLogDTO> logs = photoDAO.listActionLog(uciCode);
		
		JSONObject json = new JSONObject();
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		json.put("result", jsonList);
		
		int no = logs.size();
		for(ActionLogDTO cur : logs) {
			Map<String, Object> curMap = new HashMap<String, Object>();
			curMap.put("no", no--);
			curMap.put("seq", cur.getSeq());
			curMap.put("uciCode", cur.getUciCode());
			curMap.put("memberSeq", cur.getMemberSeq());
			curMap.put("memberId", cur.getMemberId());
			curMap.put("memberName", cur.getMemberName());
			curMap.put("actionType", cur.getActionType());
			curMap.put("actionTypeStr", cur.getActionTypeStr());
			curMap.put("description", cur.getDescription());
			curMap.put("ip", cur.getIp());
			curMap.put("regDate", cur.getRegDate().toString());
			curMap.put("regDateStr", df.format(cur.getRegDate()));
			jsonList.add(curMap);
			
//			try {
//				jsonList.add(ObjectUtil.convertToMap(cur));
//			} catch (Exception e) {
//				logger.warn("", e);
//			}
		}
		
		response.setContentType("text/json; charset=UTF-8");
		response.getWriter().print(json.toJSONString());	
		response.flushBuffer();
	}

}
