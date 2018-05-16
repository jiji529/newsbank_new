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
import java.util.Arrays;
import java.util.Date;
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
import com.dahami.newsbank.web.util.ExcelUtil;

public class LogService extends ServiceBase {

	private static final SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PhotoDAO photoDAO = new PhotoDAO();
		String downFile = request.getParameter("downFile"); // Excel 다운로드 호출
		String uciCode = request.getParameter("uciCode");
		List<ActionLogDTO> logs = photoDAO.listActionLog(uciCode);
		
		if(downFile == null){
			// 수정이력 JSON 반환
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
				
//				try {
//					jsonList.add(ObjectUtil.convertToMap(cur));
//				} catch (Exception e) {
//					logger.warn("", e);
//				}
			}
			
			response.setContentType("text/json; charset=UTF-8");
			response.getWriter().print(json.toJSONString());	
			response.flushBuffer();
			
		}else {
			// 엑셀저장
			
			List<String> headList = Arrays.asList("수정일", "아이디", "이름", "수정항목"); //  테이블 상단 제목
			List<Integer> columnSize = Arrays.asList(20, 10, 10, 10); //  컬럼별 길이정보
			List<String> columnList = Arrays.asList("regDate", "memberId", "memberName", "actionTypeStr"); // 컬럼명
			
			List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
			
			for(ActionLogDTO cur : logs) {
				
				Map<String, Object> object = new HashMap<String, Object>();
				
				object.put("regDate", cur.getRegStrDate());
				object.put("memberId", cur.getMemberId());
				object.put("memberName", cur.getMemberName());
				object.put("actionTypeStr", cur.getActionTypeStr());
				
				mapList.add(object);
			}
			
			String orgFileName = "수정이력_" + uciCode; // 파일명
			ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, mapList, orgFileName);
			
		}
		
	}

}
