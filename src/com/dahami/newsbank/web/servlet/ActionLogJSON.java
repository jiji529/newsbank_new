package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.PhotoDAO;
import com.dahami.newsbank.web.dto.ActionLogDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.ExcelUtil;

/**
 * Servlet implementation class ActionLogJSON
 */
@WebServlet(
		urlPatterns = {"/actionlog.api", "/excel.actionlog.api"},
		loadOnStartup = 1
		)
public class ActionLogJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public ActionLogJSON() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doGet(request, response);
		if (response.isCommitted()) {
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
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String keyword = request.getParameter("keyword");
		String startgo = request.getParameter("startgo"); // 현재 페이지
		int pageVol = 30; // 페이지별 노출 단위
		int totalPage = 0;

		if (MemberInfo != null) {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("pageVol", pageVol);
			
			if (start_date != null && start_date.length() > 0) {
				params.put("start_date", start_date);
			}
			
			if (end_date != null && end_date.length() > 0) {
				params.put("end_date", end_date);
			}
			
			if (keyword != null && keyword.length() > 0) {
				params.put("keyword", keyword);
			}
			
			if(startgo == null) {
				params.put("startgo", 0);
			}else {
				int startVol = (Integer.valueOf(startgo) - 1) * pageVol;
				params.put("startgo", startVol);
			}
			
			PhotoDAO photoDAO = new PhotoDAO();
			int totalCnt = photoDAO.getActionLogCount(params);
			double pageD = (double) totalCnt / pageVol;
			totalPage = (int) Math.ceil(pageD);
			List<Map<String, Object>> searchList = photoDAO.searchActionLog(params);
			List<Map<String, Object>> downlist = photoDAO.searchAllActionLog(params);
			
			if(cmd.is3("excel")) {
				List<String> headList = Arrays.asList("매체사명", "UCI코드");
				List<Integer> columnSize = Arrays.asList(30, 30);
				List<String> columnList = Arrays.asList("memberName", "uciCode");
				
				String fileName = "수정이력관리(" + start_date + "~" + end_date + ")";
				ExcelUtil.xlsWiter(request, response, headList, columnSize, columnList, downlist, fileName);
						
			}else {
				
				if (searchList != null) {
					success = true;
				}

				// JSON 데이터
				JSONObject json = new JSONObject();
				json.put("success", success);
				json.put("totalPage", totalPage);
				json.put("totalCnt", totalCnt);
				json.put("result", searchList);

				response.setContentType("application/json");
				response.getWriter().print(json);
			}
		}

	}

}
