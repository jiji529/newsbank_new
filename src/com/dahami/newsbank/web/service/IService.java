/*******************************************************************************
 * Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * @fileName : IService.java
 * @author   : JEON,HYUNGGUK
 * @date     : 2018. 4. 5. 오전 8:48:16
 * @comment   : 
 *
 * @revision history
 * date            author         comment
 * ----------      ---------      ----------------------------------------------
 * 2018. 4. 5.     JEON,HYUNGGUK		최초작성
 * 2018. 4. 5.     
 *******************************************************************************/

package com.dahami.newsbank.web.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface IService {
	public void execute(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException;
}
