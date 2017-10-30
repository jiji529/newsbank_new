package com.dahami.newsbank.web.servlet;

import java.io.IOException;
import java.lang.invoke.MethodHandles;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.xml.DOMConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public abstract class NewsbankServletBase extends HttpServlet {
	private static final long serialVersionUID = 4745659834372195390L;
	protected Logger logger;
	
	protected boolean closed;
	private boolean loggerConfInitF;
	
	protected String cmd1;
	protected String cmd2;
	protected String cmd3;
	
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected Map<String, String[]> params;
	
    public NewsbankServletBase() {
        super();
    }

	public void init(ServletConfig config) throws ServletException {
		if(!loggerConfInitF) {
			DOMConfigurator.configure(MethodHandles.lookup().lookupClass().getClassLoader().getResource("com/dahami/newsbank/web/conf/log4j.xml"));
			loggerConfInitF = true;
		}
		logger = LoggerFactory.getLogger(this.getClass());
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.request = request;
		this.response = response;
		params = request.getParameterMap();
		
		String reqUri = request.getRequestURI().substring(request.getContextPath().length()+1);
		if(reqUri.indexOf("/") != -1) {
			logger.warn("Invalid Request: " + reqUri);
			response.sendRedirect("/invalidPage.jsp");
			closed = true;
			return;
		}
		
		String[] cmds = reqUri.split("\\.");	
		if(cmds.length == 1) {
			cmd1 = cmds[0];
		}
		else if(cmds.length == 2) {
			cmd1 = cmds[1];
			cmd2 = cmds[0];	
		}
		else if(cmds.length == 3) {
			cmd1 = cmds[2];
			cmd2 = cmds[1];
			cmd3 = cmds[0];
		}
		else {
			logger.warn("Invalid Request(LONG): " + reqUri);
			response.sendRedirect("/invlidPage.jsp");
			closed = true;
			return;
		}
		logger.debug("REQ: " + reqUri);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	/**
	 * @methodName  : getParam
	 * @author      : JEON,HYUNGGUK
	 * @date        : 2017. 10. 30. 오후 2:49:33
	 * @methodCommet: 특정 파라메터 읽어오기 (값이 1개인 경우만 가능 / 여러개인 경우 첫번째것만) / 없으면 공백 리턴
	 * @param pName
	 * @return 
	 * @returnType  : String
	 */
	protected String getParam(String pName) {
		try {
			return this.params.get(pName)[0];
		}catch(Exception e) {
			return "";
		}
	}
	
}
