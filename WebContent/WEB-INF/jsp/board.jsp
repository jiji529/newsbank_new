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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
	pageContext.setAttribute("LF", "\n"); // Enter
	pageContext.setAttribute("BR", "<br/>"); //br 태그
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function (){
		$("#searchTxt").on('click', function(e) {
			boardSearch();
		});
		
		$('#searchInput').on('keypress', function(e) {
			if (e.which == 13) {/* 13 == enter key@ascii */
				boardSearch();
			}
		});
	});
	
	function boardSearch() { // 공지사항 검색
		var pages = 1;
		var keyword = $("#searchInput").val();
		var html = "";
		$(".faq dl").empty();
		
		$.ajax({
			url: "/boardJson",
			type: "GET",
			dataType: "json",
			data: {
				"keyword": keyword
			},
			success: function(data) {
				
				if(data.result != "") {
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
					
				} else {
					html += '<dt><a><span class="faq_tit noti">결과내 검색결과가 없습니다.</span></a></dt>';
				}
				
				$(html).appendTo(".faq dl");
			}
		});
	}
	
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
			<%@include file="header.jsp"%>
		<section class="mypage">
			<div class="head">
				<h2>이용안내</h2>
				<p>뉴스뱅크 사이트에 관하여 알려드립니다.</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1 use">
					<li><a href="/price.info">구매안내</a></li>
					<li class="on"><a href="/board">공지사항</a></li>
					<li><a href="/FAQ">FAQ</a></li>
					<li><a href="/contact">직접 문의하기</a></li>
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
							<c:if test="${!empty board.fileName}">
								<img src="/notice.down.photo?seq=${board.seq}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" />
							</c:if>
							<p>${fn:replace(board.description, LF, BR)}</p>
						</dd>
					</c:forEach>
				</dl>
			</div>
		</section>
		<%@include file="footer.jsp"%>
	</div>
</body>
</html>
