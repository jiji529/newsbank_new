package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet("/accountyear.mypage")
public class MypageAccountYear extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public MypageAccountYear() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
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
		
		// 임시 넣기
		HttpSession session = request.getSession();
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		
		if (MemberInfo != null) {
			boolean mypageAuth = false;
			if (session.getAttribute("mypageAuth") != null) {
				mypageAuth = (boolean) session.getAttribute("mypageAuth");
			}
			if (mypageAuth == false) {
				// 이전에 my page 비밀번호 입력했는지 체크
				response.sendRedirect("/auth.mypage");
			} else {				
				if(!(MemberInfo.getType().equalsIgnoreCase(MemberDTO.TYPE_MEDIA) || MemberInfo.getType().equalsIgnoreCase(MemberDTO.TYPE_CALCULATE_ADMIN))) {
					// 회원 종류가 해당 옵션(M: 매체사, W: 정산 관리자)이 아닌 경우는, 회원정보 페이지로 이동
					response.sendRedirect("/info.mypage");
					return;
				}
				
				request.setAttribute("MemberInfo", MemberInfo);
				
				//매체목록 세팅
				request.setAttribute("mediaList", new MemberDAO().listAdjustMedia(MemberInfo));	
				
				List<Map<String, Object>> selectTotalPrice = new ArrayList<Map<String, Object>>();
				Map<String, Object> params = new HashMap<String, Object>();
				Calendar cal = Calendar.getInstance();
				int year = cal.get(Calendar.YEAR);
				int month = cal.get(Calendar.MONTH);

				params.put("member_seq", MemberInfo.getSeq());
				params.put("start_date", year+"0101");
				params.put("end_date", year+"1231");
				
				PaymentDAO paymentDAO = new PaymentDAO(); // 회원정보 연결
				selectTotalPrice = paymentDAO.selectTotalPrice(params); // 회원정보 요청
				request.setAttribute("totalPrice", selectTotalPrice);
				
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM");
				String thisMonth = dateFormat.format(cal.getTime());
				List<String> pastMonths = new ArrayList<String>();
				pastMonths.add(thisMonth);
				
				//String[] pastMonths = { thisMonth };
				// 최근 6개월 표현
				for(int i=0; i<5; i++) {
					
					cal.add(cal.MONTH, -1);
					
					String beforeYear = dateFormat.format(cal.getTime()).substring(0,4);
					String beforeMonth = dateFormat.format(cal.getTime()).substring(4,6);
					
					String beforeDate = beforeYear + beforeMonth;
					pastMonths.add(beforeDate);
				}
				request.setAttribute("pastMonths", pastMonths);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"mypage_account_year.jsp");
				dispatcher.forward(request, response);					
			}
			
		} else {
			response.sendRedirect("/login");
		}
	}
}
