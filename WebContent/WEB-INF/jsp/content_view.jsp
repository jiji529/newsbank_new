<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 10. 17. 오전 10:48:12
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 17.   hoyadev        view.cms
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;

PhotoDTO photoDto = (PhotoDTO)request.getAttribute("photoDTO");
boolean contentBlidF = false;
// CMS에서는 삭제상태가 아니어야 함
if(photoDto == null || 
		photoDto.getSaleState() == PhotoDTO.SALE_STATE_DEL) {
	contentBlidF = true;
}
%>
		<section class="view">
			<div class="view_lt">
				<h2 class="media_logo"><img src="/logo.down.photo?seq=${photoDTO.ownerNo}" alt="${photoDTO.ownerName}" /></h2>
				<div class="img_area"><img src="<%=IMG_SERVER_URL_PREFIX%>/view.down.photo?uciCode=${photoDTO.uciCode}"/>
				</div>
				<div class="cont_area">
					<h3 class="img_tit"><span class="uci">[${photoDTO.uciCode}]</span>
<%
if(photoDto.getCompCode() != null) {
%>
${photoDTO.compCode }
<%
}
%>
					</h3>
<%
// 삭제 상태가 아니면 출력
if(!contentBlidF) {
%>					
					<h3 class="img_tit hTitle">${photoDTO.titleKor}</h3>
					<a class="btn_edit">수정</a>
					<p class="img_cont">
						${photoDTO.descriptionKor} <br />
					</p>
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
						<dt>촬영일</dt>
						<dd>${photoDTO.shotDate}</dd>
						<dt>픽셀수</dt>
						<dd>${photoDTO.widthPx} X ${photoDTO.heightPx}(pixel)</dd>
						<dt>출력사이즈</dt>
						<dd>${photoDTO.widthCm} x ${photoDTO.heightCm} (cm)</dd>
						<dt>파일용량</dt>
						<dd>${photoDTO.fileSize}MB</dd>
						<dt>파일포멧</dt>
						<dd>JPEG</dd>
						<dt>해상도</dt>
						<dd>${photoDTO.dpi}dpi</dd>
						<dt>저작권자</dt>
						<dd>${photoDTO.copyright}</dd>
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
				<div class="btn_down"><a href="javascript:;" onclick="down('${photoDTO.uciCode}')">원본이미지 다운로드</a></div>
				<!--
				<div class="cms_rt">
					<h3 class="info_tit">다운로드</h3>
					<div class="sum_sec">
						<div class="btn_wrap">
							<div class="btn_buy" id="btnDown">
								<a href="javascript:;" onclick="down('${photoDTO.uciCode}')">원본이미지 다운로드</a>
							</div>
						</div>
					</div>
				</div>
				-->
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