<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 10. 25. 오후 03:25:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 25.   hoyadev        dibs.mypage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% long currentTimeMills = System.currentTimeMillis(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/mypage.js"></script>

<script type="text/javascript">
	$(document).ready(function(key, val){
		
	});
	/** 개별 다운로드 */
	$(document).on("click", ".btn_down", function() {
		var uciCode = $(this).parent().parent().find("div span:first").text();
		var imgPath = $(this).parent().parent().find("a img").attr("src");
		
		var link = document.createElement("a");
        link.download = uciCode;
        link.href = imgPath;
        link.click();
	});
	
	/** 찜 카테고리 선택 */
	$(document).on("click", ".filter_list li", function() {		
		var choice = $(this).text();
		$(this).attr("selected", "selected");
		$(this).siblings().removeAttr("selected");
		var filter_list = "<ul class=\"filter_list\">" + $(this).parents(".filter_list").html() + "</ul>";
		$(this).parents(".filter_title").children().remove().end().html(choice + filter_list);
		
		dibsList();
	});
	
	/** 찜 목록 */
	function dibsList() {
		$("#wish_list2 ul:first").empty();
		
		var member_seq = "1002"; // 사용자 고유번호		
		var bookmark_seq = $(".filter_title:nth-of-type(2) .filter_list").find("[selected=selected]").val();
		
		var html = "";
		$.ajax({
			url: "/DibsJSON",
			type: "GET",
			dataType: "json",
			data: {
				"member_seq" : member_seq,
				"bookmark_seq" : bookmark_seq
			},
			success: function(data){ console.log(data);
				$(data.result).each(function(key, val) {
					html += '<li class="thumb"> <a href="/view.picture?uciCode='+val.uciCode+'"><img src="images/serviceImages' + val.viewPath + '&dummy=<%= currentTimeMills%>"/></a>';
					html += '<div class="thumb_info">';
					html += '<input type="checkbox" value="'+val.uciCode+'"/>';
					html += '<span>'+val.uciCode+'</span><span>'+val.copyright+'</span></div>';
					html += '<ul class="thumb_btn">';
					html += '<li class="btn_down">다운로드</li>';
					html += '<li class="btn_del">삭제</li>';
					html += '</ul></li>';					
				});
				$(html).appendTo("#wish_list2 ul:first");
			}, 
			error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
		});
	} 
	
	/** DB 삭제함수 */
	function dibsDelete(member_seq, uciCode) {
		var param = "action=delete";
		
		$.ajax({
			url: "/dibs.myPage?"+param,
			type: "POST",
			data: {
				"member_seq" : member_seq,
				"photo_uciCode" : uciCode
			},
			success: function(data){ }, 
			error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
		}); 
	}
	
	/** 개별 삭제 */
	$(document).on("click", ".btn_del", function() {
		var member_seq = "1002"; // 사용자 고유번호
		var uciCode = $(this).parent().parent().find("div span:first").text();
		$(this).closest(".thumb").remove();
		
		dibsDelete(member_seq, uciCode);		
	});
	
	/** 다중선택 삭제 */
	$(document).on("click", ".sort_del", function() {
		var member_seq = "1002"; // 사용자 고유번호
		$("#wish_list2 input:checkbox:checked").each(function(index) {
			var uciCode = $(this).val();
			dibsDelete(member_seq, uciCode);
			$(this).closest(".thumb").remove();
		});
	});
	
	/** 전체선택 */
	$(document).on("click", "input[name='checkAll']", function() {
		if($("input[name='checkAll']").prop("checked")) {
			$("#wish_list2 input:checkbox").prop("checked", true);
		}else {
			$("#wish_list2 input:checkbox").prop("checked", false);
		}
	});
	
	function go_photoView(uciCode) {
		$("#uciCode").val(uciCode);
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
					<c:if test="${MemberInfo.type eq 'M'}">
						<li>
							<a href="/account.mypage">정산 관리</a>
						</li>
						<li>
							<a href="/cms">사진 관리</a>
						</li>
					</c:if>
					<li>
						<a href="/info.mypage">회원정보 관리</a>
					</li>
					<li class="on">
						<a href="/dibs.myPage">찜관리</a>
					</li>
					<li>
						<a href="/cart.myPage">장바구니</a>
					</li>
					<li>
						<a href="/buylist.mypage">구매내역</a>
					</li>
				</ul>
				<!-- 컬렉션 생기면 추가 <ul class="mp_tab2">
					<li class="on"><a href="#">사진 찜 관리</a></li>
					<li><a href="#">컬렉션 찜 관리</a></li>
				</ul> -->
			</div>
			<div class="table_head">
				<h3>찜 관리</h3>
			</div>
			<!-- 필터시작 -->
			<div class="filters">
				<ul>
					<li class="filter_title folder_ico">찜 그룹</li>
					<li class="filter_title"> 찜한 사진 전체
						<ul class="filter_list">
							<c:forEach items="${bookmarkList}" var="bookmark">
								<li value="${bookmark.seq}">${bookmark.bookName}</li>
							</c:forEach>
							<li class="folder_edit">
								<a href="#" >그룹 관리</a>
							</li>
						</ul>
					</li>
				</ul>
				<div class="filter_rt">
					<div class="result"><b class="count">123</b>개의 결과</div>
					<div class="paging"><a href="#" class="prev" title="이전페이지"></a>
						<input type="text" class="page" value="1" />
						<span>/</span><span class="total">1234</span><a href="#" class="next" title="다음페이지"></a></div>
					<div class="viewbox">
						<select name="limit">
							<option value="40" selected="selected">40</option>
							<option value="80">80</option>
							<option value="120">120</option>
						</select>
					</div>
				</div>
			</div>
			<!-- 필터끝 -->
			<form class="view_form" method="post" action="/view.photo" name="view_form" >
				<input type="hidden" name="uciCode" id="uciCode"/>
			</form>
			<div class="btn_sort"><span class="task_check">
				<input type="checkbox" name="checkAll"/>
				</span>
				<ul class="button">
					<li class="sort_down">장바구니</li>
					<li class="sort_del">삭제</li>
					<li class="sort_menu">폴더이동</li>
				</ul>
			</div>
			<section id="wish_list2">
				<ul>					
					<c:forEach items="${dibsPhotoList}" var="PhotoDTO">
						<li class="thumb"> <a href="#" onclick="go_photoView('${PhotoDTO.uciCode}')"><img src="images/serviceImages${PhotoDTO.getViewPath()}&dummy=<%= currentTimeMills%>"/></a>
							<div class="thumb_info">
								<input type="checkbox" value="${PhotoDTO.uciCode}"/>
								<span>${PhotoDTO.uciCode}</span><span>${PhotoDTO.copyright}</span></div>
							<ul class="thumb_btn">
								<li class="btn_down">다운로드</li>
								<li class="btn_del">삭제</li>
							</ul>
						</li>
					</c:forEach>
				</ul>
			</section>
			<div class="more"><a href="#">다음 페이지</a></div>
		</section>
	</div>
</body>
</html>
