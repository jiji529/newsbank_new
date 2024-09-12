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
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
<script src="js/nyt/mypage.js?v=20180405"></script>
</head>
<body>
	<div class="wrap">
		<%@include file="common/headerKR2.jsp"%>
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
					<li>
						<a href="/postBuylist.mypage">구매내역</a>
					</li>
				</c:if>
				<c:if test="${MemberInfo.deferred eq 0}">
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
		<section class="order_list">
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
				<td>${paymentManageDTO.LGD_PAYTYPE_STR }</td>
				
				<c:choose>
					<c:when test="${paymentManageDTO.LGD_PAYSTATUS eq '0'}">
						<td>결제 실패</td>
					</c:when>
					<c:when test="${paymentManageDTO.LGD_PAYSTATUS eq '1'}">
						<td>결제 성공</td>
					</c:when>
					<c:when test="${paymentManageDTO.LGD_PAYSTATUS eq '2'}">
						<td>결제 대기</td>
					</c:when>
					<c:when test="${paymentManageDTO.LGD_PAYSTATUS eq '3'}">
						<td>무통장 입금</td>
					</c:when>
					<c:when test="${paymentManageDTO.LGD_PAYSTATUS eq '4'}">
						<td>후불 결제</td>
					</c:when>
					<c:when test="${paymentManageDTO.LGD_PAYSTATUS eq '5'}">
						<td>결제 취소</td>
					</c:when>
					<c:when test="${paymentManageDTO.LGD_PAYSTATUS eq '6'}">
						<td>부분 취소</td>
					</c:when>
					<c:otherwise>
						<td>결제 실패 ${paymentManageDTO.LGD_PAYSTATUS }</td>
					</c:otherwise>
				</c:choose>
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
				<col width="200">
				<col width="100">
			</colgroup>
			<thead>
				<tr>
					<th>카테고리</th>
					<th>구매 이미지 정보</th>
					<th>콘텐츠가격</th>
					<th>다운로드 기간</th>
					<th>다운로드 횟수</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="totalDownCount" value="0"/>
				<c:set var="totalCancelCount" value="0"/>
				<c:set var="totalPrice" value="${paymentManageDTO.getLGD_AMOUNT()}" />
				<c:forEach items="${paymentManageDTO.paymentDetailList}" var="paymentDetailList">
					<c:set var="totalDownCount" value="${totalDownCount + paymentDetailList.downCount}"></c:set>
					<c:set var="totalCancelCount" value="${totalCancelCount + paymentDetailList.status}"></c:set>
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
									<c:choose>
										<c:when test="${paymentDetailList.memberDTO.withdraw eq 0 && paymentDetailList.memberDTO.admission eq 'Y' && paymentDetailList.memberDTO.activate eq 1 && paymentDetailList.photoDTO.saleState eq 1}">
											<a href="javascript:void(0);" onclick="go_View('${paymentDetailList.photo_uciCode}', '/view.photo', '_blank')">
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0);" onclick="stopSaleMessage()">
										</c:otherwise>
									</c:choose>
										<img src="<%=IMG_SERVER_URL_PREFIX %>/list.down.photo?uciCode=${paymentDetailList.photo_uciCode }">
										</a>
								</div>
								<div class="cart_info">
									<c:choose>
										<c:when test="${paymentDetailList.memberDTO.withdraw eq 0 && paymentDetailList.memberDTO.admission eq 'Y' && paymentDetailList.memberDTO.activate eq 1 && paymentDetailList.photoDTO.saleState eq 1}">
											<a href="javascript:void(0);" onclick="go_View('${paymentDetailList.photo_uciCode}', '/view.photo', '_blank')">
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0);" onclick="stopSaleMessage()">
										</c:otherwise>
									</c:choose>
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
								<!-- <div class="message">상세용도 : 상세용도 표시되는 영역인데 이번에는 빼고 간대요. 영역 잡아만 놓을게요.</div> -->
							</div>
							</a>
						</td>
						<td>
							<c:choose>
							  <c:when test="${paymentDetailList.status eq '1'}">
						    	<del>${paymentDetailList.getPrice_Str() }</del>
						    	<%-- <c:set var="totalPrice" value="${totalPrice-paymentDetailList.getPrice() }"/> --%>
							  </c:when>
							  <c:otherwise>
							    ${paymentDetailList.getPrice_Str() }
							  </c:otherwise>
							</c:choose>
						</td>
						<td>
							${paymentDetailList.downStart }~
							<br />
							${paymentDetailList.downEnd }
						</td>
						<td>
							<c:if test="${(paymentManageDTO.LGD_PAYSTATUS eq '1' or paymentManageDTO.LGD_PAYSTATUS eq '6')  and paymentDetailList.status ne '1'}">
							${paymentDetailList.downCount }회
							<br />
								<div class="btn_group">
									<form name="payDetailForm">
										<input type="hidden" name="paymentDetail_seq" value="${paymentDetailList.paymentDetail_seq}" />
										<input type="hidden" name="photo_uciCode" value="${paymentDetailList.photo_uciCode}" />
										<input type="hidden" name="LGD_OID" value="${paymentManageDTO.LGD_OID}" />
										<c:if test="${paymentDetailList.downExpire eq false}">
											<button type="button" class="btn_o" name="btn_down">다운로드</button>
										</c:if>
										
										<!-- 결제 취소가능기간 : 결제일자 기준 7일 이내  -->
										<c:set var="today" value="<%= new Date() %>" />
										<fmt:parseNumber value="${today.time / (1000*60*60*24)}" integerOnly="true" var="NOWDATE"/>
										<fmt:parseDate value="${paymentManageDTO.LGD_PAYDATE}" var="LGD_PAYDATE" pattern="yyyyMMddHHmmss"/>
										<fmt:parseNumber value="${LGD_PAYDATE.time / (1000*60*60*24)}" integerOnly="true" var="PAYDATE"/>
										<c:set value="${NOWDATE - PAYDATE}" var="cancelTerm" />
										
										<!-- 결제 취소 : 다운로드 횟수0 && 신용카드 결제 && 결제일자 기준 7일 이내 -->
										<c:if test="${paymentDetailList.downCount eq 0 && paymentManageDTO.LGD_PAYTYPE_STR eq '신용카드' && cancelTerm <= 7 }">
											<button type="button" class="btn_g" name="btn_cancel">결제 취소</button>
										</c:if>
									</form>
								</div>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<td colspan="10">합계 : <fmt:formatNumber value="${totalPrice}" pattern="#,###" /></td>
				<%-- <td colspan="10">합계 : ${paymentManageDTO.getLGD_AMOUNT_Str() }</td> --%>
			</tfoot>
		</table>
		
		<!-- 결제상태 조건 (1: 결제승인, 2: 결제대기, 3: 무통장입금) -->
		<c:if test="${paymentManageDTO.LGD_PAYSTATUS eq '1' or paymentManageDTO.LGD_PAYSTATUS eq '2' or paymentManageDTO.LGD_PAYSTATUS eq '3'}">
				<div class="btn_area prec">
				<p>이미지 다운로드 이력이 없으신 경우에 한하여 결제일로부터 7일 이내에 결제 취소 요청이 가능합니다.</p>
				<c:if test="${paymentManageDTO.LGD_PAYTYPE_STR eq '신용카드'}">
				<form name="payAllCancel">
					<input type="hidden" name="LGD_OID" value="${paymentManageDTO.LGD_OID}" />
					<input type="hidden" name="LGD_PAYDATE" value="${paymentManageDTO.LGD_PAYDATE}" />
					<input type="hidden" name="totalDownCount" value="${totalDownCount}" />
					<c:if test="${totalDownCount eq '0' and totalCancelCount eq '0'}">
					<a href="javascript:;" class="btn_input1 precautions_btn">전체 결제 취소</a>
					</c:if>
				</form>
				
				</c:if>
				<ul class="precautions">
					<li>※ 결제 취소/환불 유의사항</li>
					<li>• 환불신청 기간(결제 후 7일 이내)이 지난 결제 건은 다운로드 내역이 없더라도 결제 취소를 신청하실 수 없습니다.</li>
					<li>• 다운로드 내역이 있는 결제 건은 환불신청 기간 이내여도 결제 취소를 신청하실 수 없습니다.</li>
					<li>• 부분 취소를 한 주문 건에 대한 전체 결제 취소는 불가능합니다.</li>
				</ul>
				<ul class="precautions ">
					<li>□ 신용카드 결제 취소: </li>
					<li>-	해외카드의 경우, 승인취소(매입전취소)가 불가능합니다.</li>
					<li>-	단, 해외 VISA카드만 당일 결제 건에 한하여 취소가 가능합니다.</li></ul>
				<ul class="precautions ">
					<li>□ 실시간 계좌이체 및 무통장입금 결제 취소:</li>
					<li>-	고객센터(02-593-4174)로 문의 부탁드립니다. </li>
				</ul>
			</div>
			
			
		</c:if>
		
		<a href="buylist.mypage" class="mp_btn">목록</a> </section> </section>
<%@include file="common/footerKR.jsp"%>
	</div>
<%@include file="view_form.jsp" %>
<%@include file="down_frame.jsp" %>
</body>
</html>
