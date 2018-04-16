package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.dahami.newsbank.web.dao.PayDAO;
import com.dahami.newsbank.web.dto.CartDTO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class Pay
 */
@WebServlet(urlPatterns = { "/pay" }, loadOnStartup = 1)
public class Pay extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public Pay() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		System.setProperty("jsse.enableSNIExtension", "false"); //handshake alert: unrecognized_name 에러

		// 로그인 정보 세션 체크
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");

		if (MemberInfo != null) {
			
			List<CartDTO> payList = new ArrayList<CartDTO>(); // 결제정보를 저장할 리스트
			PayDAO payDAO = new PayDAO(); // 결제정보 함수호출
			String orderJson = request.getParameter("orderJson");
			
			try {
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObj;
				jsonObj = (JSONObject) jsonParser.parse(orderJson);				
				JSONArray orderArray = (JSONArray) jsonObj.get("order");
				
				for (int i = 0; i < orderArray.size(); i++) {
					JSONObject tempObj = (JSONObject) orderArray.get(i);
					String uciCode = tempObj.get("uciCode").toString();
					JSONArray usageArray = (JSONArray) tempObj.get("usage");
					
					payList.add(payDAO.payList(uciCode, toStringArray(usageArray)));
				}
				request.setAttribute("payList", payList);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pay.jsp");
			dispatcher.forward(request, response);

		} else {
			response.getWriter().append("<script type=\"text/javascript\">alert('로그인 페이지로 이동합니다.');location.replace('/login');</script>").append(request.getContextPath());
		}

	}
	
	// JSONArray를 String Array로 변환
	public static String[] toStringArray(JSONArray array) {
	    if(array==null)
	        return null;

	    String[] arr=new String[array.size()];
	    for(int i=0; i<arr.length; i++) {
	        arr[i]=array.get(i).toString();
	        System.out.println("arr[" + i + "] : " + array.get(i).toString());
	    }
	    return arr;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
