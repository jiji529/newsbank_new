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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css">
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>
<script src="js/filter.js"></script>
<script src="js/cms_view.js"></script>
<script src="js/cms.js.jsp"></script>
<script src="js/search.js.jsp"></script>
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
		<%@include file="header_admin.jsp" %>
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
<%@include file="content_view.jsp" %>
		</section>
	</div>
</body>
</html>