<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2018. 03. 14. 오후 14:24:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2018. 03. 14.   LEE GWANGHO    view.online.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.dahami.newsbank.web.service.bean.SearchParameterBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css">

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>
<script src="js/jquery.twbsPagination.js"></script>
<script src="js/filter.js"></script>
<script type="text/javascript">
	function cancel_payment(refund, down_count, paymentManage_seq, LGD_OID) {	// 결제 취소
		console.log(paymentManage_seq);
	
		if((refund == "true") && (down_count == 0)){
			if (confirm("결제를 취소하시면 이미지 다운로드가 불가능해집니다. 결제를 취소하시겠습니까?")) {
				
				var param = {
					"paymentManage_seq" : paymentManage_seq,
					"LGD_OID" : LGD_OID,
					"cmd" : "C"
				};
				
				$.ajax({
					type: "POST",
					dataType: "json",
					url: "/payment.api",
					data: param,
					success: function(data) {
						console.log(data);
					}
				});
				alert("결제 취소 완료");
			}
		}else{
			if(down_count > 0) {
				alert("이미지를 다운로드 받으셔서, 결제 취소가 불가능합니다.");
			}else if(refund == "false") {
				alert("환불 가능기간은 결제일로부터 7일 입니다.");
			}
		}
	}
</script>
<title>뉴스뱅크</title>
</head>
<body>
	<div class="wrap admin">
		<%@include file="header_admin.jsp"%>
		<section class="wide"> <%@include file="sidebar.jsp"%>

			<div class="mypage">
				<div class="table_head">
					<h3>온라인 결제 관리</h3>
				</div>
				<div class="ad_sch_area">
					<table class="tb01" cellpadding="0" cellspacing="0">
						<colgroup>
						<col style="width:180px;">
						<col style="width:;">
						<col style="width:180px;">
						<col style="width:;">
						</colgroup>
						<tbody>
							<tr>
								<th>주문번호</th>
								<td>${payInfo.LGD_OID }</td>
								<th>주문일자</th>
								<fmt:parseDate var="dateString" value="${payInfo.LGD_PAYDATE}" pattern="yyyyMMddHHmmss" />
								<fmt:formatDate value="${dateString}" var="LGD_PAYDATE_DATE" pattern="yyyy-MM-dd hh:mm:ss"/>
								<td>${LGD_PAYDATE_DATE}</td>
							</tr>
							<tr>
								<th>구분</th>
								<td>${memberDTO.type }</td>
								<th>회사/기관명</th>
								<td>${memberDTO.compName }</td>
							</tr>
							<tr>
								<th>아이디</th>
								<td>${payInfo.LGD_BUYERID }</td>
								<th>이름</th>
								<td>${payInfo.LGD_BUYER }</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>${memberDTO.phone }</td>
								<th>이메일</th>
								<td><a href="${memberDTO.email }">${memberDTO.email }</a></td>
							</tr>
							<tr>
								<th>결제방법</th>
								<td>${payInfo.LGD_PAYTYPE }</td>
								<th>결제 상태</th>
								<td>${payInfo.LGD_RESPMSG }</td>
							</tr>
							<tr>
								<th>거래번호</th>
								<td>${payInfo.LGD_TID }</td>
								<th>가상계좌번호</th>
								<td>${payInfo.LGD_ACCOUNTNUM }</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="ad_result">
					<table cellpadding="0" cellspacing="0" class="tb04">
						<colgroup>
						<col width="50" />
						<col width="60" />
						<col width="80" />
						<col width="120" />
						<col width="110" />
						<col width="200" />
						<col width="80" />
						<col width="70" />
						</colgroup>
						<thead>
							<tr>
								<th>No. </th>
								<th>이미지</th>
								<th>매체</th>
								<th>UCI 코드</th>
								<th>매체사 고유 코드</th>
								<th>용도</th>
								<th>결제금액</th>
								<th>다운로드 횟수</th>
							</tr>
						</thead>
						<tbody>
							<!-- 결제 사진 목록 -->
							<c:set var="totalPrice" value="0" />
							<c:set var="totalDownCount" value="0"/>
							<c:forEach var="detail" items="${detailList}" varStatus="status">
								<c:set var="totalPrice" value="${totalPrice + detail.price}" />
								<c:set var="totalDownCount" value="${totalDownCount + detail.downCount}"/>	
								<tr>
									<td>${status.index+1}</td>
									<!-- <td><img src="https://www.newsbank.co.kr/datafolder/N0/2016/01/08/E006203286_T.jpg" /></td> -->
									<%-- <td><img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=${detail.photo_uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>"></td> --%>
									<td><img src="http://www.dev.newsbank.co.kr/list.down.photo?uciCode=${detail.photo_uciCode}" /></td>
									<td>${detail.photoDTO.copyright }</td>
									<td>${detail.photo_uciCode }</td>
									<td>${detail.photoDTO.compCode }</td>
									<td>
										<c:if test="${!empty detail.usageDTO.usage}">
											${detail.usageDTO.usage}
										</c:if>
										
										<c:if test="${!empty detail.usageDTO.division1}">
											| ${detail.usageDTO.division1}
										</c:if>
										
										<c:if test="${!empty detail.usageDTO.division2}">
											 | ${detail.usageDTO.division2}
										</c:if>
										
										<c:if test="${!empty detail.usageDTO.division3}">
											| ${detail.usageDTO.division3}
										</c:if>
										
									</td>
									<td><fmt:formatNumber value="${detail.price }" pattern="#,###" /></td>
									<td>${detail.downCount }</td>
								</tr>
							</c:forEach>						
						</tbody>
						<tfoot>
							<tr>
								<td colspan="6">총 결제 금액</td>
								<td colspan="4"><fmt:formatNumber value="${totalPrice}" pattern="#,###" /></td>
							</tr>
						</tfoot>
					</table>
				</div>
				<div class="btn_area"><a href="javascript:history.go(-1)" class="btn_input1">목록</a><a href="javascrip:void(0)" onclick="cancel_payment('${refund }', '${totalDownCount }', ${payInfo.paymentManage_seq }, '${payInfo.LGD_OID }')" class="btn_input3 fr">결제 취소</a></div>
			</div>
		</section>
	</div>
</body>
</html>