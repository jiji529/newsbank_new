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

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class ListMediaJSON
 */
@WebServlet("/listMedia.api")
public class ListMediaJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListMediaJSON() {
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
		
		String keyword = request.getParameter("keyword"); // 키워드
		int pageVol = Integer.parseInt(request.getParameter("pageVol")); // 표시 갯수
		int startPage = Integer.parseInt(request.getParameter("startPage")); // 시작 페이지
		
		Map<Object, Object> searchOpt = new HashMap<Object, Object>();
		searchOpt.put("keyword", keyword);
		searchOpt.put("pageVol", pageVol);
		searchOpt.put("startPage", startPage); 
		
		List<Map<String, String>> listMember = new ArrayList<Map<String, String>>();
		int totalCnt = 0; // 총 갯수
		int pageCnt = 0; // 페이지 갯수
		
		MemberDAO memberDAO = new MemberDAO();
		listMember = memberDAO.selectMediaList(searchOpt);
		totalCnt = memberDAO.getMediaCount(searchOpt);
		pageCnt = (totalCnt / pageVol) + 1; // 페이지 갯수 (총 갯수 / 페이지 당 행의 수  + 1)
		
		JSONArray jArray = new JSONArray(); // json 배열
		
		for(int idx=0; idx<listMember.size(); idx++) {
			JSONObject arr = new JSONObject(); // json 배열에 들어갈 객체
			arr.put("seq", listMember.get(idx).get("seq"));
			arr.put("contentCnt", getContentCnt(String.valueOf(listMember.get(idx).get("seq")))); // 콘텐츠 수량 (블라인드 / 전체)
			arr.put("id", listMember.get(idx).get("id"));
			arr.put("compNum", listMember.get(idx).get("compNum"));
			arr.put("compName", listMember.get(idx).get("compName"));
			arr.put("preRate", listMember.get(idx).get("preRate"));
			arr.put("postRate", listMember.get(idx).get("postRate"));			
			arr.put("type", listMember.get(idx).get("type"));
			arr.put("name", listMember.get(idx).get("name"));
			arr.put("email", listMember.get(idx).get("email"));
			arr.put("phone", listMember.get(idx).get("phone"));			
			arr.put("group_seq", listMember.get(idx).get("group_seq"));
			arr.put("groupName", listMember.get(idx).get("groupName"));
			arr.put("contractStart", listMember.get(idx).get("contractStart"));
			arr.put("contractEnd", listMember.get(idx).get("contractEnd"));
			arr.put("regDate", listMember.get(idx).get("regDate"));
			arr.put("masterID", listMember.get(idx).get("masterID"));
			arr.put("activate", listMember.get(idx).get("activate"));
			arr.put("logo", listMember.get(idx).get("logo"));
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
	
	// 매체사별 콘텐츠 수량 반환 (ex. 블라인드 | 전체수량)
	public static String getContentCnt(String seq) {
		
		Map<Object, Object> option = new HashMap<Object, Object>();
		option.put("seq", seq);
		
		List<Map<String, String>> content = new ArrayList<Map<String, String>>();
		MemberDAO dao = new MemberDAO();
		content = dao.getContentAmount(option);					
			
		String contentCnt = String.valueOf(content.get(0).get("blindCnt")) + "|" + String.valueOf(content.get(0).get("totalCnt"));
		//System.out.println(contentCnt);
		
		return contentCnt; 
	}

}
