package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.ErrorReportService;

/**
 * Servlet implementation class ErrorReport
 */
@WebServlet(
		urlPatterns={
				"/register.report.error",
				"/list.report.error",
				"/complete.report.error",
				"/new.report.error"
			}
	)
public class ErrorReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ErrorReport() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reqUri = request.getRequestURI().substring(request.getContextPath().length()+1);
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		ErrorReportService service = new ErrorReportService();
		Map<String,Object> reportMap = null;
		int memberSeq = 0;
		if(!MemberInfo.getType().equals("A")){memberSeq = MemberInfo.getSeq();} //관리자 권한 체크 
		if(MemberInfo == null){
			// 이전에 로그인이 안된경우
			response.sendRedirect("/login");
		}else{
			if(reqUri.startsWith("list")){ //오류 신고하기 신고내역 불러오기
				reportMap = new HashMap<String,Object>();
				reportMap.put("member_seq", memberSeq);
				reportMap.put("startPage", Integer.parseInt(request.getParameter("report_startPage")));
				reportMap.put("pageVol", Integer.parseInt(request.getParameter("report_pageVol")));
				reportMap.put("media", request.getParameter("report_media"));
				Object status = null;
				if(!request.getParameter("report_status").equals("")){
					status = Integer.parseInt(request.getParameter("report_status"));
				}
				reportMap.put("status", status);
				service.errorReportList(response, request, reportMap);
			
			}else if(reqUri.startsWith("register")){	//1차 오류 신고하기
				reportMap = new HashMap<String,Object>();
				reportMap.put("content", request.getParameter("errorReportTextArea"));
				reportMap.put("mailingCheck", request.getParameter("mailing"));
				reportMap.put("uciCode", request.getParameter("uciCode"));
				reportMap.put("writeUserSeq", MemberInfo.getSeq());
				service.errorReportRegister(response, request, reportMap);
			
			}else if(reqUri.startsWith("complete")){	//2차 오류 신고하기 수정 완료
				service.errorReportModifyComplete(response, request, request.getParameter("seq"));
			
			}else if(reqUri.startsWith("new")){	//수정 완료되지 않은 신고 건수가 있는지 확인
				service.errprReportNotCompleteCnt(response, request, memberSeq);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
