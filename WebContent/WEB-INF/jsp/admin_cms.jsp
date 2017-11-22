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
  2017. 11. 21.   LEE GWANGHO    cms.manage
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
<script src="js/cms.js"></script>
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
		
		var cms_keyword = '${cms_keyword}';
		
		if(cms_keyword) { // 사진관리 상세페이지에서 이미지 검색 시
			$("#cms_keyword").val(cms_keyword);
			cms_search();
		}else { // 최초 사진 관리 페이지 접근 시
			search();
		}
		setDatepicker();
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
					<li class="filter_title filter_duration"> 검색기간
						<ul class="filter_list">
							<li value="" selected="selected">전체</li>
							<li value="1d">1일</li>
							<li value="1w">1주</li>
							<li value="1m">1달</li>
							<li value="1y">1년</li>
							<li class="choice">직접 입력
								<div class="calendar">
									<div class="cal_input">
										<input type="text" class="datepicker" id="startDate" title="검색기간 시작일" />
										<a href="#" class="ico_cal">달력</a> </div>
									<div class="cal_input">
										<input type="text" class="datepicker" id="endDate" title="검색기간 마지막일" />
										<a href="#" class="ico_cal">달력</a> </div>
									<button class="btn_cal" type="button">적용</button>
								</div>
							</li>
						</ul>
					</li>
					<li class="filter_title filter_color">
						색상
						<ul class="filter_list">
							<li value="<%=SearchParameterBean.COLOR_ALL%>" selected="selected">전체</li>
							<li value="<%=SearchParameterBean.COLOR_YES%>">컬러</li>
							<li value="<%=SearchParameterBean.COLOR_NO%>">흑백</li>
						</ul>
					</li>
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
				</ul>
				<div class="filter_rt">
					<div class="result"><b class="count">0</b>개의 결과</div>
					<div class="paging">
						<a href="#" class="prev" title="이전페이지"></a>
						<input type="text" name="pageNo" class="page" value="1" onkeydown="return checkNumber(event);" onblur="cms_search()"/>
						<span>/</span>
						<span class="total">0</span>
						<a href="#" class="next" title="다음페이지"></a>
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
			<form class="view_form" method="post" action="/view.cms.manage" name="view_form" >
				<input type="hidden" name="uciCode" id="uciCode"/>
			</form>
			<div class="btn_sort"><span class="task_check">
				<input type="checkbox" name="check_all"/>
				</span>
				<ul class="button">
					<li class="sort_down">다운로드</li>
					<li class="sort_del">삭제</li>
					<!-- 1차 제외
					<li class="sort_menu">블라인드</li>
					<li class="sort_menu">초상권 해결</li>
					<li class="sort_menu">관련사진 묶기</li> -->
					<li class="sort_up">수동 업로드</li>
				</ul>
			</div>
			<section id="cms_list2">
				<ul>
				<c:forEach items="${picture}" var="PhotoDTO">
					<li class="thumb"> 
						<a href="/view.cms.manage?uciCode=${PhotoDTO.uciCode}">
							<%-- <img src="/list.down.photo?uciCode=${PhotoDTO.uciCode}"/> --%>
							<img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${PhotoDTO.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>">
						</a>
						<div class="thumb_info">
							<input type="checkbox" />
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
		<div class="more"><a href="#" name="nextPage">다음 페이지</a></div>
		</section>
	</div>
</body>
</html>