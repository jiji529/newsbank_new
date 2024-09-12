<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<nav class="gnb_dark">
	<div class="gnb"><a href="/" class="nyt">The New York Times</a><span class="by">X</span>
	   <a href="https://www.newsbank.co.kr/" target="_blank" class="logo">NewsBank</a>
	    <ul class="gnb_left">
	        <li><a href="/photo">Archive</a></li>
	    </ul>
	    <ul class="gnb_right">
	        <li><a href="/price.info">User Guide</a></li>
			<c:choose>
				<c:when test="${empty MemberInfo}">
					<li><a href="/login">Log In</a></li>
			        <li><a href="/kind.join">create an account</a></li>				
				</c:when>
				<c:otherwise>
					<li>
						<a href="/out.login">logout</a>
					</li>
					
					<c:choose>
						<c:when test="${(MemberInfo.type eq 'M' || MemberInfo.type eq 'Q') && MemberInfo.admission eq 'Y'}">
							<li>
								<a href="/cms">mypage</a>
							</li>
						</c:when>
						
						<c:when test="${MemberInfo.type eq 'W' && MemberInfo.admission eq 'Y'}">
							<li>
								<a href="/accountlist.mypage">mypage</a>
							</li>
						</c:when>
						
						<c:otherwise>
							<li>
								<a href="/info.mypage">mypage</a>
							</li>
						</c:otherwise>
					</c:choose>
					
					<!-- <li>
						<a href="/info.mypage">마이페이지</a>
					</li> -->
					<c:if test="${MemberInfo.type == 'A'}">
						<li class="go_admin">
							<a href="/member.manage">adminpage</a>
						</li>
					</c:if>					
				</c:otherwise>
			</c:choose>					        	        
	    </ul>
	</div>
	
	<div class="lang">
	    <a href="javascript:void(0)">Language</a>
	    <ul>
	        <li class="" onclick="languageChange('KR')">KR</li>
	        <li class="on" onclick="languageChange('EN')">EN</li>
	    </ul>
	</div>		
</nav>