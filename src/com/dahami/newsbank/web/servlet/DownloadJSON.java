package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
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

/**
 * Servlet implementation class DownloadJSON
 */
@WebServlet("/download.api")
public class DownloadJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadJSON() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		String keywordType = request.getParameter("keywordType"); // 키워드 검색 타입
		String keyword = request.getParameter("keyword"); // 키워드
		int pageVol = Integer.parseInt(request.getParameter("pageVol")); // 표시 갯수
		int startPage = Integer.parseInt(request.getParameter("startPage")); // 시작 페이지
		String contractStart = request.getParameter("contractStart"); // 시작일자
		String contractEnd = request.getParameter("contractEnd"); // 마감일자
		
		Map<Object, Object> searchOpt = new HashMap<Object, Object>();
		searchOpt.put("keywordType", keywordType);
		searchOpt.put("keyword", keyword);
		searchOpt.put("pageVol", pageVol);
		searchOpt.put("startPage", startPage);
		searchOpt.put("contractStart", contractStart); 
		searchOpt.put("contractEnd", contractEnd); 
		
		List<Map<String, String>> downlist = new ArrayList<Map<String, String>>();
		int totalCnt = 0; // 총 갯수
		int pageCnt = 0; // 페이지 갯수
		
		DownloadDAO downloadDAO = new DownloadDAO();
		downlist = downloadDAO.totalDownloadList(searchOpt);
		totalCnt = downloadDAO.getDownloadCount(searchOpt);
		pageCnt = (totalCnt / pageVol) + 1; 
		
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

		response.getWriter().print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
