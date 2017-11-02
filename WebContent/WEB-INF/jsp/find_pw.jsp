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
<title>뉴스뱅크 비밀번호 찾기</title>
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
			<h3 class="tit_join">비밀번호 찾기</h3>
			<div class="txt_desc">비밀번호를 찾고자 하는 아이디를 입력해 주세요.<br />다음단계를 클릭하면 휴대폰 본인확인 팝업이 뜹니다.</div>
		</div>
		<form id="join1">
			<fieldset class="fld_comm">
				<legend class="blind">비밀번호 찾기</legend>
				<div class="wrap_info">
					<div class="box_info">
						<dl class="item_info">
							<dt> 아이디</dt>
							<dd>
								<div class="inp">
									<input type="text" maxlength="15" placeholder="아이디">
								</div>
							</dd>
						</dl>
					</div>
				</div>
			</fieldset>
			<div class="wrap_btn2">
				<a href="https://www.bizsiren.com/nameServiceIntro.do" target="_blank" class="btn_agree">다음</a>
			</div>
			<p class="find_link">아이디를 모르시나요? <a href="/id.find">아이디 찾기</a></p>
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