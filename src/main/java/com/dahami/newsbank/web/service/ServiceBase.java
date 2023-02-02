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

import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class ServiceBase implements IService {
	protected Logger logger;
	
	public ServiceBase() {
		logger = LoggerFactory.getLogger(this.getClass());
	}
	
	protected void forward(HttpServletRequest request, HttpServletResponse response, String forward) throws ServletException, IOException {
		if(forward != null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
			dispatcher.forward(request, response);
		}
	}
	
	protected Map<String, String> makeSearchParamMap(Map<String, String[]> params) {
		Map<String, String> ret = new HashMap<String, String>();
		for(String key : params.keySet()) {
			try {
				ret.put(key, params.get(key)[0]);
			}catch(Exception e){}
		}
		return ret;
	}
}
