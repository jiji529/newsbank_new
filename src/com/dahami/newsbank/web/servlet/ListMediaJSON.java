package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUtil;
import com.mysql.cj.x.protobuf.MysqlxDatatypes.Array;

/**
 * Servlet implementation class ListMediaJSON
 */
@WebServlet(
		urlPatterns = {"/listMedia.api", "/excel.listMedia.api"},
		loadOnStartup = 1
		)
public class ListMediaJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListMediaJSON() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		
		String keyword = request.getParameter("keyword"); // 키워드
		int pageVol = Integer.parseInt(request.getParameter("pageVol")); // 표시 갯수
		int startPage = Integer.parseInt(request.getParameter("startPage")); // 시작 페이지
		
		Map<Object, Object> searchOpt = new HashMap<Object, Object>();
		searchOpt.put("keyword", keyword);
		searchOpt.put("pageVol", pageVol);
		searchOpt.put("startPage", startPage); 
		
		List<Map<String, Object>> listMember = new ArrayList<Map<String, Object>>();
		int totalCnt = 0; // 총 갯수
		int pageCnt = 0; // 페이지 갯수
		MemberDAO memberDAO = new MemberDAO();
		listMember = memberDAO.selectMediaList(searchOpt);
		totalCnt = memberDAO.getMediaCount(searchOpt);
		pageCnt = (totalCnt / pageVol) + 1; // 페이지 갯수 (총 갯수 / 페이지 당 행의 수  + 1)
		
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}		
		
		
		if(cmd.is3("excel")) {
			int idx = 0;
			for(Map<String, Object> object : listMember) {
				String strPhone = strPhone(object.get("phone").toString()); // 휴대폰 번호
				String strCompNum = strCompNum(object.get("compNum").toString()); // 사업자등록번호
				String strSettlementRate = strSettlementRate(object); // 정산요율
				String service = strService(object); // 서비스 상태
				String strState = strSettlementState(object); // 정산상태
				
				listMember.get(idx).put("contentCnt" ,getContentCnt(String.valueOf(listMember.get(idx).get("seq"))));
				listMember.get(idx).put("strSettlementRate", strSettlementRate);
				listMember.get(idx).put("strPhone", strPhone);
				listMember.get(idx).put("strCompNum", strCompNum);
				listMember.get(idx).put("service", service);
				listMember.get(idx).put("strState", strState);
				
				idx++;
			}
			// 목록 엑셀 다운로드
			List<String> headList = Arrays.asList("아이디", "회사/기관명", "이름", "휴대폰번호", "이메일", "사업자등록번호", "정산요율", "콘텐츠 수량(블라인드 | 전체)",	"서비스 상태", "정산", "제호"); //  테이블 상단 제목
			List<Integer> columnSize = Arrays.asList(10, 25, 10, 20, 30, 20, 30, 30, 20, 10, 20); //  컬럼별 길이정보
			List<String> columnList = Arrays.asList("id", "compName", "name", "strPhone", "email", "strCompNum", "strSettlementRate", "contentCnt", "service", "strState", "logo"); // 컬럼명
			
			Date today = new Date();
		    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
			String orgFileName = "정산매체사현황_" + dateforamt.format(today); // 파일명
			ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, listMember, orgFileName);
		}else {
			// JSON 목록
			
			JSONArray jArray = new JSONArray(); // json 배열
			
			for(int idx=0; idx<listMember.size(); idx++) {
				JSONObject arr = new JSONObject(); // json 배열에 들어갈 객체
				arr.put("seq", listMember.get(idx).get("seq"));
				arr.put("contentCnt", getContentCnt(String.valueOf(listMember.get(idx).get("seq")))); // 콘텐츠 수량 (블라인드 / 전체)
				arr.put("id", listMember.get(idx).get("id"));
				arr.put("compNum", listMember.get(idx).get("compNum"));
				arr.put("compName", listMember.get(idx).get("compName"));
				arr.put("preRate", listMember.get(idx).get("preRate"));
				arr.put("postRate", listMember.get(idx).get("postRate"));			
				arr.put("type", listMember.get(idx).get("type"));
				arr.put("name", listMember.get(idx).get("name"));
				arr.put("email", listMember.get(idx).get("email"));
				arr.put("phone", listMember.get(idx).get("phone"));			
				arr.put("group_seq", listMember.get(idx).get("group_seq"));
				arr.put("groupName", listMember.get(idx).get("groupName"));
				arr.put("contractStart", listMember.get(idx).get("contractStart"));
				arr.put("contractEnd", listMember.get(idx).get("contractEnd"));
				arr.put("regDate", listMember.get(idx).get("regDate"));
				arr.put("masterID", listMember.get(idx).get("masterID"));
				arr.put("activate", listMember.get(idx).get("activate"));
				arr.put("logo", listMember.get(idx).get("logo"));
				
				
				if(idx >= 1) {
					// 인덱스 1부터 기존에 추가된 항목과 비교 후에 추가해주기				
					
					int jArraySize = jArray.size();
					boolean existFlag = false; // 피정산 매체 존재여부
					for(int jdx=0; jdx<jArraySize; jdx++) {
						JSONObject obj = (JSONObject)jArray.get(jdx);
						
						// jArray에 추가하고자 하는 정산매체의 seq가 포함되어 있는지 확인
						if(Integer.parseInt(listMember.get(idx).get("seq").toString()) == Integer.parseInt(obj.get("seq").toString())) {
							// 이미 존재하는 seq를 추가하고자 할 경우,masterID를 합쳐준다.
							String masterID = obj.get("masterID") + ", " + listMember.get(idx).get("masterID").toString();
							obj.put("masterID", masterID);
							existFlag = true;
							
						}else {
							// seq가 다를 경우는 추가해준다.
							arr.put("masterID", listMember.get(idx).get("masterID"));
						}						
					}
					
					if(!existFlag) { // 중복 seq가 없을 경우만 추가
						jArray.add(arr);
					}
					
				}else {
					// (idx == 0) 첫번째 대상은 무조건 추가
					jArray.add(arr);
				}							
			}
			
			JSONObject json = new JSONObject();
			
			json.put("message", "");
			json.put("pageCnt", pageCnt);
			json.put("totalCnt", totalCnt);
			json.put("result", jArray);
			
			response.setContentType("application/json");
			response.getWriter().print(json);
		}
	}
	
	// 매체사별 콘텐츠 수량 반환 (ex. 블라인드 | 전체수량)
	public static String getContentCnt(String seq) {
		
		Map<Object, Object> option = new HashMap<Object, Object>();
		option.put("seq", seq);
		
		List<Map<String, String>> content = new ArrayList<Map<String, String>>();
		MemberDAO dao = new MemberDAO();
		content = dao.getContentAmount(option);					
			
		String contentCnt = String.valueOf(content.get(0).get("blindCnt")) + " | " + String.valueOf(content.get(0).get("totalCnt"));
		
		return contentCnt; 
	}
	
	// 휴대폰 번호(구분자 넣기)
	private String strPhone(String phone) {
		String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
	      if(!Pattern.matches(regEx, phone)) return null;
	      return phone.replaceAll(regEx, "$1-$2-$3");
	}
	
	// 사업자 번호(구분자 넣기)
	private String strCompNum(String compNum) {
		String regEx = "(\\d{3})(\\d{2})(\\d{5})";
	      if(!Pattern.matches(regEx, compNum)) return null;
	      return compNum.replaceAll(regEx, "$1-$2-$3");
	}
	
	// 정산요율
	private String strSettlementRate(Map<String, Object> object) {
		String preRate = "-";
		String postRate = "-";
		
		if(object.containsKey("preRate")) {
			preRate = object.get("preRate").toString() + "%";
		}
		
		if(object.containsKey("postRate")) {
			postRate = object.get("postRate").toString() + "%";
		}
		
		String rate = "온라인 " + preRate + "\n오프라인 " + postRate;
		
		return rate;
	}
	
	// 서비스 상태
	private String strService(Map<String, Object> object) {
		String service = "";
		String activate = object.get("activate").toString();
		
		// 로고가 존재할 때
		if(object.containsKey("logo")) { 
			if(activate.equals("1")) {
				service = "활성";
			}else if(activate.equals("2")) {
				service = "비활성";
			}
			
		}else {
			service = "제호 업로드";
		}
		
		return service;
	}
	
	// 정산상태
	private String strSettlementState(Map<String, Object> object) {
		String state = "정산";
		
		if(object.containsKey("masterID")) {			
			state = "피정산(" + object.get("masterID").toString() + ")";
		}else {
			state = "정산";
		}
		return state;
	}

}
