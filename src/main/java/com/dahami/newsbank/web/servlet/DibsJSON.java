package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class DibsJSON
 */
@WebServlet("/DibsJSON")
public class DibsJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public DibsJSON() {
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
		
	    HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		int member_seq = MemberInfo.getSeq();
		
	    int bookmark_seq = request.getParameter("bookmark_seq") == null ? 0 : Integer.parseInt(request.getParameter("bookmark_seq"));
	    int pageVol = Integer.parseInt(request.getParameter("pageVol")); // 표현 갯수
	    int pageNo = Integer.parseInt(request.getParameter("pageNo")); // 현재 페이지
	    int start = (pageNo - 1) * pageVol; // 페이지 시작
	    
	    PhotoDAO photoDAO = new PhotoDAO();
		List<PhotoDTO> dibsPhotoList = photoDAO.dibsPhotoList(member_seq, bookmark_seq, pageVol, start);
		List<PhotoDTO> totalList = photoDAO.dibsPhotoList(member_seq, bookmark_seq, 0, 0); // 전체 목록
		
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		List<PhotoDTO> list = (List<PhotoDTO>) dibsPhotoList;
		for(PhotoDTO dto : list){
			try {
				jsonList.add(dto.convertToFullMap());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		int totalCount = totalList.size(); // 전체 갯수
		int totalPage = (totalCount / pageVol) + 1; // 전체 페이지 수
		int deferred = MemberInfo.getDeferred(); // 회원 구분(온라인 / 오프라인)
		
		JSONObject json = new JSONObject();
		json.put("result", jsonList);	
		json.put("totalCount", totalCount);
		json.put("totalPage", totalPage);
		json.put("deferred", deferred);
		
		response.setContentType("application/json");	
		response.getWriter().print(json);
 		request.setAttribute("jsonList", jsonList);
	}
}
