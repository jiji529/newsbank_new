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
			<li class="" >종류 선택</li>
			<li>약관 동의</li>
			<li>정보 입력</li>
			<li class="selected">가입 완료</li>
		</ul>
		<div class="wrap_tit">
			<h3 class="tit_join">뉴스뱅크 회원이 되신것을 환영합니다.</h3>
		</div>
			<div class="wrap_btn">
				<button type="button" class="btn_agree" onClick="top.location.href='/login'">뉴스뱅크 이용하기</button>
			</div>
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
