package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.PaymentDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.PaymentDetailDTO;
import com.dahami.newsbank.web.dto.PaymentManageDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class AdminOnlineView
 */
@WebServlet(urlPatterns = { "/view.online.manage" }, loadOnStartup = 1)
public class AdminOnlineView extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminOnlineView() {
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
		MemberDTO MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		
		if (MemberInfo != null) {
			
			if(MemberInfo.getType().equals("A")) { // 관리자 권한만 접근
				
			}else {
				processNotAdminAccess(request, response);
				return;
			}
			
			String LGD_OID = request.getParameter("LGD_OID");
			String nowStartDate = request.getParameter("nowStartDate");
			String nowEndDate = request.getParameter("nowEndDate");
			String nowPayType = request.getParameter("nowPayType");
			String nowPayStatus = request.getParameter("nowPayStatus");
			String nowPageVol = request.getParameter("nowPageVol");
			String nowStartGo = request.getParameter("nowStartGo");
			
			PaymentManageDTO pmDTO = new PaymentManageDTO();
			pmDTO.setLGD_OID(LGD_OID);
			
			PaymentDAO paymentDAO = new PaymentDAO();
			PaymentManageDTO payInfo = paymentDAO.selectPaymentManageList(pmDTO); // 결제정보			
			MemberDTO memberDTO = payInfo.getMemberDTO();
			List<PaymentDetailDTO> detailList = payInfo.getPaymentDetailList(); // 구매항목
			
			// 7일 이후 날짜
			int year = Integer.parseInt(payInfo.getLGD_PAYDATE().substring(0, 4));
			int month = Integer.parseInt(payInfo.getLGD_PAYDATE().substring(4, 6));
			int day = Integer.parseInt(payInfo.getLGD_PAYDATE().substring(6, 8));
			
			Calendar cal = Calendar.getInstance();
			cal.set(year, month-1, day);
			cal.add(Calendar.DATE, 7);
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String seven_days_after = dateFormat.format(cal.getTime());
			
			// 오늘 날짜
			Date today = new Date();			
			String thisDay = dateFormat.format(today);
			
			// 환불가능 여부
			boolean refund = refund_state(seven_days_after, thisDay);
			
			request.setAttribute("payInfo", payInfo);
			request.setAttribute("memberDTO", memberDTO);
			request.setAttribute("detailList", detailList);
			request.setAttribute("refund", refund);
			
			request.setAttribute("paytype", nowPayType);
			request.setAttribute("paystatus", nowPayStatus);
			request.setAttribute("start_date", nowStartDate);
			request.setAttribute("end_date", nowEndDate);
			request.setAttribute("pagevol", nowPageVol);
			request.setAttribute("startgo", nowStartGo);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"admin_online_view.jsp");
			dispatcher.forward(request, response);				
		}else {
			response.sendRedirect("/login");
		}
	}
	
	private boolean refund_state(String seven_days_after, String thisDay){
		boolean state = false;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		Date sevenDay = null;
		Date today = null;
		
		try {
			sevenDay = format.parse(seven_days_after);
			today = format.parse(thisDay);
		} catch(ParseException e) {
			e.printStackTrace();
		}
		
		int compare = sevenDay.compareTo(today);
		
		if(compare > 0) {
			state = true;
			//System.out.println("sevenDay > today");
		}else if(compare < 0) {
			state = false;
			//System.out.println("sevenDay < today");
		}else {
			state = true;
			//System.out.println("sevenDay = today");
		}
		
		System.out.println("sevenDay : " + seven_days_after);
		System.out.println("today : " + thisDay);
		System.out.println("refund : " + state);
		return state;
	}
}
