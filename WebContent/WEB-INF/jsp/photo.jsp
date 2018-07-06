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
  2017. 10. 11.   hoyadev       picture
  2017. 10. 16.   hoyadev       searchList()
  2017. 11. 09.   hoyadev       go_photoView()
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@page import="com.dahami.newsbank.web.dto.MemberDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>뉴스뱅크</title>
<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css" />
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>
<script src="js/search.js.jsp"></script>
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script type="text/javascript">
	var loginInfo = "${loginInfo}";
	var searchTarget = "search";
	
	$(document).ready(function() {
		initSearchParam();
		search();
	});
	
	// 보기 변경 / 스퀘어, 그리드
	$(document).on("click", ".square", function() {
		$(".viewbox > .size > span.grid").removeClass("on");
		$(".viewbox > .size > span.square").addClass("on");
		$("#search_list").addClass("square").removeClass("grid"); 
	});
	$(document).on("click", ".grid", function() {
		$(".viewbox > .size > span.square").removeClass("on"); 
		$(".viewbox > .size > span.grid").addClass("on");
		$("#search_list").addClass("grid").removeClass("square");
	});

	$(document).on("click", "div .paging a.prev", function() {
		var prev = $("input[name=pageNo]").val() - 1;
		goPage(prev);
	});
	$(document).on("click", "div .paging a.next", function() {
		var next = $("input[name=pageNo]").val() - (-1);
		goPage(next);
	});
	
	$(document).on("click", "a[name=nextPage]", function() {
		var next = $("input[name=pageNo]").val() - (-1);
		goPage(next);
	});
	
	function goPage(pageNo) {
		if(pageNo < 1) {
			pageNo = 1;
		}
		else if(pageNo > $("div .paging span.total").html()) {
			pageNo = $("div .paging span.total").html();
		}
		$("input[name=pageNo]").val(pageNo);
		search();
	}
	
	// #찜하기
	$(document).on("click", ".over_wish", function() {
		var login_state = login_chk();
		
		if(login_state) { // 로그인 상태에서만 찜활성화
			var uciCode = $(this).attr("value");		
			var bookName = "기본폴더";
			var state = $(this).hasClass("on");
			
			if(state) {
				// 찜 해제
				$(this).removeClass("on");
				var param = "action=deleteBookmark";
			}else {
				// 찜 하기
				$(this).addClass("on");
				var param = "action=insertBookmark";
			}
			
			$.ajax({
				url: "/bookmark.api?"+param,
				type: "POST",
				data: {
					"uciCode" : uciCode,
					"bookName" : bookName
				},
				success: function(data) {
					
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		
		} else { // 비회원
			if(confirm("회원 서비스입니다.\n로그인 하시겠습니까?")) {
				$(".gnb_right li").first().children("a").click();	
			}
		}
				
	});	
	
	// #다운로드
	$(document).on("click", ".over_down", function() {
		var uciCode = $(this).attr("value");
		<%-- 후불 여부에 따른 다운로드 --%>
		if(login_isDeferred()) {
			downDiferred(uciCode); // 후불 다운로드	
		}
		else {
			downOutline(uciCode); // 시안 다운로드
		}
	});
	
	
	function login_chk() { // 로그인 여부 체크
		var login_state = false;
		if("${loginInfo}" != ""){ // 로그인 시
			login_state = true;
		}
		return login_state;
	}
	
	function login_isDeferred() {
		if(login_chk()) {
			if("${loginInfo.deferred}" != "<%=MemberDTO.DEFERRED_NORMAL%>") {
				return true;
			}
		}
		return false;
	}
	
	function checkNumber(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) 
			|| (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 16 || keyID == 35 || keyID == 36)		
		)
		{
			return;
		}
		else if(keyID == 13) {
			search();
		}
		else
		{
			return false;
		}
	}
</script>
</head>
<body class="fixed">
	<div class="wrap">
		<div class="fixed_layer">
<%@include file="header.jsp" %>
		<!-- 필터시작 -->
<%@include file="search_filter.jsp" %>
		<!-- 필터끝 -->
		</div>
		<section id="search_list" class="search_list grid">
		<ul>

		</ul>
		</section>
	
		<div class="more">
			<a href="javascript:void(0)" name="nextPage">다음 페이지</a>
		</div>
<%@include file="footer.jsp"%>
	</div>
<%@include file="view_form.jsp"%>
<%@include file="down_frame.jsp" %>
</body>
</html>