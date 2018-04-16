package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.DownloadDAO;
import com.dahami.newsbank.web.dto.DownloadDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class MypageDownload
 */
@WebServlet("/download.mypage")
public class MypageDownload extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public MypageDownload() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		if (MemberInfo != null) {
			
			boolean mypageAuth = false;
			if (session.getAttribute("mypageAuth") != null) {
				mypageAuth = (boolean) session.getAttribute("mypageAuth");
			}
			if (mypageAuth == false) {
				// 이전에 my page 비밀번호 입력했는지 체크
				response.sendRedirect("/auth.mypage");
			} else {
				int member_seq = MemberInfo.getSeq();
				Map<String,String[]> paramMaps = new HashMap<String,String[]>(request.getParameterMap());
				
				if(!paramMaps.containsKey("year")){
					paramMaps.put("year", new String[]{"0"});
				}
				if(!paramMaps.containsKey("page")){
					paramMaps.put("page", new String[]{"1"});
				}
				if(!paramMaps.containsKey("bundle")){
					paramMaps.put("bundle", new String[]{"20"});
				}
				
				List<Map<String, String>> downList = new ArrayList<Map<String, String>>();
				
				DownloadDAO downloadDAO = new DownloadDAO();
				downList = downloadDAO.downloadList(member_seq, paramMaps);
				
				//dataList 총합 가지고 온다.
				int total = downloadDAO.downloadListTotal(member_seq, paramMaps);
				paramMaps.put("total", new String[]{String.valueOf(total)});
				
				request.setAttribute("downList", downList);
				request.setAttribute("MemberInfo", MemberInfo);
				request.setAttribute("returnMap", paramMaps);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_download.jsp");
				dispatcher.forward(request, response);
			}
		} else { 
			response.sendRedirect("/login");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
