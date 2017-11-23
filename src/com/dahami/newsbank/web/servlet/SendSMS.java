package com.dahami.newsbank.web.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
 * Servlet implementation class SendSMS
 */
@WebServlet("/SendSMS")
public class SendSMS extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;

	/**
	 * @see NewsbankServletBase#NewsbankServletBase()
	 */
	public SendSMS() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String tel = request.getParameter("tel"); // 전화번호 request
		String token = request.getParameter("token"); // 인증번호 request
		int certifyCount = 1;
		boolean success = false;
		String success_msg = "인증번호 오류";
		
		if (token != null && tel != null) {
			// 인증번호 확인 요청
			success_msg = "인증번호를 확인할 수 없습니다.";
			String getCertiNum = null;
			String getCertiphone = null;

			if (session.getAttribute("sCertifyNumber") != null) {
				//세션 내 인증번호 체크
				getCertiNum = (String) session.getAttribute("sCertifyNumber");
			}
			
			if (session.getAttribute("sCertifyPhone") != null) {
				//세션 내 인증번호 체크
				getCertiphone = (String) session.getAttribute("sCertifyPhone");
			}
			
			if (getCertiNum != null && getCertiNum.equals(token) && getCertiphone != null && getCertiphone.equals(tel)) {
				success = true;
				success_msg = "인증번호가 확인되었습니다.";
			}

		}
		
		if (tel != null && token == null ) {
			
			MemberDTO memberDTO = new MemberDTO(); // 객체 생성
			MemberDAO memberDAO = new MemberDAO(); // 회원정보 연결
			List<MemberDTO> listMember = new ArrayList<MemberDTO>();
			
			memberDTO.setPhone(tel);
			listMember = memberDAO.listMember(memberDTO); // 회원정보 요청
			// 회원정보 배열 크기 체크
			if (listMember.size() > 0) {
				success_msg = "입력하신 핸드폰번호는 이미 가입되어있습니다.";
			}else {

				// 전화번호 인증 요청
				success_msg = "인증번호를 입력하신 휴대폰번호에 전송했습니다.";
				String certifyNumber = Integer.toString(generateNumber(6)); // 랜덤 생성

				if (session.getAttribute("sCertifyCount") != null) {
					//세션에 인증 횟수 누적
					certifyCount = (int) session.getAttribute("sCertifyCount") + 1;
				}

				if (certifyCount < 100) {
					// 같은 세션에서 100회 이상 번호 인증 요청시 차단
					session.setAttribute("sCertifyPhone", tel); // 핸드폰번호
					session.setAttribute("sCertifyNumber", certifyNumber); // 랜덤 6자리
					session.setAttribute("sCertifyCount", certifyCount); // 횟수
					// session.removeAttribute("preDate");

					String sendMemo = "고객님의 인증번호는 [ " + certifyNumber + " ] 입니다.";

					String URL = "http://222.231.4.31/~voc_user/MMS_Send/mms_process_v2.php";
					Map<String, Object> param = new HashMap<String, Object>();
					param.put("send_num", "025934174");
					param.put("receive_num", tel);
					param.put("send_title", "[뉴스뱅크]");
					param.put("send_memo", sendMemo);
					System.out.println(param);
					//String result = URLPost(URL, param); // 주석해제하면 문자로 전송됨
					String result ="success";
					if (result.equalsIgnoreCase("success")) {
						success = true;
					}
				} else {
					success_msg = "더이상 인증번호를 요청할수 없습니다.";
				}
			}
			

		}
		

		JSONObject json = new JSONObject();//json 정의
		json.put("success", success);
		json.put("message", success_msg);

		response.getWriter().print(json); // json 생성
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	public static int generateNumber(int length) {
		// 랜덤 length 자리 생성

		String numStr = "1";
		String plusNumStr = "1";

		for (int i = 0; i < length; i++) {
			numStr += "0";

			if (i != length - 1) {
				plusNumStr += "0";
			}
		}

		Random random = new Random();
		int result = random.nextInt(Integer.parseInt(numStr))
				+ Integer.parseInt(plusNumStr);

		if (result > Integer.parseInt(numStr)) {
			result = result - Integer.parseInt(plusNumStr);
		}

		return result;
	}

	public static String URLPost(String url, final Map<String, Object> param) {
		//post 전송 url , param
		StringBuffer response = new StringBuffer();

		try {
			URL obj = new URL(url);
			URLConnection conn = obj.openConnection();

			String urlParameters = "";
			if (param.size() > 0) {

				for (String key : param.keySet()) {
					if (urlParameters.length() > 0)
						urlParameters += "&";
					urlParameters += key + "=" + param.get(key);

					System.out.println(key + "=" + param.get(key));
				}
			}

			// POST 값 전송일 경우 true
			conn.setDoOutput(true);
			OutputStreamWriter wr = new OutputStreamWriter(
					conn.getOutputStream());
			// 파라미터를 wr에 넣어주고 flush
			wr.write(urlParameters);
			wr.flush();

			// in에 readLine이 null이 아닐때까지 StringBuffer에 append
			BufferedReader in = new BufferedReader(
					new InputStreamReader(conn.getInputStream()));
			String inputLine;

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			wr.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response.toString();
	}

}
