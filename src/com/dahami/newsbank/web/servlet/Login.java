package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.zookeeper.server.ServerConfig;
import org.json.simple.JSONObject;

import com.dahami.newsbank.web.dao.MemberDAO;
import com.dahami.newsbank.web.dto.MemberDTO;
import com.dahami.newsbank.web.servlet.bean.CmdClass;
import com.dahami.newsbank.web.util.CommonUtil;

/**
 * Servlet implementation class Login
 */
@WebServlet(
		urlPatterns = {"/login", "/check.login", "/out.login", "/idchange.login"},
		loadOnStartup = 1
		)
public class Login extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	private static OldMemberMailDaemon oldMemberMailDaemon;
	
	static {
		oldMemberMailDaemon = new Login().new OldMemberMailDaemon();
		oldMemberMailDaemon.start();
	}
	
	public Login() {
		super();
		
	}
	
	@Override
	public void destroy() {
		super.destroy();
		try{oldMemberMailDaemon.interrupt();}catch(Exception e){}
	}

	private static boolean destroyF;
	private class OldMemberMailDaemon extends Thread {
		public OldMemberMailDaemon() {
			super("OldMemberMailDaemon");
		}
		
		public void run() {
			while(!destroyF) {
				MemberDAO mDao = new MemberDAO();
				List<MemberDTO> oldMemberList = mDao.listOldMembert();
				if(oldMemberList.size() > 0) {
					for(MemberDTO old : oldMemberList) {
						
						mDao.setOldMailSend(old.getSeq());
					}
				}
				try {this.sleep(60 * 60 * 1000);}catch(Exception e) {}
			}
			logger.info("Finish");
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		CmdClass cmd = CmdClass.getInstance(request);
		if (cmd.isInvalid()) {
			response.sendRedirect("/invlidPage.jsp");
			return;
		}

		HttpSession session = request.getSession();
		
		// 로그아웃
		if(cmd.is2("out")) {
			session.invalidate(); //세션 삭제
			response.sendRedirect("/home");
			return;
		}
		
		MemberDTO memberInfo = (MemberDTO) session.getAttribute("MemberInfo");
		// 로그인페이지 호출
		if(cmd.get2() == null) {
			if(memberInfo != null) {
				response.sendRedirect("/home");
				return;
			}
			Cookie[] getCookie = request.getCookies();
			if (getCookie != null) {
				for (int i = 0; i < getCookie.length; i++) {
					if (getCookie[i].getName().trim().equals("id")) {
						//System.out.println(cookie[i].getValue());
						request.setAttribute("id", getCookie[i].getValue());
					}
				}
			}
			
			//String prevPage = (String) session.getAttribute("prevPage");
//			String refererUrl = request.getHeader("referer");
//			if (refererUrl == null || refererUrl.equals("/login")) {
//				refererUrl = "/home";
//			} else {
//				URL aURL = new URL(refererUrl);
//				refererUrl = aURL.getFile();
//			}

			/*if (prevPage == null) {
				// 이전 페이지 정보 없음
				session.setAttribute("prevPage", refererUrl);
				prevPage = refererUrl;
			} 
			*/
			
			// 초기화면 또는 아이디 패스워드 누락
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
			dispatcher.forward(request, response);
		}
		else if(cmd.is2("idchange")) {
			if(memberInfo == null) {
				response.sendRedirect("/login");
				return;
			}
			if (memberInfo.getId().length() < 4) {
				boolean nextChangeHide = false;
				String targetDate = "20180531";
				
				
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
				String thisDay = dateFormat.format(cal.getTime());
				if(thisDay.compareTo(targetDate)>0) {
					nextChangeHide = true;
				}
				
				request.setAttribute("id", memberInfo.getId());
				request.setAttribute("nextChangeHide", nextChangeHide);
				

				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login_popup.jsp");
				dispatcher.forward(request, response);
			}
		}
		else if(cmd.is2("check")) {
			boolean check = true;
			boolean result = false;
			String message = null;

			String id = request.getParameter("id"); // 아이디 request
			String pw = request.getParameter("pw"); // 비밀번호 request
			String login_chk = request.getParameter("login_chk"); // 아이디 저장 request
			check = check && isValidNull(id);
			check = check && isValidNull(pw);
			if (check) {
				MemberDTO memberDTO = new MemberDTO(); // 객체 생성
				MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결
				memberDTO.setId(id);
				// memberDTO.setPw();
				//System.out.println(memberDTO.getPwCurrent());
				

				memberDTO = memberDAO.selectMember(memberDTO); // 회원정보 요청
				if (memberDTO != null) {

					if (memberDTO.getWithdraw() == 0) { // 정상회원
						String request_pw = CommonUtil.sha1(pw);
						boolean pw_success = false;
						// 패스워드가 있을때
						if (memberDTO.getPw() != null && memberDTO.getPw().equals(request_pw)) {
							// 성공 리뉴뱅
							pw_success = true;
						} else if (memberDTO.getPwCurrent()!=null && memberDTO.getPwCurrent().equalsIgnoreCase(request_pw)) {
							// 성공 신뉴뱅
							pw_success = true;
							message = "홈페이지 개편으로 기존 뉴스뱅크 패스워드로 로그인을 시도합니다.";
							memberDTO.setPw(request_pw.toUpperCase());
							memberDAO.updateMember(memberDTO); // 회원정보 업데이트 요청
							
							
						} else if (memberDTO.getPwPast()!=null) {
							// 성공 //구뉴뱅
							pw_success = false;
							message = "홈페이지 개편으로 기존 뉴스뱅크 패스워드가 초기화 되었습니다.\n(주)다하미커뮤니케이션즈 02)593-4174";
							//memberDTO.setPw(request_pw.toUpperCase());
							//memberDAO.updateMember(memberDTO); // 회원정보 업데이트 요청
							
						}else {
							message = "아이디 또는 패스워드를 확인하세요.";
						}

						if (pw_success) {
							SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
							
							// 오늘 날짜
							Date today = new Date();			
							String loginDate = dateFormat.format(today);
							
							
							memberDTO.setLoginDate(loginDate);
							memberDAO.updateMember(memberDTO); // 회원정보 업데이트 요청
							// 로그인 성공
							session.setAttribute("MemberInfo", memberDTO); // 회원정보 세션 저장
							session.setMaxInactiveInterval(60 * 60 * 25 * 7);// 유효기간 7일

							// 자동로그인 쿠키 저장
							if (login_chk != null && login_chk.trim().equals("on")) {
								Cookie cookie = new Cookie("id", URLEncoder.encode(id, "UTF-8"));
								cookie.setMaxAge(60 * 60 * 25 * 7);// 쿠기 유효기간 1주일
								response.addCookie(cookie);
							} else {
								Cookie cookie = new Cookie("id", null);
								cookie.setMaxAge(0);// 유효기간 0
								response.addCookie(cookie);
							}
							result = true;
						}

					} else { // 탈퇴 회원
						message = "탈퇴 회원입니다.";
					}

				} else {
					message = "아이디 또는 패스워드를 확인하세요.";
				}
			} else {
				message = "아이디 또는 패스워드를 확인하세요.";
			}

			JSONObject json = new JSONObject();
			json.put("success", result);
			json.put("message", message);

			response.getWriter().print(json);
		}
	}
	
	private static boolean isValidNull(String str) {
		boolean err = false;
		if (str != null && !str.isEmpty()) {
			err = true;
		}
		return err;
	}
}
