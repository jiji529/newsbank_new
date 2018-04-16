package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class AdminPopular
 */
@WebServlet("/popular.manage")
public class AdminPopular extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminPopular() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		
		if (MemberInfo != null) {
			
			if(MemberInfo.getType().equals("A")) { // 관리자 권한만 접근
				MemberDAO memberDAO = new MemberDAO();
				List<MemberDTO> mediaList = memberDAO.listActiveMedia(); // 활성 매체사 불러오기
				request.setAttribute("mediaList", mediaList); // 활성 매체사
				
				PhotoDAO photoDAO = new PhotoDAO();
				List<PhotoDTO> photoList = new ArrayList<>();
				List uciCodeList = new ArrayList<>();
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("start", 0);
				params.put("count", 7);
				
				String tabName = request.getParameter("tabName") == null ? "selected" : request.getParameter("tabName"); // default (다운로드) 
				
				switch(tabName) {
					case "selected":
						// 엄선한 사진
						photoList = photoDAO.editorPhotoList();
						break;
	
					case "download":
						// 다운로드
						photoList = photoDAO.downloadPhotoList(params);
						break;
						
					case "zzim":
						// 찜
						photoList = photoDAO.basketPhotoList(params);
						break;
						
					case "detail":
						// 상세보기
						photoList = photoDAO.hitsPhotoList(params);
						break;
				}
				
				request.setAttribute("tabName", tabName);
				request.setAttribute("photoList", photoList);
				
				// 엄선한 사진 uci코드배열
				for(PhotoDTO photo : photoList) {
					uciCodeList.add(photo.getUciCode());
				}
				request.setAttribute("uciCodeList", uciCodeList);
				//System.out.println(uciCode_list.toString());
				
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin_popular.jsp");
				dispatcher.forward(request, response);
				
			} else {
				JOptionPane.showMessageDialog(null, "해당페이지는 관리자만 접근할 수 있습니다.\n 메인페이지로 이동합니다.");
				response.sendRedirect("/home");
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
