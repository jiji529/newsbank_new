<%---------------------------------------------------------------------------
  Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2018. 4. 4. 오후 1:58:59
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2018. 4. 4.     
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// CMS / 관리자 페이지에 따라 뷰화면 타겟을 달리 함
String manage = "";
String cms = ".cms";
String reqUri = request.getRequestURI();
if(reqUri.startsWith("/WEB-INF/jsp/admin_")) {
	manage += ".manage";
}
else if(reqUri.contains("photo")) {
	cms = ".photo";
}
%>

<script>
function go_View(uciCode) {
	view_form.uciCode.value = uciCode;
	view_form.submit();
}
</script>

<form class="view_form" method="post" action="/view<%=cms %><%=manage %>" name="view_form" >
	<input type="hidden" name="uciCode"  />
	<input type="hidden" id="manage" value="<%=manage%>" />
	<input type="hidden" name="keyword" value="${sParam.keyword}"/>
	<input type="hidden" name="pageNo"  value="${sParam.pageNo}"/>
	<input type="hidden" name="pageVol" value="${sParam.pageVol}"/>
	<input type="hidden" name="media"  value="${sParam.media}"/>
	<input type="hidden" name="durationReg"  value="${sParam.durationReg}"/>
	<input type="hidden" name="durationTake"  value="${sParam.durationTake}"/>
	<input type="hidden" name="horiVertChoice"  value="${sParam.horiVertChoice}"/>
	<input type="hidden" name="size"  value="${sParam.size}"/>
	<input type="hidden" name="colorMode"  value="${sParam.colorMode}"/>
	<input type="hidden" name="saleState"  value="${sParam.saleState}"/>
</form>