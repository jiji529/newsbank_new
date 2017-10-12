<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
</head>
<body> 
<div class="wrap">
	<nav class="gnb_dark">
		<div class="gnb"><a href="#" class="logo"></a>
			<ul class="gnb_left">
				<li class="on"><a href="/picture">보도사진</a></li>
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
				<input type="text" value="검색어를 입력하세요" />
				<a href="#" class="btn_search">검색</a>
			</form>
		</div>
	</nav>
	<section class="view">
		<div class="view_lt">
			<div class="navi"></div>
			<h2 class="media_logo"><img src="images/view/logo.gif" alt="뉴시스" /></h2>
			<div class="img_area"><img src="images/n2/${photoDTO.compCode}.jpg" style="width:50%; height:50%"/>
				<div class="cont_area">
					<h3 class="img_tit"><span class="uci">${photoDTO.uciCode}</span> ${photoDTO.titleKor}</h3>
					<a href="#" class="btn_wish">찜하기</a>
					<p class="img_cont">${photoDTO.descriptionKor}</p>
				</div>
				<div class="img_info_area">
					<dl>
						<dt>촬영일</dt>
						<dd>${photoDTO.shotDate}</dd>
						<%-- <dd>${photoDTO.shotDate.substring(0,4)}년 ${photoDTO.shotDate.substring(5,7)}월 ${photoDTO.shotDate.substring(8,10)}일 ${photoDTO.shotDate.substring(11,13)}시 ${photoDTO.shotDate.substring(14,16)}분 ${photoDTO.shotDate.substring(17,19)}초</dd> --%>
						<dt>픽셀수</dt>
						<dd>${photoDTO.widthPx} X ${photoDTO.heightPx}(pixel)</dd>						
					</dl>
				</div>
			</div>
		</div>
		<div class="view_rt"></div>
	</section>
	<footer>
		<div class="foot_wrap">
			<div class="foot_lt">(주)다하미커뮤니케이션즈 | 대표 박용립<br />
				서울시 중구 마른내로 140 5층 (쌍림동, 인쇄정보센터)<br />
				고객센터 02-593-4174 | 사업자등록번호 112-81-49789 <br />
				저작권대리중개신고번호 제532호<br />
				통신판매업신고번호 제2016-서울중구-0501호 (사업자정보확인)</div>
			<div class="foot_ct">
				<dl>
					<dt>회사소개</dt>
					<dd>뉴스뱅크 소개</dd>
					<dd>UCI 소개</dd>
					<dd>공지사항</dd>
					<dd>이용약관</dd>
					<dd>개인정보처리방침</dd>
				</dl>
				<dl>
					<dt>구매안내</dt>
					<dd>저작권 안내</dd>
					<dd>FAQ</dd>
					<dd>도움말</dd>
					<dd>직접 문의하기</dd>
				</dl>
				<dl>
					<dt>사이트맵</dt>
				</dl>
			</div>
			<div class="foot_rt">
				<div id="family_site">
					<div id="select-title">주요 서비스 바로가기</div>
					<div id="select-layer" style="display: none;">
						<ul class="site-list">
							<li><a href="http://scrapmaster.co.kr/" target="_blank">스크랩마스터</a></li>
							<li><a href="http://clippingon.co.kr/" target="_blank">클리핑온</a></li>
							<li><a href="http://www.t-paper.co.kr/" target="_blank">티페이퍼</a></li>
							<li><a href="http://forme.or.kr/" target="_blank">e-NIE</a></li>
							<li><a href="http://www.newsbank.co.kr/" target="_blank">뉴스뱅크</a></li>
						</ul>
					</div>
				</div>
				<div class="foot_banner">
					<ul>
						<li class="uci"><a>국가표준 디지털콘텐츠<br />
							식별체계 등록기관 지정</a></li>
						<li class="cleansite"><a>클린사이트<br />
							한국저작권보호원</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
	</footer>
</div>
</body>
</html>
