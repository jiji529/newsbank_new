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
		String type = "M"; // 회원유형 (P: 개인, M: 매체사, C: 기업)
		int pageVol = Integer.parseInt(request.getParameter("pageVol")); // 표시 갯수
		int startPage = Integer.parseInt(request.getParameter("startPage")); // 시작 페이지
		
		Map<Object, Object> searchOpt = new HashMap<Object, Object>();
		searchOpt.put("keyword", keyword);
		searchOpt.put("type", type);
		searchOpt.put("pageVol", pageVol);
		searchOpt.put("startPage", startPage); 
		
		List<MemberDTO> listMember = new ArrayList<MemberDTO>();
		int totalCnt = 0; // 총 갯수
		int pageCnt = 0; // 페이지 갯수
		
		MemberDAO memberDAO = new MemberDAO();
		listMember = memberDAO.selectMediaList(searchOpt);
		totalCnt = memberDAO.getMediaCount(searchOpt);
		pageCnt = (totalCnt / pageVol) + 1; // 페이지 갯수 (총 갯수 / 페이지 당 행의 수  + 1)
		
		JSONArray jArray = new JSONArray(); // json 배열
		
		for (MemberDTO member : listMember) {
			JSONObject arr = new JSONObject(); // json 배열에 들어갈 객체
			arr.put("seq", member.getSeq());
			arr.put("id", member.getId());
			arr.put("compNum", member.getCompNum());
			arr.put("compName", member.getCompName());
			arr.put("preRate", member.getPreRate());
			arr.put("postRate", member.getPostRate());			
			arr.put("type", member.getType());
			arr.put("name", member.getName());
			arr.put("email", member.getEmail());
			arr.put("phone", member.getPhone());			
			arr.put("group_seq", member.getGroup_seq());
			arr.put("groupName", member.getGroupName());
			arr.put("contractStart", member.getContractStart());
			arr.put("contractEnd", member.getContractEnd());
			arr.put("regDate", member.getRegDate());
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
