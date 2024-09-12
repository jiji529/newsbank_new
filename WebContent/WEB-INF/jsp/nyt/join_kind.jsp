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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="common/head_meta.jsp"/>
<title>NYT 뉴스뱅크</title>
<script src="js/nyt/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="css/nyt/base.css" />
<link rel="stylesheet" href="css/nyt/join.css" />
<script src="js/nyt/join.js"></script>
</head>
<body>
	<div class="wrap">
		<header> 
		<nav class="gnb_dark">
				<div class="gnb" style="display:flex; justify-content:center; padding: 0;">
					<a href="/" class="nyt">뉴욕타임스</a><span class="by">X</span>
			   		<a href="https://www.newsbank.co.kr/" target="_blank" class="logo">뉴스뱅크</a>
			   	</div>
		   	</nav> 
		</header>
		<section class="join">
		<ul class="navi">
			<li class="selected">종류 선택</li>
			<li class="">약관 동의</li>
			<li>정보 입력</li>
			<li>가입 완료</li>
		</ul>
		<div class="wrap_tit">
			<h3 class="tit_join">회원 종류 선택</h3>
			<div class="txt_desc">
				다음 가입 방법 중 하나를
				<b>선택</b>
				해 주세요.
			</div>
		</div>
		<ul class="join_choice">
			<li class="join1">
				<form>
					<input type="hidden" name="type" value="P" />
					<a href="javascript:void(0)">개인회원</a>
				</form>
			</li>
			<li class="join2">
				<form>
					<input type="hidden" name="type" value="C" />
					<a href="javascript:void(0)">기업회원</a>
				</form>
			</li>
<!-- 			<li class="join3"> -->
<!-- 				<form> -->
<!-- 					<input type="hidden" name="type" value="M" /> -->
<!-- 					<a href="javascript:void(0)">언론사회원</a> -->
<!-- 				</form> -->
<!-- 			</li> -->
		</ul>
		</section>
		<footer>
		<ul>
				<li>
					<a target="_blank" href="/policy.intro">이용약관</a>
				</li>
				<li class="bar"></li>
				<li>
					<a target="_blank" href="/privacy.intro">개인정보처리방침</a>
				</li>
			</ul>
		<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
		</footer>
	</div>
</body>
</html>
