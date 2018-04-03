<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 10. 17. 오전 10:48:12
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 17.   hoyadev        view.cms
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/cms.js.jsp"></script>
<script src="js/cms_view.js"></script>
<script src="js/search.js.jsp"></script>
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/photo.js"></script>
<script type="text/javascript">
	$(document).ready(function(key, val){
		var saleState = ${photoDTO.saleState};
		var portraitRightState = ${photoDTO.portraitRightState};
		var mediaExActive = ${photoDTO.mediaExActive};
		
		if(saleState == 1) { // 판매중
			$('input:radio[name="blind"][value="1"]').attr('checked', true);
		}else if(saleState == 2) { // 판매중지
			$('input:radio[name="blind"][value="2"]').attr('checked', true);
		}else {
			$('input:radio[name="blind"][value="2"]').attr('checked', true);
		}
		
		/*
		# 항목 숨기기 처리   -- 2018.02.20. hoyadev 
		if(portraitRightState == 1) {
			$('input:radio[name="likeness"][value="1"]').attr('checked', true);
		}else if(portraitRightState == 2) {
			$('input:radio[name="likeness"][value="2"]').attr('checked', true);
		}
		*/
		
		if(mediaExActive == 0) {
			$('input:radio[name="mediaExActive"][value="0"]').attr('checked', true);
		}else if(mediaExActive == 1) {
			$('input:radio[name="mediaExActive"][value="1"]').attr('checked', true);
		}else{
			$('input:radio[name="mediaExActive"][value="0"]').attr('checked', true);
		}
		
		relation_photo();
	});
	
	$(document).on("click", ".in_prev", function() {
	    var slide_width = $(".cfix").width();
	    var li_width = $(".cfix li:nth-child(1)").width();
	    var view_count = slide_width / li_width;
	    var slide_count = $(".cfix li").size();
	    
	    $(".cfix").animate({
	    	left: + li_width 
	    }, 200, function() {
	    	$(".cfix li:last-child").prependTo(".cfix");
	    	$(".cfix").css("left", "");
	    });
	});
	
	$(document).on("click", ".in_next", function() {
		var slide_width = $(".cfix").width();
	    var li_width = $(".cfix li:nth-child(1)").width();
	    var view_count = slide_width / li_width;
	    var slide_count = $(".cfix li").size();	    
	    
	    $('.cfix').animate({
            left: - li_width
        }, 200, function () {
            $('.cfix li:first-child').appendTo('.cfix');
            $('.cfix').css('left', '');
        });
	});
	
	$(document).on("keypress", "#cms_keyword", function(e) {
		if(e.keyCode == 13) {	// 엔터
			go_cms();
		}
	});
	
	$(document).on("click", "#cms_searchBtn", function() {
		go_cms();
	});
	
	function go_cms() {
		var keyword = $("#cms_keyword").val();
		$("#cms_keyword_current").val(keyword);
		view_form.submit();
	}
	
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
				<li><a href="/accountlist.mypage">정산 관리</a></li>
				<li class="on"><a href="/cms">사진 관리</a></li>
				<li><a href="/info.mypage">회원정보 관리</a></li>
				<li><a href="/dibs.myPage">찜관리</a></li>
				<li><a href="/cart.myPage">장바구니</a></li>
				<li><a href="/buylist.mypage">구매내역</a></li>
			</ul>
		</div>
		<form class="view_form" method="post" action="/cms" name="view_form" >
			<input type="hidden" id="cms_keyword_current" name="cms_keyword_current" />
		</form>
		<div class="table_head">
			<h3>사진 관리</h3>
			<div class="cms_search">이미지 검색
				<input id="cms_keyword" type="text" />
				<button id="cms_searchBtn">검색</button>
			</div>
		</div>
<%@include file="content_view.jsp" %>
		</section>
<%@include file="footer.jsp"%>
</div>
</body>
</html>
