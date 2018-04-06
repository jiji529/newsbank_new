<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 11. 16. 오전 09:49:20
  @comment   : 후불 결제내역 목록
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 25.   LEE.GWANGHO    postBuylist
---------------------------------------------------------------------------%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
 SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
 int beginYear = Integer.parseInt(yearFormat.format(new Date())) - 2; // 현재 년도 -2
 int endYear = Integer.parseInt(yearFormat.format(new Date())); // 현재 년도
%>
<c:set var="endYear" value="<%=endYear%>"/>
<c:set var="beginYear" value="<%=beginYear%>"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/mypage.js?v=20180402"></script>
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
					<c:if test="${MemberInfo.type eq 'M' && MemberInfo.admission eq 'Y'}">
						<li>
							<a href="/accountlist.mypage">정산 관리</a>
						</li>
						<li>
							<a href="/cms">사진 관리</a>
						</li>
					</c:if>
					<li>
						<a href="/info.mypage">회원정보 관리</a>
					</li>
					<li>
						<a href="/dibs.myPage">찜관리</a>
					</li>
					<c:if test="${MemberInfo.deferred eq 1 || MemberInfo.deferred eq 2}">
						<li>
							<a href="/download.mypage">다운로드 내역</a>
						</li>
						<li class="on">
							<a href="/postBuylist.mypage">구매내역</a>
						</li>
					</c:if>
					<c:if test="${MemberInfo.deferred eq 0}">
						<li>
							<a href="/cart.myPage">장바구니</a>
						</li>
						<li>
							<a href="/buylist.mypage">구매내역</a>
						</li>
					</c:if>
				</ul>
				<!-- 컬렉션 생기면 추가 <ul class="mp_tab2">
					<li class="on"><a href="javascript:void(0)">사진 찜 관리</a></li>
					<li><a href="javascript:void(0)">컬렉션 찜 관리</a></li>
				</ul> -->
			</div>
		<div class="table_head">
			<h3>구매 내역</h3>
			<div class="cms_search"> <span class="mess">※고객님과 같은 그룹으로 묶인 계정에서 구매한 내역이 모두 공유됩니다.</span>
				<select onchange="select_year(this.value, '/postBuylist.mypage')">
					<option <c:if test="${year eq '0'}">selected</c:if> value="0">전체</option>
					<c:forEach var="yearOpt" begin="${beginYear}" end="${endYear}" step="1">
						<option <c:if test="${year eq (beginYear-yearOpt+endYear)}">selected</c:if> value="${beginYear-yearOpt+endYear}">${beginYear-yearOpt+endYear}년</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<section class="order_list">
			<table cellpadding="0" cellspacing="0" class="tb03" style="border-top:0; margin-bottom:10px;">
				<colgroup>
				<col width="70">
				<col>
				<col width="120">
				<col width="220">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>구매 이미지 정보</th>
						<th>콘텐츠가격</th>
						<th>구매일</th>
						<th>구매상태</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="totalPrice" value="0"/>
					<c:forEach items="${listPaymentDetail}" var="PaymentDetail" varStatus="loop">
						<!-- 합계 -->
						<c:set var="totalPrice" value="${totalPrice + PaymentDetail.price}"/>
						<tr>
							<td>${loop.index+1}</td>
							<td>
								<div class="cart_item">
									<div class="thumb"> <a href="view.html" target="_blank"><img src="<%=IMG_SERVER_URL_PREFIX %>/list.down.photo?uciCode=${PaymentDetail.photo_uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" /></a> </div>
									<div class="cart_info"> <a href="/view.photo?uciCode=${PaymentDetail.photo_uciCode}" target="_blank">
										<div class="brand">${PaymentDetail.photoDTO.copyright }</div>
										<div class="code">${PaymentDetail.photo_uciCode }</div>
										</a>
										<div class="option_area">
											<ul class="opt_li">
												<!-- 후불 회원은 사용용도만 존재 -->
												<li>${PaymentDetail.usageDTO.usage }</li>
											</ul>
										</div>
									</div>
								</div>
							</td>
							<td>\ <fmt:formatNumber value="${PaymentDetail.price}" pattern="#,###" /></td>
							<td>${PaymentDetail.regDate }</td>
							<td>${PaymentDetail.paystatus }</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
				<td colspan="6">합계 : \ <fmt:formatNumber value="${totalPrice}" pattern="#,###" /></td>
					</tfoot>
			</table>
		</section>
	</section>
	<%@include file="footer.jsp"%>
</div>
<form id="dateForm" method="post"  target="dateFrame">
	<input type="hidden" id="year" name="year" />
</form>
</body>
</html>