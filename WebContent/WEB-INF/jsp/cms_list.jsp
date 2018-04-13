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
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<div class="table_head">
		<h3>사진 관리</h3>
		<div class="cms_search">
			<input type="text" id="cms_keyword" placeholder="이미지 검색" />
			<input type="text" id="cms_keyword_current" style="display: none;" />
			<button id="cms_searchBtn">검색</button>
		</div>
	</div>
	<!-- 필터시작 -->
<%@include file="search_filter.jsp" %>
	<!-- 필터끝 -->
	<div class="btn_sort"><span class="task_check">
		<input type="checkbox" name="check_all" id="check_all"/>
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
		<a href="javascript:void(0)" onclick="excel()" class="excel_down">엑셀저장</a>
	</div>
	<section id="cms_list2">
		<ul>
		</ul>
	</section>
	<div class="more"><a href="javascript:void(0)" name="nextPage">다음 페이지</a></div>
<%@include file="down_frame.jsp" %>
<%@include file="view_form.jsp" %>
<%@include file="excel_frame.jsp" %>