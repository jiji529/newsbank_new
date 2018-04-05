/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : ServiceBase.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 10. 12. 오전 11:06:12
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 10. 12.     JEON,HYUNGGUK		최초작성
 * 2017. 10. 12.     
 *******************************************************************************/

package com.dahami.newsbank.web.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.xml.DOMConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class ServiceBase implements IService {
	protected Logger logger;
	private static boolean loggerConfInitF;
	
	public ServiceBase() {
		if(!loggerConfInitF) {
			DOMConfigurator.configure(this.getClass().getClassLoader().getResource("com/dahami/newsbank/web/conf/log4j.xml"));
			loggerConfInitF = true;
		}
		logger = LoggerFactory.getLogger(this.getClass());
	}
	
	protected void forward(HttpServletRequest request, HttpServletResponse response, String forward) throws ServletException, IOException {
		if(forward != null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
			dispatcher.forward(request, response);
		}
	}
}
