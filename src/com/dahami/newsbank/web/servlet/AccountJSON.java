package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.xmlbeans.impl.inst2xsd.SalamiSliceStrategy;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.CalculationDAO;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.CalculationDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUtil;

/**
 * Servlet implementation class AccountJSON
 */
@WebServlet(
		urlPatterns = {"/account.api", "/excel.account.api"},
		loadOnStartup = 1
		)
public class AccountJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public AccountJSON() {
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
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = null;
		if (session.getAttribute("MemberInfo") != null) {
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		}
		
		boolean success = false;
		String message = "";
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String keyword = request.getParameter("keyword");
		String paytype = request.getParameter("paytype");
		String media_code = request.getParameter("media_code");
		String action = request.getParameter("action");
		String[] media = {};
		if(media_code == null) {
			media = request.getParameterValues("media_code[]");
			media_code = StringUtils.join(media, ",");
		}else {
			media = media_code.split(",");
			media_code = StringUtils.join(media, ",");
		}		

		List<Map<String, Object>> searchList = new ArrayList<Map<String, Object>>();
		
		List<Map<String, Object>> onlineList = new ArrayList<Map<String, Object>>(); // 온라인 판매
		List<Map<String, Object>> offlineList = new ArrayList<Map<String, Object>>(); // 오프라인 판매
		List<String> titleList = new ArrayList<String>(); // 테이블 제목리스트
		List<List<String>> headerList = new ArrayList<List<String>>(); // 테이블 헤더리스트
		List<List<Integer>> colSizeList = new ArrayList<List<Integer>>(); // 컬럼별 사이즈
		List<List<String>> colList = new ArrayList<List<String>>(); // 컬럼명
		
		List<List<Map<String, Object>>> searchOnOffList = new ArrayList<List<Map<String, Object>>>(); //  온/오프라인 판매 리스트
		
		JSONArray jArray = new JSONArray(); // json 배열
		
		if (MemberInfo != null) {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("member_seq", MemberInfo.getSeq());
			if (start_date != null && start_date.length() > 0) {
				start_date = start_date.replaceAll("-", "");
				params.put("start_date", start_date);
			}
			if (end_date != null && end_date.length() > 0) {
				end_date = end_date.replaceAll("-", "");
				params.put("end_date", end_date);
			}

			if (keyword != null && keyword.length() > 0) {
				params.put("keyword", keyword);
			}

			if (paytype != null && paytype.length() > 0) {
				params.put("paytype", paytype);
			}
			if (media_code != null && media_code.length() > 0) {
				params.put("media", media);
			}

			PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
			CalculationDAO calculationDAO = new CalculationDAO(); // 정산정보 연결
			
			if (action != null && action.equalsIgnoreCase("total")) {
				List<Map<String, Object>> tempList = new ArrayList<Map<String, Object>>();
				tempList = calculationDAO.monthlyStats(params);
				
				for(int idx=0; idx<tempList.size(); idx++) {
					boolean isInsert = true; // 추가여부
					String YearOfMonth = tempList.get(idx).get("YearOfMonth").toString();
					int price = (int) tempList.get(idx).get("price");
					int type = (int) tempList.get(idx).get("type");
					double rate = (double) tempList.get(idx).get("rate");
					int fees = (int) tempList.get(idx).get("fees");
					int total_sales_account = price - fees; // 총매출액 
					int sales_account = (int) Math.round(total_sales_account * rate / 100); // 회원사
					
					Map<String, Object> object = new HashMap<>();
					object.put("YearOfMonth", YearOfMonth);
					object.put("price", sales_account);
					object.put("type", type);
					
					if(searchList.isEmpty()) {
						searchList.add(object);
						
					}else {
						
						for(int jx=0; jx<searchList.size(); jx++) {
							if(searchList.get(jx).get("YearOfMonth").equals(YearOfMonth) && searchList.get(jx).get("type").equals(type)) {
								// 날짜와 타입이 같은 값이 이미 존재하면 기존의 값에 더하기
								
								isInsert = !isInsert;
								int sumPrice = (int) searchList.get(jx).get("price") + sales_account;
								Map<String, Object> changeObject = new HashMap<>();
								changeObject.put("YearOfMonth", YearOfMonth);
								changeObject.put("price", sumPrice);
								changeObject.put("type", type);
								searchList.set(jx, changeObject);
							}else {
								// 날짜&타입이 같지 않다면 
							}
						}
						
						if(isInsert) {
							searchList.add(object);
						}
						
					}
				}
			} else {
				searchList = calculationDAO.statsList(params); // 개별
			}


			if (searchList != null) {
				success = true;
			} else {
				message = "데이터가 없습니다.";

			}
		} else {
			message = "다시 로그인해주세요.";
		}
		
		if(cmd.is3("excel")) {
			// 엑셀 다운로드
			
			if (action != null && action.equalsIgnoreCase("total")) { 
				// == 연도별 정산내역 엑셀 다운로드 ==
				List<Map<String, Object>> OnOfflineList = new ArrayList<Map<String, Object>>();
				
				int thisYear = Integer.parseInt(start_date.substring(0, 4));
				int startMonth = Integer.parseInt(start_date.substring(4, 6));
				int endMonth = Integer.parseInt(end_date.substring(4, 6));
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
				int price = 0;
				
				for(String pay : payArr) {
					Map<String, Object> object = new HashMap<String, Object>();
					object.put("payType", pay);
					
					for(int month = startMonth; month <= endMonth; month++) {						
						price = findPrice(searchList, month, thisYear, pay);						
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
				// == 결제건별 정산내역 엑셀 다운로드 ==
				int idx = 0;
				
				for(Map<String, Object> object : searchList) {
					try {
						DecimalFormat df = new DecimalFormat("#,##0");
						SimpleDateFormat dt = new SimpleDateFormat("yyyyMMdd");
						Date paydate = dt.parse(searchList.get(idx).get("LGD_PAYDATE").toString());
						String PAYDATE = new SimpleDateFormat("yyyy-MM-dd").format(paydate); // 결제일자
						
						int billingAmount = Integer.parseInt(object.get("price").toString()); // 결제금액
						int customTax = (int) Math.round(billingAmount * 0.1); // 과세부가세
						int customValue = (int) Math.round(billingAmount * 0.9); // 과세금액
						int billingTax = (int) object.get("fees"); // 빌링수수료
								
						double rate = Double.parseDouble(object.get("rate").toString());
						
						String LGD_PAYTYPE = object.get("LGD_PAYTYPE").toString();
						String PAYTYPE_STR = "";
						
						
						switch(LGD_PAYTYPE) {
							case "SC0010":
								PAYTYPE_STR = "카드결제";
								break;
							
							case "SC0040":
								PAYTYPE_STR = "무통장입금";
								break;
								
							case "SC0030":
								PAYTYPE_STR = "계좌이체";
								break;
							case "SC9999":
								PAYTYPE_STR = "세금계산서";
								break;
						}
						
						rate = rate / 100;
						
						int totalSalesAccount = billingAmount - billingTax; // 총매출액
						int salesAccount = (int) Math.round(totalSalesAccount * rate); // 회원사 매출액
						
						int valueOfSupply = (int) Math.round(salesAccount * 0.9); // 공급가액
						int addedTaxOfSupply = (int) Math.round(salesAccount * 0.1); // 공급부가세
						int dahamiAccount = totalSalesAccount - salesAccount; // 다하미 매출액
						
						searchList.get(idx).put("PAYDATE", PAYDATE); // 결제일자
						searchList.get(idx).put("PAYTYPE_STR", PAYTYPE_STR); // 결제종류
						searchList.get(idx).put("customValue", df.format(customValue)); // 과세금액
						searchList.get(idx).put("customTax", df.format(customTax)); // 과세부가세
						searchList.get(idx).put("billingAmount", df.format(billingAmount)); // 결제금액
						searchList.get(idx).put("billingTax", df.format(billingTax)); // 빌링수수료
						searchList.get(idx).put("totalSalesAccount", df.format(totalSalesAccount)); // 총 매출액
						searchList.get(idx).put("salesAccount", df.format(salesAccount)); // 회원사 매출액
						searchList.get(idx).put("valueOfSupply", df.format(valueOfSupply)); // 공급가액
						searchList.get(idx).put("addedTaxOfSupply", df.format(addedTaxOfSupply)); // 공급부가세
						searchList.get(idx).put("dahamiAccount", df.format(dahamiAccount)); // 다하미 매출액
						
						String photo_uciCode = searchList.get(idx).get("photo_uciCode").toString(); // UCI코드
						String uciCode_compCode = photo_uciCode;
						if(searchList.get(idx).get("compCode") != null) {
							String compCode = searchList.get(idx).get("compCode").toString(); // 매체사 별도사진코드
							
							if(!compCode.isEmpty())
								uciCode_compCode = photo_uciCode + "\n(" + compCode + ")";
						}
						 
						String shotDate = ""; // 촬영일
						if(searchList.get(idx).get("shotDate") != null)
							shotDate = searchList.get(idx).get("shotDate").toString(); // 촬영일
						
						String descriptionKr = ""; // 사진내용
						if(searchList.get(idx).get("descriptionKr") != null)
							descriptionKr = searchList.get(idx).get("descriptionKr").toString(); // 사진내용
						
						searchList.get(idx).put("uciCode_compCode", uciCode_compCode);
						searchList.get(idx).put("shotDate", shotDate);
						searchList.get(idx).put("descriptionKr", descriptionKr);
						
						
						if(object.get("LGD_PAYTYPE").equals("SC9999")) {
							// 오프라인 판매목록
							offlineList.add(searchList.get(idx));
						}else {
							// 온라인 판매목록
							onlineList.add(searchList.get(idx));
						}					

						idx++;
						
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
				
				if(searchList.size() > 0) {
					
					if(onlineList.size() > 0) {
						// 온라인 판매대금 추가
						List<String> onlineHeadList = Arrays.asList("구매일자", "주문자", "사진ID", "사진용도", "촬영일", "사진내용", "판매자", "결제종류", "과세금액", "과세부가세", "결제금액", "빌링수수료", "총매출액", "회원사 매출액", "공급가액", "공급부가세", "다하미 매출액"); //  테이블 상단 제목
						List<Integer> onlineColumnSize = Arrays.asList(30, 15, 30, 50, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20); //  컬럼별 길이정보
						List<String> onlineColumnList = Arrays.asList("PAYDATE", "LGD_BUYER", "uciCode_compCode", "usageName", "shotDate", "descriptionKr", "copyright", 
								 "PAYTYPE_STR", "customValue", "customTax", "billingAmount", "billingTax", 
								 "totalSalesAccount", "salesAccount", "valueOfSupply", "addedTaxOfSupply", "dahamiAccount"); // 컬럼명
						titleList.add("온라인 판매대금 정산내역");
						headerList.add(onlineHeadList);
						colSizeList.add(onlineColumnSize);
						colList.add(onlineColumnList);
						searchOnOffList.add(onlineList);
						
						JSONObject onlineObj = new JSONObject();
						onlineObj.put("headList", onlineHeadList);
						onlineObj.put("columnSize", onlineColumnSize);
						onlineObj.put("columnList", onlineColumnList);
						onlineObj.put("title", "온라인 판매대금 정산내역");
						onlineObj.put("body", onlineList);
						
						jArray.add(onlineObj);
					}
					
					
					if(offlineList.size() > 0) {
						// 오프라인 판매대금 추가
						List<String> offlineHeadList = Arrays.asList("구매일자", "주문자", "ID", "회사명", "사진ID", "사진용도", "촬영일", "사진내용", "판매자", "결제종류", "과세금액", "과세부가세", "결제금액", "총매출액", "회원사 매출액", "공급가액", "공급부가세", "다하미 매출액"); //  테이블 상단 제목
						List<Integer> offlineColumnSize = Arrays.asList(30, 15, 30, 30, 30, 10, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20); //  컬럼별 길이정보
						List<String> offlineColumnList = Arrays.asList("PAYDATE", "LGD_BUYER", "LGD_BUYERID", "LGD_BUYER_COMPNAME", "photo_uciCode", "usageName", "shotDate", "descriptionKr", "copyright", 
								 "PAYTYPE_STR", "customValue", "customTax", "billingAmount",  
								 "totalSalesAccount", "salesAccount", "valueOfSupply", "addedTaxOfSupply", "dahamiAccount"); // 컬럼명
						titleList.add("오프라인 판매대금 정산내역");
						headerList.add(offlineHeadList);
						colSizeList.add(offlineColumnSize);
						colList.add(offlineColumnList);
						searchOnOffList.add(offlineList);
						
						
						JSONObject offlineObj = new JSONObject();
						offlineObj.put("headList", offlineHeadList);
						offlineObj.put("columnSize", offlineColumnSize);
						offlineObj.put("columnList", offlineColumnList);
						offlineObj.put("title", "오프라인 판매대금 정산내역");
						offlineObj.put("body", offlineList);
						
						jArray.add(offlineObj);
					}
					
					// 최종 엑셀 반영
					Date today = new Date();
				    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
					String orgFileName = "결제건별 정산내역_" + dateforamt.format(today); // 파일명
					
					ExcelUtil.xlsxWiterJSONParsing(request, response, jArray, orgFileName);
					
				}else {
					response.getWriter().append("<script type=\"text/javascript\">alert('생성할 데이터가 없습니다.');</script>").append(request.getContextPath());
				}
			}
						
			
		}else {
			// JSON 목록
			JSONObject json = new JSONObject();

			json.put("success", success);
			if (message != "") {
				json.put("message", message);
			}
			json.put("data", searchList);
			
			response.setContentType("application/json");
			response.getWriter().print(json);
		}
		
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
