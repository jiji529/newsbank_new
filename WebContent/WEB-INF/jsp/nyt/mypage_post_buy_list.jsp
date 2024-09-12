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
 SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
 int beginYear = Integer.parseInt(yearFormat.format(new Date())) - 2; // 현재 년도 -2
 int endYear = Integer.parseInt(yearFormat.format(new Date())); // 현재 년도
 int currentMonth = Integer.parseInt(monthFormat.format(new Date())); // 현재 월
%>
<c:set var="endYear" value="<%=endYear%>"/>
<c:set var="beginYear" value="<%=beginYear%>"/>
<c:set var="currentMonth" value="<%=currentMonth%>"/>
<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>NYT 뉴스뱅크</title>

<link rel="stylesheet" href="css/nyt/base.css" />
<link rel="stylesheet" href="css/nyt/sub.css" />
<link rel="stylesheet" href="css/nyt/mypage.css" />

<script src="js/nyt/jquery-1.12.4.min.js"></script>
<script src="js/nyt/filter.js"></script>
<script src="js/nyt/footer.js"></script>
<script src="js/nyt/mypage.js?v=20180405"></script>

</head>
<body>
<div class="wrap">
	<%@include file="common/headerKR2.jsp" %>
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
					
					<c:if test="${MemberInfo.type eq 'Q' && MemberInfo.admission eq 'Y'}">
						<li>
							<a href="/cms">사진 관리</a>
						</li>
					</c:if>
					
					<c:if test="${MemberInfo.type eq 'W' && MemberInfo.admission eq 'Y'}">
						<li>
							<a href="/accountlist.mypage">정산 관리</a>
						</li>
					</c:if>
					
					<li>
						<a href="/info.mypage">회원정보 관리</a>
					</li>
					<li>
						<a href="/dibs.myPage">찜관리</a>
					</li>
					<c:if test="${MemberInfo.deferred eq 2}">
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
				<select onchange="select_year('/postBuylist.mypage')" id="selectYear">
					<option <c:if test="${returnMap['year'][0] eq '0'}">selected</c:if> value="0">년도 전체</option>
					<c:forEach var="yearOpt" begin="${beginYear}" end="${endYear}" step="1">
						<option <c:if test="${returnMap['year'][0] eq (beginYear-yearOpt+endYear)}">selected</c:if> value="${beginYear-yearOpt+endYear}">${beginYear-yearOpt+endYear}년</option>
					</c:forEach>
				</select>
				
				<select onchange="select_month('/postBuylist.mypage')" id="selectMonth">
					<option value="0">월 전체</option>
					
					<!-- (선택년도 == 현재년도) -> 현재월까지 표시  -->
					<c:if test="${returnMap['year'][0] eq endYear}">
						<c:forEach var="monthOpt" begin="1" end="${currentMonth}" step="1">
							<option <c:if test="${returnMap['month'][0] eq monthOpt}">selected</c:if> value="${monthOpt}">${monthOpt}월</option>
						</c:forEach>
					</c:if>
					
					<!-- 과거년도는 (1~12월) 표시 -->
					<c:if test="${returnMap['year'][0] < endYear}">
						<c:forEach var="monthOpt" begin="1" end="12" step="1">
							<option <c:if test="${returnMap['month'][0] eq monthOpt}">selected</c:if> value="${monthOpt}">${monthOpt}월</option>
						</c:forEach>
					</c:if>
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
					<c:forEach items="${listPaymentDetail}" var="PaymentDetail" varStatus="loop">
						<!-- 합계 -->
						<tr>
							<c:set value="${returnMap['bundle'][0] * (returnMap['page'][0] - 1) + loop.index+1 }" var="number"/>
							<td>${number}</td>
							<td>
								<div class="cart_item">
									
									<div class="thumb"> 
										<c:choose>
											<c:when test="${PaymentDetail.memberDTO.withdraw eq 0 && PaymentDetail.memberDTO.admission eq 'Y' && PaymentDetail.memberDTO.activate eq 1 && PaymentDetail.photoDTO.saleState eq 1}">
												<a href="javascript:void(0);" onclick="go_View('${PaymentDetail.photo_uciCode}', '/view.photo', '_blank')">
											</c:when>
											<c:otherwise>
												<a href="javascript:void(0);" onclick="stopSaleMessage()">
											</c:otherwise>
										</c:choose>
										<img src="<%=IMG_SERVER_URL_PREFIX %>/list.down.photo?uciCode=${PaymentDetail.photo_uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" />
										</a>
									</div>
									
									<div class="cart_info"> 
									<c:choose>
										<c:when test="${PaymentDetail.memberDTO.withdraw eq 0 && PaymentDetail.memberDTO.admission eq 'Y' && PaymentDetail.memberDTO.activate eq 1 && PaymentDetail.photoDTO.saleState eq 1}">
											<a href="javascript:void(0);" onclick="go_View('${PaymentDetail.photo_uciCode}', '/view.photo', '_blank')">
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0);" onclick="stopSaleMessage()">
										</c:otherwise>
									</c:choose>
										<div class="brand">${PaymentDetail.photoDTO.copyright}</div>
										<div class="code">${PaymentDetail.photo_uciCode }</div>
										</a>
										
										<div class="option_area">
											<ul class="opt_li">
												<!-- 후불 회원은 사용용도만 존재 -->
												<li>${PaymentDetail.usageDTO.usage}</li>
											</ul>
										</div>
									</div>
								</div>
							</td>
							<td>\ <fmt:formatNumber value="${PaymentDetail.price}" pattern="#,###" /></td>
							<td>${PaymentDetail.regDate }</td>
							<td>${PaymentDetail.getStrStatus() }</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<c:if test="${totalPrice eq ''}">
						<td colspan="6">구매한 내역이 없습니다.</td>
					</c:if>
					<c:if test="${totalPrice ne ''}">
						<td colspan="6">합계 : \ <fmt:formatNumber value="${totalPrice}" pattern="#,###" /></td>
					</c:if>
				</tfoot>
			</table>
			
			<c:if test="${returnMap['total'][0]%returnMap['bundle'][0] == 0 }">
				<c:set value="${returnMap['total'][0]/returnMap['bundle'][0] }" var="lastPage" />
			</c:if>
			<c:if test="${returnMap['total'][0]%returnMap['bundle'][0] != 0 }">
				<c:set value="${returnMap['total'][0]/returnMap['bundle'][0]+1 }" var="lastPage" />
			</c:if>	
			<fmt:parseNumber var="lp" value="${lastPage}" integerOnly="true"/>
			<fmt:parseNumber var="cycleStart" value="${returnMap['page'][0]/10 + (returnMap['page'][0]%10==0?-1:0)}" integerOnly="true"/>
			<c:if test="${lp > 0}">
			<div class="pagination">
				<ul style="margin-bottom:0;">
					<li class="first"> <a href="javascript:pageMove('1', '${path}');">첫 페이지</a> </li>
					<c:if test="${returnMap['page'][0] > 1 }">
					<li class="prev"> <a href="javascript:pageMove('${returnMap['page'][0] - 1 }', '${path}');">이전 페이지</a> </li>
					</c:if>
					<c:forEach  begin="${(cycleStart)*10+1}" end="${((cycleStart)*10 + 10) > lastPage ? lastPage:((cycleStart)*10 + 10)}" var="i" >
						<li class="${returnMap['page'][0]==i?'active':''}"> <a href="javascript:;" onclick="pageMove('${i}', '${path}');">${i}</a> </li>
					</c:forEach>
					<c:if test="${returnMap['page'][0] < lp }">
					<li class="next"> <a href="javascript:pageMove('${returnMap['page'][0] + 1 }', '${path}');"> 다음 페이지 </a> </li>
					</c:if>
					<li class="last"> <a href="javascript:pageMove('${lp}', '${path}');"> 마지막 페이지 </a> </li>
				</ul>
			</div>
			</c:if>
			
		</section>
	</section>
	<%@include file="common/footerKR.jsp"%>
</div>
<form id="dateForm" method="post">
	<input type="hidden" id="month" name="month" />
	<input type="hidden" id="year" name="year" />
</form>

<form id="pagingForm">
	<input type="hidden" name="year" />
	<input type="hidden" name="month" />
	<input type="hidden" name="page" value="${returnMap['page'][0]}"/>
	<input type="hidden" name="bundle" value="20"/>
</form>

<%@include file="view_form.jsp" %>
</body>
</html>