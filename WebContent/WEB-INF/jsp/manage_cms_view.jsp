<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2017. 10. 16. 오후 16:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 21.   LEE GWANGHO    cms.view.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	long currentTimeMills = System.currentTimeMillis(); 
	String IMG_SERVER_URL_PREFIX = "http://www.dev.newsbank.co.kr";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
<script src="js/cms_view.js?v=20171120"></script>
<script> 
	//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
	$(document).ready(function() {
		$("[href]").each(function() {
			if (this.href == window.location.href) {
				$(this).parent().addClass("on");
			}
		});
	});
	$(document).ready(function() {
		$("#popup_open").click(function() {
			$("#popup_wrap").css("display", "block");
			$("#mask").css("display", "block");
		});
		
		$("#popup_open").click(function() {
			$("#popup_wrap").css("display", "block");
			$("#mask").css("display", "block");
		});
		$(".popup_close").click(function() {
			$("#popup_wrap").css("display", "none");
			$("#mask").css("display", "none");
		});
	});
	
	$(document).ready(function() {
		// 블라인드 옵션
		var saleState = ${photoDTO.saleState};
		var portraitRightState = ${photoDTO.portraitRightState};
		
		if(saleState == 1) { // 판매중
			$('input:radio[name="blind"][value="1"]').attr('checked', true);
		}else if(saleState == 2) { // 판매중지
			$('input:radio[name="blind"][value="2"]').attr('checked', true);
		}
		
		relation_photo(); // 연관사진
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
			url: "/view.cms.manage?action=updateOne",
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
			url: "/view.cms.manage?action=deleteTag",
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
			url: "/view.cms.manage?action=insertTag",
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
			
		}else {
			$(".btn_edit").text("수정 완료");		
			$(".btn_edit").addClass("complete");
			$(".img_tit").last().replaceWith("<textarea class=\"img_tit\" style=\"width:100%; font-size:14px; line-height:22px; color:#666;\">"+title+"</textarea>");
			$(".img_cont").replaceWith("<textarea class=\"img_cont\" style=\"height:300px; width:100%; font-size:14px; line-height:22px; color:#666;\">"+content+"</textarea>");	
		}
		
		
	});
	
	$(document).on("click", ".complete", function() {
		// DB에 기사 제목, 내용을 수정 기능 필요
		var titleKor = $(".img_tit").last().text();
		var descriptionKor = $(".img_cont").text();
		var uciCode = "${photoDTO.uciCode}";
		
		$(".btn_edit").text("수정");		
		$(".btn_edit").removeClass("complete");
		$(".img_tit").last().replaceWith("<h3 class=\"img_tit\">"+titleKor+"</h3>");
		$(".img_cont").replaceWith("<p class=\"img_cont\">"+descriptionKor+"</p>");
		
		$.ajax({
			type: "POST",
			url: "/view.cms.manage?action=updateCMS",
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
	});
</script>
<title>뉴스뱅크</title>
</head>
<body>
	<div class="wrap admin">
		<%@include file="header_manage.jsp" %>
		<section class="wide">
			<%@include file="sidebar.jsp" %>
			<div class="mypage">
			<div class="table_head">
				<h3>사진관리</h3>
				<div class="cms_search">
					이미지 검색 <input id="cms_keyword" type="text" />
					<button id="cms_searchBtn">검색</button>
				</div>

			</div>
			<form class="view_form" method="post" action="/cms.manage" name="view_form" >
				<input type="hidden" id="cms_keyword_current" name="cms_keyword_current" />
			</form>
			<section class="view">
				<div class="view_lt">
					<h2 class="media_logo"><img src="/logo.down.photo?seq=${photoDTO.ownerNo}" alt="${photoDTO.ownerName}" /></h2>
					<div class="img_area"><img src="<%=IMG_SERVER_URL_PREFIX%>/view.down.photo?uciCode=${photoDTO.uciCode}"/>
						<div class="cont_area">
							<h3 class="img_tit"><span class="uci">[${photoDTO.uciCode}]</span>ns696100264</h3>
							<h3 class="img_tit">${photoDTO.titleKor}</h3>
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
							<%-- <tr>
								<th scope="row">뮤지엄</th>
								<td><b>${statsDTO.museumCount}</b>회</td>
							</tr>
							<tr>
								<th scope="row">컬렉션</th>
								<td><b>${statsDTO.collectionCount}</b>회</td>
							</tr> --%>
						</table>
					</div>
					<div class="cms_rt">
						<h3 class="info_tit">옵션</h3>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="cms_table2">
							<!-- <tr>
								<th scope="row">게티 노출 / 타 서비스 노출</th>
								<td><label>
										<input type="radio" name="serv" />
										ON</label>
									<label>
										<input type="radio" name="serv"/>
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
							</tr> -->
							<tr>
								<th scope="row">블라인드</th>
								<td><label> <input type="radio" name="blind"
										value="2" /> ON
								</label> <label> <input type="radio" name="blind" value="1" />
										OFF
								</label></td>
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
	</div>
</body>
</html>