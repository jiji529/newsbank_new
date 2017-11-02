package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;

/**
 * Servlet implementation class MypageAuth
 */
@WebServlet("/member.api")
public class MemberAction extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
	private static String cmd = null;
	private static HttpSession session = null;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public MemberAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		session = request.getSession();
		MemberDTO MemberInfo = null;
		if (session.getAttribute("MemberInfo") != null) {
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		}

		boolean check = true;
		boolean result = false;
		String message = null;

		String type = null;
		String id = null;
		String pw = null;
		String email = null;
		String name = null;
		String phone = null;
		String compNum = null;
		String compDocPath = null;
		String compName = null;
		String compTel = null;
		String compAddress = null;
		String compAddDetail = null;
		String compZipcode = null;
		String logo = null;
		cmd = request.getParameter("cmd"); // api 구분 crud
		System.out.println("cmd => " + cmd + " : " + check);
		type = request.getParameter("type"); // 회원 구분
		System.out.println("type => " + type + " : " + check);
		id = request.getParameter("id"); // 아이디 request
		check = check && isValidId(id);
		System.out.println("id => " + id + " : " + check);
		if (!check) {
			message = "아이디 형식이 올바르지 않습니다.s";
		}
		pw = request.getParameter("pw"); // 비밀번호 request
		check = check && isValidPw(pw);
		System.out.println("pw => " + pw + " : " + check);
		if (!check) {
			message = "패스워드 형식이 올바르지 않습니다.";
		}

		email = request.getParameter("email"); // 이메일 request
		check = check && isValidEmail(email);
		System.out.println("email => " + email + " : " + check);
		if (!check) {
			message = "이메일 형식이 올바르지 않습니다.";
		}
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

		if (!type.equalsIgnoreCase("P")) {
			compNum = request.getParameter("compNum"); // 사업자등록번호
			check = check && isValidCompNum(compNum);
			System.out.println("compNum => " + compNum + " : " + check);
			if (!check) {
				message = "사업자 등록번호 형식이 올바르지 않습니다.";
			}
			compDocPath = request.getParameter("compDocPath"); // 사업자등록증
			compName = request.getParameter("compName"); // 회사 이름
			check = check && isValidNull(compName);
			System.out.println("compName => " + compName + " : " + check);
			if (!check) {
				message = "회사 이름을 입력해 주세요.";
			}
			compTel = request.getParameter("compTel"); // 회사전화번호
			check = check && isValidPhone(compTel);
			System.out.println("compTel => " + compTel + " : " + check);
			if (!check) {
				message = "회사 전화 번호 형식이 올바르지 않습니다.";
			}
			compAddress = request.getParameter("compAddress"); // 회사주소
			check = check && isValidNull(compAddress);
			System.out.println("compAddress => " + compAddress + " : " + check);
			if (!check) {
				message = "회사 주소를 입력해 주세요.";
			}
			compAddDetail = request.getParameter("compAddDetail"); // 회사상세주소
			System.out.println("compAddDetail => " + compAddDetail);
			compZipcode = request.getParameter("compZipcode"); // 회사우편번호
			check = check && isValidNull(compZipcode);
			System.out.println("compZipcode => " + compZipcode + " : " + check);
			if (!check) {
				message = "회사 우편번호를 입력해 주세요.";
			}
			if (type.equalsIgnoreCase("M")) {
				logo = request.getParameter("logo"); // 로고 경로 request
			}

		}

		// process(request, response);

		if (check) {
			MemberDTO memberDTO = new MemberDTO(); // 객체 생성
			if (MemberInfo != null && MemberInfo.getSeq() > 0) {
				memberDTO.setSeq(MemberInfo.getSeq());
			}

			memberDTO.setId(id);
			memberDTO.setPw(pw);
			memberDTO.setEmail(email);
			memberDTO.setName(name);
			memberDTO.setPhone(phone);
			memberDTO.setType(type);
			memberDTO.setCompNum(compNum);
			memberDTO.setComDocPath(compDocPath);
			memberDTO.setCompName(compName);
			memberDTO.setCompTel(compTel);
			memberDTO.setCompAddress(compAddress);
			memberDTO.setCompAddDetail(compAddDetail);
			memberDTO.setCompZipcode(compZipcode);
			memberDTO.setLogo(logo);

			MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결
			switch (cmd) {
			case "C":
				result = memberDAO.insertMember(memberDTO); // 회원정보 요청
				break;
			case "R":
				break;
			case "U":
				if (MemberInfo != null && MemberInfo.getId() != null) {
					memberDTO.setId(MemberInfo.getId());
				}
				result = memberDAO.updateMember(memberDTO); // 회원정보 요청
				if (result) {
					// 로그인 성공
					session.setAttribute("MemberInfo", memberDAO.selectMember(memberDTO)); // 회원정보 세션 저장
				}

				break;
			case "D":
				break;
			}

		}

		JSONObject json = new JSONObject();
		json.put("success", result);
		json.put("message", message);

		response.getWriter().print(json);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	public static boolean isValidEmail(String email) {
		boolean err = false;
		String regex = "^[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$";
		if (email != null) {
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(email);
			if (m.matches()) {
				err = true;
			}
		}
		return err;
	}

	public static boolean isValidId(String id) {
		String regex = "^[a-zA-Z0-9]{2,19}$";
		boolean err = false;
		if (id != null && !id.isEmpty()) {
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(id);
			if (m.matches()) {
				err = true;
			}
		}
		if (cmd.equalsIgnoreCase("U")) {
			err = true;
		}
		return err;

		/*
		 * Pattern p = Pattern.compile(regex); Matcher m = p.matcher(id); if
		 * (m.matches()) { err = true; }
		 */
	}

	public static boolean isValidNull(String str) {
		boolean err = false;
		if (str != null) {
			err = true;
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

		} else if (cmd.equalsIgnoreCase("U")) {
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
		} else if (cmd.equalsIgnoreCase("U")) {
			err = true;
		}

		return err;
	}

	public static boolean isValidCompNum(String CompNum) {
		boolean err = false;
		String regex = "[(0-9)]{10}";
		if (CompNum != null && !CompNum.isEmpty()) {
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(CompNum);
			if (m.matches()) {
				err = true;
			}
		}
		return err;
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
		} else if (cmd.equalsIgnoreCase("U")) {
			err = true;
		}

		return err;
	}

}
