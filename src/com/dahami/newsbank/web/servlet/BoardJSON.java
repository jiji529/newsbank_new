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
import com.dahami.newsbank.web.dao.BoardDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.BoardDTO;

/**
 * Servlet implementation class BoardJSON
 */
@WebServlet("/boardJson")
public class BoardJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public BoardJSON() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
	    String keyword = request.getParameter("keyword");
	    BoardDAO boardDAO = new BoardDAO();
		List<BoardDTO> boardList = boardDAO.noticeList(keyword);
		
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		List<BoardDTO> list = (List<BoardDTO>) boardList;
		for(BoardDTO dto : list){
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
