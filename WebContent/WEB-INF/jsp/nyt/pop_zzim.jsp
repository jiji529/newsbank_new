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
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<link rel="stylesheet" href="css/nyt/base.css" />
	<link rel="stylesheet" href="css/nyt/sub.css" />
	<style type="text/css">
		body { width:420px; min-width:inherit}
	</style>
	
	<script src="js/nyt/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	
		// #폴더이름 변경
		$(document).on("click", ".btn_update", function() {
			
			// 폴더명 변경은 하나씩만 가능하도록 처리
			if($(".pop_folder").find("form fieldset").length > 0) {
				$(".pop_folder").find("form fieldset .btn_back").trigger("click"); 
			} 			
			
			var originName = $(this).parents(".folder_btn_area").siblings("p").text();	
			var bookmark_seq = $(this).attr("value"); console.log("bookmark_seq : " + bookmark_seq);
			var html = '<div class="folder_btn_area"><a href="javascript:void(0)" value="' + bookmark_seq + '">수정</a><a href="javascript:void(0)" value="' + bookmark_seq + '">삭제</a></div>';
			html += '<form style="display:block ;">';
			html += '<fieldset>';
			html += '<legend>폴더 수정 폼</legend>';
			html += '<input id="originName" type="hidden" value="' + originName + '"/>';
			html += '<input id="" class="inputs" type="text" maxlength="20" value="' + originName + '" onkeypress="if(event.keyCode == 13){ complete_folder(); return false; }"/>';
			html += '<div class="folder_btn_area"><a class="btn_complete" href="javascript:void(0)" value="' + bookmark_seq + '">완료</a><a class="btn_back" href="javascript:void(0)" value="' + bookmark_seq + '">취소</a></div>';
			html += '</fieldset>';
			html += '</form>';
			
			$(this).closest("li").html(html);
			$(".inputs").focus();
			$(".inputs").select();
		});
		
		// #폴더 추가
		$(document).on("click", ".btn_add", function() {
			add_folder();
			/* var latestName = $(this).parents(".folder_btn_area").siblings("input").val();
			
			var html = '<p>' + latestName + '</p></div>';
			html += '<div class="folder_btn_area"><a class="btn_update" href="javascript:void(0)">수정</a><a class="btn_delete" href="javascript:void(0)">삭제</a></div>';
			$(this).closest("li").html(html);
			
			//var param = "action=insertBookmark";
			var param = "action=insertFolder";
			$.ajax({
				//url: "/dibs.popOption?"+param,
				url: "/bookmark.api?"+param,
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
			}); */	
		});
		
		// #폴더 추가함수
		function add_folder() {
			var latestName = $("#newFolder").val(); 
			
			var html = '<p>' + latestName + '</p></div>';
			html += '<div class="folder_btn_area"><a class="btn_update" href="javascript:void(0)">수정</a><a class="btn_delete" href="javascript:void(0)">삭제</a></div>';
			$("#newFolder").closest("li").html(html); // 폴더추가 입력란 생성
			
			//var param = "action=insertBookmark";
			var param = "action=insertFolder";
			$.ajax({
				//url: "/dibs.popOption?"+param,
				url: "/bookmark.api?"+param,
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
		}
		
		
		// #폴더 추가 레이아웃
		function add_layout() {
			var html = '<li><div class="folder_btn_area"><a href="javascript:void(0)">수정</a><a href="javascript:void(0)">삭제</a></div>';
			html += '<form style="display:block ;">';
			html += '<fieldset>';
			html += '<legend>폴더 수정 폼</legend>';
			html += '<input type="text" id="newFolder" maxlength="20" onkeypress="if(event.keyCode == 13){ add_folder(); return false; }"/>';
			html += '<div class="folder_btn_area"><a class="btn_add" href="javascript:void(0)">추가</a><a class="btn_cancel" href="javascript:void(0)">취소</a></div>';
			html += '</fieldset>';
			html += '</form></li>';
			
			$(html).appendTo(".pop_folder ul");
		}
		
		// #폴더 추가하기 버튼
		$(document).on("click", ".btn_cart", function() {
			var formTag = $(".pop_folder").find("form").length;
			if(formTag == 0) {
				add_layout();	
			}		
		});
		
		 // #폴더추가 취소
		$(document).on("click", ".btn_cancel", function() {
			$(this).closest("li").remove();
		});
		
		 // #폴더 삭제
		$(document).on("click", ".btn_delete", function() {
			var chk = confirm("폴더 내에 저장된 이미지가 모두 삭제됩니다.\n 정말로 삭제하시겠습니까?");
			
			if(chk == true) {
				var bookmark_seq = $(this).attr("value");
				//var param = "action=deleteBookmark";
				var param = "action=deleteFolder";
				$.ajax({
					//url: "/dibs.popOption?"+param,
					url: "/bookmark.api?"+param,
					type: "POST",
					data: {
						"bookmark_seq" : bookmark_seq
					},
					success: function(data) {
						alert("폴더가 삭제되었습니다.");
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
					}
				});	
				
				$(this).closest("li").remove();
			} 
			
		});
		 
		// #폴더 수정완료
		function complete_folder() {
			var latestName = $(".inputs").val();
			var bookmark_seq = $(".btn_complete").attr("value");
			
			var html = '<p>' + latestName + '</p></div>';
			html += '<div class="folder_btn_area"><a class="btn_update" href="javascript:void(0)" value="'+bookmark_seq+'">수정</a><a class="btn_delete" href="javascript:void(0)" value="'+bookmark_seq+'">삭제</a></div>';
			
			$(".inputs").closest("li").html(html);
			
			//var param = "action=updateBookmark";
			var param = "action=updateFolder";
			$.ajax({
				//url: "/dibs.popOption?"+param,
				url: "/bookmark.api?"+param,
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
		}
		 
		// #폴더 수정완료 
		$(document).on("click", ".btn_complete", function() {
			complete_folder();
		});
		 
		 // #폴더 수정취소
		$(document).on("click", ".btn_back", function() {
			var originName = $("#originName").val();
			var bookmark_seq = $(this).attr("value");
			
			var html = '<p>' + originName + '</p></div>';
			html += '<div class="folder_btn_area"><a class="btn_update" href="javascript:void(0)" value="' + bookmark_seq + '">수정</a><a class="btn_delete" href="javascript:void(0)" value="' + bookmark_seq + '">삭제</a></div>';
			
			$(this).closest("li").html(html);
		});
		
		 // 팝업창 닫으면서 부모창 새로고침
		 function popup_close() {
			 opener.parent.location.reload();
			 window.close();
		 }
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
						<c:if test="${bookmark.bookName ne '기본폴더'}">
							<div class="folder_btn_area"><a class="btn_update" href="javascript:void(0)" value="${bookmark.seq}">수정</a><a class="btn_delete" href="javascript:void(0)" value="${bookmark.seq}">삭제</a></div>
						</c:if>
						<div class="folder_btn_area"></div>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="sum_sec">
			<div class="btn_wrap">
				<div class="btn_cart"><a href="javascript:void(0)">폴더 추가하기</a></div>
				<div class="btn_down"><a href="javascript:void(0)" onclick="popup_close()">닫기</a></div>
			</div>
		</div>
	</div>
</body>
</html>