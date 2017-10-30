package com.dahami.newsbank.web.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

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
		HttpSession session = request.getSession();
		String tel = request.getParameter("tel"); // 전화번호
		String token = request.getParameter("token"); // 인증번호
		boolean success = false;
		String success_msg = "인증번호 오류";
		if (!tel.isEmpty()) {
			success_msg = "인증번호를 입력하신 휴대폰번호에 전송했습니다.";
			int certifyNumber = generateNumber(6); // 랜덤 생성

			if (certifyNumber > 0) {
				// 랜덤 생성
				session.setAttribute("certifyNumber", certifyNumber); // 랜덤 5자리
																		// 세션저장
				// session.removeAttribute("preDate");

				String sendMemo = "고객님의 인증번호는 [ " + certifyNumber + " ] 입니다.";

				String URL = "http://222.231.4.31/~voc_user/MMS_Send/mms_process_v2.php";
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("send_num", "025934174");
				param.put("receive_num", tel);
				param.put("send_title", "[뉴스뱅크]");
				param.put("send_memo", sendMemo);
				String result = URLPost(URL, param);
				if (result.equalsIgnoreCase("success")) {
					success = true;
				}
			}
		}
		if (!token.isEmpty()) {
			success_msg = "인증번호를 확인할 수 없습니다.";
			if (session.getAttribute("certifyNumber").equals(token)) {
				success = true;
				success_msg = "인증번호가 확인되었습니다.";
			}

		}

		JSONObject json = new JSONObject();
		json.put("success", success);
		json.put("message", success_msg);

		response.getWriter().print(json);
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
