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
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.DownloadDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class NotSellJSON
 */
@WebServlet("/notSell.api")
public class NotSellJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public NotSellJSON() {
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
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = null;
		if (session.getAttribute("MemberInfo") != null) {
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		}
		
		String message = "";
		String keyword = request.getParameter("keyword");
		int pageVol = Integer.parseInt(request.getParameter("pageVol"));
		int startPage = Integer.parseInt(request.getParameter("startPage"));
		int totalCnt = 0; // 총 갯수
		int pageCnt = 0; // 페이지 갯수
		
		JSONObject json = new JSONObject();
		boolean success = false;
		List<Map<String, Object>> searchList = new ArrayList<Map<String, Object>>();
		Map<String, Object> params = new HashMap<String, Object>();
		
		
		if (MemberInfo != null) {
			
			if (keyword != null && keyword.length() > 0) {
				params.put("keyword", keyword);
			}
			
			params.put("pageVol", pageVol);
			params.put("startPage", startPage);
			
			DownloadDAO downloadDAO = new DownloadDAO();
			searchList = downloadDAO.notBuyList(params);
			totalCnt = downloadDAO.notBuyListCount(params);
			pageCnt = (totalCnt / pageVol) + 1;
			
			if (searchList != null) {
				success = true;
			} else {
				message = "데이터가 없습니다.";
			}
			
		}else {
			message = "다시 로그인해주세요.";
		}

		json.put("success", success);
		json.put("pageCnt", pageCnt);
		json.put("totalCnt", totalCnt);
		json.put("result", searchList);

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
