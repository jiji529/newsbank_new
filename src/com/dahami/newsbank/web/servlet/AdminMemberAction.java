package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.ArrayUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dao.UsageDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.dto.UsageDTO;
import com.dahami.newsbank.web.util.CommonUtil;

import org.json.simple.parser.*;

/**
 * Servlet implementation class AdminMemberAction
 */
@WebServlet("/admin.member.api")
public class AdminMemberAction extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
	//private static HttpSession session = null;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public AdminMemberAction() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		
		MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결
		MemberDTO MemberInfo = new MemberDTO();
		
		if(request.getParameter("seq") != null) {
			int member_seq = Integer.parseInt(request.getParameter("seq"));
			MemberInfo = memberDAO.getMember(member_seq);
		}
		/*if (session.getAttribute("MemberInfo") != null) {
			MemberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		}*/

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
		String compExtTel = null;
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
		String[] usage = null; // 사용용도
		String[] price = null; // 사진단가
		String[] usageList_seq = null; // 사진용도 고유번호
		Double preRate = null;
		Double postRate = null;
		String taxName = null;
		String taxPhone = null;
		String taxEmail = null;
		String taxExtTell = null;
		String[] media_seq = null; // 정산정보별 회원번호

		/** 관리자 기능 **/
		String permission = null;
		int deferred = 0;
		String activate = null;
		String admission = null; // 승인
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
		if (check && request.getParameter("pw") != null && request.getParameter("pw") != "") {
			pw = request.getParameter("pw"); // 비밀번호 request
			check = check && isValidPw(pw);
			System.out.println("pw => " + pw + " : " + check);
			if (!check) {
				message = "패스워드 형식이 올바르지 않습니다.";
			}
			pw = CommonUtil.sha1(pw);
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
			/*check = check && isValidCertiNum(request);
			if (!check) {
				message = "인증번호가 올바르지 않습니다.";
			}*/

		}

		if (check && request.getParameter("compNum") != null) {
			compNum = request.getParameter("compNum"); // 사업자등록번호
			check = check && isValidCompNum(compNum);

			System.out.println("compNum => " + compNum + " : " + check);
			if (!check) {
				message = "사업자 등록번호 형식이 올바르지 않습니다.";
			}
		}

		if (check && request.getParameter("compDocPath") != null) {
			compDocPath = request.getParameter("compDocPath"); // 사업자등록증
			compDocPath = com.dahami.newsbank.web.service.UploadService.PATH_COMP_DOC_BASE+"/"+compDocPath;
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
		
		if(check && request.getParameter("compExtTel") != null && request.getParameter("compExtTel").length() != 0) {
			compExtTel = request.getParameter("compExtTel"); // 회사 내선번호
			check = check && isValidExhTel(compExtTel); 
			System.out.println("compExtTel => " + compExtTel + " : " + check);
			if (!check) {
				message = "회사 내선번호 형식이 올바르지 않습니다.";
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

		if (check && request.getParameter("contractStart") != null && request.getParameter("contractStart") != "") {
			contractStart = request.getParameter("contractStart"); // 로고 경로 request
		}

		if (check && request.getParameter("contractEnd") != null && request.getParameter("contractEnd") != "") {
			contractEnd = request.getParameter("contractEnd"); // 로고 경로 request
		}

		if (check && request.getParameter("contractAuto") != null) {
			contractAuto = request.getParameter("contractAuto"); // 로고 경로 request
		}
		
		if (check && request.getParameterValues("usage") != null && !ArrayUtils.isEmpty(request.getParameterValues("usage"))) {
			usage = request.getParameterValues("usage"); // 로고 경로 request
		}
		
		if (check && request.getParameterValues("price") != null && !ArrayUtils.isEmpty(request.getParameterValues("price"))) {
			price = request.getParameterValues("price"); // 로고 경로 request
		}
		
		if (check && request.getParameterValues("usageList_seq") != null && !ArrayUtils.isEmpty(request.getParameterValues("usageList_seq"))) {
			usageList_seq = request.getParameterValues("usageList_seq"); // 로고 경로 request
		}

		if (check && request.getParameter("preRate") != null && request.getParameter("taxName").length() != 0) {
			preRate = Double.parseDouble(request.getParameter("preRate"));
		}

		if (check && request.getParameter("postRate") != null && request.getParameter("taxName").length() != 0) {
			postRate = Double.parseDouble(request.getParameter("postRate"));
		}

		if (check && request.getParameter("taxName") != null && request.getParameter("taxName").length() != 0) {
			taxName = request.getParameter("taxName"); // 로고 경로 request
		}

		if (check && request.getParameter("taxPhone") != null && request.getParameter("taxPhone").length() != 0) {
			taxPhone = request.getParameter("taxPhone"); // 로고 경로 request
		}
		if (check && request.getParameter("taxEmail") != null && request.getParameter("taxEmail").length() != 0) {
			taxEmail = request.getParameter("taxEmail"); // 로고 경로 request
		}
		
		
		if(check && request.getParameter("taxExtTell") != null && request.getParameter("taxExtTell").length() != 0) {
			taxExtTell = request.getParameter("taxExtTell"); // 회사 내선번호
			check = check && isValidExhTel(taxExtTell); 
			System.out.println("taxExtTell => " + taxExtTell + " : " + check);
			if (!check) {
				message = "세금계산서 담당자 내선번호 형식이 올바르지 않습니다.";
			}
		}

		if (check && request.getParameter("permission") != null) {
			permission = request.getParameter("permission"); // 로고 경로 request
		}

		if (check && request.getParameter("deferred") != null) {
			deferred = Integer.parseInt(request.getParameter("deferred")); 
		}

		if (check && request.getParameter("activate") != null) {
			activate = request.getParameter("activate"); 
		}
		
		if (check && request.getParameter("admission") != null) {
			admission = request.getParameter("admission"); 
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
		ArrayList<UsageDTO> usageList = new ArrayList<>(); // 사용용도 리스트
		ArrayList<MemberDTO> adjustList = new ArrayList<>(); // 정산매체 리스트(Master - Slave)
		
		// 정산정보 리스트
		if(check && request.getParameter("ajdustList") != null) {
			//System.out.println(request.getParameter("ajdustList"));
			String json = request.getParameter("ajdustList");
			Object obj = JSONValue.parse(json);			
			JSONArray jsonArray = (JSONArray)obj;
			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jsonObject = (JSONObject)jsonArray.get(i);
				
				memberDTO.setType(jsonObject.get("type").toString());
				
				if (jsonObject.get("cmd") != null && !jsonObject.get("cmd").toString().equals("")) {
					cmd = jsonObject.get("cmd").toString(); // api 구분 crud
				}
				
				if (jsonObject.get("compBankName") != null && !jsonObject.get("compBankName").toString().equals("")) {
					memberDTO.setCompBankName(jsonObject.get("compBankName").toString());
				}
				
				if (jsonObject.get("compBankAcc") != null && !jsonObject.get("compBankAcc").toString().equals("")) {
					memberDTO.setCompBankAcc(jsonObject.get("compBankAcc").toString());
				}
				
				if (jsonObject.get("contractStart") != null && !jsonObject.get("contractStart").toString().equals("")) {
					memberDTO.setContractStart(jsonObject.get("contractStart").toString());
				}
				
				if (jsonObject.get("contractEnd") != null && !jsonObject.get("contractEnd").toString().equals("")) {
					memberDTO.setContractEnd(jsonObject.get("contractEnd").toString());
				}
				
				if (jsonObject.get("preRate") != null && jsonObject.get("preRate").toString().length() != 0) {
					memberDTO.setPreRate(Double.parseDouble(jsonObject.get("preRate").toString()));
				}
				
				if (jsonObject.get("postRate") != null && jsonObject.get("postRate").toString().length() != 0) {
					memberDTO.setPostRate(Double.parseDouble(jsonObject.get("postRate").toString()));
				}
				
				if (jsonObject.get("taxName") != null && !jsonObject.get("taxName").toString().equals("")) {
					memberDTO.setTaxName(jsonObject.get("taxName").toString());
				}
				
				if (jsonObject.get("taxPhone") != null && !jsonObject.get("taxPhone").toString().equals("")) {
					memberDTO.setTaxPhone(jsonObject.get("taxPhone").toString());
				}
				
				if (jsonObject.get("taxExtTell") != null && !jsonObject.get("taxExtTell").toString().equals("")) {
					memberDTO.setTaxExtTell(jsonObject.get("taxExtTell").toString());
				}
				
				if (jsonObject.get("taxEmail") != null && !jsonObject.get("taxEmail").toString().equals("")) {
					memberDTO.setTaxEmail(jsonObject.get("taxEmail").toString());
				}
				
				if (jsonObject.get("activate") != null && !jsonObject.get("activate").toString().equals("")) {
					memberDTO.setActivate(jsonObject.get("activate").toString());
				}
				
				if (jsonObject.get("admission") != null) {
					memberDTO.setAdmission(jsonObject.get("admission").toString());
				}
				
				if (jsonObject.get("media_seq") != null && !jsonObject.get("media_seq").toString().equals("")) {
					memberDTO.setSeq(Integer.parseInt(jsonObject.get("media_seq").toString()));
				}
				
				result = memberDAO.updateMember(memberDTO); // 회원정보 요청
				message = "회원정보 수정완료";
			}
			
		}
		
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
			memberDTO.setcompExtTel(compExtTel);
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
			memberDTO.setTaxExtTell(taxExtTell);

			memberDTO.setPermission(permission);
			memberDTO.setDeferred(deferred);
			memberDTO.setActivate(activate);
			memberDTO.setAdmission(admission);
			memberDTO.setMaster_seq(master_seq);
			memberDTO.setGroup_seq(group_seq);
			
			// 후불회원만 사용 용도 갯수만큼 생성 (deferred = 2)
			if(deferred != 0 && deferred == 2) {
				for(int i = 0; i<usage.length; i++) {
					UsageDTO usageDTO = new UsageDTO(); // 사용용도 객체 생성
					usageDTO.setUsage(usage[i]);
					usageDTO.setPrice(Integer.parseInt(price[i]));
					//System.out.println("["+i+"] : "+usageList_seq[i]);
					
					if(usageList_seq[i] != null && usageList_seq[i] != "") {
						usageDTO.setUsageList_seq(Integer.parseInt(usageList_seq[i]));
					}			
					
					usageList.add(i, usageDTO);
				}
				
				saveUsageList(seq, usageList); // 사용용도 저장
			}
			
			switch (cmd) {
			case "C":
				memberDTO = memberDAO.insertMember(memberDTO); // 회원정보 요청
				if (memberDTO.getSeq() > 0) {
					result = true;
				}
				break;
			case "R":
				memberDTO = memberDAO.selectMember(memberDTO);
				// 로그인 정보 요청
				break;
			case "U":
				if (seq > 0) {
					result = memberDAO.updateMember(memberDTO); // 회원정보 요청
					//result = true;
				} else {
					message = "세션정보가 없습니다. 다시 로그인 해주세요.";
				}

				if (result) {
					// 로그인 성공
					//session.setAttribute("MemberInfo", memberDAO.selectMember(MemberInfo)); // 회원정보 세션 저장
				}

				break;
			case "D":
				// 탈퇴
				if (seq > 0) {
					result = memberDAO.leaveMember(memberDTO); // 회원정보 요청
				} else {
					message = "세션정보가 없습니다. 다시 로그인 해주세요.";
				}
				break;
				
			case "M":
				// 매체사 정산정보
				result = true;
				message = "정산정보가 수정되었습니다.";
				break;
			}

		}

		JSONObject json = new JSONObject();

		if (cmd.equalsIgnoreCase("R")) {
			if (memberDTO != null && memberDTO.isMember()) {
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
			} else {
				message = "매체 정보를 찾을 수 없습니다.";
			}

		}
		json.put("success", result);
		json.put("message", message);

		response.getWriter().print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
	
	public static boolean isValidExhTel(String phone) {
		boolean err = false;
		String regex = "[(0-9)]{3}";
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
	
	public void saveUsageList(int seq, List<UsageDTO> usageList) { // 사용용도를 저장
		UsageDAO usageDAO = new UsageDAO();
		List<UsageDTO> dbUsageList = usageDAO.usageListOfuser(seq); // 기존의 DB 사용용도
		
		ArrayList<UsageDTO> dbsameList = new ArrayList<>(); // 공통항목(DB)
		ArrayList<UsageDTO> usageSameList = new ArrayList<>(); // 공통항목(수정항목)
		
		for(int ix=0; ix<dbUsageList.size(); ix++) {
			for(int idx=0; idx<usageList.size(); idx++) {
				
				if(dbUsageList.get(ix).getUsageList_seq() == usageList.get(idx).getUsageList_seq()) {
					usageDAO.updateUsage(usageList, seq); // 사용용도 수정
					dbsameList.add(dbUsageList.get(ix));
					usageSameList.add(usageList.get(idx));
				}				
			}
		}
		
		usageList.removeAll(usageSameList); // 공통항목 제거
		dbUsageList.removeAll(dbsameList); // 공통항목 제거		
		
		if(dbUsageList.size() != 0) { 
			usageDAO.disableUsage(dbUsageList, seq); // 사용용도 비활성화
		}
		
		if(usageList.size() != 0) {
			usageDAO.insertUsage(usageList, seq); // 사용용도 추가
		}
	}

	/*public static boolean isValidCertiNum(HttpServletRequest request) {
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
	}*/
}
