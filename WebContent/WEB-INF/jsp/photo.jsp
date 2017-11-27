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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
 String IMG_SERVER_URL_PREFIX = "http://www.dev.newsbank.co.kr";
// String IMG_SERVER_URL_PREFIX = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/photo.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		search();
		setDatepicker();	
		
	});
	
	$(document).on("click", ".square", function() {
		$(".viewbox > .size > span.grid").removeClass("on");
		$(".viewbox > .size > span.square").addClass("on");
		$("#search_list1").css("display", "none");
		$("#search_list2").css("display", "block");
	});

	$(document).on("click", ".grid", function() {
		$(".viewbox > .size > span.square").removeClass("on");
		$(".viewbox > .size > span.grid").addClass("on");
		$("#search_list1").css("display", "block");
		$("#search_list2").css("display", "none");
	});

	$(document).on("click", ".filter_list li", function() {
		var choice = $(this).text();
		$(this).siblings().removeAttr("selected");
		$(this).attr("selected", "selected");
		
		if(!$(this).hasClass("choice")){ // 직접 선택을 제외한 나머지는 slide up 이벤트 적용
			var filter_list = "<ul class=\"filter_list\">" + $(this).parents(".filter_list").html() + "</ul>";
			var titleTag = $(this).parents(".filter_title").find("span");
			var titleStr = titleTag.html();
			titleStr = titleStr.substring(0, titleStr.indexOf(":")) + ": " + choice;
			titleTag.html(titleStr);
			
			$(this).closest(".filter_list").stop().slideUp("fast");		
			// 필터 바꾸면 페이지 번호 초기화
			$("input[name=pageNo]").val("1");
			search();
		}else {
			var startDate = $("#startDate").val();
			var endDate = $("#endDate").val();
			var choice = startDate + "~" + endDate;
			var titleTag = $(this).parents(".filter_title").find("span");
			var titleStr = titleTag.html();
			titleStr = titleStr.substring(0, titleStr.indexOf(":")) + ": " + choice;
			titleTag.html(titleStr);
		}
	});
	
	$(document).on("click", ".btn_cal", function() {
		// 기간 : 직접선택
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		var choice = startDate + "~" + endDate;
		$(".choice").attr("value", choice);
		$(this).closest(".filter_list").stop().slideUp("fast");
		
		// 필터 바꾸면 페이지 번호 초기화
		$("input[name=pageNo]").val("1");
		search();
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
			var bookName = "기본그룹";
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
				url: "/view.photo?"+param,
				type: "POST",
				data: {
					"photo_uciCode" : uciCode,
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
		var login_state = login_chk();
		
		if(login_state) { // 로그인 시
			var uciCode = $(this).attr("value");
			down(uciCode); // 다운로드
			
		} else { // 비회원
			if(confirm("회원 서비스입니다.\n로그인 하시겠습니까?")) {
				$(".gnb_right li").first().children("a").click();	
			}
		}
	});
	
	
	function login_chk() { // 로그인 여부 체크
		var login_state = false;
		if("${loginInfo}" != ""){ // 로그인 시
			login_state = true;
		}
		return login_state;
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
	
	function search() {
		var keyword = $("#keyword_current").val();
		keyword = $.trim(keyword);
		var pageNo = $("input[name=pageNo]").val();
		var transPageNo = pageNo.match(/[0-9]/g).join("");
		if(pageNo != transPageNo) {
			pageNo = transPageNo;
			$("input[name=pageNo]").val(pageNo);
		}
		var pageVol = $("select[name=pageVol]").val();
		var contentType = $(".filter_contentType .filter_list").find("[selected=selected]").attr("value");
		var media = $(".filter_media .filter_list").find("[selected=selected]").attr("value");
		var duration = $(".filter_duration .filter_list").find("[selected=selected]").attr("value");
		var colorMode = $(".filter_color .filter_list").find("[selected=selected]").attr("value");
		var horiVertChoice = $(".filter_horizontal .filter_list").find("[selected=selected]").attr("value");
		var size = $(".filter_size .filter_list").find("[selected=selected]").attr("value");
		var portRight = $(".filter_portRight .filter_list").find("[selected=selected]").attr("value");
		var includePerson = $(".filter_incPerson .filter_list").find("[selected=selected]").attr("value");
		var group = $(".filter_group .filter_list").find("[selected=selected]").attr("value");

		var searchParam = {
				"keyword":keyword
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
			success : function(data) { //console.log(data);
				$("#search_list1 ul").empty();
				$("#search_list2 ul").empty();
				$(data.result).each(function(key, val) {
					html += "<li class=\"thumb\"><a href=\"javascript:void(0)\" onclick=\"go_photoView('" + val.uciCode + "')\"><img src=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>\"></a>";
					html += "<div class=\"info\">";
					html += "<div class=\"photo_info\">" + val.copyright + "</div>";
					html += "<div class=\"right\">";
					html += "<a class=\"over_wish\" href=\"javascript:void(0)\" value=\"" + val.uciCode + "\">찜</a> <a class=\"over_down\" href=\"javascript:void(0)\" value=\"" + val.uciCode + "\">시안 다운로드</a> </div>";
					html += "</div>";
					html += "</li>";
				});
				$(html).appendTo("#search_list1 ul");
				$(html).appendTo("#search_list2 ul");
				var totalCount = $(data.count)[0];
				var totalPage = $(data.totalPage)[0];
				$("div .result b").html(totalCount);
				$("div .paging span.total").html(totalPage);
				
				if("${loginInfo}" != ""){ // 로그인 시, 찜 목록을 불러오기
					userBookmarkList();
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}
	
	function userBookmarkList() { // 사용자가 찜한 북마크 목록
		$.ajax({
			type: "POST",
			url: "bookmarkPhoto.api",
			dataType: "json",
			success : function(data) { 
				$(data.result).each(function(key, val) {
					var uciCode = val.uciCode;
					$("#search_list1 ul .over_wish").each(function(idx, value) { // 가로맞춤 보기
						var list_uci = $("#search_list1 ul .over_wish").eq(idx).attr("value");
						
						if(list_uci == uciCode) {
							$("#search_list1 ul .over_wish").eq(idx).addClass("on");
						}
					});
					
					$("#search_list2 ul .over_wish").each(function(idx, value) { // 사각형 보기
						var list_uci = $("#search_list2 ul .over_wish").eq(idx).attr("value");
						if(list_uci == uciCode) {
							console.log(list_uci);
							$("#search_list2 ul .over_wish").eq(idx).addClass("on");
						}
					});
				});
			}
		});
	}
	
	function go_photoView(uciCode) {
		$("#uciCode").val(uciCode);
		view_form.submit();
	}
</script>
</head>
<body class="fixed">
	<div class="wrap">
		<div class="fixed_layer">
			<%@include file="header.jsp" %>
			<!-- 필터시작 -->
			<div class="filters">
				<ul>
					<li class="filter_title filter_ico">검색필터</li>
					<li class="filter_title filter_media">
						<c:if test="${seq eq '0'}">
							<span>매체 :전체</span>
						</c:if>
						<c:if test="${seq ne '0'}">
							<%-- <span>매체 :${seq}</span> --%>
							<c:forEach items="${mediaList}" var="media">
								<c:if test="${seq eq media.seq}">
									<span>매체 :${media.name}</span>
								</c:if>
							</c:forEach>
						</c:if>
						<ul class="filter_list">
							<c:if test="${seq eq '0'}">
								<li value="0" selected="selected">전체</li>
							</c:if>
							<c:if test="${seq ne '0'}">
								<li value="0">전체</li>
							</c:if>
							
							<c:forEach items="${mediaList}" var="media">
							
								<c:if test="${seq eq media.seq}">
									<li value="${media.seq }" selected="selected">${media.name }</li>
								</c:if>
								
								<c:if test="${seq ne media.seq}">
									<li value="${media.seq }">${media.name }</li>
								</c:if>
																
							</c:forEach>
						</ul>
					</li>
					<li class="filter_title filter_duration">
						<span>기간 : 전체</span>
						<ul class="filter_list">
							<li value="" selected="selected">전체</li>
							<li value="1d">1일</li>
							<li value="1w">1주</li>
							<li value="1m">1달</li>
							<li value="1y">1년</li>
							<li value="choice" class="choice">
								직접 입력
								<div class="calendar">
									<div class="cal_input">
										<input type="text" class="datepicker" id="startDate" title="검색기간 시작일" />
										<a href="javascript:void(0)" class="ico_cal">달력</a>
									</div>
									<div class="cal_input">
										<input type="text" class="datepicker" id="endDate" title="검색기간 마지막일" />
										<a href="javascript:void(0)" class="ico_cal">달력</a>
									</div>
									<button class="btn_cal" type="button">적용</button>
								</div>
							</li>
						</ul>
					</li>
					<%-- 1차 제외 
					<li class="filter_title filter_color">
						<span>컬러/흑백 :전체</span>
						<ul class="filter_list">
							<li value="<%=SearchParameterBean.COLOR_ALL%>" selected="selected">전체</li>
							<li value="<%=SearchParameterBean.COLOR_YES%>">컬러</li>
							<li value="<%=SearchParameterBean.COLOR_NO%>">흑백</li>
						</ul>
					</li> --%>
					<li class="filter_title filter_horizontal">
						<span>가로/세로 : 전체</span>
						<ul class="filter_list">
							<li value="<%=SearchParameterBean.HORIZONTAL_ALL%>" selected="selected">전체</li>
							<li value="<%=SearchParameterBean.HORIZONTAL_YES%>">가로</li>
							<li value="<%=SearchParameterBean.HORIZONTAL_NO%>">세로</li>
						</ul>
					</li>
					<li class="filter_title filter_size">
						<span>크기 : 전체</span>
						<ul class="filter_list">
							<li value="<%=SearchParameterBean.SIZE_ALL%>" selected="selected">전체</li>
							<li value="<%=SearchParameterBean.SIZE_LARGE%>">3,000 px 이상</li>
							<li value="<%=SearchParameterBean.SIZE_MEDIUM%>">1,000~3,000 px</li>
							<li value="<%=SearchParameterBean.SIZE_SMALL%>">1,000 px 이하</li>
						</ul>
					</li>	
				</ul>
				<div class="filter_rt">
					<div class="result">
						<b class="count">0</b>
						개의 결과
					</div>
					<div class="paging">
						<a href="javascript:void(0)" class="prev" title="이전페이지"></a>
						<input type="text" name="pageNo" class="page" value="1"  onkeydown="return checkNumber(event);" onblur="search()"/>
						<span>/</span>
						<span class="total">0</span>
						<a href="javascript:void(0)" class="next" title="다음페이지"></a>
					</div>
					<div class="viewbox">
						<div class="size">
							<span class="grid on">가로맞춤보기</span>
							<span class="square">사각형보기</span>
						</div>
						<select name="pageVol" onchange="search()">
							<option value="40" selected="selected">40</option>
							<option value="80">80</option>
							<option value="120">120</option>
						</select>
					</div>
				</div>
			</div>
			<!-- 필터끝 -->
		</div>
		<form class="view_form" method="post" action="/view.photo" name="view_form" >
			<input type="hidden" name="uciCode" id="uciCode"/>
		</form>
		<section id="search_list1">
		<ul>
			<c:forEach items="${picture}" var="PhotoDTO">
				<li class="thumb">
					<%-- <a href="/view.photo?uciCode=${PhotoDTO.uciCode}"> --%>
					<a href="javascript:void(0)" onclick="go_photoView('${PhotoDTO.uciCode}')">
						<img src="/list.down.photo?uciCode=${PhotoDTO.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>">
					</a>
					<div class="info">
						<div class="photo_info">${PhotoDTO.copyright}</div>
						<div class="right">
							<a class="over_wish" href="javascript:void(0)" value="${PhotoDTO.uciCode}">찜</a>
							<a class="over_down" href="javascript:void(0)" value="${PhotoDTO.uciCode}">시안 다운로드</a>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
		</section>
		<section id="search_list2" style="display: none;">
		<ul>
			<c:forEach items="${picture}" var="PhotoDTO">
				<li class="thumb">
					<%-- <a href="/view.photo?uciCode=${PhotoDTO.uciCode}"> --%>
					<a href="javascript:void(0)" onclick="go_photoView('${PhotoDTO.uciCode}')">
						<img src="/list.down.photo?uciCode=${PhotoDTO.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>">
					</a>
					<div class="info">
						<div class="photo_info">${PhotoDTO.copyright}</div>
						<div class="right">
							<a class="over_wish" href="javascript:void(0)" value="${PhotoDTO.uciCode}">찜</a>
							<a class="over_down" href="javascript:void(0)" value="${PhotoDTO.uciCode}">시안 다운로드</a>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
		</section>
		<div class="more">
			<a href="javascript:void(0)" name="nextPage">다음 페이지</a>
		</div>
		<%@include file="footer.jsp"%>
	</div>
<form id="downForm" method="post"  target="downFrame">
	<input type="hidden" id="downUciCode" name="uciCode" />
	<input type="hidden" id="downType" name="type" />
	<input type="hidden" name="dummy" value="<%=com.dahami.common.util.RandomStringGenerator.next()%>" />
</form>
<iframe id="downFrame" name="downFrame" style="display:none" >
</iframe>
</body>
</html>