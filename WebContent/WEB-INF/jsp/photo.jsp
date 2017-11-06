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
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		search();
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
		var filter_list = "<ul class=\"filter_list\">" + $(this).parents(".filter_list").html() + "</ul>";
		var titleTag = $(this).parents(".filter_title").find("span");
		var titleStr = titleTag.html();
		titleStr = titleStr.substring(0, titleStr.indexOf(":")) + ": " + choice;
		titleTag.html(titleStr);
		
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
		var uciCode = $(this).attr("value");		
		var bookName = "기본그룹";
		var member_seq = 1002;
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
				"bookName" : bookName,
				"member_seq" : member_seq
			},
			success: function(data) {
				
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});		
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
			success : function(data) {
				$("#search_list1 ul").empty();
				$("#search_list2 ul").empty();
				$(data.result).each(function(key, val) {
					html += "<li class=\"thumb\"><a href=\"/view.photo?uciCode=" + val.uciCode + "\"><img src=\"/list.down.photo?uciCode=" + val.uciCode + "\"></a>";
					html += "<div class=\"info\">";
					html += "<div class=\"photo_info\">" + val.copyright + "</div>";
					html += "<div class=\"right\">";
					html += "<a class=\"over_wish\" href=\"#\" value=\"" + val.uciCode + "\">찜</a> <a class=\"over_down\" href=\"/list.down.photo?uciCode=" + val.uciCode + "\" download>시안 다운로드</a> </div>";
					html += "</div>";
					html += "</li>";
				});
				$(html).appendTo("#search_list1 ul");
				$(html).appendTo("#search_list2 ul");
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
						<span>매체 :전체</span>
						<ul class="filter_list">
							<li value="0" selected="selected">전체</li>
							<c:forEach items="${mediaList}" var="media">
								<li value="${media.seq }">${media.name }</li>								
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
										<input type="text" title="검색기간 시작일" />
										<a href="#" class="ico_cal">달력</a>
									</div>
									<div class="cal_input">
										<input type="text" title="검색기간 시작일" />
										<a href="#" class="ico_cal">달력</a>
									</div>
									<button class="btn_cal" type="button">적용</button>
								</div>
							</li>
						</ul>
					</li>
					<li class="filter_title filter_color">
						<span>컬러/흑백 :전체</span>
						<ul class="filter_list">
							<li value="<%=SearchParameterBean.COLOR_ALL%>" selected="selected">전체</li>
							<li value="<%=SearchParameterBean.COLOR_YES%>">컬러</li>
							<li value="<%=SearchParameterBean.COLOR_NO%>">흑백</li>
						</ul>
					</li>
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
						<a href="#" class="prev" title="이전페이지"></a>
						<input type="text" name="pageNo" class="page" value="1"  onkeydown="return checkNumber(event);" onblur="search()"/>
						<span>/</span>
						<span class="total">0</span>
						<a href="#" class="next" title="다음페이지"></a>
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
		<section id="search_list1">
		<ul>
			<c:forEach items="${picture}" var="PhotoDTO">
				<li class="thumb">
					<a href="/view.photo?uciCode=${PhotoDTO.uciCode}">
						<img src="/list.down.photo?uciCode=${PhotoDTO.uciCode}">
					</a>
					<div class="info">
						<div class="photo_info">${PhotoDTO.copyright}</div>
						<div class="right">
							<a class="over_wish" href="#" value="${PhotoDTO.uciCode}">찜</a>
							<a class="over_down" href="/list.down.photo?uciCode=${PhotoDTO.uciCode}" download>시안 다운로드</a>
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
					<a href="/view.photo?uciCode=${PhotoDTO.uciCode}">
						<img src="/list.down.photo?uciCode=${PhotoDTO.uciCode}">
					</a>
					<div class="info">
						<div class="photo_info">${PhotoDTO.copyright}</div>
						<div class="right">
							<a class="over_wish" href="#" value="${PhotoDTO.uciCode}">찜</a>
							<a class="over_down" href="/list.down.photo?uciCode=${PhotoDTO.uciCode}" download>시안 다운로드</a>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
		</section>
		<div class="more">
			<a href="#" name="nextPage">다음 페이지</a>
		</div>
		<footer>
		<div class="foot_wrap">
			<div class="foot_lt">
				(주)다하미커뮤니케이션즈 | 대표 박용립
				<br />
				서울시 중구 마른내로 140 5층 (쌍림동, 인쇄정보센터)
				<br />
				고객센터 02-593-4174 | 사업자등록번호 112-81-49789
				<br />
				저작권대리중개신고번호 제532호
				<br />
				통신판매업신고번호 제2016-서울중구-0501호 (사업자정보확인)
			</div>
			<div class="foot_ct">
				<dl>
					<dt>회사소개</dt>
					<dd>뉴스뱅크 소개</dd>
					<dd>UCI 소개</dd>
					<dd>공지사항</dd>
					<dd>이용약관</dd>
					<dd>개인정보처리방침</dd>
				</dl>
				<dl>
					<dt>구매안내</dt>
					<dd>저작권 안내</dd>
					<dd>FAQ</dd>
					<dd>도움말</dd>
					<dd>직접 문의하기</dd>
				</dl>
				<dl>
					<dt>사이트맵</dt>
				</dl>
			</div>
			<div class="foot_rt">
				<div id="family_site">
					<div id="select-title">주요 서비스 바로가기</div>
					<div id="select-layer" style="display: none;">
						<ul class="site-list">
							<li>
								<a href="http://scrapmaster.co.kr/" target="_blank">스크랩마스터</a>
							</li>
							<li>
								<a href="http://clippingon.co.kr/" target="_blank">클리핑온</a>
							</li>
							<li>
								<a href="http://www.t-paper.co.kr/" target="_blank">티페이퍼</a>
							</li>
							<li>
								<a href="http://forme.or.kr/" target="_blank">e-NIE</a>
							</li>
							<li>
								<a href="http://www.newsbank.co.kr/" target="_blank">뉴스뱅크</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="foot_banner">
					<ul>
						<li class="uci">
							<a>
								국가표준 디지털콘텐츠
								<br />
								식별체계 등록기관 지정
							</a>
						</li>
						<li class="cleansite">
							<a>
								클린사이트
								<br />
								한국저작권보호원
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
		</footer>
	</div>
</body>
</html>