<%---------------------------------------------------------------------------
  Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2018. 4. 4. 오후 12:18:02
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2018. 4. 4.     
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form id="downForm" method="post"  target="downFrame">
	<input type="hidden" id="downUciCode" name="uciCode" />
	<input type="hidden" id="downType" name="type" />
	<input type="hidden" name="dummy" value="<%=com.dahami.common.util.RandomStringGenerator.next()%>" />
	<input type="hidden" id="group_seq" name="group_seq" value="${memberInfo.group_seq}" />
</form>
<iframe id="downFrame" name="downFrame" style="display:none"></iframe>