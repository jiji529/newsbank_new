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

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.PayDAO;
import com.dahami.newsbank.web.dto.CartDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

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
		if(response.isCommitted()) {
			return;
		}
		
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		
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
					
					CartDTO cartDTO = payDAO.payList(uciCode, toStringArray(usageArray));
					payList.add(cartDTO);
					//payList.add(payDAO.payList(uciCode, toStringArray(usageArray)));
					//System.out.println(cartDTO.toString());
				}
				request.setAttribute("payList", payList);
				
				// 모바일 웹 환경에서 결제가 안됨에 따라, 안내창 띄우기 위해 처리한 부분
				String device = isDevice(request);
				if (device.equals(IS_MOBILE)) {
					request.setAttribute("device","mobile");
				} else if (device.equals(IS_TABLET)) {
					request.setAttribute("device","tablet");
				} else {
					request.setAttribute("device","desktop");
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"pay.jsp");
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
