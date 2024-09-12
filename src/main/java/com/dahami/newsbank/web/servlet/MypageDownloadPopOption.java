package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.UsageDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.UsageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class MypageDownloadPopOption
 */
@WebServlet("/download.popOption")
public class MypageDownloadPopOption extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public MypageDownloadPopOption() {
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
		
		UsageDAO usageDAO = new UsageDAO();
				
		List<UsageDTO> usageOptions = usageDAO.usageList(MemberInfo.getSeq());
		request.setAttribute("usageOptions", usageOptions);
		
		// 선택항목
		//String[] uciCode_arr = request.getParameterValues("uciCode_arr");
		String uciCode_arr = request.getParameter("uciCode_arr");
		request.setAttribute("uciCode_arr", uciCode_arr);
		
		// 모바일 웹 환경에서 결제가 안됨에 따라, 안내창 띄우기 위해 처리한 부분
		String device = isDevice(request);
		if (device.equals(IS_MOBILE)) {
			request.setAttribute("device","mobile");
		} else if (device.equals(IS_TABLET)) {
			request.setAttribute("device","tablet");
		} else {
			request.setAttribute("device","desktop");
		}
		
		System.out.println(uciCode_arr.toString());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"pop_download.jsp");
		dispatcher.forward(request, response);
	}
	
	public static final String IS_MOBILE = "MOBILE";
	private static final String IS_PHONE = "PHONE";
	public static final String IS_TABLET = "TABLET";
	public static final String IS_PC = "PC";

	/**
	 * 모바일,타블렛,PC구분
	 * @param req
	 * @return
	 */
	public static String isDevice(HttpServletRequest req) {
	    String userAgent = req.getHeader("User-Agent").toUpperCase();
		
	    if(userAgent.indexOf(IS_MOBILE) > -1) {
	        if(userAgent.indexOf(IS_PHONE) == -1)
		    return IS_MOBILE;
		else
		    return IS_TABLET;
	    } else
	return IS_PC;
	}
}
