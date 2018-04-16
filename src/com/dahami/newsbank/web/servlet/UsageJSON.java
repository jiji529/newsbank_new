package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.UsageDAO;
import com.dahami.newsbank.web.dto.UsageDTO;

/**
 * Servlet implementation class UsageJSON
 */
@WebServlet("/UsageJSON")
public class UsageJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public UsageJSON() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UsageDAO usageDAO = new UsageDAO();
		int individual = 0;
		if(request.getParameter("individual") != null) {
			individual = Integer.parseInt(request.getParameter("individual"));
		}
		List<UsageDTO> usageOption = usageDAO.usageList(individual);
		
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		List<UsageDTO> list = (List<UsageDTO>) usageOption;
		for(UsageDTO dto : list){
			try {
				jsonList.add(dto.convertToMap());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		JSONObject json = new JSONObject();
		json.put("result", jsonList);		
		
		response.setContentType("application/json");
		response.getWriter().print(json);		
	
 		request.setAttribute("jsonList", jsonList);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
