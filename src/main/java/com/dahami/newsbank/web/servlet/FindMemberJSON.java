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
import com.dahami.newsbank.web.dto.BookmarkDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.google.gson.Gson;

/**
 * Servlet implementation class CheckId
 */
@WebServlet("/findMember.api")
public class FindMemberJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public FindMemberJSON() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
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
		
		boolean isMember = false;
		boolean isParameter = false;
		String id = null;
		String name = null;
		String phone = null;
		
		MemberDTO memberDTO = new MemberDTO(); // 객체 생성
		MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결
		List<MemberDTO> listMember = new ArrayList<MemberDTO>();
	

		id = request.getParameter("id"); // 아이디 request
		name = request.getParameter("name"); // 이름 request
		phone = request.getParameter("phone"); // 핸드폰번호 request
		// 아이디
		if (id != null && !id.isEmpty()) {
			memberDTO.setId(id);
			isParameter = true;
			// isMember = memberDAO.selectId(memberDTO); // 아이디 정보 요청
		}
		// 이름
		if (name != null&& !name.isEmpty()) {
			memberDTO.setName(name);
			isParameter = true;
		}
		// 핸드폰번호
		if (phone != null&& !phone.isEmpty()) {
			memberDTO.setPhone(phone);
			isParameter = true;
		}

		// 파라미터가 있으면 DB 요청
		if (isParameter) {
			listMember = memberDAO.listMember(memberDTO); // 회원정보 요청
		}

		JSONArray jArray = new JSONArray();//배열이 필요할때

		// 회원정보 배열 크기 체크
		if (listMember.size() > 0) {

			for (MemberDTO member : listMember) {
				JSONObject arr = new JSONObject();//배열 내에 들어갈 json
				arr.put("id", member.getId());
				arr.put("reg_date", member.getRegDate());
				jArray.add(arr);
				
			}

			isMember = true;
		}

	

		JSONObject json = new JSONObject();

		json.put("success", isMember);
		json.put("message", "");
		json.put("data", jArray);

		response.setContentType("application/json");
		response.getWriter().print(json);
	}

}
