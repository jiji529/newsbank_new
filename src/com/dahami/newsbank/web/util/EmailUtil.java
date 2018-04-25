package com.dahami.newsbank.web.util;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {
	private static final String SMTP_HOST = "mail.dahami.com";
	private static final String SMTP_PORT = "25";
	private static final String SMTP_HOST_ID = "newsbank@dahami.com";
	private static final String SMTP_HOST_PW = "ekgkal$4174%p]";
	
	public void sendMail(String title, StringBuffer content, String receiverEmail){
		List<String> receiverEmailList = Arrays.asList(receiverEmail);
		sendMail(title,content, null, receiverEmailList);
	}
	
	public void sendMail(String title, StringBuffer content, List<String> receiverEmailList){
		sendMail(title,content, null, receiverEmailList);
	}
	
	private void sendMail(String title, StringBuffer content, String senderEmail, List<String> receiverEmailList) {
		// properties object 얻기
		Properties props = System.getProperties();
		// SMTP host property 정의
		props.put("mail.smtp.host", SMTP_HOST);
		props.put("mail.smtp.port", SMTP_PORT);
		props.put("mail.smtp.auth", "true");
		
		try {
			// session 얻기
			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(
	                   SMTP_HOST_ID, SMTP_HOST_PW);
	             }
	          });
			
			// 새로운 message object 생성
			MimeMessage message = new MimeMessage(session);
			
			//보내는 사람 
			if(senderEmail == null){
				senderEmail = "newsbank@dahami.com";
			}
			
			//받는사람
			Address[] addTo = null;
			boolean correctRequest = true;
			if(receiverEmailList.size() > 0){
				addTo = new Address[receiverEmailList.size()];
				for(int i=0; i<receiverEmailList.size(); i++){
					addTo[i] = new InternetAddress(receiverEmailList.get(i)); 
				}
			}else{
				correctRequest = false;
			}
			
			// 일반적인 message object 채우기
			message.setText(content.toString());
			message.setSubject(title);
			
			message.setFrom(new InternetAddress(senderEmail));
			
			message.addRecipients(Message.RecipientType.TO, addTo);
			System.out.println("Message Sent");
			// message 보내기
			if(correctRequest){ //옳바른 요청인지 확인하고 보낸다.
				Transport.send(message);
			}
		}
		catch (MessagingException me) {
			System.err.println(me.getMessage());
		}
	}
}
