package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.service.CMSService;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet("/account.mypage")
public class MypageAccountInfo extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public MypageAccountInfo() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		super.doGet(request, response);
		if(response.isCommitted()) {
			return;
		}

		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}

		// 임시 넣기
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
				//request.setAttribute("type", MemberInfo.getType());
				if(!(MemberInfo.getType().equalsIgnoreCase(MemberDTO.TYPE_MEDIA) || MemberInfo.getType().equalsIgnoreCase(MemberDTO.TYPE_CALCULATE_ADMIN))) {
					// 회원 종류가 해당 옵션(M: 매체사, W: 정산 관리자)이 아닌 경우는, 회원정보 페이지로 이동
					response.sendRedirect("/info.mypage");
					return;
				}
				
				if(MemberInfo.getType().equalsIgnoreCase(MemberDTO.TYPE_CALCULATE_ADMIN)) {
					// 회원 권한이 정산관리자의 경우는 slave 회원의 정산정보를 가져온다. (아주경제: 정산관리자 특별 계정생성으로 인한 예외처리)
					MemberInfo = memberDAO.adjustMediaInfo(MemberInfo);
				}
				
				request.setAttribute("MemberInfo", MemberInfo);
				// 세금계산서 전화번호, 이메일
				if (MemberInfo.getTaxPhone() != null && MemberInfo.getTaxPhone().length() >= 9) {
					MemberInfo.setTaxPhone(MemberInfo.getTaxPhone().replaceAll("-", ""));

					if (MemberInfo.getTaxPhone().substring(0, 2).equalsIgnoreCase("02")) {
						request.setAttribute("taxPhone1", MemberInfo.getTaxPhone().substring(0, 2));
						if (MemberInfo.getTaxPhone().length() == 9) {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(2, 5));
						} else {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(2, 6));
						}
					} else if (MemberInfo.getTaxPhone().substring(0, 4).equalsIgnoreCase("0130")) {
						request.setAttribute("taxPhone1", MemberInfo.getTaxPhone().substring(0, 4));
						if (MemberInfo.getTaxPhone().length() == 11) {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(4, 7));
						} else {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(4, 8));
						}
					} else {
						request.setAttribute("taxPhone1", MemberInfo.getTaxPhone().substring(0, 3));
						if (MemberInfo.getTaxPhone().length() == 10) {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(3, 6));
						} else {
							request.setAttribute("taxPhone2", MemberInfo.getTaxPhone().substring(3, 7));
						}
					}

					request.setAttribute("taxPhone3", MemberInfo.getTaxPhone().substring(MemberInfo.getTaxPhone().length() - 4, MemberInfo.getTaxPhone().length()));
				}
				
				
				//매체목록 세팅
				request.setAttribute("mediaList", new MemberDAO().listAdjustMedia(MemberInfo));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"mypage_account_info.jsp");
				dispatcher.forward(request, response);					
			}
			
		} else {
			response.sendRedirect("/login");
		}

	}
}
