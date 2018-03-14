<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 10. 16. 오후 16:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 16.   hoyadev        cms
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>

<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css">
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>

<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/mypage.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var cms_keyword = '${cms_keyword}';
		
		if(cms_keyword) { // 사진관리 상세페이지에서 이미지 검색 시
			$("#cms_keyword").val(cms_keyword);
			cms_search();
		}else { // 최초 사진 관리 페이지 접근 시
			search();
		}
		
		setDatepicker();
	});
	
	function setDatepicker() {
		$( ".datepicker" ).datepicker({
         changeMonth: true, 
         dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
         monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         showButtonPanel: true, 
         currentText: '오늘 날짜', 
         closeText: '닫기', 
         dateFormat: "yymmdd"
	  });
	}
	
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
	
	$(document).on("keypress", "#keyword", function(e) {
		if(e.keyCode == 13) {	// 엔터
			//$("#keyword_current").val($("#keyword").val());

			// 키워드 바꾸면 페이지 번호 초기화
			$("input[name=pageNo]").val("1");
			
			search();
		}
	});
	
	$(document).on("keypress", "#cms_keyword", function(e) {
		if(e.keyCode == 13) {	// 엔터
			//$("#keyword_current").val($("#keyword").val());

			// 키워드 바꾸면 페이지 번호 초기화
			$("input[name=pageNo]").val("1");
			cms_search();
		}
	});
	
	$(document).on("click", "#cms_searchBtn", function() {
		$("input[name=pageNo]").val("1");
		cms_search();
	});
	
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
			cms_search();
		}
		else
		{
			return false;
		}
	}
	
	function goPage(pageNo) {
		if(pageNo < 1) {
			pageNo = 1;
		}
		else if(pageNo > $("div .paging span.total").html()) {
			pageNo = $("div .paging span.total").html();
		}
		$("input[name=pageNo]").val(pageNo);
		cms_search();
	}
	
	$(document).on("click", ".filter_list li", function() {
		var choice = $(this).text();
		$(this).siblings().removeAttr("selected");
		$(this).attr("selected", "selected");
		
		if(!$(this).hasClass("choice")){
			var choice = $(this).text();
			$(this).attr("selected", "selected");
			$(this).siblings().removeAttr("selected");
			var filter_list = "<ul class=\"filter_list\">"+$(this).parents(".filter_list").html()+"</ul>";
			$(this).parents(".filter_title").children().remove().end().html(choice+filter_list);
			
			// 필터 바꾸면 페이지 번호 초기화
			$("input[name=pageNo]").val("1");
			cms_search();
		}else {
			var startDate = $("#startDate").val();
			var endDate = $("#endDate").val();
			var choice = startDate + "~" + endDate;
			var duration = $(".filter_duration").text();
			//console.log(duration);
			/* var titleTag = $(this).parents(".filter_title").find("span");
			var titleStr = titleTag.html();
			console.log(titleStr);
			titleStr = titleStr.substring(0, titleStr.indexOf(":")) + ": " + choice;
			titleTag.html(titleStr); */
		}
		
	});
	
	function search() {
		var keyword = $("#keyword").val();
		
		var pageNo = $("input[name=pageNo]").val();
		var transPageNo = pageNo.match(/[0-9]/g).join("");
		if(pageNo != transPageNo) {
			pageNo = transPageNo;
			$("input[name=pageNo]").val(pageNo);
		}
		
		var pageVol = $("select[name=pageVol]").val();
		var media = $(".filter_media .filter_list").find("[selected=selected]").attr("value");
		var duration = $(".filter_duration .filter_list").find("[selected=selected]").attr("value");
		var colorMode = $(".filter_color .filter_list").find("[selected=selected]").attr("value");
		var horiVertChoice = $(".filter_horizontal .filter_list").find("[selected=selected]").attr("value");
		var size = $(".filter_size .filter_list").find("[selected=selected]").attr("value");
		
		var searchParam = {
				"keyword":keyword
				, "pageNo":pageNo
				, "pageVol":pageVol
				, "media":media
				, "duration":duration
				, "colorMode":colorMode
				, "horiVertChoice":horiVertChoice
				, "size":size
				//, "id":id
		};
		
		$("#keyword").val(keyword);
		
		var html = "";
		$.ajax({
			type: "POST",
			async: false,
			dataType: "json",
			data: searchParam,
			timeout: 1000000,
			url: "cms.search",
			success : function(data) { //console.log(data);
				$(data.result).each(function(key, val) {	
					var blind = (val.saleState == 2 || val.saleState == 3) ? "blind" : "";  					
					html += "<li class=\"thumb\"><a href=\"#\" onclick=\"go_cmsView('" + val.uciCode + "')\"><img src=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>\"></a>";
					html += "<div class=\"thumb_info\"><input type=\"checkbox\" value=\""+ val.uciCode +"\"/><span>" + val.uciCode + "</span><span>" + val.copyright + "</span></div>";
					html += "<ul class=\"thumb_btn\"> <li class=\"btn_down\"><a href=\"<%=IMG_SERVER_URL_PREFIX%>/service.down.photo?uciCode=" + val.uciCode + "\" download>다운로드</a></li>	<li class=\"btn_del\" value=\"" + val.uciCode + "\"><a>삭제</a></li> <li class=\"btn_view " + blind + "\" value=\"" + val.uciCode + "\"><a>블라인드</a></li> </ul>";
				});
				$("#cms_list2 ul").html(html);
				var totalCount = $(data.count)[0];
				var totalPage = $(data.totalPage)[0];
				$("div .result b").html(totalCount);
				$("div .paging span.total").html(totalPage);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}
	
	function cms_search() {
		var keyword = $("#cms_keyword").val();
		
		var pageNo = $("input[name=pageNo]").val();
		var transPageNo = pageNo.match(/[0-9]/g).join("");
		if(pageNo != transPageNo) {
			pageNo = transPageNo;
			$("input[name=pageNo]").val(pageNo);
		}
		
		var pageVol = $("select[name=pageVol]").val();
		var media = $(".filter_media .filter_list").find("[selected=selected]").attr("value");
		var duration = $(".filter_duration .filter_list").find("[selected=selected]").attr("value");
		var colorMode = $(".filter_color .filter_list").find("[selected=selected]").attr("value");
		var horiVertChoice = $(".filter_horizontal .filter_list").find("[selected=selected]").attr("value");
		var size = $(".filter_size .filter_list").find("[selected=selected]").attr("value");
		
		var searchParam = {
				"keyword":keyword
				, "pageNo":pageNo
				, "pageVol":pageVol
				, "media":media
				, "duration":duration
				, "colorMode":colorMode
				, "horiVertChoice":horiVertChoice
				, "size":size
				//, "id":id
		};
		
		console.log(searchParam);
		
		$("#keyword_current").val(keyword);
		
		var html = "";
		$.ajax({
			type: "POST",
			async: false,
			dataType: "json",
			data: searchParam,
			timeout: 1000000,
			url: "cms.search",
			success : function(data) { 
				$(data.result).each(function(key, val) {	
					var blind = (val.saleState == 2 || val.saleState == 3) ? "blind" : "";
					html += "<li class=\"thumb\"> <a href=\"#\" onclick=\"go_cmsView('" + val.uciCode + "')\"><img src=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>\" /></a>";
					html += "<div class=\"thumb_info\"><input type=\"checkbox\" value=\""+ val.uciCode +"\"/><span>" + val.uciCode + "</span><span>" + val.copyright + "</span></div>";
					html += "<ul class=\"thumb_btn\"> <li class=\"btn_down\"><a href=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "\" download>다운로드</a></li>	<li class=\"btn_del\" value=\"" + val.uciCode + "\"><a>삭제</a></li> <li class=\"btn_view " + blind + "\" value=\"" + val.uciCode + "\"><a>블라인드</a></li> </ul>";					
				});
				$("#cms_list2 ul").html(html);
				var totalCount = $(data.count)[0];
				var totalPage = $(data.totalPage)[0];
				$("div .result b").html(totalCount);
				$("div .paging span.total").html(totalPage);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}
	
	function go_cmsView(uciCode) {
		$("#uciCode").val(uciCode);
		view_form.submit();
	}
	
	// #사진관리 삭제
	$(document).on("click", ".btn_del", function() {
		var uciCode = $(this).attr("value");		
		var param = "action=deletePhoto";
		
		$.ajax({
			url: "/cms?"+param,
			type: "POST",
			data: {
				"uciCode" : uciCode
			},
			success: function(data) {					
				
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	});
	
	// #사진관리 블라인드 처리
	$(document).on("click", ".btn_view", function() {
		var uciCode = $(this).attr("value");
		var saleState;
		if($(this).hasClass("blind")) {
			$(this).removeClass("blind");
			saleState = 1;
		}else {
			$(this).addClass("blind");
			saleState = 2;
		}
		var param = "action=blindPhoto";
		
		$.ajax({
			url: "/cms?"+param,
			type: "POST",
			data: {
				"uciCode" : uciCode,
				"saleState" : saleState
			},
			success: function(data) {					
				
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}, 
			complete: function() {
				//search();
			}
		});
	});
	
	/** 전체선택 */
	$(document).on("click", "input[name='check_all']", function() {
		if($("input[name='check_all']").prop("checked")) {
			$("#cms_list2 input:checkbox").prop("checked", true);
		}else {
			$("#cms_list2 input:checkbox").prop("checked", false);
		}
	});
	
	function down(uciCode) {
		if(!confirm("원본을 다운로드 하시겠습니까?")) {
			return;
		}
		var url = IMG_SERVER_URL_PREFIX + "/service.down.photo?uciCode="+uciCode+"&type=file";
		$("#downFrame").attr("src", url);
	}
	
	function mutli_download() {
		var uciCode = new Array();
		if(!confirm("선택파일을 압축파일로 다운로드하시겠습니까?")) {
			return;
		}
		$("#cms_list2 input:checkbox:checked").each(function(index) {
			uciCode.push($(this).val());
		});
		
		var param = uciCode.join("&uciCode=");
		
		//var url = "<%=IMG_SERVER_URL_PREFIX%>/zip.down.photo?&type=file&uciCode=";
		var url = "/zip.down.photo?&type=file&uciCode=";
		url += param;
		console.log(url);
		
		$("#downFrame").attr("src", url);
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
							<a href="/accountlist.mypage">정산 관리</a>
						</li>
						<li class="on">
							<a href="/cms">사진 관리</a>
						</li>
					</c:if>
					<li>
						<a href="/info.mypage">회원정보 관리</a>
					</li>
					<li>
						<a href="/dibs.myPage">찜관리</a>
					</li>
					<li>
						<a href="/cart.myPage">장바구니</a>
					</li>
					<li>
						<a href="/buylist.mypage">구매내역</a>
					</li>
			</ul>
		</div>
		<div class="table_head">
			<h3>사진 관리</h3>
			<div class="cms_search">이미지 검색
				<input id="cms_keyword" type="text" />
				<button id="cms_searchBtn">검색</button>
			</div>
		</div>
		<!-- 필터시작 -->
		<div class="filters">
			<ul>
				<li class="filter_title filter_ico">검색필터</li>
				<li class="filter_title filter_media"> 전체매체
					<ul class="filter_list">
						<li value="0" selected="selected">전체</li>
						<c:forEach items="${mediaList}" var="media">
							<li value="${media.seq }">${media.name }</li>								
						</c:forEach>
					</ul>
				</li>
				<li class="filter_title filter_duration"> 촬영일
					<ul class="filter_list">
						<li value="" selected="selected">전체</li>
						<li value="1d">1일</li>
						<li value="1w">1주</li>
						<li value="1m">1달</li>
						<li value="1y">1년</li>
						<li class="choice">직접 입력
							<div class="calendar">
								<div class="cal_input">
									<input type="text" class="datepicker" id="startDate" title="촬영 시작일" />
									<a href="javascript:void(0)" class="ico_cal">달력</a> </div>
								<div class="cal_input">
									<input type="text" class="datepicker" id="endDate" title="촬영 마지막일" />
									<a href="javascript:void(0)" class="ico_cal">달력</a> </div>
								<button class="btn_cal" type="button">적용</button>
							</div>
						</li>
					</ul>
				</li>
				<%-- 1차 제외
				<li class="filter_title filter_color">
					색상
					<ul class="filter_list">
						<li value="<%=SearchParameterBean.COLOR_ALL%>" selected="selected">전체</li>
						<li value="<%=SearchParameterBean.COLOR_YES%>">컬러</li>
						<li value="<%=SearchParameterBean.COLOR_NO%>">흑백</li>
					</ul>
				</li> --%>
				<li class="filter_title filter_horizontal">
					형태
					<ul class="filter_list">
						<li value="<%=SearchParameterBean.HORIZONTAL_ALL%>" selected="selected">전체</li>
						<li value="<%=SearchParameterBean.HORIZONTAL_YES%>">가로</li>
						<li value="<%=SearchParameterBean.HORIZONTAL_NO%>">세로</li>
					</ul>
				</li>
				<li class="filter_title filter_size"> 사진크기
					<ul class="filter_list">
						<li value="<%=SearchParameterBean.SIZE_ALL%>" selected="selected">전체</li>
						<li value="<%=SearchParameterBean.SIZE_LARGE%>">3,000 px 이상</li>
						<li value="<%=SearchParameterBean.SIZE_MEDIUM%>">1,000~3,000 px</li>
						<li value="<%=SearchParameterBean.SIZE_SMALL%>">1,000 px 이하</li>
					</ul>
				</li>
				<li class="filter_title filter_service"> 서비스 상태
					<ul class="filter_list">
						<li value="" selected="selected">전체</li>
						<li value="<%=SearchParameterBean.SALE_STATE_OK%>">정상</li>
						<li value="<%=SearchParameterBean.SALE_STATE_STOP%>">블라인드</li>
						<li value="<%=SearchParameterBean.SALE_STATE_DEL_SOLD%>">삭제</li>
					</ul>
				</li>
				<li class="filter_title filter_upload"> 업로드일
					<ul class="filter_list">
						<li value="" selected="selected">전체</li>
						<li value="1d">1일</li>
						<li value="1w">1주</li>
						<li value="1m">1달</li>
						<li value="1y">1년</li>
						<li class="choice">직접 입력
							<div class="calendar">
								<div class="cal_input">
									<input type="text" class="datepicker" title="업로드 시작일" />
									<a href="javascript:void(0)" class="ico_cal">달력</a> </div>
								<div class="cal_input">
									<input type="text" class="datepicker" title="업로드 마지막일" />
									<a href="javascript:void(0)" class="ico_cal">달력</a> </div>
								<button class="btn_cal" type="button">적용</button>
							</div>
						</li>
					</ul>
				</li>
			</ul>
			<div class="filter_rt">
				<div class="result"><b class="count">0</b>개의 결과</div>
				<div class="paging">
					<a href="javascript:void(0)" class="prev" title="이전페이지"></a>
					<input type="text" name="pageNo" class="page" value="1" onkeydown="return checkNumber(event);" onblur="cms_search()"/>
					<span>/</span>
					<span class="total">0</span>
					<a href="javascript:void(0)" class="next" title="다음페이지"></a>
				</div>
				<div class="viewbox">
					<div class="size">
						<span class="square on">사각형보기</span>
					</div>
					<select name="pageVol" onchange="cms_search()">
						<option value="40" selected="selected">40</option>
						<option value="80">80</option>
						<option value="120">120</option>
					</select>
				</div>
			</div>
		</div>
		<!-- 필터끝 -->
		<form class="view_form" method="post" action="/view.cms" name="view_form" >
			<input type="hidden" name="uciCode" id="uciCode"/>
		</form>
		<div class="btn_sort"><span class="task_check">
			<input type="checkbox" name="check_all" />
			</span>
			<ul class="button">
				<li class="sort_down" onclick="mutli_download()">다운로드</li>
				<li class="sort_del">삭제</li>
				<!-- 1차 제외
				<li class="sort_menu">초상권 해결</li>
				<li class="sort_menu">관련사진 묶기</li> -->
				<li class="sort_menu">블라인드</li>
				<li class="sort_menu">블라인드 해제</li>
				<li class="sort_up">수동 업로드</li>
			</ul>
		</div>
		<section id="cms_list2">
			<ul>
				<c:forEach items="${picture}" var="PhotoDTO">
					<li class="thumb"> 
						<a href="/view.cms?uciCode=${PhotoDTO.uciCode}">
							<%-- <img src="/list.down.photo?uciCode=${PhotoDTO.uciCode}"/> --%>
							<img src="/list.down.photo?uciCode=${PhotoDTO.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>">
						</a>
						<div class="thumb_info">
							<input type="checkbox" value="${PhotoDTO.uciCode}"/>
							<span>${PhotoDTO.uciCode}</span><span>${PhotoDTO.copyright}</span></div>
						<ul class="thumb_btn">
							<li class="btn_down"><a>다운로드</a></li>
							<li class="btn_del"><a>삭제</a></li>
							<li class="btn_view blind"><a>블라인드</a></li>
						</ul>
					</li>
				</c:forEach>
			</ul>
		</section>
	<div class="more"><a href="javascript:void(0)" name="nextPage">다음 페이지</a></div>
	</section>
	<%@include file="footer.jsp"%>
</div>
<iframe id="downFrame" style="display:none" >
</iframe>
</body>
</html>