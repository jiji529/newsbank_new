<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 10. 17. 오전 10:48:12
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 17.   hoyadev        view.cms
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>뉴스뱅크</title>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/jquery-1.12.4.min.js"></script>

<script src="js/cms.js.jsp"></script>
<script src="js/cms_view.js.jsp"></script>
<script src="js/search.js.jsp"></script>

<script src="js/filter.js"></script>
<script src="js/footer.js"></script>

<script>
var searchTarget = "cms.search";
</script>
</head>
<body> 
<div class="wrap">
	<%@include file="header.jsp" %>
	<section class="mypage">
		<div class="head">
			<h2>마이페이지</h2>
			<p>설명어쩌고저쩌고</p>
		</div>
		<div class="mypage_ul">
			<ul class="mp_tab1">
				<li><a href="/accountlist.mypage">정산 관리</a></li>
				<li class="on"><a href="/cms">사진 관리</a></li>
				<li><a href="/info.mypage">회원정보 관리</a></li>
				<li><a href="/dibs.myPage">찜관리</a></li>
				<li><a href="/cart.myPage">장바구니</a></li>
				<li><a href="/buylist.mypage">구매내역</a></li>
			</ul>
		</div>
<%@include file="cms_content.jsp" %>
		</section>
<%@include file="footer.jsp"%>
</div>
</body>
</html>
