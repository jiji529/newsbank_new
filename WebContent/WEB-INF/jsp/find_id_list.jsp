<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 11. 1.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 1.   	  tealight        file_name
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크 아이디 찾기</title>
<link rel="stylesheet" href="css/join.css" />
</head>
<body>
<div class="wrap">
	<header>
		<a href="/home" class="logo">
			<h1>뉴스뱅크</h1>
		</a>
	</header>
	<section class="join">
		<div class="wrap_tit">
			<h3 class="tit_join">아이디 찾기</h3>
			<div class="txt_desc">고객님의 정보와 일치하는 아이디 목록입니다.</div>
		</div>
		<form id="join1">
			<div class="id_box">
				<ul class="id_list">
					<li><strong>
						<input type="radio" id="id1" name="id" />
						<label for="id1">nb_personal</label>
						</strong><span>가입일 2017.05.01</span></li>
					<li><strong>
						<input type="radio" id="id2" name="id" />
						<label for="id2">nb_company</label>
						</strong><span>가입일 2017.03.31</span></li>
				</ul>
			</div>
			<div class="wrap_btn2">
				<button type="button" class="btn_agree" onClick="top.location.href='/login'">로그인하기</button>
				<button type="button" class="btn_cancel" onClick="top.location.href='/pw.find'">비밀번호 찾기</button>
			</div>
		</form>
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