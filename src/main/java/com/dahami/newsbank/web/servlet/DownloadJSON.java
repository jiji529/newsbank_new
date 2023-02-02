package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.DownloadDAO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUtil;

/**
 * Servlet implementation class DownloadJSON
 */
@WebServlet(
		urlPatterns = {"/download.api", "/excel.download.api"},
		loadOnStartup = 1
		)
public class DownloadJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadJSON() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		if(response.isCommitted()) {
			return;
		}
		
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		
		String keywordType = request.getParameter("keywordType"); // 키워드 검색 타입
		String keyword = request.getParameter("keyword"); // 키워드
		int pageVol = Integer.parseInt(request.getParameter("pageVol")); // 표시 갯수
		int startPage = Integer.parseInt(request.getParameter("startPage")); // 시작 페이지
		String contractStart = request.getParameter("contractStart") + " 00:00:00"; // 시작일자
		String contractEnd = request.getParameter("contractEnd") + " 23:59:59"; // 마감일자
		
		Map<Object, Object> searchOpt = new HashMap<Object, Object>();
		searchOpt.put("keywordType", keywordType);
		searchOpt.put("keyword", keyword);
		searchOpt.put("pageVol", pageVol);
		searchOpt.put("startPage", startPage);
		searchOpt.put("contractStart", contractStart); 
		searchOpt.put("contractEnd", contractEnd); 
		
		List<Map<String, Object>> downlist = new ArrayList<Map<String, Object>>();
		int totalCnt = 0; // 총 갯수
		int pageCnt = 0; // 페이지 갯수
		
		DownloadDAO downloadDAO = new DownloadDAO();
		downlist = downloadDAO.totalDownloadList(searchOpt);
		totalCnt = downloadDAO.getDownloadCount(searchOpt);
		if(totalCnt % pageVol != 0) {
			pageCnt = (totalCnt / pageVol) + 1;
		}else {
			pageCnt = (totalCnt / pageVol);
		} 
		
		if(cmd.is3("excel")) {
			// 목록 엑셀다운로드
			List<String> headList = Arrays.asList("회사/기관명", "아이디", "이름", "매체", "UCI코드", "언론사 사진번호", "다운로드일"); //  테이블 상단 제목
			List<Integer> columnSize = Arrays.asList(30, 20, 15, 15, 20, 30, 25); //  컬럼별 길이정보
			List<String> columnList = Arrays.asList("compName", "id", "name", "media", "uciCode", "compCode", "regDate"); // 컬럼명
			
			Date today = new Date();
		    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
			String orgFileName = "다운로드 내역_오프라인결제_" + dateforamt.format(today); // 파일명
			ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, downlist, orgFileName);
		}else {
			// 회원 목록 json
			JSONArray jArray = new JSONArray(); // json 배열
			
			for(int idx=0; idx<downlist.size(); idx++) {
				JSONObject arr = new JSONObject();
				arr.put("id", downlist.get(idx).get("id"));
				arr.put("name", downlist.get(idx).get("name"));
				arr.put("compName", downlist.get(idx).get("compName"));
				arr.put("media", downlist.get(idx).get("media"));
				arr.put("uciCode", downlist.get(idx).get("uciCode"));
				arr.put("compCode", downlist.get(idx).get("compCode"));
				arr.put("regDate", downlist.get(idx).get("regDate"));
				
				jArray.add(arr);
			}
			
			JSONObject json = new JSONObject();
			
			json.put("message", "");
			json.put("pageCnt", pageCnt);
			json.put("totalCnt", totalCnt);
			json.put("result", jArray);
			
			response.setContentType("application/json");
			response.getWriter().print(json);
		}
		
	}

}
