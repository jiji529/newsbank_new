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
<script type="text/javascript" src="js/find.js"></script>
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
			<div class="txt_desc">내 명의(주민등록번호)로 가입한 아이디를 찾을 수 있습니다.</div>
		</div>
		<form id="join1">
			<fieldset class="fld_comm">
				<legend class="blind">아이디 찾기</legend>
				<div class="wrap_info">
					<div class="box_info">
						<dl class="item_info">
							<dt> 이름 </dt>
							<dd>
								<div class="inp">
									<input type="text" maxlength="15" placeholder="이름">
								</div>
							</dd>
						</dl>
						<dl class="item_info">
							<dt> 휴대폰 번호 </dt>
							<dd class="btn_inp">
								<div class="inp">
									<input type="number" placeholder="휴대폰 번호">
									<button type="button">인증</button>
								</div>
							</dd>
							<dd class="btn_inp">
								<div class="inp">
									<input type="text" placeholder="인증번호">
									<button type="button">확인</button>
								</div>
							</dd>
						</dl>
					</div>
				</div>
			</fieldset>
			<div class="wrap_btn2">
				<button type="button" class="btn_agree" >다음</button>
			</div>
			<p class="find_link">비밀번호를 찾으시나요? <a href="/pw.find">비밀번호 찾기</a></p>
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
