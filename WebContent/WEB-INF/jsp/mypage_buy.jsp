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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<script src="js/mypage.js"></script>
</head>
<body>
	<div class="wrap">
		<%@include file="header.jsp"%>
		<section class="mypage">
		<div class="head">
			<h2>마이페이지</h2>
			<p>설명어쩌고저쩌고</p>
		</div>
		<div class="mypage_ul">
			<ul class="mp_tab1">
				<c:if test="${MemberInfo.type eq 'M'}">
					<li>
						<a href="/account.mypage">정산 관리</a>
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
				<c:if test="${MemberInfo.deferred eq 'Y'}">
					<li>
						<a href="/download.mypage">다운로드 내역</a>
					</li>
					<li>
						<a href="/postBuylist.mypage">구매내역</a>
					</li>
				</c:if>
				<c:if test="${MemberInfo.deferred eq 'N'}">
					<li>
						<a href="/cart.myPage">장바구니</a>
					</li>
					<li class="on">
						<a href="/buylist.mypage">구매내역</a>
					</li>
				</c:if>
			</ul>
		</div>
		<div class="table_head">
			<h3>주문 상세 정보</h3>
		</div>
		<section id="order_list">
		<div class="calculate_info_area">
			주문번호 :
			<span class="color">${paymentManageDTO.LGD_OID }</span>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tb03">
			<colgroup>
				<col width="200">
					<col width="200">
						<col width="300">
							<col width="300">
			</colgroup>
			<tr>
				<th scope="col">결제방법</th>
				<th scope="col">결제상태</th>
				<th scope="col">거래번호</th>
				<th scope="col">가상계좌번호</th>
			</tr>
			<tr>
				<td>${paymentManageDTO.getPayType() }</td>
				<td>${paymentManageDTO.LGD_RESPMSG }</td>
				<td>${paymentManageDTO.LGD_TID }</td>
				<td>
					<c:if test="${!empty paymentManageDTO.LGD_FINANCENAME}">
					[${paymentManageDTO.LGD_FINANCENAME }] 
				</c:if>
					${paymentManageDTO.LGD_ACCOUNTNUM }
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" class="tb02">
			<colgroup>
				<col width="100">
					<col>
						<col width="120">
							<col width="60">
								<col width="200">
									<col width="100">
			</colgroup>
			<thead>
				<tr>
					<th>카테고리</th>
					<th>구매 이미지 정보</th>
					<th>콘텐츠가격</th>
					<th>파일</th>
					<th>다운로드 기간</th>
					<th>다운로드 횟수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${paymentManageDTO.paymentDetailList}" var="paymentDetailList">
					<tr>
						<c:choose>
							<c:when test="${paymentDetailList.photoDTO.ownerType eq 'M'}">
								<td>보도사진</td>
							</c:when>
							<c:when test="${paymentDetailList.photoDTO.ownerType eq 'P'}">
								<td>개인</td>
							</c:when>
							<c:when test="${paymentDetailList.photoDTO.ownerType eq 'C'}">
								<td>제휴업체</td>
							</c:when>
							<c:when test="${paymentDetailList.photoDTO.ownerType eq 'S'}">
								<td>다하미</td>
							</c:when>
							<c:otherwise>
								<td></td>
							</c:otherwise>
						</c:choose>
						<td>
							<div class="cart_item">
								<div class="thumb">
									<a href="/view.photo?uciCode=${paymentDetailList.photo_uciCode }" target="_blank">
										<img src="http://www.dev.newsbank.co.kr/list.down.photo?uciCode=${paymentDetailList.photo_uciCode }">
									</a>
								</div>
								<div class="cart_info">
									<a href="/view.cms?uciCode=${paymentDetailList.photo_uciCode }" target="_blank">
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
								<div class="message">상세용도 : 상세용도 표시되는 영역인데 이번에는 빼고 간대요. 영역 잡아만 놓을게요.</div>
							</div>
							</a>
						</td>
						<td>${paymentDetailList.getPrice_Str() }</td>
						<td>jpg</td>
						<td>
							${paymentDetailList.downStart }~
							<br />
							${paymentDetailList.downEnd }
						</td>
						<td>
							${paymentDetailList.downCount }회
							<br />
							<div class="btn_group">
<c:if test="${paymentDetailList.downExpire eq false}">
								<button type="button" class="btn_o" name="btn_down" value="${paymentDetailList.photo_uciCode }">다운로드</button>
</c:if>
								<button type="button" class="btn_g" name="btn_cancle" value="${paymentDetailList.photo_uciCode }">결제취소</button>
								<!-- 다운로드 0일때만 가능-->
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<td colspan="10">합계 : ${paymentManageDTO.getLGD_AMOUNT_Str() }</td>
			</tfoot>
		</table>
		<a href="buylist.mypage" class="mp_btn">목록</a> </section> </section>
	</div>
</body>
</html>
