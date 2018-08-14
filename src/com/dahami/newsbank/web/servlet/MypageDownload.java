package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.web.dao.DownloadDAO;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.DownloadDTO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class MypageDownload
 */
@WebServlet("/download.mypage")
public class MypageDownload extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public MypageDownload() {
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
		MemberDAO memberDAO = new MemberDAO();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		MemberInfo = memberDAO.getMember(MemberInfo); // 최신 회원정보 갱신

		if (MemberInfo != null) {
			
			boolean mypageAuth = false;
			if (session.getAttribute("mypageAuth") != null) {
				mypageAuth = (boolean) session.getAttribute("mypageAuth");
			}
			if (mypageAuth == false) {
				// 이전에 my page 비밀번호 입력했는지 체크
				response.sendRedirect("/auth.mypage");
			} else {
				int member_seq = MemberInfo.getSeq();
				Map<String,String[]> paramMaps = new HashMap<String,String[]>(request.getParameterMap());
				
				if(!paramMaps.containsKey("year")){
					paramMaps.put("year", new String[]{"0"});
				}
				if(!paramMaps.containsKey("month")){
					paramMaps.put("month", new String[]{"0"});
				}
				if(!paramMaps.containsKey("page")){
					paramMaps.put("page", new String[]{"1"});
				}
				if(!paramMaps.containsKey("bundle")){
					paramMaps.put("bundle", new String[]{"20"});
				}
				
				List<Map<String, String>> downList = new ArrayList<Map<String, String>>();
				
				DownloadDAO downloadDAO = new DownloadDAO();
				
				int group_seq = MemberInfo.getGroup_seq(); // 회원그룹여부
				List<Integer> memberList = new ArrayList<>();
				
				if(group_seq == 0) {
					// 일반 회원
					memberList.add(member_seq);
				}else {
					// 그룹핑 회원
					memberList = MemberInfo.getDownloadGroupList(); 
				}
				downList = downloadDAO.downloadList(memberList, paramMaps);
				
				//dataList 총합 가지고 온다.
				int total = downloadDAO.downloadListTotal(memberList, paramMaps);
				paramMaps.put("total", new String[]{String.valueOf(total)});
				
				request.setAttribute("downList", downList);
				request.setAttribute("MemberInfo", MemberInfo);
				request.setAttribute("returnMap", paramMaps);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_download.jsp");
				dispatcher.forward(request, response);
			}
		} else { 
			response.sendRedirect("/login");
		}
	}

}
