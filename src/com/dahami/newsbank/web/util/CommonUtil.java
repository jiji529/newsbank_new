/**
 * <%---------------------------------------------------------------------------
 * Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @Package Name   : com.dahami.newsbank.web.util
 * @fileName : CommonUtil.java
 * @author   : CHOI, SEONG HYEON
 * @date     : 2017. 11. 23.
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2017. 11. 23.   	  tealight        CommonUtil.java
 *--------------------------------------------------------------------------%>
 */
package com.dahami.newsbank.web.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.xml.bind.DatatypeConverter;

/**
 * @author p153-1706
 *
 */
public class CommonUtil {

	
	public static String sha1(String input) {
	    String sha1 = null;
	    try {
	        MessageDigest msdDigest = MessageDigest.getInstance("SHA-1");
	        msdDigest.update(input.getBytes("UTF-8"), 0, input.length());
	        sha1 = DatatypeConverter.printHexBinary(msdDigest.digest());
	    } catch (UnsupportedEncodingException | NoSuchAlgorithmException e) {
	    	e.printStackTrace();
	    }
	    return sha1;
	}
}
