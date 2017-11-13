<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2017. 11. 09. 오후 05:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 09.   hoyadev        pay
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% long currentTimeMills = System.currentTimeMillis(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script type="text/javascript">
	
</script>
</head>
<body> 
<div class="wrap">
	<%@include file="header.jsp" %>
	<section class="mypage pay">
		<div class="head">
			<h2>결제하기</h2>
			<p>설명어쩌고저쩌고</p>
		</div>
		<div class="table_head">
			<h3>주문정보 확인</h3>
		</div>
		<section id="order_list">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tb03" style="border-top:0; margin-bottom:15px;">
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
				<c:set var="sum" value="0" />
				<c:forEach items="${payList}" var="pay">
					<tr>
						<td>
							<div class="cart_item">
							<div class="thumb"><a href="view.html" target="_blank"><img src="/list.down.photo?uciCode=${pay.uciCode}" /></a></div>
							<div class="cart_info"> <a href="view.html" target="_blank">
								<div class="brand">${pay.copyright}</div>
								<div class="code">${pay.uciCode}</div>
								</a>
								<div class="option_area">
									<c:forEach items="${pay.getUsageList()}" var="UsageDTO">
										<ul class="opt_li">
											<li>${UsageDTO.usage}</li>
											<li>${UsageDTO.division1}</li>
											<li>${UsageDTO.division2}</li>
											<li>${UsageDTO.division3}</li>
											<li>${UsageDTO.usageDate}</li>
										</ul>
									</c:forEach>
								</div>
							</div>
						</div></td>
						<td><fmt:formatNumber value="${pay.price * 10 / 11}" type="number"/>원</td>
						<td><fmt:formatNumber value="${pay.price * 10 / 11 / 10}" type="number"/>원</td>
						<td><strong class="color"><fmt:formatNumber value="${pay.price}" type="number"/>원</strong></td>
						<c:set var="sum" value="${sum + pay.price}" />
					</tr>
				</c:forEach>
			</table>
			<div class="pay_lt">
				<div class="table_head">
					<h3>결제방법 선택</h3>
				</div>
				<ul>
					<li>
						<input type="radio" id="pay1" name="pay" />
						<label for="pay1">신용카드 </label>
					</li>
					<li>
						<input type="radio" id="pay2" name="pay" />
						<label for="pay2">실시간 계좌이체 </label>
					</li>
					<li>
						<input type="radio" id="pay3" name="pay" />
						<label for="pay3">무통장입금 </label>
					</li>
				</ul>
			</div>
			<div class="pay_rt">
				<div class="table_head">
					<h3>최종 결제 정보</h3>
				</div>
				<div class="pay_rt_box">
				<ul>
					<li><strong>판매가</strong>
						<p><fmt:formatNumber value="${sum * 10 / 11}" type="number"/><em>원</em></p>
					</li>
					<li><strong>부가세</strong>
						<p><fmt:formatNumber value="${sum * 10 / 11 / 10}" type="number"/><em>원</em></p>
					</li>
				</ul>
				<div class="result_list">
					<ul>
						<li><strong>결제금액</strong>
							<p><fmt:formatNumber value="${sum}" type="number"/><em>원</em></p>
						</li>
					</ul>
					<div class="btn_area"><a href="http://ecredit.uplus.co.kr/" class="btn_input2">결제하기</a></div>
				</div>
			</div></div>
		</section>
	</section>
</div>
</body>
</html>