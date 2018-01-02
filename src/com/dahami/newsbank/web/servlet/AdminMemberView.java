package com.dahami.newsbank.web.servlet;

import java.io.IOException;

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
 * Servlet implementation class AdminMemberView
 */
@WebServlet("/view.member.manage")
public class AdminMemberView extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminMemberView() {
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
				int member_seq = Integer.parseInt(request.getParameter("member_seq"));
				
				MemberDTO memberDTO = new MemberDTO();
				MemberDAO memberDAO = new MemberDAO();
				memberDTO = memberDAO.getMember(member_seq);
				
				// 휴대전화
				if (memberDTO.getPhone() != null && memberDTO.getPhone().length() >= 10) {
					memberDTO.setPhone(memberDTO.getPhone().replaceAll("-", ""));
					request.setAttribute("phone1", memberDTO.getPhone().substring(0, 3));
					if (memberDTO.getPhone().length() == 11) {
						request.setAttribute("phone2", memberDTO.getPhone().substring(3, 7));
					} else {
						request.setAttribute("phone2", memberDTO.getPhone().substring(3, 6));
					}
					request.setAttribute("phone3", memberDTO.getPhone().substring(memberDTO.getPhone().length() - 4, memberDTO.getPhone().length()));

				}
				
				// 사업자 및 언론사 정보
				if (memberDTO.getCompNum() != null && memberDTO.getCompNum().length() == 10) {
					memberDTO.setCompNum(memberDTO.getCompNum().replaceAll("-", ""));
					request.setAttribute("compNum1", memberDTO.getCompNum().substring(0, 3));
					request.setAttribute("compNum2", memberDTO.getCompNum().substring(3, 5));
					request.setAttribute("compNum3", memberDTO.getCompNum().substring(memberDTO.getCompNum().length() - 5, memberDTO.getCompNum().length()));

				}
				
				// 사무실 전화
				if (memberDTO.getCompTel() != null && memberDTO.getCompTel().length() >= 9) {
					memberDTO.setCompTel(memberDTO.getCompTel().replaceAll("-", ""));

					if (memberDTO.getCompTel().substring(0, 2).equalsIgnoreCase("02")) {
						request.setAttribute("compTel1", memberDTO.getCompTel().substring(0, 2));
						if (memberDTO.getCompTel().length() == 9) {
							request.setAttribute("compTel2", memberDTO.getCompTel().substring(2, 5));
						} else {
							request.setAttribute("compTel2", memberDTO.getCompTel().substring(2, 6));
						}
					} else if (memberDTO.getCompTel().substring(0, 4).equalsIgnoreCase("0130")) {
						request.setAttribute("compTel1", memberDTO.getCompTel().substring(0, 4));
						if (memberDTO.getCompTel().length() == 11) {
							request.setAttribute("compTel2", memberDTO.getCompTel().substring(4, 7));
						} else {
							request.setAttribute("compTel2", memberDTO.getCompTel().substring(4, 8));
						}
					} else {
						request.setAttribute("compTel1", memberDTO.getCompTel().substring(0, 3));
						if (memberDTO.getCompTel().length() == 10) {
							request.setAttribute("compTel2", memberDTO.getCompTel().substring(3, 6));
						} else {
							request.setAttribute("compTel2", memberDTO.getCompTel().substring(3, 7));
						}
					}

					request.setAttribute("compTel3", memberDTO.getCompTel().substring(memberDTO.getCompTel().length() - 4, memberDTO.getCompTel().length()));

				}
				
				// 세금계산서 전화번호, 이메일
				if (memberDTO.getTaxPhone() != null && memberDTO.getTaxPhone().length() >= 9) {
					memberDTO.setTaxPhone(memberDTO.getTaxPhone().replaceAll("-", ""));

					if (memberDTO.getTaxPhone().substring(0, 2).equalsIgnoreCase("02")) {
						request.setAttribute("taxPhone1", memberDTO.getTaxPhone().substring(0, 2));
						if (memberDTO.getTaxPhone().length() == 9) {
							request.setAttribute("taxPhone2", memberDTO.getTaxPhone().substring(2, 5));
						} else {
							request.setAttribute("taxPhone2", memberDTO.getTaxPhone().substring(2, 6));
						}
					} else if (memberDTO.getTaxPhone().substring(0, 4).equalsIgnoreCase("0130")) {
						request.setAttribute("taxPhone1", memberDTO.getTaxPhone().substring(0, 4));
						if (memberDTO.getTaxPhone().length() == 11) {
							request.setAttribute("taxPhone2", memberDTO.getTaxPhone().substring(4, 7));
						} else {
							request.setAttribute("taxPhone2", memberDTO.getTaxPhone().substring(4, 8));
						}
					} else {
						request.setAttribute("taxPhone1", memberDTO.getTaxPhone().substring(0, 3));
						if (memberDTO.getTaxPhone().length() == 10) {
							request.setAttribute("taxPhone2", memberDTO.getTaxPhone().substring(3, 6));
						} else {
							request.setAttribute("taxPhone2", memberDTO.getTaxPhone().substring(3, 7));
						}
					}

					request.setAttribute("taxPhone3", memberDTO.getTaxPhone().substring(memberDTO.getTaxPhone().length() - 4, memberDTO.getTaxPhone().length()));

				}
				
				request.setAttribute("MemberDTO", memberDTO);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin_member_view.jsp");
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