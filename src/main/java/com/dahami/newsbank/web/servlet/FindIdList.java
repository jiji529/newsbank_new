package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.dahami.newsbank.Constants;
import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;

/**
 * Servlet implementation class FindIdList
 */
@WebServlet("/list.find")
public class FindIdList extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
	private static HttpSession session = null;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public FindIdList() {
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
		
		session = request.getSession();

		boolean check = true;
		boolean result = false;
		String message = null;

		String name = null;
		String phone = null;

		name = request.getParameter("name"); // 이름 request
		check = check && isValidNull(name);
		System.out.println("name => " + name + " : " + check);
		if (!check) {
			message = "이름을 입력해 주세요.";
		}
		phone = request.getParameter("phone"); // 전화번호 request
		check = check && isValidPhone(phone);
		System.out.println("phone => " + phone + " : " + check);
		if (!check) {
			message = "휴대폰 번호 형식이 올바르지 않습니다.";
		}
		check = check && isValidCertiNum(request);
		if (!check) {
			message = "인증번호가 올바르지 않습니다.";
		}

		if (check) {
			MemberDTO memberDTO = new MemberDTO(); // 객체 생성
			MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결
			List<MemberDTO> listMember = new ArrayList<MemberDTO>();
			memberDTO.setName(name);
			memberDTO.setPhone(phone);
			listMember = memberDAO.listMember(memberDTO); // 회원정보 요청
			request.setAttribute("listMember", listMember);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp"+Constants.JSP_BASHPATH+"find_id_list.jsp");
			dispatcher.forward(request, response);
		} else {
			response.getWriter().append("<script type=\"text/javascript\">alert('" + message + "');location='/id.find';</script>").append(request.getContextPath());

		}

	}

	public static boolean isValidCertiNum(HttpServletRequest request) {
		boolean err = false;
		String getCertiphone = null;
		String getCertiNum = null;
		String CertiNum = null;
		String phone = null;

		if (session.getAttribute("sCertifyNumber") != null) {
			// 세션 내 인증번호 체크
			getCertiNum = (String) session.getAttribute("sCertifyNumber");
		}
		if (session.getAttribute("sCertifyPhone") != null) {
			// 세션 내 인증번호 체크
			getCertiphone = (String) session.getAttribute("sCertifyPhone");
		}
		CertiNum = request.getParameter("CertiNum"); // 전화번호 인증번호 request
		phone = request.getParameter("phone");
		if (CertiNum != null && phone != null && !CertiNum.isEmpty() && !phone.isEmpty() && CertiNum.equalsIgnoreCase(getCertiNum) && phone.equalsIgnoreCase(getCertiphone)) {
			err = true;
		}
		session.removeAttribute("sCertifyNumber");
		session.removeAttribute("sCertifyPhone");

		return err;
	}

	public static boolean isValidNull(String str) {
		boolean err = false;
		if (str != null) {
			err = true;
		}
		return err;
	}

	public static boolean isValidPhone(String phone) {
		boolean err = false;
		String regex = "^0([0-9]{1,3})-?([0-9]{3,4})-?([0-9]{4})$";
		if (phone != null && !phone.isEmpty()) {
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(phone);
			if (m.matches()) {
				err = true;
			}
		}

		return err;
	}
}
