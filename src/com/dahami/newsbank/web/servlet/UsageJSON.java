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
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		
		UsageDAO usageDAO = new UsageDAO();
		List<UsageDTO> usageOption = usageDAO.usageList();
		
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		List<UsageDTO> list = (List<UsageDTO>) usageOption;
		for(UsageDTO dto : list){
			try {
				jsonList.add(dto.convertToMap());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		JSONObject json = new JSONObject();
		json.put("result", jsonList);		
		
		response.getWriter().print(json);		
	
 		request.setAttribute("jsonList", jsonList);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
