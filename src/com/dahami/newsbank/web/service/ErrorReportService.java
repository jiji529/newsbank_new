package com.dahami.newsbank.web.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.ReportDAO;
import com.dahami.newsbank.web.util.EmailUtil;
import com.dahami.newsbank.web.util.JsonUtil;

public class ErrorReportService {
	
	/**
	 * @methodName  : errorReportRegister
	 * @author      : LEE. JEAWOO
	 * @date        : 2018. 04. 20. 오전 09:56:50
	 * @methodCommet: 사진 오류 신고하기	
	 * 				mailing - 0:받지 않음, 1:받음
	 * @param param
	 * @return 
	 */
	public void errorReportRegister(HttpServletResponse response, HttpServletRequest request, Map<String,Object> reportMap){
		ReportDAO dao = new ReportDAO();
		
		String title = "사진 오류 신고 접수";
		StringBuffer content = new StringBuffer();
		String writerEmail = dao.reportWriterEmail((int)reportMap.get("writeUserSeq"));
		
		content.append("안녕하세요, 뉴스뱅크입니다.")									.append("\n\n")
				.append("고객님께서 신고하신 ("+reportMap.get("uciCode")+") 사진의 오류 내역이 정상적으로 접수되었습니다.")	.append("\n\n")
				.append("-----------------------------------------------------------------")		.append("\n")
				.append("신고 내용: ")											.append("\n")
				.append(reportMap.get("content"))							.append("\n")
				.append("-----------------------------------------------------------------")		.append("\n\n")
				.append("최대한 신속하게 수정하여 정상적으로 서비스될 수 있도록 하겠습니다.")			.append("\n\n")
				.append("뉴스뱅크 서비스를 이용해 주셔서 감사합니다.")
				;
		
		/**
		 *		메일링을 위해서 비워둔다. 타이틀과 내용은 만들어 두었다.		 
		 * **/
		if(!reportMap.get("mailingCheck").equals("0")){ //메일을 받겠다.
			EmailUtil eu = new EmailUtil();
//			eu.sendMail(title,content,writerEmail);		//오픈할때 주석 풀것
		}else{}
		
		//DB 처리
		int result = 0;
		result = dao.reportRegister(reportMap);
		try {
			response.getWriter().print(result);
			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * @methodName  : errorReportList
	 * @author      : LEE. JEAWOO
	 * @date        : 2018. 04. 20. 오전 10:36:50
	 * @methodCommet: 오류 신고하기 내용 가져오기(개인 오류 신고 내역, 수정완료 메일에 참조)	
	 * 				status - 0:전체, 1:접수, 2:수정완료
	 * 				mailing - 0:받지 않음, 1:받음
	 * @param param
	 * @return 
	 */
	public void errorReportList(HttpServletResponse response, HttpServletRequest request, Map<String,Object> map){
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		int total = 0;
		ReportDAO dao = new ReportDAO();
		
		list = dao.reportSelectList(map);
		total = dao.reportSelectListTotalCnt(map);
		
		JSONArray jArr = JsonUtil.getJsonArrayFromList(list);
		JSONObject jObj = new JSONObject();
		jObj.put("data", jArr);
		jObj.put("total", total);
		try {
			response.setContentType("text/json; charset=UTF-8");
			response.getWriter().print(jObj.toJSONString());
			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @methodName  : errorReportModifyComplete
	 * @author      : LEE. JEAWOO
	 * @date        : 2018. 04. 20. 오후 13:30:50
	 * @methodCommet: 수정완료 DB처리
	 * 				status - 0:전체, 1:접수, 2:수정완료
	 * @param param
	 * @return 
	 */
	public void errorReportModifyComplete(HttpServletResponse response, HttpServletRequest request, Map<String,Object> reportMap){
		ReportDAO dao = new ReportDAO();
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("seq", reportMap.get("reportSeq"));
		List<Map<String,Object>> list = dao.reportSelectList(map);
		
		String title = "사진 오류 수정 완료 안내";
		StringBuffer content = new StringBuffer();
		String writerEmail = dao.reportWriterEmail((int)list.get(0).get("member_seq"));
		
		content.append("안녕하세요, 뉴스뱅크입니다.")									.append("\n\n")
				.append("고객님께서 신고하신 ("+list.get(0).get("uciCode")+") 사진의 오류 사항이 수정되었습니다.")		.append("\n\n")
				.append("-----------------------------------------------------------------")		.append("\n")
				.append("신고 내용: ")											.append("\n")
				.append(list.get(0).get("reason"))							.append("\n")
				.append("-----------------------------------------------------------------")		.append("\n\n")
				.append("앞으로도 서비스 품질 향상을 위해 끊임없이 노력하겠습니다.")				.append("\n\n")
				.append("감사합니다.")
				;
		
		/**
		 *		메일링을 위해서 비워둔다. 타이틀과 내용은 만들어 두었다.		 
		 * **/
		if((Integer)list.get(0).get("mailing") != 0){ //메일을 받겠다.
			EmailUtil eu = new EmailUtil();
//			eu.sendMail(title,content,writerEmail);		//오픈할때 주석 풀것 
		}else{}	//메일을 받지 않겠다.
				int result = 0;
		result = dao.reportModifyComplete((int)reportMap.get("reportSeq"));
		try {
			response.getWriter().print(result);
			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @methodName  : errprReportNotCompleteCnt
	 * @author      : LEE. JEAWOO
	 * @date        : 2018. 04. 20. 오후 13:30:50
	 * @methodCommet: 수정완료 DB처리
	 * 				status - 0:전체, 1:접수, 2:수정완료
	 * @param param
	 * @return 
	 */
	public void errprReportNotCompleteCnt(HttpServletResponse response, HttpServletRequest request, int member_seq){
		ReportDAO dao = new ReportDAO();
		
		int result = 0;
		result = dao.reportNotCompleteCnt(member_seq);
		try {
			response.getWriter().print(result);
			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
