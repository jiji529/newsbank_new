<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 9. 21. 오후 3:27:27
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 10.   tealight       home
---------------------------------------------------------------------------%>


<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
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
	<%
		out.println(request.getParameter("test"));
		List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
		items = (List<Map<String,Object>>)request.getAttribute("test");
		out.println(items.get(1).get("descriptionKr"));
		
	%>
<div class="wrap">
	<nav class="gnb_light">
		<div class="gnb"><a href="#" class="logo"></a>
			<ul class="gnb_left">
				<li><a href="#">보도사진</a></li>
				<li><a href="#">뮤지엄</a></li>
				<li><a href="#">사진</a></li>
				<li><a href="#">컬렉션</a></li>
			</ul>
			<ul class="gnb_right">
				<li><a href="#">로그인</a></li>
				<li><a href="#">가입하기</a></li>
			</ul>
		</div>
	</nav>
	<div class="main">
		<section class="top">
			<div class="overlay"></div>
			<div class="main_bg"></div>
			<div class="main_tit">
				<h2>보도사진 박물관 뉴스뱅크</h2>
				<p>대한민국의 근현대사를 담은 26개 언론사의 보도사진을 만나보세요.</p>
				<div class="search main_search">
					<form class="search_form">
						<div class="search_area">
							<input type="text" class="search_bar" placeholder="검색어를 입력해주세요." />
							<a href="#" class="btn_search">검색</a></div>
					</form>
					<!--상세검색    <a href="#" class="search_detail">상세검색</a>   -->
				</div>
			</div>
		</section>
		<section class="photo">
			<div class="center">
				<h2>뉴스뱅크가 엄선한 사진</h2>
				<p>수백명의 보도사진 작가가 현장을 누비며 대한민국의 역사를 담고 있습니다.</p>
				<div class="tab">
					<ul class="tabs">
						<li><a href="#" class="active">보도사진</a></li>
						<li><a href="#">뮤지엄</a></li>
						<li><a href="#">컬렉션</a></li>
					</ul>
				</div>
				<div class="photo_cont img_ver">
					<div class="img_list"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a></div>
					<div class="img_list"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a></div>
					<div class="img_list"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a></div>
				</div>
				<div class="photo_cont img_hor">
					<div class="img_list"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/N0/2010/08/30/E003394463_P.jpg" /></a></div>
					<div class="img_list"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/A0/2009/06/22/E003319517_P.jpg" /></a></div>
					<div class="img_list"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/A0/2009/04/30/E003307027_P.jpg" /></a></div>
					<div class="img_list"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/N0/2012/04/09/E004316655_P.jpg" /></a></div>
				</div>
			</div>
		</section>
		<!--엄선한사진-->
		<section class="service">
			<div class="center">
				<div class="serv_txt_l">
					<h3>뉴스뱅크 서비스 소개</h3>
					<h2>언론사 보도사진 통합 라이브러리</h2>
					<p>뉴스뱅크는 25개 언론사의 보도사진 520만 컷 이상을 보유하고 있는 <br />
						국내 최대의 보도사진 통합 라이브러리입니다.<br />
						신미양요, 병인양요의 19세기 사진을 비롯해 일제 강점기를 지나 <br />
						6.25 전쟁을 거치고 산업화와 민주화 시대를 거쳐 <br />
						오늘에 이르기까지<br />
						대한민국 근현대사의 중요 장면이<br />
						생생한 보도사진으로 기록되어 남아 있습니다.</p>
				</div>
			</div>
		</section>
		<!--서비스소개-->
		<section class="popular">
			<div class="center">
				<h2>인기 사진</h2>
				<p>최근 뉴스뱅크 회원님들께 가장 많은 관심을 받은 사진을 소개합니다. </p>
				<div class="tab">
					<ul class="tabs">
						<li><a href="#" class="active">다운로드</a></li>
						<li><a href="#">찜</a></li>
						<li><a href="#">상세보기</a></li>
					</ul>
				</div>
				<div class="popular_cont">
					<div class="photo_cont img_ver">
						<div class="img_list"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/N0/2010/08/30/E003394463_P.jpg" /></a></div>
						<div class="img_list"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/A0/2009/06/22/E003319517_P.jpg" /></a></div>
						<div class="img_list"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/A0/2009/04/30/E003307027_P.jpg" /></a></div>
					</div>
					<div class="photo_cont img_ver">
						<div class="img_list"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a></div>
						<div class="img_list"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a></div>
						<div class="img_list"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a></div>
					</div>
				</div>
			</div>
		</section>
		<!--인기사진-->
		<section class="media">
			<div class="center">
				<h2>회원사 소개</h2>
				<p>문구 수정. </p>
				<ul class="media_list">
					<li><a href="#"><img src="images/media/p01.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p02.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p03.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p04.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p05.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p06.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p07.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p08.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p09.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p10.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p11.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p12.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p13.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p14.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p15.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p16.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p17.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p18.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p19.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p20.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p21.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p22.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p23.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p27.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p28.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p29.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p30.jpg" /></a></li>
					<li><a href="#"><img src="images/media/p31.jpg" /></a></li>
				</ul>
			</div>
		</section>
		<!--회원사-->
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