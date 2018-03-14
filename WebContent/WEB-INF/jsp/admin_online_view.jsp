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
								<td>20180227164321-1</td>
								<th>주문일자</th>
								<td>2017-07-27 21:46:02</td>
							</tr>
							<tr>
								<th>구분</th>
								<td>개인</td>
								<th>회사/기관명</th>
								<td>-</td>
							</tr>
							<tr>
								<th>아이디</th>
								<td>crk0526</td>
								<th>이름</th>
								<td>김기동</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>010-5319-5907</td>
								<th>이메일</th>
								<td><a href="mailto:crk0526@gmail.com">crk0526@gmail.com</a></td>
							</tr>
							<tr>
								<th>결제방법</th>
								<td>신용카드</td>
								<th>결제 상태</th>
								<td>결제 완료</td>
							</tr>
							<tr>
								<th>거래번호</th>
								<td>dahami2017072721455074865</td>
								<th>가상계좌번호</th>
								<td>-</td>
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
								<th>상품구분</th>
								<th>매체</th>
								<th>UCI 코드</th>
								<th>매체사 고유 코드</th>
								<th>용도</th>
								<th>결제금액</th>
								<th>다운로드 횟수</th>
							</tr>
						</thead>
						<tbody id="mtBody">
							<!-- 결제 사진 목록 -->							
						</tbody>
						<tfoot>
							<tr>
								<td colspan="6">총 결제 금액</td>
								<td colspan="4">176,000</td>
							</tr>
						</tfoot>
					</table>
				</div>
				
			</div>
		</section>
	</div>
</body>
</html>