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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	long currentTimeMills = System.currentTimeMillis();
	String IMG_SERVER_URL_PREFIX = "http://www.dev.newsbank.co.kr";
%>
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
<script src="js/mypage.js"></script>
<script src="js/dibs.js?v=20171120"></script>

<script type="text/javascript">
	$(document).ready(function(key, val){
		
	});
</script>
</head>
<body>
	<div class="wrap">
		<%@include file="header.jsp" %>
		<section class="mypage">
			<div class="head">
				<h2>마이페이지</h2>
				<p>설명어쩌고저쩌고</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1">
					<c:if test="${MemberInfo.type eq 'M'}">
						<li>
							<a href="/account.mypage">정산 관리</a>
						</li>
						<li>
							<a href="/cms">사진 관리</a>
						</li>
					</c:if>
					<li>
						<a href="/info.mypage">회원정보 관리</a>
					</li>
					<li class="on">
						<a href="/dibs.myPage">찜관리</a>
					</li>
					<c:if test="${MemberInfo.deferred eq 'Y'}">
						<li>
							<a href="/download.mypage">다운로드 내역</a>
						</li>
						<li>
							<a href="/postBuylist.mypage">구매내역</a>
						</li>
					</c:if>
					<c:if test="${MemberInfo.deferred eq 'N'}">
						<li>
							<a href="/cart.myPage">장바구니</a>
						</li>
						<li>
							<a href="/buylist.mypage">구매내역</a>
						</li>
					</c:if>
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
						<ul class="filter_list">
							<c:forEach items="${bookmarkList}" var="bookmark">
								<li value="${bookmark.seq}">${bookmark.bookName}</li>
							</c:forEach>
							<li class="folder_edit">
								<a href="/dibs.popOption" onclick="window.open('/dibs.popOption','new','resizable=no width=420 height=600');return false">폴더 관리</a>
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
			<form class="cart_form" name="cart_form">
				<input type="hidden" name="page" id="page"/>
				<input type="hidden" name="uciCode" id="uciCode"/>
			</form>
			<form class="view_form" method="post" action="/view.photo" name="view_form" >
				<input type="hidden" name="uciCode" id="uciCode"/>
			</form>
			<div class="btn_sort"><span class="task_check">
				<input type="checkbox" name="checkAll"/>
				</span>
				<ul class="button">
					<c:if test="${MemberInfo.deferred eq 'Y'}">
						<li class="sort_down" onclick="mutli_download()">다운로드</li>
					</c:if>
					<c:if test="${MemberInfo.deferred eq 'N'}">
						<li class="sort_down" onclick="insertMultiBasket()">장바구니</li>
					</c:if>
					<li class="sort_del">삭제</li>
					<li class="sort_folder">폴더이동
						<div class="folder_item">
							<ul class="list_layer">
								<!-- <li class="select">기본폴더</li>
								<li>사용자 폴더</li> -->
								<c:forEach items="${bookmarkList}" var="bookmark">
									<c:if test="${bookmark.bookName eq '기본그룹'}">
										<li class="select" value="${bookmark.seq}">${bookmark.bookName}</li>
									</c:if>
									<c:if test="${bookmark.bookName ne '기본그룹'}">
										<li value="${bookmark.seq}" onclick="change_folder('${bookmark.seq}')">${bookmark.bookName}</li>
									</c:if>
									
								</c:forEach>
							</ul>
							<div class="box_add"><a>새 폴더 추가</a>
								<form style="display: ;"><!-- 바로윗줄 추가버튼 눌렀을때 display block-->
									<fieldset>
										<legend>폴더 추가 폼</legend>
										<input type="text" maxlength="20">
										<button>추가</button>
									</fieldset>
								</form>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<section id="wish_list2">
				<ul>					
					<c:forEach items="${dibsPhotoList}" var="PhotoDTO">
						<%-- <li class="thumb"> <a href="#" onclick="go_photoView('${PhotoDTO.uciCode}')"><img src="images/serviceImages${PhotoDTO.getViewPath()}&dummy=<%= currentTimeMills%>"/></a> --%>
						<li class="thumb"> <a href="#" onclick="go_photoView('${PhotoDTO.uciCode}')"><img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${PhotoDTO.uciCode}&dummy=<%= currentTimeMills%>"/></a>
							<div class="thumb_info">
								<input type="checkbox" value="${PhotoDTO.uciCode}"/>
								<span>${PhotoDTO.uciCode}</span><span>${PhotoDTO.copyright}</span></div>
							<ul class="thumb_btn">
								<c:if test="${MemberInfo.deferred eq 'Y'}">
									<li class="btn_down" onclick="down('${PhotoDTO.uciCode}')">다운로드</li>
								</c:if>
								<c:if test="${MemberInfo.deferred eq 'N'}">
									<li class="btn_cart" onclick="insertBasket('${PhotoDTO.uciCode}')">장바구니</li>
								</c:if>
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
<iframe id="downFrame" style="display:none" >
</iframe>
</html>
