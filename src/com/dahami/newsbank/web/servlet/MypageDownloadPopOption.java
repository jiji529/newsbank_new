package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.UsageDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.UsageDTO;

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
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		
		UsageDAO usageDAO = new UsageDAO();
				
		List<UsageDTO> usageOptions = usageDAO.usageList(MemberInfo.getSeq());
		request.setAttribute("usageOptions", usageOptions);
		
		// 선택항목
		//String[] uciCode_arr = request.getParameterValues("uciCode_arr");
		String uciCode_arr = request.getParameter("uciCode_arr");
		request.setAttribute("uciCode_arr", uciCode_arr);
		
		System.out.println(uciCode_arr.toString());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pop_download.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
