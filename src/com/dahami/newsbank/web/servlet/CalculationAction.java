package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.CalculationDAO;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.CalculationDTO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUtil;

/**
 * Servlet implementation class CalculationAction
 */
//@WebServlet("/calculation.api")
@WebServlet(
		urlPatterns = {"/calculation.api", "/excel.calculation.api"},
		loadOnStartup = 1
		)
public class CalculationAction extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
	//private static HttpSession session = null;
	
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public CalculationAction() {
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
		
		CalculationDAO calculationDAO = new CalculationDAO(); // 정산정보 연결
		
		boolean check = true;
		boolean result = false;
		String message = null;
		int seq = 0;
		String action = null;
		String name = null;
		String id = null;
		String compName = null;
		String payType = null;
		String uciCode = null;
		String shotDate = null;
		int member_seq = 0; // 판매자 회원 고유번호
		int usage = 0;
		int type = 0;
		int price = 0;
		int fees = 0;
		int status = 0;
		int rate = 0;
		
		String keyword = null; // 키워드
		String start_date = null; // 시작 일자
		String end_date = null; // 마지막 일자
		String seqArr = null; // 피정산 매체
		String keywordType = null;
		
		
		if (request.getParameter("action") != null) { // 구분
			action = request.getParameter("action"); // api 구분 crud
		}
		System.out.println("action => " + action);
		
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
		
		if (request.getParameter("shotDate") != null) { // 촬영일자
			uciCode = request.getParameter("shotDate");
		}
		System.out.println("shotDate => " + shotDate);
		
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
		
		if (request.getParameter("keywordType") != null) { // 키워드
			keywordType = request.getParameter("keywordType");
		}
		System.out.println("keywordType => " + keywordType);
		
		if (request.getParameter("rate") != null) { // 정산 요율
			rate = Integer.parseInt(request.getParameter("rate"));
		}
		System.out.println("rate => " + rate);
		
		CalculationDTO calculationDTO = new CalculationDTO();
		calculationDTO.setId(id);
		calculationDTO.setSeq(seq);
		calculationDTO.setUciCode(uciCode);
		calculationDTO.setShotDate(shotDate);
		calculationDTO.setMember_seq(member_seq);
		calculationDTO.setUsage(usage);
		calculationDTO.setType(type);
		calculationDTO.setPrice(price);
		calculationDTO.setFees(fees);
		calculationDTO.setCompName(compName);
		calculationDTO.setPayType(payType);
		//calculationDTO.setStatus(status);
		calculationDTO.setRate(rate);
		
		JSONArray jArray = new JSONArray(); // json 배열
		JSONArray tempArray = new JSONArray();
		Map<String, Object> param = new HashMap<String, Object>(); // 전달할 파라미터값
		
		String[] member_seqArr = {};
		if(seqArr != null) {
			member_seqArr = removeNull(seqArr.split(",")); // 피정산 매체 seq
		}
		
		PaymentDAO paymentDAO = new PaymentDAO();
		
		switch(action) {
			case "C":
				// 정산 추가
				break;
				
			case "R": 
				// 결제건별 상세내역(정산관리)
				param.put("keywordType", keywordType);
				param.put("keyword", keyword);
				param.put("start_date", start_date);
				param.put("end_date", end_date);
				param.put("payType", payType);
				param.put("member_seqArr", member_seqArr);
				
				List<CalculationDTO> calcList = calculationDAO.selectCalculation(param);
				result = true;
				
				if (cmd.isInvalid()) {
					response.sendRedirect("/invlidPage.jsp");
					return;
				}
				
				if(cmd.is3("excel")) {
					// 목록 엑셀 다운로드
					List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
					for(CalculationDTO dto : calcList) {
						try {
							DecimalFormat df = new DecimalFormat("#,##0");
							Map<String, Object> object = new HashMap<String, Object>();
							
							int billingAmount = dto.getPrice(); // 결제금액
							double customValue = (double) Math.round(billingAmount / 1.1); // 과세금액
							double customTax = billingAmount - customValue; // 과세부가세(결제금액-과세금액)
							int billingTax = dto.getFees(); // 빌링수수료
							double dRate = 0; // 정산요율
							if(dto.getRate() != 0) {
								dRate = (double) dto.getRate() / 100;
							}
							
							String payTypeStr = dto.getPayType_Str(); // 결제종류
							double totalSalesAccount = billingAmount - billingTax; // 총매출액
							double salesAccount = (double) Math.round(totalSalesAccount * dto.getRate() / 100); // 회원사 매출액
							
							int valueOfSupply = (int) Math.round(salesAccount / 1.1); // 공급가액 (회원사 매출액 / 1.1)
							int addedTaxOfSupply = (int) Math.round(valueOfSupply * 0.1); // 공급부가세 (공급가액 * 0.1)
							
							double dahamiAccount = totalSalesAccount - salesAccount; // 다하미 매출액
							
							object.put("regDate", dto.getRegDate());
							object.put("nameId", dto.getName() + "\n" + dto.getId());
							object.put("compName", dto.getCompName());
							object.put("uciCode", dto.getUciCode());
							object.put("shotDate", dto.getShotDate());
							object.put("copyright", dto.getCopyright());
							object.put("payType", dto.getPayType_Str());
							
							object.put("customValue", df.format(customValue)); // 과세금액
							object.put("customTax", df.format(customTax)); // 과세부가세
							object.put("billingAmount", df.format(billingAmount)); // 결제금액 
							object.put("billingTax", df.format(billingTax)); // 빌링수수료
							object.put("totalSalesAccount", df.format(totalSalesAccount)); // 총 매출액
							object.put("salesAccount", df.format(salesAccount)); // 회원사 매출액
							object.put("valueOfSupply", df.format(valueOfSupply));// 공급가액
							object.put("addedTaxOfSupply", df.format(addedTaxOfSupply)); // 공급부가세
							object.put("dahamiAccount", df.format(dahamiAccount)); // 다하미 매출액
							
							object.put("usage", dto.getUsageDTO().getUsage());
							object.put("division1", dto.getUsageDTO().getDivision1());							
							object.put("division2", dto.getUsageDTO().getDivision2());
							object.put("division3", dto.getUsageDTO().getDivision3());
							object.put("division4", dto.getUsageDTO().getDivision4());
							object.put("price", dto.getUsageDTO().getPrice());
							
							if(dto.getUsageDTO().getDivision1() != null) {
								object.put("usageName", dto.getUsageDTO().getDivision1());
							}else{
								object.put("usageName", dto.getUsageDTO().getUsage());
							}
							
							mapList.add(object);
							
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					List<String> headList = Arrays.asList("구매일자", "이름(아이디)", "기관/회사", "사진ID", "촬영일\n(이미지생성일)", "판매자", "결제종류", "용도", "과세금액", "과세부가세", "결제금액", "빌링수수료", "총매출액", "회원사 매출액", "공급가액", "공급부가세", "다하미 매출액"); //  테이블 상단 제목
					List<Integer> columnSize = Arrays.asList(20, 15, 15, 25, 20, 10, 10, 15, 10, 10, 10, 10, 10, 10, 10, 10, 10); //  컬럼별 길이정보
					List<String> columnList = Arrays.asList("regDate", "nameId", "compName", "uciCode", "shotDate", "copyright", "payType", "usageName", "customValue", "customTax", "billingAmount", "billingTax", "totalSalesAccount", "salesAccount", "valueOfSupply", "addedTaxOfSupply", "dahamiAccount"); // 컬럼명
					
					Date today = new Date();
				    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
					String orgFileName = "결제건별 상세내역_" + dateforamt.format(today); // 파일명
					ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, mapList, orgFileName);
				
				}else {
					// 목록 JSON
					
					for(CalculationDTO dto : calcList) {
						try {
							JSONObject obj = new JSONObject();
							DecimalFormat df = new DecimalFormat("#,##0");
							Map<String, Object> object = new HashMap<String, Object>();
							
							int billingAmount = dto.getPrice(); // 결제금액
							double customValue = (double) Math.round(billingAmount / 1.1); // 과세금액
							double customTax = billingAmount - customValue; // 과세부가세(결제금액-과세금액)
							int billingTax = dto.getFees(); // 빌링수수료
							double dRate = 0;
							if(dto.getRate() != 0) {
								dRate = (double) dto.getRate() / 100;
							}
							
							String payTypeStr = dto.getPayType_Str(); // 결제종류
							double totalSalesAccount = billingAmount - billingTax; // 총매출액
							double salesAccount = (double) Math.round(totalSalesAccount * dto.getRate() / 100); // 회원사 매출액
							
							int valueOfSupply = (int) Math.round(salesAccount / 1.1); // 공급가액 (회원사 매출액 / 1.1)
							int addedTaxOfSupply = (int) Math.round(valueOfSupply * 0.1); // 공급부가세 (공급가액 * 0.1)
							double dahamiAccount = totalSalesAccount - salesAccount; // 다하미 매출액
							
							obj.put("id", dto.getId());
							obj.put("regDate", dto.getRegDate());
							obj.put("name", dto.getName());
							obj.put("compName", dto.getCompName());
							obj.put("uciCode", dto.getUciCode());
							obj.put("shotDate", dto.getShotDate());
							obj.put("copyright", dto.getCopyright());
							obj.put("member_seq", dto.getMember_seq());
							obj.put("payType", dto.getPayType_Str());
							obj.put("customValue", customValue); // 과세금액
							obj.put("customTax", customTax); // 과세부가세
							obj.put("billingAmount", billingAmount); // 결제금액 
							obj.put("billingTax", billingTax); // 빌링수수료
							obj.put("totalSalesAccount", totalSalesAccount); // 총 매출액
							obj.put("salesAccount", salesAccount); // 회원사 매출액
							obj.put("valueOfSupply", valueOfSupply);// 공급가액
							obj.put("addedTaxOfSupply", addedTaxOfSupply); // 공급부가세
							obj.put("dahamiAccount", dahamiAccount); // 다하미 매출액
							
							obj.put("admission", dto.getMemberDTO().getAdmission()); // 매체사 회원 - 승인여부(Y: 승인, N: 비승인)
							obj.put("withdraw", dto.getMemberDTO().getWithdraw()); // 매체사 회원 - 탈퇴여부(0: 기본, 1: 탈퇴)
							
							obj.put("usage", dto.getUsageDTO().getUsage());
							obj.put("division1", dto.getUsageDTO().getDivision1());
							obj.put("division2", dto.getUsageDTO().getDivision2());
							obj.put("division3", dto.getUsageDTO().getDivision3());
							obj.put("division4", dto.getUsageDTO().getDivision4());
							obj.put("price", dto.getUsageDTO().getPrice());
							
							jArray.add(obj);
							
							
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				break;
				
				
			case "S":
				// 년도별 총 판매금액(정산관리)
				param.put("keywordType", keywordType);
				param.put("keyword", keyword);
				param.put("start_date", start_date);
				param.put("end_date", end_date);
				param.put("payType", payType);
				param.put("member_seqArr", member_seqArr);
				
				List<Map<String, Object>> staticsList = calculationDAO.selectOfMonth(param);
				
				if (cmd.isInvalid()) {
					response.sendRedirect("/invlidPage.jsp");
					return;
				}
				
				if(cmd.is3("excel")) {
					
					List<Map<String, Object>> OnOfflineList = new ArrayList<Map<String, Object>>();
					
					int thisYear = Integer.parseInt(start_date.substring(0, 4));
					int startMonth = Integer.parseInt(start_date.substring(5, 7));
					int endMonth = Integer.parseInt(end_date.substring(5, 7));
					int[] totalPrice = new int[endMonth+1];					
					int[] columnSizeArr = new int[endMonth+1];
					List<String> headList = new ArrayList<String>(); //  테이블 상단 제목
					List<String> columnList = new ArrayList<String>(); // 컬럼명
					
					headList.add("구분");
					columnList.add("payType");
					columnSizeArr[0] = 20;
					totalPrice[0] = 0;
					
					// 년도별 판매금액 배열 생성
					String[] payArr = {"온라인", "오프라인"};
					int index = 0;
					for(String pay : payArr) {
						Map<String, Object> object = new HashMap<String, Object>();
						object.put("payType", pay);
						
						for(int month = startMonth; month <= endMonth; month++) {						
							price = findPrice(staticsList, month, thisYear, pay);						
							object.put(String.valueOf(month)+"월", price);
							columnSizeArr[month] = 20;
							
							if(index == 0) {
								headList.add(String.valueOf(month)+"월");
								columnList.add(String.valueOf(month)+"월");
								totalPrice[month] = price;
							}else {
								int total = price + totalPrice[month];
								totalPrice[month] = total;
							}
						}
						index++;
						OnOfflineList.add(object);
					}
					
					Map<String, Object> totalObject = new HashMap<String, Object>();
					totalObject.put("payType", "합계");
					
					for(int idx=1; idx<totalPrice.length; idx++) {
						totalObject.put((idx) + "월", totalPrice[idx]);
					}
					OnOfflineList.add(totalObject);
					
					String columnStr = Arrays.toString(columnSizeArr);
					columnStr = columnStr.replaceAll("\\[", "");
					columnStr = columnStr.replaceAll("\\]", "");
					String[] columnStrSize = columnStr.split(","); //  컬럼별 길이정보 (한글)
					
					List<Integer> columnSize = new ArrayList<Integer>();
					for(String size : columnStrSize) {
						columnSize.add(Integer.parseInt(size.trim()));
					}
					// 목록 엑셀 다운로드
					// 기간에 따라 동적으로 테이블 항목이 생성
					Date today = new Date();
				    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
					String orgFileName = "년도별 총 판매금액_" + dateforamt.format(today); // 파일명
					ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, OnOfflineList, orgFileName);
				
				}else {
					// 목록 JSON
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
				}
				
				break;
				
			case "U": // 정산 상태 수정(승인/취소)
				int paymentDetail_seq = Integer.parseInt(request.getParameter("paymentDetail_seq"));
				
				PaymentDetailDTO paymentDetailDTO = new PaymentDetailDTO();
				paymentDetailDTO.setPaymentDetail_seq(paymentDetail_seq);
				paymentDetailDTO.setStatus(String.valueOf(status));
				
				PaymentManageDTO paymentManageDTO = new PaymentManageDTO();
				paymentManageDTO = paymentDAO.selectOfflinePay(paymentDetailDTO);
				paymentDetailDTO.setPaymentManage_seq(paymentManageDTO.getPaymentManage_seq());
				
				boolean update_state = true; // 정산취소 시, 내역이 없을 때 시도하는 것을 방지하기 위해 사용.
				
				// 정산 취소(1) / 승인(2) 건은 정산테이블(calculations)에 추가
				if(status == 1 || status == 2) {
					
					if(status == 2) { // 후불회원 결제승인(2) : 등록일자 기준으로 -1달 하기 (정산은 매월 1일 ~5일에 이루어지기 때문)
						Calendar cal = Calendar.getInstance();
						cal.add(Calendar.MONTH, -1);
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String calculateDay = dateFormat.format(cal.getTime()); // 정산일자 (한달전)
						//System.out.println("정산 날짜 : " + calculateDay);
						
						calculationDTO.setRegDate(calculateDay);
						
						// 세부항목이 모두 수정되면, paymentManage LGD_PAYSTATUS를 변경
						boolean isUpdate = paymentDAO.getOfflineAllState(paymentDetailDTO);
						if(isUpdate) {
							paymentManageDTO.setLGD_PAYSTATUS(1); // 결제 승인처리
							paymentDAO.updatePaymentManage(paymentManageDTO);
						}
						calculationDTO.setStatus(0); // 정산 기본값
						calculationDAO.insertCalculation(calculationDTO); // 정산데이터 추가
						
					}else{ // 정산 취소
						
						paymentDetailDTO.setPaymentDetail_seq(paymentDetail_seq);
						PaymentDetailDTO now_detail = new PaymentDetailDTO(); // 현재 결제상태값
						now_detail = paymentDAO.selectOfflinePayDetail(paymentDetailDTO);
						
						if(Integer.parseInt(now_detail.getStatus()) == 2) { // 관리자 승인일 때만 취소내역 추가
							calculationDTO.setStatus(1); // 정산 취소값
							calculationDAO.insertCalculation(calculationDTO); // 정산데이터 추가
						}else {
							update_state = false; // 승인을 받지 않았을 때는 정산취소 불가능
						}
					}	
					
					
				}
				
				
				// 정산 내역(calculations)이 있는 경우에만 결제내용 수정 가능
				if(update_state) { 
					paymentDAO.updatePaymentDetail(paymentDetailDTO); // 세부항목 수정
				}
				
				break;
				
		}	
		
		JSONObject json = new JSONObject(); // json 객체
		json.put("result", jArray);
		
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(json);
	}
	
	private String[] removeNull(String[] array) {
		List<String> list = new ArrayList<String>();
		
		for(String s : array) {
			if(s != null && s.length() > 0) {
				list.add(s);
			}
		}
		array = list.toArray(new String[list.size()]);
		
		return array;
	}
	
	
	
	// 온라인 | 오프라인 구분
	private String strType(String type) {
		String strType = "";
		switch(type) {
			case "0":
				strType = "온라인";
				break;
				
			case "1":
				strType = "오프라인";
				break;
		}
		return strType;
	}
	
	// 년월에 해당하는 합계 금액
	private int findPrice(List<Map<String, Object>> staticsList, int month, int thisYear, String pay) {
		String thisMonth = (month < 10) ? '0' + String.valueOf(month) : String.valueOf(month);
		String YearOfMonth = thisYear + "-" + thisMonth;
		int price = 0;
		for(Map<String, Object> object : staticsList) {
			if(object.get("YearOfMonth").equals(YearOfMonth) && strType(object.get("type").toString()).equals(pay)) {
				price = Integer.parseInt(object.get("price").toString());
			}
		}
		
		return price;
	}

}
