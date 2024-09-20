<%---------------------------------------------------------------------------
  Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : cms_content.jsp
  @author   : JEON,HYUNGGUK
  @date     : 2018. 04. 03.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
2018. 04. 03. 
---------------------------------------------------------------------------%>

<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% 
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;

PhotoDTO photoDto = (PhotoDTO)request.getAttribute("photoDTO");
boolean contentBlidF = false;
// CMS에서는 삭제상태가 아니어야 함
if(photoDto == null || 
		photoDto.getSaleState() == PhotoDTO.SALE_STATE_DEL) {
	contentBlidF = true;
}

SimpleDateFormat df = new SimpleDateFormat("yyyy년 MM월 dd일");
%>
		<input id="uciCode" type="hidden" value="${photoDTO.uciCode}" />
		<input id="saleState" type="hidden" value="${photoDTO.saleState}" />
		<input id="portraitRightState" type="hidden" value="${photoDTO.portraitRightState}" />
		<input id="mediaExActive" type="hidden" value="${photoDTO.mediaExActive}" />
		
		<div class="table_head">
			<h3>사진 관리</h3>
			<div class="cms_search">
				<input id="cms_keywordFV" type="text" placeholder="이미지 검색" />
				<button id="cms_searchFVBtn">검색</button>
			</div>
		</div>
		
		<section class="view">
			<div class="view_lt">				
				<h2 class="media_logo">
					<c:if test="${photoDTO.ownerName!='뉴욕타임즈'}">	
						<img src="/logo.down.photo?seq=${photoDTO.ownerNo}" alt="${photoDTO.ownerName}" />
					</c:if>
					<div class="btn_edit">
						<span id="history_open"><a href="#none">수정 이력 보기</a></span>
<%
// 삭제 상태가 아니면 출력
if(!contentBlidF) {
%>
						<span id="open_edit"><a href="#">수정하기</a></span>
						<span id="save_edit" style="display:none;"><a href="#">저장</a></span>
						<span id="close_edit" style="display:none;"><a href="#">취소</a></span> 
						<span id="open_del"><a href="#">삭제</a></span>
<%
}
%>
					</div>
				</h2>
				<div class="img_area">
					<img src="<%=IMG_SERVER_URL_PREFIX%>/view.down.photo?uciCode=${photoDTO.uciCode}"/>
					<button class="btn" id="btnChangePic" style="display:none;">사진 변경</button>
					<input type="file" id="fileChangePic" name="fileChangePic" accept="image/jpeg"  required style="display:none;"/>
				</div>
				<div class="cont_area">
				<input type="file" style="display:none;" />
					<h3 class="img_tit"><span class="uci">[${photoDTO.uciCode}]</span>
<%
if(photoDto.getCompCode() != null) {
%>
${photoDTO.compCode }
<%
}
%>
					<span class="img_date">
					
					업로드 : 
<%
if(photoDto.getRegDate() != null) {
	out.print(df.format(photoDto.getRegDate()));
}
%>
					</span></h3>
<%
// 삭제 상태가 아니면 출력
if(!contentBlidF) {
%>					
					<h3 class="img_tit hTitle viewTitle">${photoDTO.titleKor}</h3>
					<h3 class="img_tit hTitle orgTitle" style="display:none;">${photoDTO.titleKor}</h3>
					<textarea class="editTitle" style="display:none;"></textarea>
					<p class="img_cont viewCont">${photoDTO.descriptionKor} <br /></p>
					<p class="img_cont orgCont" style="display:none;">${photoDTO.descriptionKor}</p>
					<textarea class="editCont" rows="5" style="display:none;"></textarea>
<%
}
else {
%>
					<h3 class="img_tit hTitle">삭제된 이미지</h3>
<%
}
%>
				</div>
<%
// 삭제 상태가 아니면 출력
if(!contentBlidF) {
%>
				<div class="img_info_area area1">
					<h3 class="info_tit">사진 정보</h3>
					<dl>
						<dt>업로드일</dt>
						<dd><fmt:formatDate value="${photoDTO.regDate}" pattern="yyyy년 MM월 dd일  HH시 mm분 ss초"/></dd>
						<dt>촬영일(이미지생성일)</dt>
						<dd><fmt:formatDate value="${photoDTO.shotDate}" pattern="yyyy년 MM월 dd일  HH시 mm분 ss초"/></dd>
						<dt>픽셀수</dt>
						<dd>${photoDTO.widthPx} X ${photoDTO.heightPx}(pixel)</dd>
						<dt>출력사이즈</dt>
						<dd>${photoDTO.getWidthCmStr()} x ${photoDTO.getHeightCmStr()} (cm)</dd>
						<dt>파일용량</dt>
						<dd>${photoDTO.getFileSizeMBStr()}MB</dd>
						<dt>파일포멧</dt>
						<dd>JPEG</dd>
						<dt>해상도</dt>
						<dd>${photoDTO.dpi}dpi</dd>
						<dt>저작권자</dt>
						<dd>${photoDTO.ownerName}</dd>
					</dl>
				</div>
				<div class="img_info_area area2">
					<h3 class="info_tit">EXIF (Exchangeable Image File Format)</h3>
					<c:set var="split_exif" value="${fn:split(photoDTO.exif, '|')}" />
					
					<dl>
						<c:forEach items="${split_exif}" var="split_exif">
							<c:set var="name" value="${fn:substringBefore(split_exif, ':')}" />
							<c:set var="value" value="${fn:substringAfter(split_exif, ':')}" />
							<dt>${name}</dt>
							<dd>${value}</dd>
						</c:forEach>
					</dl>
				</div>
				<div class="img_info_area">
					<h3 class="info_tit">연관 사진</h3>
					<div class="conn">
						<ul class="cfix">
						</ul>
						<div class="btn_conn">
							<button class="in_prev">이전</button>
							<button class="in_next">다음</button>
						</div>
					</div>
				</div>
<%
}
%>
			</div>
			<div class="view_rt">
<%
// 삭제 상태가 아니면 출력
if(!contentBlidF) {
%>
				<div class="btn_down" value="${photoDTO.uciCode}"><a>원본이미지 다운로드</a></div>
<%
}
%>
				<div class="cms_rt">
					<h3 class="info_tit">통계</h3>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="cms_table1">
						<tr>
							<th scope="col">구분</th>
							<th scope="col">전체 횟수</th>
						</tr>
						<tr>
							<th scope="row">찜</th>
							<td><b>${statsDTO.bookmarkCount}</b>회</td>
						</tr>
						<tr>
							<th scope="row">다운로드</th>
							<td><b>${statsDTO.downCount}</b>회</td>
						</tr>
						<tr>
							<th scope="row">상세보기</th>
							<td><b>${statsDTO.hitCount}</b>회</td>
						</tr>
						<tr>
							<th scope="row">결제</th>
							<td><b>${statsDTO.saleCount}</b>회</td>
						</tr>
						<!--
							주석처리 
						<tr>
							<th scope="row">뮤지엄</th>
							<td><b>${statsDTO.museumCount}</b>회</td>
						</tr>
						<tr>
							<th scope="row">컬렉션</th>
							<td><b>${statsDTO.collectionCount}</b>회</td>
						</tr>
						 -->
					</table>
				</div>
<%
// 삭제 상태가 아니면 출력
if(!contentBlidF) {
%>
				<div class="cms_rt">
					<h3 class="info_tit">옵션</h3>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="cms_table2">
						<!--
					 	  숨김 
						<tr>
							<th scope="row">게티 노출 / 타 서비스 노출</th>
							<td><label>
									<input type="radio" name="mediaExActive" value="0"/>
									ON</label>
								<label>
									<input type="radio" name="mediaExActive" value="1"/>
									OFF</label></td>
						</tr>
						 -->
						<tr>
							<th scope="row">블라인드</th>
							<td><label>
									<input type="radio" name="blind" value="2"/>
									ON</label>
								<label>
									<input type="radio" name="blind" value="1"/>
									OFF</label></td>
						</tr>
						<!-- 
						# 항목 숨기기 처리   -- 2018.02.20. hoyadev
						<tr>
							<th scope="row">초상권 해결</th>
							<td><label>
									<input type="radio" name="likeness" value="1"/>
									ON</label>
								<label>
									<input type="radio" name="likeness" value="2"/>
									OFF</label></td>
						</tr>
						-->
					</table>
				</div>
				<div class="cms_rt">
					<h3 class="info_tit">태그 달기</h3>
					<div class="add_tag">
						<input type="text" />
						<button>추가</button>
					</div>
					<ul class="tag_list">
						<!-- <li class="tag_auto"><span class="tag_remove">×</span>장원준</li>
						<li class="tag_self"><span class="tag_remove">×</span>승리투수</li> -->
						
						<c:forEach items="${photoTagList}" var="tag">
							<%-- <li class="tag_self"><span class="tag_remove">×</span>${tag.tag_tagName}</li> --%>
							
							<c:set value="${tag.tagType}" var="tagType"/>
							<c:if test="${tagType == 0}" var="result">
								<li class="tag_auto"><span class="tag_remove">×</span>${tag.tag_tagName}</li>
							</c:if>
							
							<c:if test="${tagType == 1}" var="result">
								<li class="tag_self"><span class="tag_remove">×</span>${tag.tag_tagName}</li>
							</c:if>
							
						</c:forEach>
					</ul>
				</div>
<%
}
%>
			</div>
		</section>
<%@include file="down_frame.jsp" %>
<%@include file="view_form.jsp" %>
<%@include file="history_popup.jsp"%>