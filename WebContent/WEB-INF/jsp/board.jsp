<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 11. 07. 오후 04:02:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 25.   hoyadev        board
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function (){
		$("#searchTxt").on('click', function(e) {
			var pages = 1;
			var keyword = $("#searchInput").val();
			//var param = "action=search";
			$(".faq dl").empty();
			
			$.ajax({
				url: "/boardJson",
				type: "GET",
				dataType: "json",
				data: {
					"keyword": keyword
				},
				success: function(data) {
					$(data.result).each(function(key, val) {		
						html += '<dt id="dt'+key+'" style="cursor: pointer;">';
						html += '<a onclick="evt('+key+', '+val.seq+')">';
						html += '<span class="faq_tit noti">'+val.title+'</span>';
						html += '<span class="faq_date">'+val.regDate+'</span>';
						html += '<span class="faq_ico"></span>';
						html += '</a>';
						html += '</dt>';
						html += '<dd id="'+key+'">';
						html += '<p>'+val.description+'</p>';
						html += '</dd>';
					});
					
					$(html).appendTo(".faq dl");
				}
			});
		});
		
		$('#searchInput').on('keypress', function(e) {
			if (e.which == 13) {/* 13 == enter key@ascii */
				var pages = 1;
				var keyword = $("#searchInput").val();
				var html = "";
				//var param = "action=search";
				$(".faq dl").empty();
				
				$.ajax({
					url: "/boardJson",
					type: "GET",
					dataType: "json",
					data: {
						"keyword": keyword
					},
					success: function(data) {
						
						$(data.result).each(function(key, val) {		
							html += '<dt id="dt'+key+'" style="cursor: pointer;">';
							html += '<a onclick="evt('+key+', '+val.seq+')">';
							html += '<span class="faq_tit noti">'+val.title+'</span>';
							html += '<span class="faq_date">'+val.regDate+'</span>';
							html += '<span class="faq_ico"></span>';
							html += '</a>';
							html += '</dt>';
							html += '<dd id="'+key+'">';
							html += '<p>'+val.description+'</p>';
							html += '</dd>';
						});
						
						$(html).appendTo(".faq dl");
					}
				});
			}
		});
	});
	
	//공지사항 클릭시 반응
	function evt(newwin, board_seq){
		var objid=document.getElementById(newwin);
		var param = "action=hit";
		//class='on'
		if(objid.style.display=="block")
		{
		  objid.style.display="none";
		  $(".faq dl dt").removeClass();
		}
		else{
		  $('.faq dd').css('display','none');
		  $(".faq dl dt").removeClass();
		  objid.style.display="block";
		  $("#dt"+newwin).addClass("on");
		  
		  $.ajax({
				url: "/board?"+param,
				dataType: "json",
				data: {
					"board_seq": board_seq
				}
			});
		}
	}
</script>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/footer.js"></script>
</head>
<body>
	<div class="wrap">
		<nav class="gnb_dark">
			<div class="gnb"><a href="/home" class="logo"></a>
				<ul class="gnb_left">
					<li class=""><a href="/photo">보도사진</a></li>
					<li><a href="#">뮤지엄</a></li>
					<li><a href="#">사진</a></li>
					<li><a href="#">컬렉션</a></li>
				</ul>
				<ul class="gnb_right">
					<li><a href="/login">로그인</a></li>
					<li><a href="/kind.join">가입하기</a></li>
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
				<h2>이용안내</h2>
				<p>뉴스뱅크 사이트에 관하여 알려드립니다.</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1 use">
					<li><a href="#">구매안내</a></li>
					<li class="on"><a href="/board">공지사항</a></li>
					<li><a href="#">FAQ</a></li>
					<li><a href="#">직접 문의하기</a></li>
					<li><a href="#">사이트맵</a></li>
				</ul>
			</div>
			<div class="table_head">
				<h3>공지사항</h3>
				<div class="cms_search">공지사항 검색
					<input id="searchInput" type="text" />
					<button id="searchTxt">검색</button>
				</div>
			</div>
			<div class="faq">
				<dl>
					<c:forEach items="${boardList}" var="board" varStatus="status">
						<dt id="dt${status.index}" style="cursor: pointer;"><a onClick="evt('${status.index}', '${board.seq}')"><span class="faq_tit noti">${board.title}</span><span class="faq_date">${board.regDate}</span><span class="faq_ico"></span></a></dt>
						<dd id="${status.index}">
							<p>${board.description}</p>
						</dd>
					</c:forEach>
				</dl>
				<!-- 나중에 쓸수도 있어요 지금 어차피 faq 11개라 그냥 가려놔도 될거같아요
				<div class="paging">
					<ul>
						<li class="first"> <a href="#">첫 페이지</a> </li>
						<li class="prev"> <a href="#">이전 페이지</a> </li>
						<li> <a href="#">1</a> </li>
						<li class="active"> <a href="#">2</a> </li>
						<li> <a href="#">3</a> </li>
						<li> <a href="#">4</a> </li>
						<li> <a href="#">5</a> </li>
						<li> <a href="#">6</a> </li>
						<li> <a href="#">7</a> </li>
						<li> <a href="#">8</a> </li>
						<li> <a href="#">9</a> </li>
						<li> <a href="#">10</a> </li>
						<li class="next"> <a href="#"> 다음 페이지 </a> </li>
						<li class="last"> <a href="#"> 마지막 페이지 </a> </li>
					</ul>
				</div> -->
			</div>
		</section>
	</div>
</body>
</html>