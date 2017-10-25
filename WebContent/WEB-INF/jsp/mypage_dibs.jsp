<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 10. 25. 오후 03:25:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 25.   hoyadev        dibs.mypage
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
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script type="text/javascript">
	$(document).ready(function(key, val){
		
	});
</script>
</head>
<body>
	<div class="wrap">
		<nav class="gnb_dark">
			<div class="gnb"><a href="#" class="logo"></a>
				<ul class="gnb_left">
					<li class=""><a href="#">보도사진</a></li>
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
		<section class="mypage">
			<div class="head">
				<h2>마이페이지</h2>
				<p>설명어쩌고저쩌고</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1">
					<li><a href="#">정산 관리</a></li>
					<li><a href="#">사진 관리</a></li>
					<li><a href="#">회원정보 관리</a></li>
					<li class="on"><a href="#">찜관리</a></li>
					<li><a href="#">장바구니</a></li>
					<li><a href="#">구매내역</a></li>
				</ul>
				<!-- 컬렉션 생기면 추가 <ul class="mp_tab2">
					<li class="on"><a href="#">사진 찜 관리</a></li>
					<li><a href="#">컬렉션 찜 관리</a></li>
				</ul> -->
			</div>
			<div class="table_head">
				<h3>찜 관리</h3>
			</div>
			<!-- 필터시작 -->
			<div class="filters">
				<ul>
					<li class="filter_title folder_ico">찜 그룹</li>
					<li class="filter_title"> 찜한 사진 전체
						<ul class="filter_list" style="display:block;">
							<li>기본 그룹</li>
							<li>사용자 지정 그룹</li>
							<li class="folder_edit">
										<a href="#" >그룹 관리</a>
							</li>
						</ul>
					</li>
	</ul>
				<div class="filter_rt">
					<div class="result"><b class="count">123</b>개의 결과</div>
					<div class="paging"><a href="#" class="prev" title="이전페이지"></a>
						<input type="text" class="page" value="1" />
						<span>/</span><span class="total">1234</span><a href="#" class="next" title="다음페이지"></a></div>
					<div class="viewbox">
						<select name="limit">
							<option value="40" selected="selected">40</option>
							<option value="80">80</option>
							<option value="120">120</option>
						</select>
					</div>
				</div>
			</div>
			<!-- 필터끝 -->
			<div class="btn_sort"><span class="task_check">
				<input type="checkbox" />
				</span>
				<ul class="button">
					<li class="sort_down">장바구니</li>
					<li class="sort_del">삭제</li>
					<li class="sort_menu">폴더이동</li>
				</ul>
			</div>
			<section id="wish_list2">
				<ul>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<c:forEach items="${dibsPhotoList}" var="PhotoDTO">
						<li class="thumb"> <a href="/view.cms?uciCode=${PhotoDTO.uciCode}"><img src="images/serviceImages${PhotoDTO.getViewPath()}"/></a>
							<div class="thumb_info">
								<input type="checkbox" />
								<span>${PhotoDTO.uciCode}</span><span>${PhotoDTO.copyright}</span></div>
							<ul class="thumb_btn">
								<li class="btn_down">다운로드</li>
								<li class="btn_del">삭제</li>
							</ul>
						</li>
					</c:forEach>
				</ul>
			</section>
			<div class="more"><a href="#">다음 페이지</a></div>
		</section>
	</div>
</body>
</html>
