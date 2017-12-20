/*******************************************************************************
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : CmdClass.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2017. 12. 20. 오후 3:51:40
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 12. 20.     JEON,HYUNGGUK		최초작성
 * 2017. 12. 20.     
 *******************************************************************************/

package com.dahami.newsbank.web.servlet.bean;

import java.lang.invoke.MethodHandles;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.xml.DOMConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CmdClass {
	private static Logger logger;
	
	static {
		DOMConfigurator.configure(MethodHandles.lookup().lookupClass().getClassLoader().getResource("com/dahami/newsbank/web/conf/log4j.xml"));
		logger = LoggerFactory.getLogger(MethodHandles.lookup().lookupClass());
	}
	
	private boolean invalid;
	private String cmd1;
	private String cmd2;
	private String cmd3;
	
	public static CmdClass getInstance(HttpServletRequest request) {
		CmdClass ret = new CmdClass();
		String reqUri = request.getRequestURI().substring(request.getContextPath().length()+1);
		if(reqUri.indexOf("/") != -1) {
			logger.warn("Invalid Request: " + reqUri);
			ret.invalid = true;
		}
		else {
			String[] cmds = reqUri.split("\\.");	
			if(cmds.length == 1) {
				ret.cmd1 = cmds[0];
			}
			else if(cmds.length == 2) {
				ret.cmd1 = cmds[1];
				ret.cmd2 = cmds[0];	
			}
			else if(cmds.length == 3) {
				ret.cmd1 = cmds[2];
				ret.cmd2 = cmds[1];
				ret.cmd3 = cmds[0];
			}
			else {
				logger.warn("Invalid Request(LONG): " + reqUri);
				ret.invalid = true;
			}
		}
		logger.debug("REQ: " + reqUri);
		return ret;
	}
	
	public boolean isInvalid() {
		return invalid;
	}
	
	public boolean is1(String cmd) {
		return is(cmd2, cmd);
	}
	
	public boolean is2(String cmd) {
		return is(cmd2, cmd);
	}
	
	public boolean is3(String cmd) {
		return is(cmd2, cmd);
	}
	
	private  boolean is(String cmd, String tgtCmd) {
		if(cmd != null && cmd.equals(tgtCmd)) {
			return true;
		}
		return false;
	}
	
	public String get1() {
		return cmd1;
	}
	
	public String get2() {
		return cmd2;
	}
	
	public String get3() {
		return cmd3;
	}
}
