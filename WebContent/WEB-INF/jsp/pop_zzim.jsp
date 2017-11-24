<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 11. 14. 오전 09:38:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 30.   hoyadev        pop_zzim (dibs.myPage 내부) 
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<link rel="stylesheet" href="css/base.css" />
	<link rel="stylesheet" href="css/sub.css" />
	<style type="text/css">
		body { width:420px; min-width:inherit}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	
		// #폴더이름 변경
		$(document).on("click", ".btn_update", function() {
			var originName = $(this).parents(".folder_btn_area").siblings("p").text();	
			var bookmark_seq = $(this).attr("value");
			var html = '<div class="folder_btn_area"><a href="javascript:void(0)">수정</a><a href="javascript:void(0)">삭제</a></div>';
			html += '<form style="display:block ;">';
			html += '<fieldset>';
			html += '<legend>폴더 수정 폼</legend>';
			html += '<input id="originName" type="hidden" value="' + originName + '"/>';
			html += '<input class="inputs" type="text" maxlength="20" value="' + originName + '"/>';
			html += '<div class="folder_btn_area"><a class="btn_complete" href="javascript:void(0)" value="' + bookmark_seq + '">완료</a><a class="btn_back" href="javascript:void(0)" value="' + bookmark_seq + '">취소</a></div>';
			html += '</fieldset>';
			html += '</form>';
			
			$(this).closest("li").html(html);
			$(".inputs").focus();
			$(".inputs").select();
		});
		
		// #폴더 추가
		$(document).on("click", ".btn_add", function() {
			var latestName = $(this).parents(".folder_btn_area").siblings("input").val();
			
			var html = '<p>' + latestName + '</p></div>';
			html += '<div class="folder_btn_area"><a class="btn_update" href="javascript:void(0)">수정</a><a class="btn_delete" href="javascript:void(0)">삭제</a></div>';
			$(this).closest("li").html(html);
			
			var param = "action=insertBookmark";
			$.ajax({
				url: "/dibs.popOption?"+param,
				type: "POST",
				data: {
					"bookName" : latestName
				},
				success: function(data) {					
					
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}, complete: function() {
					
				}
			});	
		});
		
		// #폴더 추가 레이아웃
		function add_layout() {
			var html = '<li><div class="folder_btn_area"><a href="javascript:void(0)">수정</a><a href="javascript:void(0)">삭제</a></div>';
			html += '<form style="display:block ;">';
			html += '<fieldset>';
			html += '<legend>폴더 수정 폼</legend>';
			html += '<input type="text" maxlength="20"/>';
			html += '<div class="folder_btn_area"><a class="btn_add" href="javascript:void(0)">추가</a><a class="btn_cancel" href="javascript:void(0)">취소</a></div>';
			html += '</fieldset>';
			html += '</form></li>';
			
			$(html).appendTo(".pop_folder ul");
		}
		
		// #폴더 추가하기 버튼
		$(document).on("click", ".btn_cart", function() {
			add_layout();
		});
		
		 // #폴더추가 취소
		$(document).on("click", ".btn_cancel", function() {
			$(this).closest("li").remove();
		});
		
		 // #폴더 삭제
		$(document).on("click", ".btn_delete", function() {
			var bookmark_seq = $(this).attr("value");
			var param = "action=deleteBookmark";
			$.ajax({
				url: "/dibs.popOption?"+param,
				type: "POST",
				data: {
					"bookmark_seq" : bookmark_seq
				},
				success: function(data) {
					
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});	
			
			$(this).closest("li").remove();
		});
		 
		 // #폴더 수정완료
		$(document).on("click", ".btn_complete", function() {
			var latestName = $(".inputs").val();
			var bookmark_seq = $(this).attr("value");
			
			var html = '<p>' + latestName + '</p></div>';
			html += '<div class="folder_btn_area"><a class="btn_update" href="javascript:void(0)" value="'+bookmark_seq+'">수정</a><a class="btn_delete" href="javascript:void(0)" value="'+bookmark_seq+'">삭제</a></div>';
			
			$(this).closest("li").html(html);
			
			var param = "action=updateBookmark";
			$.ajax({
				url: "/dibs.popOption?"+param,
				type: "POST",
				data: {
					"bookName" : latestName,
					"bookmark_seq" : bookmark_seq
				},
				success: function(data) {
					//console.log(data);
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});	
		});
		 
		 // #폴더 수정취소
		$(document).on("click", ".btn_back", function() {
			var originName = $("#originName").val();
			
			var html = '<p>' + originName + '</p></div>';
			html += '<div class="folder_btn_area"><a class="btn_update" href="javascript:void(0)">수정</a><a class="btn_delete" href="javascript:void(0)">삭제</a></div>';
			
			$(this).closest("li").html(html);
		});
		
	</script>
</head>
<body>
	<div class="wrap_pop">
		<div class="view_rt_top">
			<h3>찜 폴더 관리</h3>
		</div>
		<div class="pop_folder">
			<ul>
				<c:forEach items="${bookmarkList}" var="bookmark">
					<li>
						<p>${bookmark.bookName}</p>
						<c:if test="${bookmark.bookName ne '기본그룹'}">
							<div class="folder_btn_area"><a class="btn_update" href="javascript:void(0)" value="${bookmark.seq}">수정</a><a class="btn_delete" href="javascript:void(0)" value="${bookmark.seq}">삭제</a></div>
						</c:if>
						<div class="folder_btn_area"></div>
					</li>
				</c:forEach>
				<!-- <li>
					<p>기본 폴더</p>
					<div class="folder_btn_area"></div>
				</li>
				<li>
					<p>일이삼사오육칠팔구십일이삼사오육칠팔구십</p>
					<div class="folder_btn_area"><a class="btn_update" href="javascript:void(0)">수정</a><a class="btn_delete" href="javascript:void(0)">삭제</a></div>
				</li> -->
				<!-- <li>
					<p>수정눌렀을때</p>
					<div class="folder_btn_area"><a href="javascript:void(0)">수정</a><a href="javascript:void(0)">삭제</a></div>
					<form style="display:block ;">
						<fieldset>
							<legend>폴더 수정 폼</legend>
							<input type="text" maxlength="20" />
							<div class="folder_btn_area"><a href="javascript:void(0)">완료</a><a href="javascript:void(0)">취소</a></div>
						</fieldset>
					</form>
				</li> -->
			</ul>
		</div>
		<div class="sum_sec">
			<div class="btn_wrap">
				<div class="btn_cart"><a href="javascript:void(0)">폴더 추가하기</a></div>
				<div class="btn_down"><a href="javascript:void(0)" onclick="javascript:self.close()">닫기</a></div>
			</div>
		</div>
	</div>
</body>
</html>