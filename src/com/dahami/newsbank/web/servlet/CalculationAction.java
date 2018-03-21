package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.dahami.newsbank.web.dao.CalculationDAO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.CalculationDTO;

/**
 * Servlet implementation class CalculationAction
 */
@WebServlet("/calculation.api")
public class CalculationAction extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
	//private static HttpSession session = null;
	
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public CalculationAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		request.setCharacterEncoding("UTF-8");
		//session = request.getSession();
		
		CalculationDAO calculationDAO = new CalculationDAO(); // 정산정보 연결
		
		boolean check = true;
		boolean result = false;
		String message = null;
		int seq = 0;
		String cmd = "";
		String name = "";
		String compName = "";
		String payType = "";
		String uciCode = "";
		int member_seq = 0; // 판매자 회원 고유번호
		int usage = 0;
		int type = 0;
		int price = 0;
		int fees = 0;
		int status = 0;
		
		
		if (request.getParameter("cmd") != null) { // 구분
			cmd = request.getParameter("cmd"); // api 구분 crud
		}
		System.out.println("cmd => " + cmd);
		
		if (request.getParameter("seq") != null) { // 회원번호
			seq = Integer.parseInt(request.getParameter("seq"));
		}
		System.out.println("seq => " + seq);
		
		if (request.getParameter("name") != null) { // 이름
			name = request.getParameter("name");
		}
		System.out.println("name => " + name);
		
		if (request.getParameter("compName") != null) { // 판매자
			compName = request.getParameter("compName");
		}
		System.out.println("compName => " + compName);
		
		if (request.getParameter("payType") != null) { // 지불수단
			payType = request.getParameter("payType");
		}
		System.out.println("payType => " + payType);
		
		if (request.getParameter("uciCode") != null) { // uciCode
			uciCode = request.getParameter("uciCode");
		}
		System.out.println("uciCode => " + uciCode);
		
		if (request.getParameter("member_seq") != null) { // 판매자 고유회원번호
			member_seq = Integer.parseInt(request.getParameter("member_seq"));
		}
		System.out.println("member_seq => " + member_seq);
		
		if (request.getParameter("usage") != null) { // 사용용도
			usage = Integer.parseInt(request.getParameter("usage"));
		}
		System.out.println("usage => " + usage);
		
		if (request.getParameter("type") != null) { // 온라인 / 오프라인 구분
			type = Integer.parseInt(request.getParameter("type"));
		}
		System.out.println("type => " + type);
		
		if (request.getParameter("price") != null) { // 결제비용
			price = Integer.parseInt(request.getParameter("price"));
		}
		System.out.println("price => " + price);
		
		if (request.getParameter("fees") != null) { // 빌링수수료
			fees = Integer.parseInt(request.getParameter("seq"));
		}
		System.out.println("fees => " + fees);
		
		if (request.getParameter("status") != null) { // 정산상태
			fees = Integer.parseInt(request.getParameter("status"));
		}
		System.out.println("status => " + status);
		
		CalculationDTO calculationDTO = new CalculationDTO();
		calculationDTO.setSeq(seq);
		calculationDTO.setUciCode(uciCode);
		calculationDTO.setMember_seq(member_seq);
		calculationDTO.setUsage(usage);
		calculationDTO.setType(type);
		calculationDTO.setPrice(price);
		calculationDTO.setFees(fees);
		calculationDTO.setCompName(compName);
		calculationDTO.setPayType(payType);
		calculationDTO.setType(type);
		calculationDTO.setStatus(status);
		
		JSONArray jArray = new JSONArray(); // json 배열
		
		switch(cmd) {
			case "C":
				// 정산 추가
				break;
				
			case "R": 
				// 정산 목록
				List<CalculationDTO> calcList = calculationDAO.selectCalculation(calculationDTO);
				result = true;
								
				for(CalculationDTO calc : calcList) {
					JSONObject obj = new JSONObject();
					obj.put("id", calc.getId());
					obj.put("name", calc.getName());
					obj.put("member_seq", calc.getMember_seq());
					obj.put("payType", calc.getPayType());
					obj.put("uciCode", calc.getUciCode());
					obj.put("usage", calc.getUsage());
					obj.put("type", calc.getType());
					obj.put("price", calc.getPrice());
					obj.put("status", calc.getStatus());
					obj.put("fees", calc.getFees());
					obj.put("regDate", calc.getRegDate());
					
					jArray.add(obj);					
				}				
				
				break;
				
			case "U":
				// 정산 수정
				break;
				
			case "D":
				// 정산 취소
				break;
		}	
		
		JSONObject json = new JSONObject(); // json 객체
		System.out.println(jArray.toJSONString());
		
		json.put("result", jArray);
		//json.put("success", result);
		
		System.out.println(json.toJSONString());
		
		response.getWriter().print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
