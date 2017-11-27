package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class ListMemberJSON
 */
@WebServlet("/listMember.api")
public class ListMemberJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public ListMemberJSON() {
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
		String type = request.getParameter("type"); // 회원유형 (P: 개인, C: 기업)
		String deferred = request.getParameter("deferred"); // 후불결제 구분 (Y/N)
		String group = request.getParameter("group"); // 그룹구분 (개별: I, 그룹: G) 
		int pageVol = Integer.parseInt(request.getParameter("pageVol")); // 표시 갯수
		//int group_seq = (request.getParameter("group") == null) ? 0 : Integer.parseInt(request.getParameter("group")); // 그룹구분 (개별: 0, 그룹: 1) 
		//int group_seq = Integer.parseInt(request.getParameter("group"));
		
		Map<Object, Object> searchOpt = new HashMap<Object, Object>();
		searchOpt.put("keyword", keyword);
		searchOpt.put("type", type);
		searchOpt.put("deferred", deferred);
		searchOpt.put("group", group);
		searchOpt.put("pageVol", pageVol);
		
		/*MemberDTO memberDTO = new MemberDTO(); // 객체 생성
		memberDTO.setType(type);
		memberDTO.setDeferred(deferred);
		memberDTO.setGroup_seq(group_seq);*/
		
		List<MemberDTO> listMember = new ArrayList<MemberDTO>();
		
		MemberDAO memberDAO = new MemberDAO();
		listMember = memberDAO.selectMemberList(searchOpt);
		
		JSONArray jArray = new JSONArray(); // json 배열
		
		for (MemberDTO member : listMember) {
			JSONObject arr = new JSONObject(); // json 배열에 들어갈 객체
			arr.put("id", member.getId());
			arr.put("compName", member.getCompName());
			arr.put("type", member.getType());
			arr.put("name", member.getName());
			arr.put("email", member.getEmail());
			arr.put("phone", member.getPhone());
			arr.put("deferred", member.getDeferred());
			arr.put("group_seq", member.getGroup_seq());
			arr.put("groupName", member.getGroupName());
			arr.put("contractStart", member.getContractStart());
			arr.put("contractEnd", member.getContractEnd());
			arr.put("regDate", member.getRegDate());
			jArray.add(arr);
			
		}
		
		JSONObject json = new JSONObject();
		
		json.put("message", "");
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

