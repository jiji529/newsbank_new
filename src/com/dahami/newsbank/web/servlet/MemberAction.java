package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
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
		MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결
		MemberDTO MemberInfo = null;
		if (session.getAttribute("MemberInfo") != null) {
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		}

		boolean check = true;
		boolean result = false;
		String message = null;
		String cmd = "";

		/** 공통 **/
		int seq = 0;
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
		/** 정산 **/
		String compBankName = null;
		String compBankAcc = null;
		String compBankPath = null;
		String contractPath = null;
		String contractStart = null;
		String contractEnd = null;
		String contractAuto = null;
		Double preRate = null;
		Double postRate = null;
		String taxName = null;
		String taxPhone = null;
		String taxEmail = null;

		/** 관리자 기능 **/
		String permission = null;
		String deferred = null;
		String activate = null;
		int master_seq = 0;
		int group_seq = 0;

		if (request.getParameter("cmd") != null) {
			cmd = request.getParameter("cmd"); // api 구분 crud
		}
		if (check && request.getParameter("type") != null) {
			type = request.getParameter("type"); // 회원 구분
		}
		System.out.println("type => " + type + " : " + check);
		if (check && request.getParameter("id") != null) {
			id = request.getParameter("id"); // 아이디 request
			check = check && isValidId(id);
			System.out.println("id => " + id + " : " + check);
			if (!check) {
				message = "아이디 형식이 올바르지 않습니다.s";
			}
		}
		if (check && request.getParameter("pw") != null) {
			pw = request.getParameter("pw"); // 비밀번호 request
			check = check && isValidPw(pw);
			System.out.println("pw => " + pw + " : " + check);
			if (!check) {
				message = "패스워드 형식이 올바르지 않습니다.";
			}
		}

		if (check && request.getParameter("email") != null) {
			email = request.getParameter("email"); // 이메일 request
			check = check && isValidEmail(email);
			System.out.println("email => " + email + " : " + check);
			if (!check) {
				message = "이메일 형식이 올바르지 않습니다.";
			}
		}

		if (check && request.getParameter("name") != null) {
			name = request.getParameter("name"); // 이름 request

		}

		if (check && request.getParameter("phone") != null) {
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

		}

		if (check && request.getParameter("compNum") != null) {
			compNum = request.getParameter("compNum"); // 사업자등록번호
			check = check && isValidCompNum(compNum);

			System.out.println("compNum => " + compNum + " : " + check);
			if (!check) {
				message = "사업자 등록번호 형식이 올바르지 않습니다.";
			}
		}

		if (check && request.getParameter(
				"compDocPath") != null) {
			compDocPath = request.getParameter("compDocPath"); // 사업자등록증
		}

		if (check && request.getParameter("compName") != null) {
			compName = request.getParameter("compName"); // 회사 이름

		}

		if (check && request.getParameter("compTel") != null) {
			compTel = request.getParameter("compTel"); // 회사전화번호
			check = check && isValidPhone(compTel);
			System.out.println("compTel => " + compTel + " : " + check);
			if (!check) {
				message = "회사 전화 번호 형식이 올바르지 않습니다.";
			}
		}

		if (check && request.getParameter("compAddress") != null) {
			compAddress = request.getParameter("compAddress"); // 회사주소
		}

		if (check && request.getParameter("compAddDetail") != null) {
			compAddDetail = request.getParameter("compAddDetail"); // 회사상세주소
		}

		if (check && request.getParameter("compZipcode") != null) {
			compZipcode = request.getParameter("compZipcode"); // 회사우편번호

		}

		if (check && request.getParameter("logo") != null) {
			logo = request.getParameter("logo"); // 로고 경로 request
		}

		// process(request, response);

		if (check && request.getParameter("compBankName") != null) {
			compBankName = request.getParameter("compBankName"); // 로고 경로 request
		}

		if (check && request.getParameter("compBankAcc") != null) {
			compBankAcc = request.getParameter("compBankAcc"); // 로고 경로 request
		}

		if (check && request.getParameter("compBankPath") != null) {
			compBankPath = request.getParameter("compBankPath"); // 로고 경로 request
		}

		if (check && request.getParameter("contractPath") != null) {
			contractPath = request.getParameter("contractPath"); // 로고 경로 request
		}

		if (check && request.getParameter("contractStart") != null) {
			contractStart = request.getParameter("contractStart"); // 로고 경로 request
		}

		if (check && request.getParameter("contractEnd") != null) {
			contractEnd = request.getParameter("contractEnd"); // 로고 경로 request
		}

		if (check && request.getParameter("contractAuto") != null) {
			contractAuto = request.getParameter("contractAuto"); // 로고 경로 request
		}

		if (check && request.getParameter("preRate") != null) {
			preRate = Double.parseDouble(request.getParameter("preRate"));
		}

		if (check && request.getParameter("postRate") != null) {
			postRate = Double.parseDouble(request.getParameter("postRate"));
		}

		if (check && request.getParameter("taxName") != null) {
			taxName = request.getParameter("taxName"); // 로고 경로 request
		}

		if (check && request.getParameter("taxPhone") != null) {
			taxPhone = request.getParameter("taxPhone"); // 로고 경로 request
		}
		if (check && request.getParameter("taxEmail") != null) {
			taxEmail = request.getParameter("taxEmail"); // 로고 경로 request
		}

		if (check && request.getParameter("permission") != null) {
			permission = request.getParameter("permission"); // 로고 경로 request
		}

		if (check && request.getParameter("deferred") != null) {
			deferred = request.getParameter("deferred"); // 로고 경로 request
		}

		if (check && request.getParameter("activate") != null) {
			activate = request.getParameter("activate"); // 로고 경로 request
		}

		if (check && request.getParameter("master_seq") != null) {
			master_seq = Integer.parseInt(request.getParameter("master_seq"));
		}

		if (check && request.getParameter("group_seq") != null) {
			group_seq = Integer.parseInt(request.getParameter("group_seq"));
		}

		if (MemberInfo != null && MemberInfo.getSeq() > 0) {

			seq = MemberInfo.getSeq();
		}

		if (check && request.getParameter("media_code") != null) {
			int adjSlave = Integer.parseInt(request.getParameter("media_code"));
			MemberDTO memberDTO = new MemberDTO(); // 객체 생성
			memberDTO.setSeq(adjSlave);
			List<MemberDTO> mediaList = memberDAO.listAdjustMedia(memberDTO);
			boolean slave_match = false;
			for (MemberDTO adj : mediaList) {
				if (adj.getSeq() == adjSlave) {
					System.out.println(adjSlave);
					slave_match = true;
				}

			}
			if (slave_match) {
				seq = adjSlave;
			} else {
				check = false;
			}

		}
		MemberDTO memberDTO = new MemberDTO(); // 객체 생성
		if (check) {
			

			memberDTO.setSeq(seq);
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

			memberDTO.setCompBankName(compBankName);
			memberDTO.setCompBankAcc(compBankAcc);
			memberDTO.setCompBankPath(compBankPath);
			memberDTO.setContractPath(contractPath);
			memberDTO.setContractStart(contractStart);
			memberDTO.setContractEnd(contractEnd);
			memberDTO.setContractAuto(contractAuto);
			memberDTO.setPreRate(preRate);
			memberDTO.setPostRate(postRate);
			memberDTO.setTaxEmail(taxEmail);
			memberDTO.setTaxName(taxName);
			memberDTO.setTaxPhone(taxPhone);

			memberDTO.setPermission(permission);
			memberDTO.setDeferred(deferred);
			memberDTO.setActivate(activate);
			memberDTO.setMaster_seq(master_seq);
			memberDTO.setGroup_seq(group_seq);

			switch (cmd) {
			case "C":
				result = memberDAO.insertMember(memberDTO); // 회원정보 요청
				break;
			case "R":
				memberDTO = memberDAO.selectMember(memberDTO);
				// 로그인 정보 요청
				break;
			case "U":
				if (seq > 0) {
					result = memberDAO.updateMember(memberDTO); // 회원정보 요청
				} else {
					message = "세션정보가 없습니다. 다시 로그인 해주세요.";
				}

				if (result) {
					// 로그인 성공
					session.setAttribute("MemberInfo", memberDAO.selectMember(MemberInfo)); // 회원정보 세션 저장
				}

				break;
			case "D":
				break;
			}

		}

		JSONObject json = new JSONObject();
		
		if (cmd.equalsIgnoreCase("R")) {
			if (memberDTO!=null && memberDTO.isMember()) {
				result = true;
				Map<String, Object> data = new HashMap<String, Object>();
				data.put("compBankName", memberDTO.getCompBankName());
				data.put("compBankAcc", memberDTO.getCompBankAcc());
				data.put("compBankPath", memberDTO.getCompBankPath());
				data.put("contractPath", memberDTO.getContractPath());
				data.put("contractStart", memberDTO.getContractStart());
				data.put("contractEnd", memberDTO.getContractEnd());
				data.put("contractAuto", memberDTO.getContractAuto());
				data.put("preRate", memberDTO.getPreRate());
				data.put("postRate", memberDTO.getPostRate());
				data.put("taxEmail", memberDTO.getTaxEmail());
				data.put("taxName", memberDTO.getTaxName());
				data.put("taxPhone", memberDTO.getTaxPhone());

				json.put("data", data);
			}else {
				message ="매체 정보를 찾을 수 없습니다.";
			}
			
		}
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
		}
		session.removeAttribute("sCertifyNumber");
		session.removeAttribute("sCertifyPhone");

		return err;
	}

}
