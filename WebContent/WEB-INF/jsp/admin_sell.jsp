<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2018. 03. 07. 오후 14:24:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 21.   LEE GWANGHO    sell.manage
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
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
<fmt:formatDate value="${now}" pattern="yyyy" var="year" />
<fmt:formatDate value="${now}" pattern="MM" var="month" />

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
<script src="js/filter.js"></script>
<script src="js/mypage.js?v=20180327"></script>

<script type="text/javascript">
	$(document).ready(function() {
		//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
		$("[href]").each(function() {
			if (this.href == window.location.href) {
				$(this).parent().addClass("on");
			}
		});		
	});
	
	
	function tabSwitch(tabName) {
		$("#tabName").val(tabName);
		sell_form.submit();
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
					<h3>정산 관리</h3>
				</div>
				<div class="tab">
					<ul class="tabs">
						<li><a href="javascript:tabSwitch('byYear')" <c:if test="${tabName eq 'byYear'}">class="active"</c:if>>년도별 총 판매금액</a></li>
						<li><a href="javascript:tabSwitch('byItem')" <c:if test="${tabName eq 'byItem'}">class="active"</c:if>>결제건별 상세내역</a></li>
					</ul>
				</div>
				
				<div class="tabs_result">
				
					<c:if test="${tabName eq 'byYear'}">
						<%@include file="admin_tab_sellyear.jsp"%>
					</c:if>
					
					<c:if test="${tabName eq 'byItem'}">
						<%@include file="admin_tab_sellitem.jsp"%>
					</c:if>				
				</div>
				
				<%-- <div class="ad_sch_area">
					<table class="tb01" cellpadding="0" cellspacing="0">
						<colgroup>
							<col style="width: 180px;">
								<col style="width:;">
						</colgroup>
						<tbody>
							<tr>
								<th>검색</th>
								<td><input type="text" class="inp_txt" size="80" id="keyword"
									placeholder="아이디, 이름, 회사명" /></td>
							</tr>
							<tr>
								<th>기간 선택</th>
								<td>
								<select id="customYear" class="inp_txt" style="width:100px;">
									<c:forEach var="i" begin="2015" end="${year}" step="1">
										<option value="${i }" <c:if test="${i eq year}">selected</c:if>>${i}년</option>
									</c:forEach>
								</select>
								<select id="customDay" class="inp_txt" style="width:95px;">
									<option value="all" selected="selected">전체(월)</option>
									<option value="1" >1월</option>
									<option value="2" >2월</option>
									<option value="3" >3월</option>
									<option value="4" >4월</option>
									<option value="5" >5월</option>
									<option value="6" >6월</option>
									<option value="7" >7월</option>
									<option value="8" >8월</option>
									<option value="9" >9월</option>
									<option value="10" >10월</option>
									<option value="11" >11월</option>
									<option value="12" >12월</option>
								</select>
								<ul id="customDayOption" class="period">
									<c:forEach var="pastMonth" items="${pastMonths}">
										<li><a href="javascript:;" class="btn" value="${pastMonth}">${fn:substring(pastMonth, 4, 6)}월</a> </li>
									</c:forEach>
								</ul>
								<div class="period">
									<input type="text"  size="12" id="contractStart" name="start_date"  class="inp_txt" value="${year}-${month}-01" maxlength="10">
									<span class=" bar">~</span>
									<input type="text"  size="12" id="contractEnd" name="end_date"  class="inp_txt" value="${today }" maxlength="10">
								</div>
							</tr>
							<tr>
								<th>매체</th>
								<td><select name="" id="adjMaster" class="inp_txt" style="width: 150px;">
										<option value="all" selected="selected">정산 매체 전체</option>
										<c:forEach var="mediaList" items="${mediaList}" >
											<option value="${mediaList.seq }">${mediaList.compName }</option>
										</c:forEach>
										
										
								</select> <select name="" id="adjSlave" class="inp_txt" style="width: 150px;">
										<option value="all" selected="selected">피정산 매체 전체</option>
										<option value=" ">선택안함</option>
								</select>
								<input type="hidden" id="adjSlave_arr" value="">
								</td>
							</tr>
							<tr>
								<th>결제 상황</th>
								<td><select name="select" class="inp_txt" id="paytype"
									style="width: 200px;">
										<option value="all" selected="selected">전체</option>
										<option value="SC0040">무통장 입금</option>
										<option value="SC0030">실시간 계좌이체</option>
										<option value="SC9999">오프라인 세금계산서 발행</option>
								</select></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_area" style="margin-top: 0;">
						<a href="javascript:void(0)" class="btn_input2">검색</a>
					</div>
				</div>
				<div class="calculate_info_area">
					기간 : 2017-01-01 ~ 2017-10-15 <span class="bar3">l</span> 건수 : <span
						class="color">101</span>건 <span class="bar3">l</span> 총 판매금액 : <span
						class="color">15,000,000</span>원
				</div>
				<div class="ad_result">
					<div class="ad_result_btn_area fr">
						<a href="#">엑셀저장</a>
					</div>
					
					<div id="tb_media" style="display:none;">
						<table cellpadding="0" cellspacing="0" class="tb02">
							<thead>
								<tr>
									<th>No.</th>
									<th>구매일자</th>
									<th>이름 (아이디)</th>
									<th>기관/회사</th>
									<th>사진ID</th>
									<th>판매자</th>
									<th>결제종류</th>
									<th>과세금액</th>
									<th>과세부가세</th>
									<th>결제금액</th>
									<th>빌링수수료</th>
									<th>총매출액</th>
									<th><p>회원사</p>
										<p>매출액</p></th>
									<th>공급가액</th>
									<th>공급부가세</th>
									<th><p>다하미</p>
										<p>매출액</p></th>
								</tr>
							</thead>
							<tbody id="tb_media_tbody">
								<tr>
									<td>1</td>
									<td>2017-07-11</td>
									<td>인플루엔셜<br> (influential) </td>
									<td>C004200107</td>
									<td>뉴시스</td>
									<td>신용카드</td>
									<td>80,000</td>
									<td>8,000</td>
									<td>88,000</td>
									<td>3,098</td>
									<td>84,902</td>
									<td>59,431</td>
									<td>54,028</td>
									<td>5,403</td>
									<td>25,471</td>
								</tr>								
							</tbody>
							<tfoot id="tf_media">
								<!-- <tr>
									<td colspan="6">7월 매출액 합계</td>
									<td>300,000</td>
									<td>30,000</td>
									<td>330,000</td>
									<td>6,196</td>
									<td>323,804</td>
									<td><font color="#FF0000">217,862</font></td>
									<td>198,056</td>
									<td>19,806</td>
									<td><font color="#0000FF">105,942</font></td>
								</tr> -->
							</tfoot>
						</table>
					</div>
					
					<div id="tb_total">
						<table cellpadding="0" cellspacing="0" class="tb04">
							<thead>
								<tr>
									<th>구분</th>
									<th>1월</th>
									<th>2월</th>
									<th>3월</th>
									<th>4월</th>
									<th>5월</th>
									<th>6월</th>
									<th>7월</th>
									<th>8월</th>
									<th>9월</th>
									<th>10월</th>
									<th>11월</th>
									<th>12월</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>온라인 결제</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>12,000,000</td>
								</tr>
								<tr>
									<td>오프라인 결제</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>1,000,000</td>
									<td>12,000,000</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td>총 합계</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>24,000,000</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div> --%>
				
			</div>
		</section>
	</div>
	
	<form method="post" action="/sell.manage" name="sell_form" >
		<input type="hidden" id="tabName" name="tabName" />
	</form>
</body>
</html>