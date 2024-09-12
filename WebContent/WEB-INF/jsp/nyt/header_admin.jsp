<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%
String errMsg = (String)request.getAttribute("ErrorMSG");
if(errMsg != null && errMsg.length() > 0) {
%>
<script>
	alert("<%=errMsg%>");
</script>
<%
}
%>

<nav class="gnb_dark">
	<div class="gnb">
	   	<a href="/member.manage">
			<a href="/member.manage" class="nyt" style="line-height: 50px;">뉴욕타임스</a>
			<span class="by" style="line-height: 50px;">X</span>
			<a href="/member.manage" class="logo">관리자페이지</a>			   		
	   	</a>
		<a href="/" target="_blank" class="link">뉴스뱅크 이동</a>
		<ul class="gnb_right">
			<c:choose>
				<c:when test="${empty MemberInfo}">
					<li>
						<a href="/login">로그인</a>
					</li>
				</c:when>
				<c:otherwise>
					<li>
						<a href="/out.login">로그아웃</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</nav>

<%--프로그레시브 바 --%>
<div id="searchProgress" class="progress">
	<div id="searchProgressImg" class="loader"></div>
</div>

<%-- TOP으로 이동 버튼 --%>
<div id="top"><a href="#">TOP</a></div>