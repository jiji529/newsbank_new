<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<nav class="gnb_dark">
	<div class="gnb"><a href="/cms.manage" class="logo">관리자페이지</a><a href="/home" target="_blank" class="link">뉴스뱅크 이동</a>
		<ul class="gnb_right">
			<c:choose>
				<c:when test="${empty MemberInfo}">
					<li>
						<a href="/login">로그인</a>
					</li>
				</c:when>
				<c:otherwise>
					<li>
						<a href="/logout">로그아웃</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</nav>