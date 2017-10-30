package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dahami.newsbank.web.dao.UsageDAO;
import com.dahami.newsbank.web.dto.UsageDTO;

/**
 * Servlet implementation class MypageCartPopOption
 */
@WebServlet("/cart.popOption")
public class MypageCartPopOption extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public MypageCartPopOption() {
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
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		UsageDAO usageDAO = new UsageDAO();
		List<UsageDTO> usageOption = usageDAO.usageList();
		
		request.setAttribute("usageOption", usageOption);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pop_opt.jsp");
		dispatcher.forward(request, response);
	}	
	
	private List<String> makeSelectOption(String select, List<UsageDTO> usageList) {
		// 옵션 선택값에 따른 추가 옵션리스트 불러오기
		List<String> options = new ArrayList<String>();
		for(UsageDTO usageDTO : usageList) {
			if(usageDTO.getDivision1().equals(select)) {
				options.add(usageDTO.getDivision2());				
			}
		}
		return options;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
