/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : DAOBase.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 10. 12. 오전 11:02:45
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 10. 12.     JEON,HYUNGGUK		최초작성
 * 2017. 10. 12.     
 *******************************************************************************/

package com.dahami.newsbank.web.dao;

import java.lang.invoke.MethodHandles;

import org.apache.log4j.xml.DOMConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.dahami.common.mybatis.MybatisSessionFactory;
import com.dahami.common.mybatis.impl.MybatisService;

public abstract class DAOBase {
	protected Logger logger;
	private static boolean loggerConfInitF;
	
	protected static MybatisSessionFactory sf;
	
	static {
		String confBase = "com/dahami/newsbank/web/dao/mybatis/conf";
		MybatisService mybatis = new MybatisService(confBase);
		mybatis.activate();
		sf = mybatis.getMybatisServiceSessionFactory(MethodHandles.lookup().lookupClass(), "service");
	}
	
	public DAOBase() {
		if(!loggerConfInitF) {
			DOMConfigurator.configure(this.getClass().getClassLoader().getResource("com/dahami/newsbank/web/conf/log4j.xml"));
			loggerConfInitF = true;
		}
		logger = LoggerFactory.getLogger(this.getClass());
	}
}
