package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.dahami.newsbank.web.dao.PayDAO;
import com.dahami.newsbank.web.dto.CartDTO;
import com.dahami.newsbank.web.dto.UsageDTO;


/**
 * Servlet implementation class Pay
 */
@WebServlet(
		urlPatterns = {"/pay"},
		loadOnStartup = 1
		)
public class Pay extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public Pay() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		List<CartDTO> payList = new ArrayList<CartDTO>();
		String cartArry = request.getParameter("cartArry");
		
		String[] splitCart = cartArry.split(",");
		
		for(int num=0; num<splitCart.length; num++) {
			String[] items = splitCart[num].split("\\|");
			String[] usageList = new String[items.length-1];
			String uciCode = "";
			
			for(int idx = 0; idx < items.length; idx++) {
				if(idx == 0) {
					uciCode = items[idx];
				}else {
					String usageList_seq = items[idx];
					usageList[idx-1] = usageList_seq;
				}
			}
			PayDAO payDAO = new PayDAO();
			payList.add(payDAO.payList(uciCode, usageList));
		}
		request.setAttribute("payList", payList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pay.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
