<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 11. 3.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 3.   	  tealight        file_name
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크 비밀번호 찾기</title>
<link rel="stylesheet" href="css/join.css" />
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script type="text/javascript" src="js/find.js"></script>
</head>
<body>
<div class="wrap">
	<header>
		<h1><a href="#" class="logo">뉴스뱅크</a></h1>
	</header>
	<section class="join">
		<div class="wrap_tit">
			<h3 class="tit_join">비밀번호 찾기</h3>
			<div class="txt_desc">새 비밀번호를 입력해주세요.</div>
		</div>
		<form id="frmChangePw">
			<fieldset class="fld_comm">
				<legend class="blind">비밀번호 찾기</legend>
				<div class="wrap_info">
					<div class="box_info">
					<div class="id_area">뉴스뱅크 아이디: <font class="color">dahami</font></div>
						<dl class="item_info">
							<dt> 새 비밀번호 </dt>
							<dd>
								<div class="inp">
									<input type="password" maxlength="16" placeholder="비밀번호 (6~16자의 영문 대소문자, 숫자, 특수문자를 조합)">
								</div>
								<p class="txt_message" style="display:none;">일반적인 단어는 추측하기 쉽습니다. 다시 만드시겠어요?</p>
							</dd>
						</dl>
						<dl class="item_info">
							<dt> 비밀번호 재확인 </dt>
							<dd>
								<div class="inp">
									<input type="password" class="inp_info" maxlength="15" placeholder="비밀번호 재확인">
								</div>
								<p class="txt_message" style="display:none;">비밀번호가 일치하지 않습니다.</p>
							</dd>
						</dl>
					</div>
				</div>
			</fieldset>
			<div class="wrap_btn2">
				<a href="login.html" class="btn_agree">확인</a>
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