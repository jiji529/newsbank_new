package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
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

import com.dahami.newsbank.web.dao.CartDAO;
import com.dahami.newsbank.web.dao.UsageDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.UsageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

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
		// 장바구니에 담기 이전에 로그인 체크가 필요
		
		String page = request.getParameter("page") == null ? "" : request.getParameter("page");
		int member_seq = (MemberInfo != null) ? MemberInfo.getSeq() : 0;
		String action = request.getParameter("action") == null ? "" : request.getParameter("action");
		String uciCode = request.getParameter("uciCode");
		//String usageList_seq = request.getParameter("usageList_seq");
		//String price = request.getParameter("price");
		String cartArray = request.getParameter("cartArray");
		
		UsageDAO usageDAO = new UsageDAO();
		CartDAO cartDAO = new CartDAO();
		List<UsageDTO> usageOptions = usageDAO.uciCodeOfUsage(uciCode, member_seq);
		//List<UsageDTO> usageOptions = usageDAO.usageListOfuser(member_seq);
		
		request.setAttribute("page", page);
		request.setAttribute("usageOptions", usageOptions);
		request.setAttribute("uciCode", uciCode);
		
		if(action.equals("deleteCart")) {
			cartDAO.deleteCart(member_seq, uciCode);
			
		}else if(action.equals("insertCart")) {		
			
			try {
				JSONParser jsonParser = new JSONParser();
				JSONArray jsonArray = (JSONArray) jsonParser.parse(cartArray);
				
				if(jsonArray != null) {
					
					for(int i=0; i<jsonArray.size(); i++) {
						JSONObject jsonObj = (JSONObject) jsonArray.get(i);
						String uci = jsonObj.get("uciCode").toString();
						String usageList_seq = jsonObj.get("usageList_seq").toString();
						String price = jsonObj.get("price").toString();
						
						cartDAO.insertCart(member_seq, uci, usageList_seq, price);
					}
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			//cartDAO.insertCart(member_seq, uciCode, usageList_seq, price);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/pop_opt.jsp");
		dispatcher.forward(request, response);
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
}
