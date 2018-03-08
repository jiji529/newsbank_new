<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<div class="lnb">
	<ul>
		<li><strong>회원관리</strong>
			<ul class="lnb_li2">
				<li><a href="/member.manage">회원 현황</a></li>
				<li><a href="/media.manage">정산 매체사 관리</a></li>
			</ul>
		</li>
		<li><strong>콘텐츠 관리</strong>
			<ul class="lnb_li2">
				<li><a href="/cms.manage">사진관리</a></li>
				<li><a href="/board.manage">공지사항</a></li>
				<li><a href="/popular.manage">인기사진 관리</a></li>
			</ul>
		</li>
		<li> <strong>판매 및 정산관리</strong>
			<ul class="lnb_li2">
				<li><a href="/offline.manage">오프라인 결제 관리</a></li>
				<li><a href="/online.manage">온라인 결제 관리</a></li>
				<li><a href="/sell.manage">정산 관리</a></li>
			</ul>
		</li>
	</ul>
</div>