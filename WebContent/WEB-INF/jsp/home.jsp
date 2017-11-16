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
  2017. 11. 09.   hoyadev        인기사진, 보도사진 수정 
---------------------------------------------------------------------------%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
long currentTimeMills = System.currentTimeMillis(); 
String IMG_SERVER_URL_PREFIX = "http://www.dev.newsbank.co.kr";
// String IMG_SERVER_URL_PREFIX = "";
%>
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
	$(document).ready(function() {
		/* Start rowGrid.js */
		$(".photo_cont").rowGrid({
			itemSelector : ".img_list",
			minMargin : 10,
			maxMargin : 25,
			firstItemClass : "first-item"
		});
		
		$("#keyword").focus();
	});
	
	$(document).on("click", ".btn_search", function() {
		search();
	});
	
	$(document).on("keypress", "#keyword", function(e) {
		if(e.keyCode == 13) {	// 엔터
			search();
		}
	});
	
	function search() {
		var keyword = $.trim($("#keyword").val());
		if(keyword.length == 0) {
			alert("검색어를 입력하세요.");
			$("#keyword").val("");
			$("#keyword").focus();
		}
		else {
			$("#keyword").val(keyword);
			search_form.submit();
		}
	}
	
	function tabControl(index) {
		$(".popular .center .tab .tabs li a").removeClass("active");
		$(".popular_cont").css("display", "none");
		$(".zzim_cont").css("display", "none");
		$(".hit_cont").css("display", "none");
		
		switch(index) {
		
			case 0:
				$(".popular_cont").css("display", "block");	
				$(".popular .center .tab .tabs li a:eq("+index+")").addClass("active");
				break;
				
			case 1:
				$(".zzim_cont").css("display", "block");
				$(".popular .center .tab .tabs li a:eq("+index+")").addClass("active");
				break;
				
			case 2:
				$(".hit_cont").css("display", "block");
				$(".popular .center .tab .tabs li a:eq("+index+")").addClass("active");
				break;
		
		}
	}
	
	function media_submit(member_seq) {
		$("#seq").val(member_seq);
		$("#keyword").val("");
		search_form.submit();
	}
	
	function go_photoView(uciCode) {
		$("#uciCode").val(uciCode);
		view_form.submit();
	}
	
</script>
</head>
<body>	
	<div class="wrap">
		<nav class="gnb_light">
		<div class="gnb">
			<a href="/home" class="logo"></a>
			<ul class="gnb_left">
				<li>
					<a href="/photo">보도사진</a>
				</li>
				<!-- <li>
					<a href="#">뮤지엄</a>
				</li>
				<li>
					<a href="#">사진</a>
				</li>
				<li>
					<a href="#">컬렉션</a>
				</li> -->
			</ul>
			<ul class="gnb_right">
				<c:choose>
					<c:when test="${empty MemberInfo}">
						<li>
							<a href="/login">로그인</a>
						</li>
						<li>
							<a href="/kind.join" target="_blank">가입하기</a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="/logout">Log Out</a>
						</li>
						<li>
							<a href="/info.mypage">My Page</a>
						</li>
					</c:otherwise>
				</c:choose>
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
					<form class="search_form" method="post" action="/photo" name="search_form" >
						<input type="hidden" id="seq" name="seq"/>
						<div class="search_area">
							<input type="text" class="search_bar"  id="keyword" name="keyword" placeholder="검색어를 입력해주세요." />
							<a href="#" class="btn_search">검색</a>
						</div>
					</form>
					<form class="view_form" method="post" action="/view.photo" name="view_form" >
						<input type="hidden" name="uciCode" id="uciCode"/>
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
						<li>
							<a href="/photo" class="active">보도사진</a>
						</li>
						<!-- <li>
							<a href="#">뮤지엄</a>
						</li>
						<li>
							<a href="#">컬렉션</a>
						</li> -->
					</ul>
				</div>
				
				<div id="photo_hor" class="photo_cont img_hor">
					<c:forEach items="${photoList}" var="photo">
						<c:if test="${photo.widthCm > photo.heightCm}">
							<div class="img_list">
								<%-- <a href="/view.photo?uciCode=${photo.uciCode}"> --%>
								<a href="#" onclick="go_photoView('${photo.uciCode}')">
									<img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${photo.uciCode}&dummy=<%= currentTimeMills%>">
								</a>
							</div>
						</c:if>
					</c:forEach>
				</div>
				
				<div id="photo_ver" class="photo_cont img_ver">
					<c:forEach items="${photoList}" var="photo">
						<c:if test="${photo.widthCm < photo.heightCm}">
							<div class="img_list">
								<%-- <a href="/view.photo?uciCode=${photo.uciCode}"> --%>
								<a href="#" onclick="go_photoView('${photo.uciCode}')">
									<img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${photo.uciCode}&dummy=<%= currentTimeMills%>">
								</a>
							</div>
						</c:if>					
					</c:forEach>
				</div>
				
			</div>
			</section>
			<!--엄선한사진-->
			<section class="service">
			<div class="center">
				<div class="serv_txt_l">
					<h3>뉴스뱅크 서비스 소개</h3>
					<h2>언론사 보도사진 통합 라이브러리</h2>
					<p>
						뉴스뱅크는 25개 언론사의 보도사진 520만 컷 이상을 보유하고 있는
						<br />
						국내 최대의 보도사진 통합 라이브러리입니다.
						<br />
						신미양요, 병인양요의 19세기 사진을 비롯해 일제 강점기를 지나
						<br />
						6.25 전쟁을 거치고 산업화와 민주화 시대를 거쳐
						<br />
						오늘에 이르기까지
						<br />
						대한민국 근현대사의 중요 장면이
						<br />
						생생한 보도사진으로 기록되어 남아 있습니다.
					</p>
				</div>
			</div>
			</section>
			<!--서비스소개-->
			<section class="popular">
			<div class="center">
				<h2>인기 사진</h2>
				<p>최근 뉴스뱅크 회원님들께 가장 많은 관심을 받은 사진을 소개합니다.</p>
				<div class="tab">
					<ul class="tabs">
						<li>
							<a href="javascript:tabControl(0)" class="active">다운로드</a>
						</li>
						<li>
							<a href="javascript:tabControl(1)">찜</a>
						</li>
						<li>
							<a href="javascript:tabControl(2)">상세보기</a>
						</li>
					</ul>
				</div>
				<div class="popular_cont">
					<div id="photo_ver" class="photo_cont img_ver">
						<c:forEach items="${downloadList}" var="down">
							<c:if test="${down.widthCm < down.heightCm}">
								<div class="img_list">
									<a href="#" onclick="go_photoView('${down.uciCode}')">
										<img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${down.uciCode}&dummy=<%= currentTimeMills%>">
									</a>
								</div>
							</c:if>					
						</c:forEach>
					</div>
					
					<div id="photo_hor" class="photo_cont img_hor">
						<c:forEach items="${downloadList}" var="down">
							<c:if test="${down.widthCm > down.heightCm}">
								<div class="img_list">
									<a href="#" onclick="go_photoView('${down.uciCode}')">
										<img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${down.uciCode}&dummy=<%= currentTimeMills%>">
									</a>
								</div>
							</c:if>
						</c:forEach>
					</div>			
				</div>
				
				<div class="zzim_cont" style="display:none;">
					<div id="photo_ver" class="photo_cont img_ver">
						<c:forEach items="${basketList}" var="basket">
							<c:if test="${basket.widthCm < basket.heightCm}">
								<div class="img_list">
									<%-- <a href="/view.photo?uciCode=${basket.uciCode}"> --%>
									<a href="#" onclick="go_photoView('${basket.uciCode}')">
										<img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${basket.uciCode}&dummy=<%= currentTimeMills%>">
									</a>
								</div>
							</c:if>					
						</c:forEach>
					</div>
					
					<div id="photo_hor" class="photo_cont img_hor">
						<c:forEach items="${basketList}" var="basket">
							<c:if test="${basket.widthCm > basket.heightCm}">
								<div class="img_list">
									<a href="#" onclick="go_photoView('${basket.uciCode}')">
										<img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${basket.uciCode}&dummy=<%= currentTimeMills%>" />
									</a>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
				
				<div class="hit_cont" style="display:none;">
					<div id="photo_ver" class="photo_cont img_ver">
						<c:forEach items="${hitsList}" var="hit">
							<c:if test="${hit.widthCm < hit.heightCm}">
								<div class="img_list">
									<a href="#" onclick="go_photoView('${hit.uciCode}')">
										<img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${hit.uciCode}&dummy=<%= currentTimeMills%>">
									</a>
								</div>
							</c:if>					
						</c:forEach>
					</div>
					
					<div id="photo_hor" class="photo_cont img_hor">
						<c:forEach items="${hitsList}" var="hit">
							<c:if test="${hit.widthCm > hit.heightCm}">
								<div class="img_list">
									<a href="#" onclick="go_photoView('${hit.uciCode}')">
										<img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${hit.uciCode}&dummy=<%= currentTimeMills%>">
									</a>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
				
			</div>
			</section>
			<!--인기사진-->
			<section class="media">
			<div class="center">
				<h2>회원사 소개</h2>
				<ul class="media_list">
					<c:forEach items="${mediaList}" var="member">
						<li>
							<a href="#" onclick="media_submit('${member.seq}')">
								<img src="/logo.down.photo?seq=${member.seq}&dummy=<%= currentTimeMills%>" />
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			</section>
			<!--회원사-->
		</div>
		<%@include file="footer.jsp"%>
	</div>
</body>
</html>
