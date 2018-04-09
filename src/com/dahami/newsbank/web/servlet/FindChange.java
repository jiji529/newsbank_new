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

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class Findpw
 */
@WebServlet("/change.find")
public class FindChange extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
	private static HttpSession session = null;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public FindChange() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		session = request.getSession();

		boolean check = true;
		boolean result = false;
		String message = null;

		String id = null;
		String phone = null;
		String pw = null;
		
		MemberDTO memberDTO = new MemberDTO(); // 객체 생성
		MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결

		id = request.getParameter("id"); // 이름 request
		phone = request.getParameter("phone"); // 전화번호 request
		pw = request.getParameter("pw"); // 비밀번호 request

		if (pw != null) {
			response.setContentType("application/json;charset=UTF-8");
			if (isValidPw(pw)) {
				if (session.getAttribute("findMemberDTO") != null) {
					
					memberDTO = (MemberDTO) session.getAttribute("findMemberDTO");
					memberDTO.setPw(pw);
					result = memberDAO.updateMember(memberDTO); // 회원정보 요청
					if(result) {
						message = "수정되었습니다.";
						//response.getWriter().append("<script type=\"text/javascript\">alert('수정되었습니다.');location.replace('/login');</script>").append(request.getContextPath());
					}else {
						message = "서버 오류\n고객센터에 문의해주시기 바랍니다.";
						//response.getWriter().append("<script type=\"text/javascript\">alert('서버 오류\n고객센터에 문의해주시기 바랍니다.');history.back(-1);</script>").append(request.getContextPath());
					}
					session.removeAttribute("findMemberDTO");
				}
			} else {
				message = "비밀번호 형식이 올바르지 않습니다.";
			}
			//response.getWriter().append("<script type=\"text/javascript\">alert('" + message + "');history.back(-1);</script>").append(request.getContextPath());
			
			
			JSONObject json = new JSONObject();
			json.put("success", result);
			json.put("message", message);

			response.getWriter().print(json);
			
			return;

		}

		check = check && isValidNull(id);
		if (!check) {
			message = "아이디를 입력해 주세요.";
		}
		check = check && isValidPhone(phone);
		if (!check) {
			message = "휴대폰 번호 형식이 올바르지 않습니다.";
		}
		check = check && isValidCertiNum(request);
		if (!check) {
			message = "인증번호가 올바르지 않습니다.";
		}

		System.out.println("id => " + id + " : " + check);
		System.out.println("phone => " + phone + " : " + check);

		if (check) {
			memberDTO.setId(id);
			memberDTO.setPhone(phone);
			memberDTO = memberDAO.selectMember(memberDTO); // 회원정보 요청
			if(memberDTO!=null) {
				session.setAttribute("findMemberDTO", memberDTO);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/find_pw_change.jsp");
				dispatcher.forward(request, response);
			}else {
				message = id+"의 회원정보를 찾을 수 없습니다.";
				response.getWriter().append("<script type=\"text/javascript\">alert('" + message + "');history.back(-1);</script>").append(request.getContextPath());
			}
			
		} else {
			response.getWriter().append("<script type=\"text/javascript\">alert('" + message + "');history.back(-1);</script>").append(request.getContextPath());

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
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

	public static boolean isValidPw(String pw) {
		boolean err = false;
		String regex = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}";
		if (pw != null && !pw.isEmpty()) {
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(pw);
			if (m.matches()) {
				err = true;
			}

		}
		return err;
	}	

}
