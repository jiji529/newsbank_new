<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 10. 16. 오후 16:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 16.   hoyadev        cms
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>NYT 뉴스뱅크</title>

<link rel="stylesheet" href="css/nyt/jquery-ui-1.12.1.min.css" />
<link rel="stylesheet" href="css/nyt/base.css" />
<link rel="stylesheet" href="css/nyt/sub.css" />
<link rel="stylesheet" href="css/nyt/mypage.css" />

<script src="js/nyt/jquery-1.12.4.min.js"></script>
<script src="js/nyt/jquery-ui-1.12.1.min.js"></script>

<script src="js/nyt/cms_list.js.jsp"></script>
<script src="js/nyt/cms.js.jsp"></script>
<script src="js/nyt/search.js.jsp"></script>

<script src="js/nyt/filter.js"></script>
<script src="js/nyt/footer.js"></script>
<script src="js/nyt/mypage.js"></script>
<script type="text/javascript">
	var searchTarget = "cms.search";

	$(window).load(function() {
		search();
	});
	
</script>
</head>
<body> 
<div class="wrap">
	<%@include file="common/headerKR2.jsp" %>
	<section class="mypage">
		<div class="head">
			<h2>마이페이지</h2>
			<p>설명어쩌고저쩌고</p>
		</div>
		<div class="mypage_ul">
			<ul class="mp_tab1">
				<c:if test="${MemberInfo.type eq 'M' && MemberInfo.admission eq 'Y'}">
					<li>
						<a href="/accountlist.mypage">정산 관리</a>
					</li>
					<li class="on">
						<a href="/cms">사진 관리</a>
					</li>
				</c:if>
				
				<c:if test="${MemberInfo.type eq 'Q' && MemberInfo.admission eq 'Y'}">
					<li class="on">
						<a href="/cms">사진 관리</a>
					</li>
				</c:if>
				
				<c:if test="${MemberInfo.type eq 'W' && MemberInfo.admission eq 'Y'}">
					<li class="on">
						<a href="/accountlist.mypage">정산 관리</a>
					</li>
				</c:if>
				
				<li>
					<a href="/info.mypage">회원정보 관리</a>
				</li>
				<li>
					<a href="/dibs.myPage">찜관리</a>
				</li>
				<c:if test="${MemberInfo.deferred eq 2}">
					<li>
						<a href="/download.mypage">다운로드 내역</a>
					</li>
					<li>
						<a href="/postBuylist.mypage">구매내역</a>
					</li>
				</c:if>
				<c:if test="${MemberInfo.deferred eq 0}">
					<li>
						<a href="/cart.myPage">장바구니</a>
					</li>
					<li>
						<a href="/buylist.mypage">구매내역</a>
					</li>
				</c:if>
			</ul>
		</div>
<%@include file="cms_list.jsp" %>
	</section>
<%@include file="common/footerKR.jsp"%>
</div>
</body>
</html>