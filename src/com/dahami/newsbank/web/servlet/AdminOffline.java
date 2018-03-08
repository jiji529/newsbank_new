package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class AdminOffline
 */
@WebServlet("/offline.manage")
public class AdminOffline extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminOffline() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		
		if (MemberInfo != null) {
			
			if(MemberInfo.getType().equals("A")) { // 관리자 권한만 접근
				MemberDAO memberDAO = new MemberDAO();
				List<MemberDTO> mediaList = memberDAO.listActiveMedia(); // 활성 매체사 불러오기
				request.setAttribute("mediaList", mediaList); // 활성 매체사
				
				
				
				// 날짜 기간선택 옵션
				Calendar cal = Calendar.getInstance();
				int year = cal.get(Calendar.YEAR);
				int month = cal.get(Calendar.MONTH);				
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM");
				String thisMonth = dateFormat.format(cal.getTime());
				List<String> pastMonths = new ArrayList<String>();
				pastMonths.add(thisMonth);				
				// 최근 6개월 표현
				for(int i=0; i<5; i++) {
					
					cal.add(cal.MONTH, -1);
					
					String beforeYear = dateFormat.format(cal.getTime()).substring(0,4);
					String beforeMonth = dateFormat.format(cal.getTime()).substring(4,6);
					
					String beforeDate = beforeYear + beforeMonth;
					pastMonths.add(beforeDate);
				}
				request.setAttribute("pastMonths", pastMonths);
				//request.setAttribute("year", year);
				
				
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin_offline.jsp");
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
