package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.ParseException;
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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUtil;

/**
 * Servlet implementation class ListMemberJSON
 */
@WebServlet(
		urlPatterns = {"/listMember.api", "/excel.listMember.api"},
		loadOnStartup = 1
		)
public class ListMemberJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    public ListMemberJSON() {
        super();
    }

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
		
		String keyword = request.getParameter("keyword"); // 키워드
		String type = request.getParameter("type"); // 회원유형 (P: 개인, C: 기업)
		String deferred = request.getParameter("deferred"); // 후불결제 구분 (Y/N)
		String group = request.getParameter("group"); // 그룹구분 (개별: I, 그룹: G) 
		int pageVol = Integer.parseInt(request.getParameter("pageVol")); // 표시 갯수
		int startPage = Integer.parseInt(request.getParameter("startPage")); // 시작 페이지
		
		List<MemberDTO> listMember = new ArrayList<MemberDTO>();
		MemberDAO memberDAO = new MemberDAO();
		
		Map<Object, Object> searchOpt = new HashMap<Object, Object>();
		searchOpt.put("keyword", keyword);
		searchOpt.put("type", type);
		searchOpt.put("deferred", deferred);
		searchOpt.put("group", group);
		searchOpt.put("pageVol", pageVol);
		searchOpt.put("startPage", startPage);
		
		if(cmd.is3("excel")) {
			// 목록 엑셀다운로드
			listMember = memberDAO.selectMemberList(searchOpt);
			
			List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
			for(MemberDTO dto : listMember) {
				try {
					//mapList.add(dto.convertToMap());
					Map<String, Object> object = new HashMap<String, Object>();
					object.put("seq", dto.getSeq());
					object.put("id", dto.getId());
					object.put("compName", dto.getCompName());
					object.put("type", dto.getType());
					object.put("typeStr", strType(dto.getType()));
					object.put("name", dto.getName());
					object.put("email", dto.getEmail());
					object.put("phone", dto.getPhone());
					object.put("strPhone", strPhone(dto.getPhone()));
					object.put("deferred", dto.getDeferred());
					object.put("strDeferred", strDeferred(dto.getDeferred()));
					object.put("group_seq", dto.getGroup_seq());
					object.put("groupName", dto.getGroupName());
					object.put("groupInfo", groupInfo(dto.getGroupName()));
					object.put("contractStart", dto.getContractStart());
					object.put("contractEnd", dto.getContractEnd());
					object.put("contractPeriod", contractPeriod(dto.getContractStart(), dto.getContractEnd()));
					object.put("regDate", dto.getRegDate());
					
					mapList.add(object);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			List<String> headList;
			List<Integer> columnSize;
			List<String> columnList;
			if(Constants.IS_NYT == false) {
				headList = Arrays.asList("아이디", "회사명", "회원구분", "이름", "이메일", "연락처", "결제구분", "그룹구분", "계약기간", "가입일자"); //  테이블 상단 제목
				columnSize = Arrays.asList(10, 20, 8, 10, 30, 20, 20, 15, 25, 20); //  컬럼별 길이정보
				columnList = Arrays.asList("id", "compName", "typeStr", "name", "email", "strPhone", "strDeferred", "groupInfo", "contractPeriod", "regDate"); // 컬럼명				
			} else {
				headList = Arrays.asList("아이디", "회사명", "회원구분", "이름", "이메일", "연락처", "결제구분", "가입일자"); //  테이블 상단 제목
				columnSize = Arrays.asList(10, 20, 8, 10, 30, 20, 20, 20); //  컬럼별 길이정보
				columnList = Arrays.asList("id", "compName", "typeStr", "name", "email", "strPhone", "strDeferred", "regDate"); // 컬럼명
			}
			
			Date today = new Date();
		    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
			String orgFileName = "회원현황_" + dateforamt.format(today); // 파일명
			ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, mapList, orgFileName);
			
		}else {
			// 회원 목록 json
			int totalCnt = 0; // 총 갯수
			int pageCnt = 0; // 페이지 갯수
			
			
			listMember = memberDAO.selectMemberList(searchOpt);
			totalCnt = memberDAO.getMemberCount(searchOpt);
			pageCnt = (totalCnt / pageVol) + 1; // 페이지 갯수 (총 갯수 / 페이지 당 행의 수  + 1)
			
			JSONArray jArray = new JSONArray(); // json 배열
			
			for (MemberDTO member : listMember) {
				JSONObject arr = new JSONObject(); // json 배열에 들어갈 객체
				arr.put("seq", member.getSeq());
				arr.put("id", member.getId());
				arr.put("compName", member.getCompName());
				arr.put("type", member.getType());
				arr.put("name", member.getName());
				arr.put("email", member.getEmail());
				arr.put("phone", member.getPhone());
				arr.put("deferred", member.getDeferred());
				arr.put("group_seq", member.getGroup_seq());
				arr.put("groupName", member.getGroupName());
				arr.put("contractStart", member.getContractStart());
				arr.put("contractEnd", member.getContractEnd());
				arr.put("regDate", member.getRegDate());
				jArray.add(arr);
				
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
	
	// 회원 타입구분
	private String strType(String type) {
		String strType = "";
		switch(type) {
			case MemberDTO.TYPE_MEDIA:
				strType = "언론사";
				break;
			
			case MemberDTO.TYPE_PERSON:
				strType = "개인";
				break;
				
			case MemberDTO.TYPE_COOP:
				strType = "법인";
				break;
				
			case MemberDTO.TYPE_ADMIN:
				strType = "관리자";
				break;
		}
		return strType;
	}
	
	// 회원 결제구분
	private String strDeferred(int deferred) {
		String strDeferred = "";
		switch(deferred) {
			case 0:
				strDeferred = "온라인 결제";
				break;
			
			case 1:
				strDeferred = "오프라인 결제(온라인 가격)";
				break;
				
			case 2:
				strDeferred = "오프라인 결제(별도 가격)";
				break;			
			
		}
		return strDeferred;
	}
	
	// 계약기간 반환
	private String contractPeriod(String contractStart, String contractEnd) {
		String contractPeriod = "";
		SimpleDateFormat dateforamt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		if(contractStart != null && contractEnd != null) {
			
			try {
				Date startDate = dateforamt.parse(contractStart);
				Date endDate = dateforamt.parse(contractEnd);
				
				contractStart = new SimpleDateFormat("yyyy-MM-dd").format(startDate);
				contractEnd = new SimpleDateFormat("yyyy-MM-dd").format(endDate);
				
				contractPeriod = contractStart + " ~ " + contractEnd;
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else {
			contractPeriod = "정보 미기재";
		}
		
		return contractPeriod;
	}
	
	// 그룹구분
	private String groupInfo(String groupName) {
		String groupInfo = "";
		
		if(groupName != null) {
			groupInfo = "그룹(" + groupName + ")";
		}else {
			groupInfo = "개별";
		}
		
		return groupInfo;
	}
	
	// 휴대폰 번호(구분자 넣기)
	private String strPhone(String phone) {
		String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
	      if(!Pattern.matches(regEx, phone)) return null;
	      return phone.replaceAll(regEx, "$1-$2-$3");
	}

}


