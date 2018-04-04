<%---------------------------------------------------------------------------
  Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : cms_list.jsp
  @author   : JEON,HYUNGGUK
  @date     : 2018. 04. 04.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
2018. 04. 04. 
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<div class="table_head">
		<h3>사진 관리</h3>
		<div class="cms_search">
			<input id="cms_keyword" type="text" placeholder="이미지 검색" />
			<button id="cms_searchBtn">검색</button>
		</div>
	</div>
	<!-- 필터시작 -->
	<div class="filters">
		<ul>
			<li class="filter_title filter_ico">검색필터</li>
			<li class="filter_title filter_media">
				<span>매체 : 전체</span>
				<ul class="filter_list">
					<li value="0" selected="selected">전체</li>
					<c:forEach items="${mediaList}" var="media">
						<li value="${media.seq }">${media.name }</li>								
					</c:forEach>
				</ul>
			</li>
			<li class="filter_title filter_durationReg">
				<span>업로드일 : 전체</span>
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
			<li class="filter_title filter_durationTake">
				<span>촬영일 : 전체</span>
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
				<span>가로/세로 : 전체</span>
				<ul class="filter_list">
					<li value="<%=SearchParameterBean.HORIZONTAL_ALL%>" selected="selected">전체</li>
					<li value="<%=SearchParameterBean.HORIZONTAL_YES%>">가로</li>
					<li value="<%=SearchParameterBean.HORIZONTAL_NO%>">세로</li>
				</ul>
			</li>
			<li class="filter_title filter_size">
				<span>사진크기 : 전체</span>
				<ul class="filter_list">
					<li value="<%=SearchParameterBean.SIZE_ALL%>" selected="selected">전체</li>
					<li value="<%=SearchParameterBean.SIZE_LARGE%>">3,000 px 이상</li>
					<li value="<%=SearchParameterBean.SIZE_MEDIUM%>">1,000~3,000 px</li>
					<li value="<%=SearchParameterBean.SIZE_SMALL%>">1,000 px 이하</li>
				</ul>
			</li>
			<li class="filter_title filter_service">
				<span>서비스 상태 : 정상+숨김</span>
				<ul class="filter_list">
					<li value="<%=SearchParameterBean.SALE_STATE_OK_BLIND%>" selected="selected">정상+숨김</li>
					<li value="<%=SearchParameterBean.SALE_STATE_OK%>">정상</li>
					<li value="<%=SearchParameterBean.SALE_STATE_BLIND%>">숨김</li>
					<li value="<%=SearchParameterBean.SALE_STATE_DEL%>">삭제</li>
					<li value="<%=SearchParameterBean.SALE_STATE_BLIND_DEL%>">숨김 + 삭제</li>
					<li value="<%=SearchParameterBean.SALE_STATE_ALL%>">전체</li>
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
			<li class="sort_down" onclick="mutli_download()">선택 다운로드</li>
			<li class="sort_del" onclick="multi_delete()">선택 삭제</li>
			<!-- 1차 제외
			<li class="sort_menu">초상권 해결</li>
			<li class="sort_menu">관련사진 묶기</li>
			-->
			<li class="sort_blind" onclick="multi_blind(<%=PhotoDTO.SALE_STATE_STOP%>)">블라인드</li>
			<li class="sort_unblind" onclick="multi_blind(<%=PhotoDTO.SALE_STATE_OK%>)">블라인드 해제</li>
			<!-- 1차 제외
			<li class="sort_up">수동 업로드</li>
			-->
		</ul>
	</div>
	<section id="cms_list2">
		<ul>
		</ul>
	</section>
	<div class="more"><a href="javascript:void(0)" name="nextPage">다음 페이지</a></div>
<%@include file="down_frame.jsp" %>