package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.lang.invoke.MethodHandles;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.xml.DOMConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.dahami.newsbank.web.dto.MemberDTO;


public abstract class NewsbankServletBase extends HttpServlet {
	
//	public static final String IMG_SERVER_URL_PREFIX = "http://www.dev.newsbank.co.kr";
	public static final String IMG_SERVER_URL_PREFIX = "";
	
	private static final long serialVersionUID = 4745659834372195390L;
	protected Logger logger;
	
	private boolean loggerConfInitF;
	
    public NewsbankServletBase() {
        super();
    }

	public void init(ServletConfig config) throws ServletException {
		if(!loggerConfInitF) {
			DOMConfigurator.configure(MethodHandles.lookup().lookupClass().getClassLoader().getResource("com/dahami/newsbank/web/conf/log4j.xml"));
			loggerConfInitF = true;
		}
		logger = LoggerFactory.getLogger(MethodHandles.lookup().lookupClass());
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setAttribute("loginInfo",(MemberDTO) session.getAttribute("MemberInfo"));
		request.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.addHeader("Cache-Control", "no-cache");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	/**
	 * @methodName  : getParam
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 10. 30. 오후 2:49:33
	 * @methodCommet: 특정 파라메터 읽어오기 (값이 1개인 경우만 가능 / 여러개인 경우 첫번째것만) / 없으면 공백 리턴
	 * @param params
	 * @param pName
	 * @return 
	 * @returnType  : String
	 */
	protected String getParam(Map<String, String[]> params, String pName) {
		try {
			return params.get(pName)[0];
		}catch(Exception e) {
			return "";
		}
	}
	
	protected void processNotAdminAccess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("ErrorMSG", "해당페이지는 관리자만 접근할 수 있습니다.\\n 메인페이지로 이동합니다.");
		RequestDispatcher dispatcher = request.getRequestDispatcher("/home");
		dispatcher.forward(request, response);
	}
	
	protected void processNotLoginAccess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("ErrorMSG", "해당페이지는 로그인 하여야 접근할 수 있습니다.\\n메인 페이지로 이동합니다.");
		RequestDispatcher dispatcher = request.getRequestDispatcher("/login");
		dispatcher.forward(request, response);
	}
}
