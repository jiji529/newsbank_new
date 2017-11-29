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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script type="text/javascript">
	$(document).ready(function(key, val){
		var saleState = ${photoDTO.saleState};
		var portraitRightState = ${photoDTO.portraitRightState};
		
		if(saleState == 1) { // 판매중
			$('input:radio[name="blind"][value="1"]').attr('checked', true);
		}else if(saleState == 2) { // 판매중지
			$('input:radio[name="blind"][value="2"]').attr('checked', true);
		}
		
		if(portraitRightState == 1) {
			$('input:radio[name="likeness"][value="1"]').attr('checked', true);
		}else if(portraitRightState == 2) {
			$('input:radio[name="likeness"][value="2"]').attr('checked', true);
		}
		
		relation_photo();
	});
	
	$(document).on("change", "input[type=radio][name=blind]", function() {
		var saleState = $('input[type=radio][name=blind]:checked').val();
		changeOption("saleState", saleState);
	});
	
	$(document).on("change", "input[type=radio][name=likeness]", function() {
		var portraitRightState = $('input[type=radio][name=likeness]:checked').val();
		changeOption("portraitRightState", portraitRightState);
	});
	
	function changeOption(name, value) {	
		var uciCode = "${photoDTO.uciCode}";
		
		$.ajax({
			type: "POST",
			url: "/view.cms?action=updateOne",
			data: {
				"uciCode" : uciCode,
				"columnName" : name,
				"columnValue" : value
			},
			success: function(data){
				
			}, error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
		});
	}
	
	$(document).on("click", ".tag_remove", function() {
		$(this).parent().remove();
		var uciCode = "${photoDTO.uciCode}";
		var tagName = $(this).parent().text().replace("×", "");
		
		deleteTag(uciCode, tagName)
	});
	
	function deleteTag(uciCode, tagName) {
		$.ajax({
			type: "POST",
			url: "/view.cms?action=deleteTag",
			data: {
				"uciCode" : uciCode,
				"tagName" : tagName
			},
			dataType: "text",
			success: function(data){
				
			}, error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
			
		});
	}
	
	$(document).on("click", ".add_tag > button", function() {
		var uciCode = "${photoDTO.uciCode}";
		var tagName = $(this).prev().val();
		
		var tag_list = $(".tag_list").children().text(); 
		tag_list = tag_list.split("×");
		tag_list = tag_list.filter(isNotEmpty);		
		
		if(tag_list.indexOf(tagName) != -1) {
			alert("이미 존재하는 태그입니다.");
		}else {
			var html = "<li class=\"tag_self\"><span class=\"tag_remove\">×</span>"+tagName+"</li>";
			$(html).appendTo(".tag_list");
			$(this).prev().val("");
			
			insertTag(uciCode, tagName);
		}
		
	});
	
	function insertTag(uciCode, tagName) {
		$.ajax({
			type: "POST",
			url: "/view.cms?action=insertTag",
			data: {
				"uciCode" : uciCode,
				"tagName" : tagName
			},
			dataType: "text",
			success: function(data){
				
			}, error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
			
		});
	}
	
	function isNotEmpty(value) { // 배열 빈값 제외
		return value != "";
	}
	
	$(document).on("click", ".btn_edit", function() {
		var title = $(".img_tit").last().text();
		var content = $(".img_cont").text();		
		
		if($(".btn_edit").hasClass("complete")) {
			// DB에 기사 제목, 내용을 수정 기능 필요
			var titleKor = $(".hTitle").val(); 
			var descriptionKor = $(".img_cont").text();
			var uciCode = "${photoDTO.uciCode}";
			
			$(".btn_edit").text("수정");		
			$(".btn_edit").removeClass("complete");
			$(".img_tit").last().replaceWith("<h3 class=\"img_tit\">"+titleKor+"</h3>");
			$(".img_cont").replaceWith("<p class=\"img_cont\">"+descriptionKor+"</p>");
			
			$.ajax({
				type: "POST",
				url: "/view.cms?action=updateCMS",
				data: {
					"uciCode" : uciCode,
					"titleKor" : titleKor,
					"descriptionKor" : descriptionKor
				},
				success: function(data){
					
				}, error:function(request,status,error){
		        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		       	}
				
			});
		}else {
			$(".img_tit").last().replaceWith("<textarea class=\"img_tit hTitle\" style=\"width:100%; font-size:14px; line-height:22px; color:#666;\">"+title+"</textarea>");
			$(".img_cont").replaceWith("<textarea class=\"img_cont\" style=\"height:300px; width:100%; font-size:14px; line-height:22px; color:#666;\">"+content+"</textarea>");	
			$(".btn_edit").text("수정 완료");		
			$(".btn_edit").addClass("complete");
		}
		
		
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
	
	// #연관사진
	function relation_photo() {
		var keyword = "";
		keyword = $.trim(keyword);
		var pageNo = "1";
		var pageVol = "10";
		var contentType = $(".filter_contentType .filter_list").find("[selected=selected]").attr("value");
		var media = 0;
		var duration = "";
		var colorMode = "0";
		var horiVertChoice = "0";
		var size = "0";
		var portRight = $(".filter_portRight .filter_list").find("[selected=selected]").attr("value");
		var includePerson = $(".filter_incPerson .filter_list").find("[selected=selected]").attr("value");
		var group = $(".filter_group .filter_list").find("[selected=selected]").attr("value");

		var searchParam = {
				"uciCode":"${photoDTO.uciCode}"
				,"keyword":keyword
				, "pageNo":pageNo
				, "pageVol":pageVol
				, "contentType":contentType
				, "media":media
				, "duration":duration
				, "colorMode":colorMode
				, "horiVertChoice":horiVertChoice
				, "size":size
				, "portRight":portRight
				, "includePerson":includePerson
				, "group":group
		};
		
		$("#keyword").val($("#keyword_current").val());
		
		var html = "";
		$.ajax({
			type: "POST",
			async: false,
			dataType: "json",
			data: searchParam,
			timeout: 1000000,
			url: "search",
			success : function(data) {
				$(data.result).each(function(key, val) {
					html += '<li><a href="javascript:void(0)"><img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '" /></a></li>';
				});
				$(html).appendTo(".cfix");
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
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
				<li><a href="/account.mypage">정산 관리</a></li>
				<li class="on"><a href="/cms">사진 관리</a></li>
				<li><a href="/info.mypage">회원정보 관리</a></li>
				<li><a href="/dibs.myPage">찜관리</a></li>
				<li><a href="/cart.myPage">장바구니</a></li>
				<li><a href="/buy.mypage">구매내역</a></li>
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
		<section class="view">
			<div class="view_lt">
				<h2 class="media_logo"><img src="/logo.down.photo?seq=${photoDTO.ownerNo}" alt="${photoDTO.ownerName}" /></h2>
				<div class="img_area"><img src="<%=IMG_SERVER_URL_PREFIX%>/view.down.photo?uciCode=${photoDTO.uciCode}"/>
				</div>
				<div class="cont_area">
					<h3 class="img_tit"><span class="uci">[${photoDTO.uciCode}]</span>ns696100264</h3>
					<h3 class="img_tit hTitle">${photoDTO.titleKor}</h3>
					<a class="btn_edit">수정</a>
					<p class="img_cont">
						${photoDTO.descriptionKor} <br />
					</p>
				</div>
				<div class="img_info_area area1">
					<h3 class="info_tit">사진 정보</h3>
					<dl>
						<dt>촬영일</dt>
						<dd>${photoDTO.shotDate}</dd>
						<dt>픽셀수</dt>
						<dd>${photoDTO.widthPx} X ${photoDTO.heightPx}(pixel)</dd>
						<dt>출력사이즈</dt>
						<dd>${photoDTO.widthCm} x ${photoDTO.heightCm} (cm)</dd>
						<dt>파일용량</dt>
						<dd>${photoDTO.fileSize}MB</dd>
						<dt>파일포멧</dt>
						<dd>JPEG</dd>
						<dt>해상도</dt>
						<dd>${photoDTO.dpi}dpi</dd>
						<dt>저작권자</dt>
						<dd>${photoDTO.copyright}</dd>
					</dl>
				</div>
				<div class="img_info_area area2">
					<h3 class="info_tit">EXIF (Exchangeable Image File Format)</h3>
					<c:set var="split_exif" value="${fn:split(photoDTO.exif, '|')}" />
					
					<dl>
						<c:forEach items="${split_exif}" var="split_exif">
							<c:set var="name" value="${fn:substringBefore(split_exif, ':')}" />
							<c:set var="value" value="${fn:substringAfter(split_exif, ':')}" />
							<dt>${name}</dt>
							<dd>${value}</dd>
						</c:forEach>
					</dl>
				</div>
				<div class="img_info_area">
					<h3 class="info_tit">연관 사진</h3>
					<div class="conn">
						<ul class="cfix">
						</ul>
						<div class="btn_conn">
							<button class="in_prev">이전</button>
							<button class="in_next">다음</button>
						</div>
					</div>
				</div>
				
			</div>
			<div class="view_rt">
				<div class="cms_rt">
					<h3 class="info_tit">통계</h3>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="cms_table1">
						<tr>
							<th scope="col">구분</th>
							<th scope="col">전체 횟수</th>
						</tr>
						<tr>
							<th scope="row">찜</th>
							<td><b>${statsDTO.bookmarkCount}</b>회</td>
						</tr>
						<tr>
							<th scope="row">다운로드</th>
							<td><b>${statsDTO.downCount}</b>회</td>
						</tr>
						<tr>
							<th scope="row">상세보기</th>
							<td><b>${statsDTO.hitCount}</b>회</td>
						</tr>
						<tr>
							<th scope="row">결제</th>
							<td><b>${statsDTO.saleCount}</b>회</td>
						</tr>
						<tr>
							<th scope="row">뮤지엄</th>
							<td><b>${statsDTO.museumCount}</b>회</td>
						</tr>
						<tr>
							<th scope="row">컬렉션</th>
							<td><b>${statsDTO.collectionCount}</b>회</td>
						</tr>
					</table>
				</div>
				<div class="cms_rt">
					<h3 class="info_tit">옵션</h3>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="cms_table2">
						<tr>
							<th scope="row">게티 노출 / 타 서비스 노출</th>
							<td><label>
									<input type="radio" name="serv" />
									ON</label>
								<label>
									<input type="radio" name="serv"/>
									OFF</label></td>
						</tr>
						<tr>
							<th scope="row">블라인드</th>
							<td><label>
									<input type="radio" name="blind" value="2"/>
									ON</label>
								<label>
									<input type="radio" name="blind" value="1"/>
									OFF</label></td>
						</tr>
						<tr>
							<th scope="row">초상권 해결</th>
							<td><label>
									<input type="radio" name="likeness" value="1"/>
									ON</label>
								<label>
									<input type="radio" name="likeness" value="2"/>
									OFF</label></td>
						</tr>
					</table>
				</div>
				<div class="cms_rt">
					<h3 class="info_tit">태그 달기</h3>
					<div class="add_tag">
						<input type="text" />
						<button>추가</button>
					</div>
					<ul class="tag_list">
						<!-- <li class="tag_auto"><span class="tag_remove">×</span>장원준</li>
						<li class="tag_self"><span class="tag_remove">×</span>승리투수</li> -->
						
						<c:forEach items="${photoTagList}" var="tag">
							<%-- <li class="tag_self"><span class="tag_remove">×</span>${tag.tag_tagName}</li> --%>
							
							<c:set value="${tag.tagType}" var="tagType"/>
							<c:if test="${tagType == 0}" var="result">
								<li class="tag_auto"><span class="tag_remove">×</span>${tag.tag_tagName}</li>
							</c:if>
							
							<c:if test="${tagType == 1}" var="result">
								<li class="tag_self"><span class="tag_remove">×</span>${tag.tag_tagName}</li>
							</c:if>
							
						</c:forEach>
					</ul>
				</div>
			</div>
		</section>
	</section>
	<%@include file="footer.jsp"%>
</div>
</body>
</html>
