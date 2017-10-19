<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 10. 19.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 19.   	  tealight        file_name
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<link rel="stylesheet" href="css/join.css" />
</head>
<body>
<div class="wrap">
	<header>
		<h1><a href="#" class="logo">뉴스뱅크</a></h1>
	</header>
	<section class="join">
		<ul class="navi">
			<li class="selected" >종류 선택</li>
			<li  class="">약관 동의</li>
			<li>정보 입력</li>
			<li>가입 완료</li>
		</ul>
		<div class="wrap_tit">
			<h3 class="tit_join">회원 종류 선택</h3>
			<div class="txt_desc">다음 가입 방법 중 하나를 <b>선택</b>해 주세요. </div>
		</div>
		<ul class="join_choice">
			<li class="join1"><a href="/terms.join">개인회원</a></li>
			<li class="join2"><a href="/terms.join">기업회원</a></li>
			<li class="join3"><a href="/terms.join">언론사회원</a></li>
		</ul>
	</section>
	<footer>
		<ul>
			<li><a href="#">뉴스뱅크 소개</a></li>
			<li class="bar"></li>
			<li><a href="#">이용약관</a></li>
			<li class="bar"></li>
			<li><a href="#">개인정보처리방침</a></li>
		</ul>
		<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
	</footer>
</div>
</body>
</html>
