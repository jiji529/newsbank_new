package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class AdminMember
 */
@WebServlet("/member.manage")
public class AdminMember extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminMember() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		
		if (MemberInfo != null) {
			
			if(MemberInfo.getType().equals("A")) { // 관리자 권한만 접근
				String action = (request.getParameter("action") == null) ? "" : request.getParameter("action");
				
				if(action.equals("makeGroup")) {
					String groupName = request.getParameter("groupName");
					String radio_id = request.getParameter("radio_id");
					String[] id = radio_id.split(",");
					
					Map<Object, Object> param = new HashMap<Object, Object>();
					param.put("groupName", groupName);
					
					MemberDAO memberDAO = new MemberDAO();
					memberDAO.insertGroup(param);
					String group_seq = param.get("seq").toString(); // last insert seq
					
					Map<Object, Object> mParam = new HashMap<Object, Object>();
					mParam.put("id", Arrays.asList(id));
					mParam.put("group_seq", group_seq);
					memberDAO.updateMemberGroup(mParam); // 선택한 ID group_seq 수정
				}
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin_member.jsp");
				dispatcher.forward(request, response);
				
			} else {
				JOptionPane.showMessageDialog(null, "해당페이지는 관리자만 접근할 수 있습니다.\n 메인페이지로 이동합니다.");
				response.sendRedirect("/home");
			}
		
		} else {
			response.sendRedirect("/login");
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
