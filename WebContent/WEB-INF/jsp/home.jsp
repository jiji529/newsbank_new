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
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
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

<script src="js/unitegallery.min.js"></script>
<script src="js/ug-theme-tiles.js"></script>
<link rel="stylesheet" href="css/unite-gallery.css" />
<%
String errMsg = (String)request.getAttribute("ErrorMSG");
if(errMsg != null && errMsg.length() > 0) {
%>
<script>
	alert("<%=errMsg%>");
</script>
<%
}
%>
<script>
	$(document).ready(function() {
		get_totalNumberPhoto();
		/* Start rowGrid.js */
		$(".photo_cont").rowGrid({
			itemSelector : ".img_list",
			minMargin : 10,
			maxMargin : 25,
			firstItemClass : "first-item"
		});
		$("#keyword").focus();
		
		// unite 옵션
		var unite_option = { 
			gallery_theme: "tiles",			
			gallery_width:"1218px", // 전체 가로길이
			
			tiles_type: "justified", 
			tile_enable_shadow:true,
			tile_shadow_color:"#8B8B8B",
			tile_enable_icons:false, // 아이콘 숨김
			tile_as_link:true, // 링크처리
			tile_link_newpage: false, // 링크 새 페이지로 이동
			
			tiles_justified_row_height: 250,
			tiles_justified_space_between: 10,
			tiles_set_initial_height: true,	
			tiles_enable_transition: true,
		};
		
		// 보도사진 영역 
		$("#photo_area").unitegallery(unite_option);
		
		// 다운로드 영역 
		$("#download_area").unitegallery(unite_option);
		
		// 찜관리 
		$("#zzim_area").unitegallery(unite_option);
		
		// 상세보기
		$("#hit_area").unitegallery(unite_option);
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
		$("#media").val(member_seq);
		$("#keyword").val("");
		search_form.submit();
	}
	
	function go_photoView(uciCode) {
		$("#uciCode").val(uciCode);
		view_form.submit();
	}
	
	function get_totalNumberPhoto() {
		var keyword = "";
		var pageNo = 1;
		var pageVol = 40;
		var durationReg = 1;
		var durationTake = 1;
		var media = 0;
		var size = 0;
		
		var searchParam = {
				"keyword":keyword
				, "pageNo":pageNo
				, "pageVol":pageVol
				, "durationReg":durationReg
				, "durationTake":durationTake
				, "media":media
				, "size":size
		};
		
		$.ajax({
			type: "POST",
			async: true,
			dataType: "json",
			data: searchParam,
			timeout: 1000000,
			url: "/search",
			success : function(data) { 
				var count = data.count; // 만 단위로 표현
				var totalNumber = Math.floor(count / 10000);
				$(".totalNumberPhoto").text(totalNumber + "만");
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
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
					<a href="/collection">컬렉션</a>
				</li> -->
				<!-- <li>
					<a href="javascript:void(0)">뮤지엄</a>
				</li>
				<li>
					<a href="javascript:void(0)">사진</a>
				</li>
				 -->
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
							<a href="/out.login">로그아웃</a>
						</li>
						
						<c:choose>
							<c:when test="${(MemberInfo.type eq 'M' || MemberInfo.type eq 'Q') && MemberInfo.admission eq 'Y'}">
								<li>
									<a href="/cms">마이페이지</a>
								</li>
							</c:when>
							
							<c:when test="${MemberInfo.type eq 'W' && MemberInfo.admission eq 'Y'}">
								<li>
									<a href="/accountlist.mypage">마이페이지</a>
								</li>
							</c:when>
							
							<c:otherwise>
								<li>
									<a href="/info.mypage">마이페이지</a>
								</li>
							</c:otherwise>
						</c:choose>
						
						<!-- <li>
							<a href="/info.mypage">마이페이지</a>
						</li> -->
						<c:if test="${MemberInfo.type == 'A'}">
							<li class="go_admin">
								<a href="/member.manage">관리자페이지</a>
							</li>
						</c:if>
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
				<p>대한민국의 근현대사를 담은 13개 언론사의 보도사진을 만나보세요.</p>
				<div class="search main_search">
					<form class="search_form" method="post" action="/photo" name="search_form" >
						<input type="hidden" id="media" name="media"/>
						<div class="search_area">
							<input type="text" class="search_bar"  id="keyword" name="keyword" placeholder="검색어를 입력해주세요." />
							<a href="javascript:void(0)" class="btn_search">검색</a>
						</div>
					</form>
					<form class="view_form" method="post" action="/view.photo" name="view_form" >
						<input type="hidden" name="uciCode" id="uciCode"/>
					</form>
					<!--상세검색    <a href="javascript:void(0)" class="search_detail">상세검색</a>   -->
				</div>
			</div>
			</section>
			<section class="photo">
			<div class="center">
				<h2>뉴스뱅크가 엄선한 사진</h2>
				<p>수백명의 보도사진 작가가 현장을 누비며 대한민국의 오늘을 담고 있습니다.</p>
				<div class="tab">
					<ul class="tabs">
						<li>
							<a href="/photo" class="active">보도사진</a>
						</li>
						<!-- <li>
							<a href="javascript:void(0)">뮤지엄</a>
						</li>
						<li>
							<a href="javascript:void(0)">컬렉션</a>
						</li> -->
					</ul>
				</div>
				
				
				<div id="photo_area"> 
					<c:forEach items="${photoList}" var="photo">						
						<a href='javascript:go_photoView("${photo.uciCode}")' onclick='go_photoView("${photo.uciCode}")'>
							<img alt="image_${status.index}" src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${photo.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>">
						</a>
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
					<p>뉴스뱅크는 ${fn:length(mediaList)}개 언론사의 보도사진 <span class="totalNumberPhoto"></span> 컷 이상을 보유하고 있는 국내 최대의 보도사진 통합 라이브러리입니다.<br />
						신미양요, 병인양요의 19세기 사진을 비롯해 일제 강점기를 지나 6.25 전쟁을 거치고<br />
						산업화와 민주화 시대를 거쳐 오늘에 이르기까지 <br />대한민국 근현대사의 중요 장면이 생생한 보도사진으로 기록되어 남아 있습니다.</p>
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
				
				<!-- 다운로드 Tab -->
				<div class="popular_cont">
					<div id="download_area"> 
						<c:forEach items="${downloadList}" var="down" varStatus="status">
							<a href='javascript:go_photoView("${down.uciCode}")' onclick='go_photoView("${down.uciCode}")'>
								<img alt="image_${status.index}" src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${down.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>">
							</a>
						</c:forEach>					
					 </div>									
				</div>
				
				<!-- 찜관리 Tab -->
				<div class="zzim_cont" style="display:none;">
					<div id="zzim_area"> 
						<c:forEach items="${basketList}" var="basket" varStatus="status">
							<a href='javascript:go_photoView("${basket.uciCode}")' onclick='go_photoView("${basket.uciCode}")'>
								<img alt="image_${status.index}" src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${basket.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>">
							</a>
						</c:forEach>					
					 </div>					
				</div>
				
				<!-- 상세보기 Tab -->
				<div class="hit_cont" style="display:none;">
					<div id="hit_area"> 
						<c:forEach items="${hitsList}" var="hit" varStatus="status">
							<a href='javascript:go_photoView("${hit.uciCode}")' onclick='go_photoView("${hit.uciCode}")'>
								<img alt="image_${status.index}" src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${hit.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>">
							</a>
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
							<a href="javascript:void(0)" onclick="media_submit('${member.seq}')">
								<img src="/logo.down.photo?seq=${member.seq}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" />
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
	<!-- TOP으로 이동 버튼 -->
	<div id="top"><a href="#">TOP</a></div>
</body>
</html>
