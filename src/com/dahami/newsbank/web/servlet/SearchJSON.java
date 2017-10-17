package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.SearchDAO;
import com.dahami.newsbank.web.service.bean.SearchParameterBean;

/**
 * Servlet implementation class PictureJSON
 */
@WebServlet("/searchJson")
public class SearchJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public SearchJSON() {
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
	    
	    int count = Integer.parseInt(request.getParameter("count"));
	    int contentType = 0;    if(request.getParameter("contentType") != null && !request.getParameter("contentType").equals("undefined")) contentType = Integer.parseInt(request.getParameter("contentType"));
	    String duration = request.getParameter("duration");
	    int colorMode = 0;	    if(request.getParameter("colorMode") != null && !request.getParameter("colorMode").equals("undefined")) colorMode = Integer.parseInt(request.getParameter("colorMode"));
	    int horiVertChoice = 0; if(request.getParameter("horiVertChoice") != null && !request.getParameter("horiVertChoice").equals("undefined")) horiVertChoice = Integer.parseInt(request.getParameter("horiVertChoice"));
	    int size = 0; if(request.getParameter("size") != null && !request.getParameter("size").equals("undefined")) size = Integer.parseInt(request.getParameter("size"));
	    int portRight = 0; if(request.getParameter("portRight") != null && !request.getParameter("portRight").equals("undefined")) portRight = Integer.parseInt(request.getParameter("portRight"));
	    int includePerson = 0; if(request.getParameter("includePerson") != null && !request.getParameter("includePerson").equals("undefined")) includePerson = Integer.parseInt(request.getParameter("includePerson"));
	    int group = 0; if(request.getParameter("group") != null && !request.getParameter("group").equals("undefined")) group = Integer.parseInt(request.getParameter("group"));
	    
		SearchParameterBean parameterBean = new SearchParameterBean();
		parameterBean.setPageVol(count);	
		parameterBean.setContentType(contentType);
		parameterBean.setDuration(duration);
		parameterBean.setColorMode(colorMode);
		parameterBean.setHoriVertChoice(horiVertChoice);
		parameterBean.setSize(size);
		parameterBean.setPortRight(portRight);
		parameterBean.setIncludePerson(includePerson);
		parameterBean.setGroup(group);
		
		SearchDAO searchDAO = new SearchDAO();
		Map<String, Object> photoList = searchDAO.search(parameterBean);		
		request.setAttribute("total", photoList.get("count"));
		request.setAttribute("picture", photoList.get("result"));
		
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		List<PhotoDTO> list = (List<PhotoDTO>) photoList.get("result");
		for(PhotoDTO dto : list){
			try {
				jsonList.add(dto.convertToMap());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		JSONObject json = new JSONObject();
		json.put("count", photoList.get("count"));
		json.put("result", jsonList);		
		
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
