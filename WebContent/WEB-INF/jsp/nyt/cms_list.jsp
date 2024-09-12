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
<script src="js/nyt/jquery.twbsPagination.js"></script>

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
			<li class="sort_del" onclick="multi_delete()">삭제</li>
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
	
	<div id="popup_wrap" class="pop_group wd">
		<div class="pop_tit">
			<h2>오류 신고내역</h2>
			<p>
				<button class="popup_close">닫기</button>
			</p>
		</div>
		<div class="pop_cont error_list">
				<div class="sort_error">
					<select name="reportPageVol">
						<option value="40" selected="selected">40</option>
						<option value="80">80</option>
						<option value="120">120</option>
					</select>
					<select name="reportStatus">
						<option value="0" selected="selected">상태</option>
						<option value="1">접수</option>
						<option value="2">수정 완료</option>
					</select>
					<select name="reportMedia">
<!-- 						<option value="" selected="selected">매체</option> -->
<!-- 						<option value="뉴시스">뉴시스</option> -->
<!-- 						<option value="뉴스1">뉴스1</option> -->
					<c:choose>
						<c:when test="${seq ne null && !empty seq}">
							<option value="0">매체</option>
							<c:forEach items="${mediaList}" var="media">
								<c:if test="${seq eq media.seq}">
									<option value="${media.seq }" selected="selected">${media.name }</option>
								</c:if>
								<c:if test="${seq ne media.seq}">
									<option value="${media.seq }">${media.name }</option>
								</c:if>
							</c:forEach>
						</c:when>
						
						<c:otherwise>
							<option value="0" selected="selected">매체</option>
							<c:forEach items="${mediaList}" var="media">
								<option value="${media.seq }">${media.name }</option>								
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</select>
				</div>
				<table id="reportList" cellpadding="0" cellspacing="0" class="tb04" style="">
					<colgroup>
					<col width="40">
					<col width="80">
					<col width="100">
					<col width="120">
					<col width="120">
					<col width="80">
					</colgroup>
					<thead>
					<tr><th>번호</th>
						<th>신고일</th>
						<th>매체</th>
						<th>UCI 코드</th>
						<th>언론사 사진코드</th>
						<th>상태</th>
						</tr></thead>
					<tbody>
						
					</tbody>
				</table>
				<div class="pagination">
					<ul id="pagination-demo" class="pagination-sm pagination">
						<li class="first disabled"><a href="#">First</a></li>
						<li class="prev disabled"><a href="#">Previous</a></li>
						<li class="page active"><a href="#">1</a></li>
						<li class="next disabled"><a href="#">Next</a></li>
						<li class="last disabled"><a href="#">Last</a></li>
					</ul>
				</div>
		</div>
		<div class="pop_foot">
			<div class="pop_btn">
				<button class="popup_close">닫기</button>
			</div>
		</div>
	</div>
	<form id="reportListForm">
		<input type="hidden" name="report_startPage" value="0"/>
		<input type="hidden" name="report_pageVol" value="1"/>
		<input type="hidden" name="report_media" value=""/>
		<input type="hidden" name="report_status" value="0"/>
		<input type="hidden" name="report_page" value="1"/>
	</form>
<%@include file="down_frame.jsp" %>
<%@include file="view_form.jsp" %>
<%@include file="excel_frame.jsp" %>