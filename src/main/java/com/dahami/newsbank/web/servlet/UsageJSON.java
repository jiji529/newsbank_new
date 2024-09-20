package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.dto.PhotoDTO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.UsageDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.UsageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class UsageJSON
 */
@WebServlet(urlPatterns = { "/UsageJSON" , "/Foreign.UsageJSON" }, loadOnStartup = 1)
public class UsageJSON extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public UsageJSON() {
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
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo"); // 회원정보
		UsageDAO usageDAO = new UsageDAO();
		
		int individual = 0;
		if(cmd.is2("Foreign") || Constants.IS_NYT==true) {
			individual = 999;
		} else {			
			individual = 0; // 0 : 온라인(기본값)
			
			if (MemberInfo != null) {
				// 로그인 상태
				if(MemberInfo.getDeferred() == 2) { 
					// 오프라인 회원은 개인 사용용도를 전달
					individual = MemberInfo.getSeq();
				}
			}else {
				// 로그아웃(일반회원)
			}			
		}
		
		List<UsageDTO> usageOption = usageDAO.usageList(individual);
		
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		List<UsageDTO> list = (List<UsageDTO>) usageOption;
		for(UsageDTO dto : list){
			try {
				jsonList.add(dto.convertToMap());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		JSONObject json = new JSONObject();
		json.put("result", jsonList);		
		
		response.setContentType("application/json");
		response.getWriter().print(json);		
	
 		request.setAttribute("jsonList", jsonList);
	}
}
