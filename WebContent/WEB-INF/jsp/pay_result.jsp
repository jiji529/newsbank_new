<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 10. 12. 오전 11:20:00
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 16.   hoyadev        buy.mypage
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="tomorrow" value="<%=new Date(new Date().getTime() + 60*60*24*1000)%>"/>

<%
	String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="js/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/mypage.js"></script>

</head>
<body>
	<div class="wrap">
		<%@include file="header.jsp"%>
		<section class="mypage pay">
		<div class="head">
			<h2>주문완료</h2>
			<p style="display: block;">은행에 입금해 주시면 이미지 구매가 완료됩니다.</p>
		</div>
		<c:if test="${paymentManageDTO.LGD_PAYTYPE eq 'SC0040'}">
			<section class="order_list">
			<div class="table_head">
				<h3>입금 은행 정보</h3>
			</div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tb03" style="border-top: 0; margin-bottom: 15px;">
				<colgroup>
					<col width="250">
						<col width="110">
							<col width="100">
								<col width="200">
				</colgroup>
				<tr>
					<th scope="col">은행(예금주)</th>
					<th scope="col">계좌번호</th>
					<th scope="col">금액</th>
					<th scope="col">기간</th>
				</tr>
				<tr>
					<td>${paymentManageDTO.LGD_FINANCENAME }(${paymentManageDTO.LGD_BUYER })</td>
					<td>
						<b>${paymentManageDTO.LGD_ACCOUNTNUM }</b>
					</td>
					<td>${paymentManageDTO.getLGD_AMOUNT_Str() }원</td>
					<td><fmt:formatDate value="${tomorrow}" type="DATE" pattern="yyyy-MM-dd"/> 까지</td>
				</tr>
			</table>
			</section>
		</c:if> <section class="order_list">
		<div class="table_head">
			<h3>주문 정보 확인</h3>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tb03" style="border-top: 0; margin-bottom: 15px;">
			<colgroup>
				<col>
					<col width="110">
						<col width="100">
							<col width="110">
			</colgroup>
			<tr>
				<th scope="col">상품정보</th>
				<th scope="col">판매가</th>
				<th scope="col">부가세</th>
				<th scope="col">구매금액</th>
			</tr>
			<c:forEach items="${paymentManageDTO.paymentDetailList}" var="paymentDetailList">
				<tr>
					<td>
						<div class="cart_item">
							<div class="thumb">
								<a href="<%=IMG_SERVER_URL_PREFIX  %>/view.photo?uciCode=${paymentDetailList.photo_uciCode }" target="_blank">
										<img src="<%=IMG_SERVER_URL_PREFIX  %>/list.down.photo?uciCode=${paymentDetailList.photo_uciCode }">
									</a>
							</div>
							<div class="cart_info">
								<a href="/view.photo?uciCode=${paymentDetailList.photo_uciCode }" target="_blank">
										<div class="brand">${paymentDetailList.photoDTO.copyright }</div>
										<div class="code">${paymentDetailList.photo_uciCode }</div>
									</a>
									<div class="option_area">
										<ul class="opt_li">
											<li>${paymentDetailList.usageDTO.usage }</li>
											<li>${paymentDetailList.usageDTO.division1 }</li>
											<li>${paymentDetailList.usageDTO.division2 }</li>
											<li>${paymentDetailList.usageDTO.division3 }</li>
											<c:if test="${!empty paymentDetailList.usageDTO.division4}">
												<li>${paymentDetailList.usageDTO.division4 }</li>
											</c:if>
											<li>${paymentDetailList.usageDTO.usageDate }</li>
										</ul>
									</div>
							</div>
						</div>
					</td>
					<td>${paymentDetailList.usageDTO.formatPrice(paymentDetailList.usageDTO.price*10/11) }원</td>
					<td>${paymentDetailList.usageDTO.formatPrice(paymentDetailList.usageDTO.price/11) }원</td>
					<td>
						<strong class="color">${paymentDetailList.usageDTO.formatPrice(paymentDetailList.usageDTO.price) }원</strong>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div class="btn_area">
			<a href="/buylist.mypage" class="btn_input2">주문완료 확인</a>
		</div>
		</section> </section>
	</div>
</body>
</html>
