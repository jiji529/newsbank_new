package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class ActionLog
 */
@WebServlet("/actionlog.manage")
public class ActionLog extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public ActionLog() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		
		if (MemberInfo != null) {
			
			if(MemberInfo.getType().equals("A")) { // 관리자 권한만 접근
				String action = (request.getParameter("action") == null) ? "" : request.getParameter("action");
				
				// 날짜 기간선택 옵션
				Calendar cal = Calendar.getInstance();
				int year = cal.get(Calendar.YEAR);
				int month = cal.get(Calendar.MONTH);				
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM");
				String thisMonth = dateFormat.format(cal.getTime());
				List<String> pastMonths = new ArrayList<String>();
				pastMonths.add(thisMonth);				
				String tabName = request.getParameter("tabName") == null ? "download" : request.getParameter("tabName"); // default (다운로드) 
				
				// 최근 6개월 표현
				for(int i=0; i<5; i++) {
					
					cal.add(cal.MONTH, -1);
					
					String beforeYear = dateFormat.format(cal.getTime()).substring(0,4);
					String beforeMonth = dateFormat.format(cal.getTime()).substring(4,6);
					
					String beforeDate = beforeYear + beforeMonth;
					pastMonths.add(beforeDate);
				}
				request.setAttribute("pastMonths", pastMonths);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin_action_log.jsp");
				dispatcher.forward(request, response);
				
			} else {
				processNotAdminAccess(request, response);
				return;
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