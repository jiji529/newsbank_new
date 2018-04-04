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
		// TODO Auto-generated constructor stub
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
			/*List<CartDTO> payList = new ArrayList<CartDTO>(); // 결제정보를 저장할 리스트
			PayDAO payDAO = new PayDAO(); // 결제정보 함수호출
			
			String uciCode_array = request.getParameter("uciCode_array"); // 결제할 사진 목록
			String usage_array = request.getParameter("usage_array"); // 선택한 사용용도
			
			if(!uciCode_array.isEmpty() && !usage_array.isEmpty()) {
				String[] split_uciCode = uciCode_array.split(",");
				String[] split_usage = usage_array.split(",");
				
				for(String uciCode : split_uciCode) {
					payList.add(payDAO.payList(uciCode, split_usage)); // uci코드별 사용용도를 저장
				}
				System.out.println(payList.toArray());
				request.setAttribute("payList", payList);
			}*/
			
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
					
					//System.out.println(uciCode);
					//System.out.println(usageArray.toJSONString());
					//System.out.println(toStringArray(usageArray));
					payList.add(payDAO.payList(uciCode, toStringArray(usageArray)));
				}
				request.setAttribute("payList", payList);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pay.jsp");
			dispatcher.forward(request, response);

 			/*String cartArry = request.getParameter("cartArry");
			if (cartArry != null && !cartArry.isEmpty()) {
				List<CartDTO> payList = new ArrayList<CartDTO>();
				String[] splitCart = cartArry.split(",");
				System.out.println(splitCart.length);
				for (int num = 0; num < splitCart.length; num++) {
					String[] items = splitCart[num].split("\\|");
					String[] usageList = new String[items.length - 1];
					String[] uciCode_arr = {};
					//String uciCode = "";

					for (int idx = 0; idx < items.length; idx++) {
						if (idx == 0) {
							uciCode_arr = items[idx].split(",");
							//uciCode = items[idx]; // uciCode 배열을 찾아서 payList에 add
						} else {
							String usageList_seq = items[idx];
							usageList[idx - 1] = usageList_seq;
						}
					}
					PayDAO payDAO = new PayDAO();
					
					for(String uciCode : uciCode_arr) {
						System.out.println(uciCode + " | " + usageList.toString());
						//payList.add(payDAO.payList(uciCode, usageList));
					}
					
				}
				request.setAttribute("payList", payList);

				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pay.jsp");
				dispatcher.forward(request, response);
			} else {
				response.getWriter().append("<script type=\"text/javascript\">alert('결제할 사진을 선택해 주세요.');history.back(-1);</script>").append(request.getContextPath());
			}*/

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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
