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
import com.dahami.newsbank.web.servlet.bean.CmdClass;

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
		
		int adjMaster = Integer.parseInt(request.getParameter("adjMaster"));
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setSeq(adjMaster);
		MemberDAO memberDAO = new MemberDAO();
		
		List<MemberDTO> slaveList = memberDAO.adjSlaveMedia(memberDTO); // 주정산 선택매체에 따른 피정산 매체 목록
		
		JSONArray jArray = new JSONArray();//배열이 필요할때
		for(MemberDTO slave : slaveList) {
			JSONObject obj = new JSONObject();
			obj.put("seq", slave.getSeq());
			obj.put("compName", slave.getCompName());
			jArray.add(obj);
		}
		
		JSONObject json = new JSONObject();
		json.put("result", jArray);
		
		response.setContentType("application/json");
		response.getWriter().print(json);
	}

}
