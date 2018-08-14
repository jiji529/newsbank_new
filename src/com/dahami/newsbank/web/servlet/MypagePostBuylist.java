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

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class MypagePostBuylist
 */
@WebServlet("/postBuylist.mypage")
public class MypagePostBuylist extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public MypagePostBuylist() {
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
				// 이전에 mypage 비밀번호 입력했는지 체크
				response.sendRedirect("/auth.mypage");
			} else {
				Map<String,String[]> paramMaps = new HashMap<String,String[]>(request.getParameterMap());
				
				if(!paramMaps.containsKey("year")){
					paramMaps.put("year", new String[]{"0"});
				}
				if(!paramMaps.containsKey("month")){
					paramMaps.put("month", new String[]{"0"});
				}
				
				int group_seq = MemberInfo.getGroup_seq(); // 회원그룹여부
				List<Integer> memberList = new ArrayList<>();
				
				if(group_seq == 0) {
					// 일반 회원
					memberList.add(MemberInfo.getSeq());
				}else {
					// 그룹핑 회원
					memberList = MemberInfo.getDownloadGroupList(); 
				}
				
				// 구매내역 목록
				PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
				List<PaymentDetailDTO> listPaymentDetail = new ArrayList<PaymentDetailDTO>();
				listPaymentDetail = paymentDAO.selectPaymentList(memberList, paramMaps);
				
				request.setAttribute("listPaymentDetail", listPaymentDetail);
				request.setAttribute("returnMap", paramMaps);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mypage_post_buy_list.jsp");
				dispatcher.forward(request, response);
			}
		} else { 
			response.sendRedirect("/login");
		}
	}

}
