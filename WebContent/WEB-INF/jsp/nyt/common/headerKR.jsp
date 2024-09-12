<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="URL" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<nav class="gnb_dark">
	<div class="gnb"><a href="/" class="nyt">뉴욕타임스</a><span class="by">X</span>
	   <a href="https://www.newsbank.co.kr/" target="_blank" class="logo">뉴스뱅크</a>
	    <ul class="gnb_left">
	        <li><a href="/photo">아카이브</a></li>
	    </ul>
	    <ul class="gnb_right">
	        <li><a href="/price.info">이용안내</a></li>
			<c:choose>
				<c:when test="${empty MemberInfo}">
			        <li><a href="/login">로그인</a></li>
			        <li><a href="/kind.join">가입하기</a></li>
				</c:when>
				<c:otherwise>
					<li>
						<a href="/out.login">로그아웃</a>
					</li>
					
					<c:choose>
						<c:when test="${(MemberInfo.type eq 'M' || MemberInfo.type eq 'Q') && MemberInfo.admission eq 'Y'}">
							<li>
								<a href="/cms">마이페이지</a>
							</li>
						</c:when>
						
						<c:when test="${MemberInfo.type eq 'W' && MemberInfo.admission eq 'Y'}">
							<li>
								<a href="/accountlist.mypage">마이페이지</a>
							</li>
						</c:when>
						
						<c:otherwise>
							<li>
								<a href="/info.mypage">마이페이지</a>
							</li>
						</c:otherwise>
					</c:choose>
					
					<!-- <li>
						<a href="/info.mypage">마이페이지</a>
					</li> -->
					<c:if test="${MemberInfo.type == 'A'}">
						<li class="go_admin">
							<a href="/member.manage">관리자페이지</a>
						</li>
					</c:if>					
				</c:otherwise>
			</c:choose>					
	    </ul>
	</div>
	
	<c:if test='${URL=="/" || URL=="/index.jsp" || URL=="/price.info" || URL=="/FAQ" || URL=="/contact"}'>
		<div class="lang">
		    <a href="javascript:void(0)">언어</a>
		    <ul>
		        <li class="on" onclick="languageChange('KR')">KR</li>
		        <li class="" onclick="languageChange('EN')">EN</li>
		    </ul>
		</div>		
	</c:if>
</nav>