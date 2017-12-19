package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Servlet implementation class SendEmail
 */
@WebServlet("/SendEmail")
public class SendEmail extends NewsbankServletBase {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see NewsbankServletBase#NewsbankServletBase()
     */
    public SendEmail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		HttpSession httpSession = request.getSession();
		
		boolean success = false;
		String success_msg = "전송 오류";
		
		final String username = "hello@dahami.com";
		final String password = "p%gpfhdn$4174";

		String tmpName = request.getParameter("name");
		String TmpPhone = request.getParameter("phone");
		String TmpEmail = request.getParameter("email");
		String TmpTitle = "[뉴스뱅크]" + request.getParameter("title");
		String TmpContents = request.getParameter("contents");
		
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "mail.dahami.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props,
		    new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });
		
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(TmpEmail));
			message.setRecipients(Message.RecipientType.TO,
				//InternetAddress.parse("hoyadev@dahami.com"));
				InternetAddress.parse("helpdesk@dahami.com"));
			message.setSubject(TmpTitle);
			message.setText("작성자 : "+tmpName+"\n\n "+"연락처 : "+TmpPhone+"\n\n "+TmpContents);
			Transport.send(message);

			System.out.println("Mail Send Complete");
			success = true;
			success_msg = "메일 전송 완료";
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}		
		
		JSONObject json = new JSONObject();//json 정의
		json.put("success", success);
		json.put("message", success_msg);

		response.getWriter().print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
