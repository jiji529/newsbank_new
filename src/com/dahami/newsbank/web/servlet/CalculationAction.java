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
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.CalculationDTO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;

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
		response.setContentType("application/json;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		//session = request.getSession();
		
		CalculationDAO calculationDAO = new CalculationDAO(); // 정산정보 연결
		
		boolean check = true;
		boolean result = false;
		String message = null;
		int seq = 0;
		String cmd = null;
		String name = null;
		String id = null;
		String compName = null;
		String payType = null;
		String uciCode = null;
		int member_seq = 0; // 판매자 회원 고유번호
		int usage = 0;
		int type = 0;
		int price = 0;
		int fees = 0;
		int status = 0;
		
		String keyword = null; // 키워드
		String start_date = null; // 시작 일자
		String end_date = null; // 마지막 일자
		String seqArr = null; // 피정산 매체
		
		
		if (request.getParameter("cmd") != null) { // 구분
			cmd = request.getParameter("cmd"); // api 구분 crud
		}
		System.out.println("cmd => " + cmd);
		
		if (request.getParameter("seq") != null) { // 회원번호
			seq = Integer.parseInt(request.getParameter("seq"));
		}
		System.out.println("seq => " + seq);
		
		if (request.getParameter("id") != null) { // 아이디
			id = request.getParameter("id");
		}
		System.out.println("id => " + id);
		
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
			fees = Integer.parseInt(request.getParameter("fees"));
		}
		System.out.println("fees => " + fees);
		
		if (request.getParameter("status") != null) { // 정산상태
			status = Integer.parseInt(request.getParameter("status"));
		}
		System.out.println("status => " + status);
		
		if (request.getParameter("keyword") != null) { // 키워드
			keyword = request.getParameter("keyword");
		}
		System.out.println("keyword => " + keyword);
		
		if (request.getParameter("start_date") != null) { // 시작 일자
			start_date = request.getParameter("start_date");
		}
		System.out.println("start_date => " + start_date);
		
		if (request.getParameter("end_date") != null) { // 마지막 일자
			end_date = request.getParameter("end_date");
		}
		System.out.println("end_date => " + end_date);
		
		if (request.getParameter("seqArr") != null && !request.getParameter("seqArr").equals("")) { // 피정산 매체
			seqArr = request.getParameter("seqArr");
		}
		System.out.println("seqArr => " + seqArr);
		
		CalculationDTO calculationDTO = new CalculationDTO();
		calculationDTO.setId(id);
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
		JSONArray tempArray = new JSONArray();
		Map<String, Object> param = new HashMap<String, Object>(); // 전달할 파라미터값
		
		String[] member_seqArr = {};
		if(seqArr != null) {
			member_seqArr = seqArr.split(","); // 피정산 매체 seq
		}
		
		PaymentDAO paymentDAO = new PaymentDAO();
		
		switch(cmd) {
			case "C":
				// 정산 추가
				break;
				
			case "R": 
				// 정산 목록
				param.put("keyword", keyword);
				param.put("start_date", start_date);
				param.put("end_date", end_date);
				param.put("payType", payType);
				param.put("member_seqArr", member_seqArr);
				
				List<CalculationDTO> calcList = calculationDAO.selectCalculation(param);
				result = true;
								
				for(CalculationDTO calc : calcList) {
					JSONObject obj = new JSONObject();
					obj.put("id", calc.getId());
					obj.put("name", calc.getName());
					obj.put("compName", calc.getCompName());
					obj.put("copyright", calc.getCopyright());
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
				
			case "S":
				// 정산 월별통계
				param.put("keyword", keyword);
				param.put("start_date", start_date);
				param.put("end_date", end_date);
				param.put("payType", payType);
				param.put("member_seqArr", member_seqArr);
				
				List<Map<String, Object>> staticsList = calculationDAO.selectOfMonth(param);
				String year = start_date.substring(0, 4);				
				String[] sDate = start_date.split("-");
				String[] eDate = end_date.split("-");
				
				int sMonth = Integer.parseInt(sDate[1]);
				int eMonth = Integer.parseInt(eDate[1]);
				
				// local 배열
				for(int m=sMonth; m<=eMonth; m++) { // 월별
					for(int t=0; t<2; t++) { // type = 0, 1 (2가지)
						String month = String.format("%02d", m);
						String YearOfMonth = year + "-" + month;
						
						JSONObject obj = new JSONObject();
						obj.put("price", 0);
						obj.put("YearOfMonth", YearOfMonth);
						obj.put("type", t);
						obj.put("count", 0);
						
						jArray.add(obj);
					}					
					
				}
				
				// DB에서 받아온 값
				for(Map<String, Object> statics : staticsList) {
					JSONObject obj = new JSONObject();
					obj.put("price", statics.get("price"));
					obj.put("YearOfMonth", statics.get("YearOfMonth"));
					obj.put("type", statics.get("type"));
					obj.put("count", statics.get("count"));
					tempArray.add(obj);
					
					// local 배열을 돌면서 같은 값은 치환
					for(int idx = 0; idx < jArray.size(); idx++) {
						JSONObject object = (JSONObject)jArray.get(idx);
						
						String jYearOfMonth = object.get("YearOfMonth").toString();
						String jType = object.get("type").toString();
						
						// year && type이 같으면 price 치환
						if(jYearOfMonth.equals(statics.get("YearOfMonth").toString()) && jType.equals(statics.get("type").toString())) {
							jArray.set(idx, obj);
						}
					}
				}
				
				break;
				
			case "U": // 정산 상태 수정(승인/취소)
				int paymentDetail_seq = Integer.parseInt(request.getParameter("paymentDetail_seq"));
				
				PaymentDetailDTO paymentDetailDTO = new PaymentDetailDTO();
				paymentDetailDTO.setPaymentDetail_seq(paymentDetail_seq);
				paymentDetailDTO.setStatus(String.valueOf(status));
				
				paymentDAO.updatePaymentDetail(paymentDetailDTO);
				
				// 결제 취소건에 대해서는 calculations 테이블에 취소내역 추가
				if(status == 1) {
					calculationDAO.insertCalculation(calculationDTO);
				}
				
				break;
				
		}	
		
		JSONObject json = new JSONObject(); // json 객체
		json.put("result", jArray);
		
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
