<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2018. 7. 05. 오전 10:11:00
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2018. 07. 05.   hoyadev        IE 브라우저 예외처리
   
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>뉴스뱅크</title>

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery.row-grid.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/main.css" />

<script src="js/footer.js"></script>
<script>
    $(document).ready(function(){
      /* Start rowGrid.js */
      $(".photo_cont").rowGrid({itemSelector: ".img_list", minMargin: 10, maxMargin: 25, firstItemClass: "first-item"});
    });
  </script>
</head>
<body>
<div class="wrap">
	<nav class="gnb_dark">
		<div class="gnb"><a href="/home" class="logo"></a>
			<ul class="gnb_left">
				<li><a href="#">보도사진</a></li>
				<!-- <li><a href="#">뮤지엄</a></li>
				<li><a href="#">사진</a></li>
				<li><a href="#">컬렉션</a></li> -->
			</ul>
			<ul class="gnb_right">
				<li><a href="#">로그인</a></li>
				<li><a href="#">가입하기</a></li>
				<!-- <li class="go_admin"><a href="admin1.html">관리자페이지</a></li> -->
			</ul>
		</div>
	</nav>
	<div class="main">
		<section class="html5">
		<div class="html5_ex"><b>뉴스뱅크는 HTML5 로 제작되었습니다.</b><br />
크롬, 파이어폭스, 익스플로러11 등 HTML5 표준 브라우저를 지원하며, <br />
보다 원활한 사용을 위해 <a href="https://www.google.com/chrome/">크롬 브라우저</a>를 권장합니다.</div>
			<ul class="browser">
				<li class="chrome"><a href="https://www.google.com/chrome/">구글 Chrome<br />다운로드</a></li>
				<li class="firefox"><a href="https://www.mozilla.org/ko/firefox/">Mozila Firefox<br />다운로드</a></li>
				<li class="ie"><a href="https://support.microsoft.com/ko-kr/help/17621/internet-explorer-downloads">Internet Explorer 11<br />다운로드</a></li>
			</ul>
		</section>
	</div>
	<footer>
		<div class="foot_wrap">
			<div class="foot_lt">(주)다하미커뮤니케이션즈 | 대표 박용립<br />
				서울시 중구 마른내로 140 5층 (쌍림동, 인쇄정보센터)<br />
				고객센터 02-593-4174 | 사업자등록번호 112-81-49789 <br />
				저작권대리중개신고번호 제532호<br />
				통신판매업신고번호 제2016-서울중구-0501호 (사업자정보확인)</div>
			<div class="foot_ct">
				<dl>
					<dt>서비스 소개</dt>
					<!--<dd><a href="#">뉴스뱅크 소개</a></dd>-->
					<dd><a href="#">UCI 소개</a></dd>
					<!--<dd><a href="#">저작권 안내</a></dd>-->
				</dl>
				<dl>
					<dt>이용안내</dt>
					<dd><a href="#">구매안내</a></dd>
					<dd><a href="#">공지사항</a></dd>
					<dd><a href="#">FAQ</a></dd>
					<dd><a href="#">직접 문의하기</a></dd>
					<!--<dd><a href="sitemap.html">사이트맵</a></dd>-->
				</dl>
				<dl>
					<dt>법적고지</dt>
					<dd><a href="#">이용약관</a></dd>
					<dd><b><a href="#">개인정보처리방침</a></b></dd>
				</dl>
			</div>
			<div class="foot_rt">
				<div id="family_site">
					<div id="select-title">Family site</div>
					<div id="select-layer" style="display: none;">
						<ul class="site-list">
							<li><a href="http://www.dahami.com/" target="_blank">다하미커뮤니케이션즈</a></li>
							<li><a href="http://scrapmaster.co.kr/" target="_blank">스크랩마스터</a></li>
							<li><a href="http://clippingon.co.kr/" target="_blank">클리핑온</a></li>
							<li><a href="http://www.t-paper.co.kr/" target="_blank">티페이퍼</a></li>
						</ul>
					</div>
				</div>
				<div class="foot_banner">
					<ul>
						<li class="uci"><a href="http://www.uci.or.kr/kor/file/main/main.jsp" target="_blank">국가표준 디지털콘텐츠<br />
							식별체계 등록기관 지정</a></li>
						<li class="cleansite"><a href="http://www.cleansite.org/" target="_blank">클린사이트<br />
							한국저작권보호원</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
	</footer>
	<div id="top"><a href="#">TOP</a></div>
</div>
</body>
</html>
