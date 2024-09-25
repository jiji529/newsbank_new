<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 11. 1.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 1.   	  tealight        file_name
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>NYT 뉴스뱅크</title>
<script src="js/nyt/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="css/nyt/base.css" />
<link rel="stylesheet" href="css/nyt/sub.css" />
<link rel="stylesheet" href="css/nyt/mypage.css" />
<script src="js/nyt/filter.js"></script>
<script src="js/nyt/footer.js"></script>
<script src="js/nyt/mypage.js?v=20180913"></script>

</head>
<body>
	<div class="wrap">
		<%@include file="common/headerKR2.jsp"%>
		<section class="mypage">
			<div class="head">
				<h2>마이페이지</h2>
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
						<li>
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
			</div>
			<div class="table_head">
				<h3>구매내역</h3>
			</div>
			<section class="order_list">
				<table id="tbBuyList" width="100%" id="" border="0" cellspacing="0" cellpadding="0" class="tb03" style="border-top: 0;">
					<colgroup>
						<col width="40">
						<col>
						<col width="200">
						<col width="200">
						<col width="200">
					</colgroup>
					<tr>
						<th scope="col">No</th>
						<th scope="col">주문번호</th>
						<th scope="col">결제방법</th>
						<th scope="col">결제금액</th>
						<th scope="col">결제상태</th>
					</tr>
					<c:forEach items="${listPaymentManage}" var="paymentManage" varStatus="loop">
						<tr>
							<td>${loop.index+1}</td>
							<td>
								<a href="javascript:;">${paymentManage.LGD_OID }</a>
							</td>
							<td>${paymentManage.LGD_PAYTYPE_STR}</td>
							<td>${paymentManage.getLGD_AMOUNT_Str()}</td>
							<c:choose>
								<c:when test="${paymentManage.LGD_PAYSTATUS eq '0'}">
									<td>결제 실패</td>
								</c:when>
								<c:when test="${paymentManage.LGD_PAYSTATUS eq '1'}">
									<td>결제 성공</td>
								</c:when>
								<c:when test="${paymentManage.LGD_PAYSTATUS eq '2'}">
									<td>결제 대기</td>
								</c:when>
								<c:when test="${paymentManage.LGD_PAYSTATUS eq '3'}">
									<td>입금 대기중</td>
								</c:when>
								<c:when test="${paymentManage.LGD_PAYSTATUS eq '4'}">
									<td>후불 결제</td>
								</c:when>
								<c:when test="${paymentManage.LGD_PAYSTATUS eq '5'}">
									<td>결제 취소</td>
								</c:when>
								<c:when test="${paymentManage.LGD_PAYSTATUS eq '6'}">
									<td>부분 취소</td>
								</c:when>
								
							</c:choose>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(listPaymentManage) == 0}">
						<tr>
							<td colspan="5">구매 내역이 없습니다.</td>
						</tr>
					</c:if>
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
	
	<form id="pagingForm">
		<input type="hidden" name="year" />
		<input type="hidden" name="month" />
		<input type="hidden" name="page" value="${returnMap['page'][0]}"/>
		<input type="hidden" name="bundle" value="20"/>
	</form>
</body>
</html>