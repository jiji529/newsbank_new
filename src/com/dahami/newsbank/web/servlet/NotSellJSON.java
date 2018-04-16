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
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.DownloadDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUtil;

/**
 * Servlet implementation class NotSellJSON
 */
@WebServlet(
		urlPatterns = {"/notSell.api", "/excel.notSell.api"},
		loadOnStartup = 1
		)
public class NotSellJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public NotSellJSON() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = null;
		if (session.getAttribute("MemberInfo") != null) {
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		}
		
		String message = "";
		String keyword = request.getParameter("keyword");
		int pageVol = Integer.parseInt(request.getParameter("pageVol"));
		int startPage = Integer.parseInt(request.getParameter("startPage"));
		int totalCnt = 0; // 총 갯수
		int pageCnt = 0; // 페이지 갯수
		
		JSONObject json = new JSONObject();
		boolean success = false;
		List<Map<String, Object>> searchList = new ArrayList<Map<String, Object>>();
		Map<String, Object> params = new HashMap<String, Object>();
		
		
		if (MemberInfo != null) {
			
			if (keyword != null && keyword.length() > 0) {
				params.put("keyword", keyword);
			}
			
			params.put("pageVol", pageVol);
			params.put("startPage", startPage);
			
			DownloadDAO downloadDAO = new DownloadDAO();
			searchList = downloadDAO.notBuyList(params);
			totalCnt = downloadDAO.notBuyListCount(params);
			pageCnt = (totalCnt / pageVol) + 1;
			
			CmdClass cmd = CmdClass.getInstance(request);
			if (cmd.isInvalid()) {
				response.sendRedirect("/invlidPage.jsp");
				return;
			}
			
			if(cmd.is3("excel")) {
				// 목록 엑셀다운로드
				List<String> headList = Arrays.asList("회사/기관명", "아이디", "이름", "전화번호"); //  테이블 상단 제목
				List<Integer> columnSize = Arrays.asList(15, 10, 10, 20); //  컬럼별 길이정보
				List<String> columnList = Arrays.asList("compName", "id", "name", "phone"); // 컬럼명
				
				Date today = new Date();
			    SimpleDateFormat dateforamt = new SimpleDateFormat("yyyyMMdd");
				String orgFileName = "비구매계정_오프라인결제_" + dateforamt.format(today); // 파일명
				ExcelUtil.xlsxWiter(request, response, headList, columnSize, columnList, searchList, orgFileName);
				
			}else {
				// 회원 목록 json
				if (searchList != null) {
					success = true;
				} else {
					message = "데이터가 없습니다.";
				}
			}
			
		}else {
			message = "다시 로그인해주세요.";
		}

		json.put("success", success);
		json.put("pageCnt", pageCnt);
		json.put("totalCnt", totalCnt);
		json.put("result", searchList);
		
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
