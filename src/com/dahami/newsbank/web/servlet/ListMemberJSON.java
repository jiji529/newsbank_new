package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUtil;

/**
 * Servlet implementation class ListMemberJSON
 */
//@WebServlet("/listMember.api")

@WebServlet(
		urlPatterns = {"/listMember.api", "/excel.listMember.api"},
		loadOnStartup = 1
		)
public class ListMemberJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public ListMemberJSON() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		String keyword = request.getParameter("keyword"); // 키워드
		String type = request.getParameter("type"); // 회원유형 (P: 개인, C: 기업)
		String deferred = request.getParameter("deferred"); // 후불결제 구분 (Y/N)
		String group = request.getParameter("group"); // 그룹구분 (개별: I, 그룹: G) 
		int pageVol = Integer.parseInt(request.getParameter("pageVol")); // 표시 갯수
		int startPage = Integer.parseInt(request.getParameter("startPage")); // 시작 페이지
		//int group_seq = (request.getParameter("group") == null) ? 0 : Integer.parseInt(request.getParameter("group")); // 그룹구분 (개별: 0, 그룹: 1) 
		//int group_seq = Integer.parseInt(request.getParameter("group"));
		
		List<MemberDTO> listMember = new ArrayList<MemberDTO>();
		MemberDAO memberDAO = new MemberDAO();
		
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}
		
		if(cmd.is3("excel")) {
			// 목록 엑셀다운로드
			Map<Object, Object> searchOpt = new HashMap<Object, Object>();
			searchOpt.put("pageVol", pageVol);
			searchOpt.put("startPage", startPage);
			
			listMember = memberDAO.selectMemberList(searchOpt);
			
			List<String> headList = Arrays.asList("아이디", "회사명", "회원구분", "이름", "이메일", "연락처", "결제구분", "그룹구분", "계약기간", "가입일자"); //  테이블 상단 제목
			List<Integer> columnSize = Arrays.asList(10, 15, 8, 10, 30, 20, 10, 10, 20, 20); //  컬럼별 길이정보
			List<String> columnList = Arrays.asList("id", "compName", "type", "name", "email", "phone", "deferred", "groupName", "contractStart", "regDate"); // 컬럼명
			
			
			List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
			for(MemberDTO dto : listMember) {
				try {
					mapList.add(dto.convertToMap());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			Date today = new Date();
		    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
			String orgFileName = "회원현황_" + dateforamt.format(today) + ".xls"; // 파일명
			ExcelUtil.xlsWiter(request, response, headList, columnSize, columnList, mapList, orgFileName);
			
		}else {
			// 회원 목록 json
			Map<Object, Object> searchOpt = new HashMap<Object, Object>();
			searchOpt.put("keyword", keyword);
			searchOpt.put("type", type);
			searchOpt.put("deferred", deferred);
			searchOpt.put("group", group);
			searchOpt.put("pageVol", pageVol);
			searchOpt.put("startPage", startPage);
			
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

			response.getWriter().print(json);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

