<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 10. 16.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 16.   	  tealight        file_name
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/common.js"></script>
<script src="js/footer.js"></script>
</head>
<body>
	<div class="wrap">
		<nav class="gnb_dark">
		<div class="gnb">
			<a href="/home" class="logo"></a>
			<ul class="gnb_left">
				<li class=""><a href="/picture">보도사진</a></li>
				<li><a href="#">뮤지엄</a></li>
				<li><a href="#">사진</a></li>
				<li><a href="#">컬렉션</a></li>
			</ul>
			<ul class="gnb_right">
				<li><a href="#">로그인</a></li>
				<li><a href="#">가입하기</a></li>
			</ul>
		</div>
		<div class="gnb_srch">
			<form id="searchform">
				<input type="text" value="검색어를 입력하세요" /> <a href="#"
					class="btn_search">검색</a>
			</form>
		</div>
		</nav>
		<section class="mypage">
		<div class="head">
			<h2>마이페이지</h2>
		</div>
		<div class="table_head">
			<h3>비밀번호 확인</h3>
			<p class="txt">회원님의 안전한 개인 정보 보호를 위해 비밀번호를 다시 한 번 입력해주세요.</p>
		</div>
		<div class="pw">
			<div class="pw_box">
				<input type="password" placeholder="비밀번호를 입력해주세요." />
				<button>확인</button>
			</div>
			<div class="guide">
				비밀번호 찾기를 원하시나요? <a href="invalidPage.jsp" id="mypage_password_lost">바로가기</a>
			</div>
		</div>
		</section>
	</div>
</body>
</html>
