package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class AdjustMediaJSON
 */
@WebServlet("/adjust.media.api")
public class AdjustMediaJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdjustMediaJSON() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		int adjMaster = Integer.parseInt(request.getParameter("adjMaster"));
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setSeq(adjMaster);
		MemberDAO memberDAO = new MemberDAO();
		
		List<MemberDTO> slaveList = memberDAO.adjSlaveMedia(memberDTO); // 주정산 선택매체에 따른 피정산 매체 목록
		
		JSONArray jArray = new JSONArray();//배열이 필요할때
		for(MemberDTO slave : slaveList) {
			JSONObject obj = new JSONObject();
			obj.put("seq", slave.getSeq());
			obj.put("name", slave.getName());
			jArray.add(obj);
		}
		
		JSONObject json = new JSONObject();
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
