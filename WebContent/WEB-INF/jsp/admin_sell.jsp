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
<script type="text/javascript">
	$(document).ready(function() {
		//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
		$("[href]").each(function() {
			if (this.href == window.location.href) {
				$(this).parent().addClass("on");
			}
		});		
		
	});
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
				<div class="ad_sch_area">
					<table class="tb01" cellpadding="0" cellspacing="0">
						<colgroup>
							<col style="width: 180px;">
								<col style="width:;">
						</colgroup>
						<tbody>
							<tr>
								<th>검색</th>
								<td><input type="text" class="inp_txt" size="80"
									placeholder="아이디, 이름, 회사명" /></td>
							</tr>
							<tr>
								<th>기간 선택</th>
								<td><select name="" class="inp_txt" style="width: 100px;">
										<option value="all" selected="selected">전체(년)</option>
										<option value="2018">2018년</option>
										<option value="2017">2017년</option>
										<option value="2016">2016년</option>
										<option value="2015">2015년</option>
								</select> <select name="" class="inp_txt" style="width: 95px;">
										<option value="all" selected="selected">전체(월)</option>
										<option value="1">1월</option>
										<option value="2">2월</option>
										<option value="3">3월</option>
										<option value="4">4월</option>
										<option value="5">5월</option>
										<option value="6">6월</option>
										<option value="7">7월</option>
										<option value="8">8월</option>
										<option value="9">9월</option>
										<option value="10">10월</option>
										<option value="11">11월</option>
										<option value="12">12월</option>
								</select>
									<ul class="period">
										<li><a href="#" class="btn">2월</a></li>
										<li><a href="#" class="btn">1월</a></li>
										<li><a href="#" class="btn">12월</a></li>
										<li><a href="#" class="btn">11월</a></li>
										<li><a href="#" class="btn">10월</a></li>
										<li><a href="#" class="btn">9월</a></li>
									</ul>
									<div class="period">
										<input type="text" size="12" class="inp_txt" value="2017-05-01"
											maxlength="10"> <span class=" bar">~</span> <input
											type="text" size="12" class="inp_txt" value="2017-05-01"
											maxlength="10">
									</div></td>
							</tr>
							<tr>
								<th>매체</th>
								<td><select name="" class="inp_txt" style="width: 150px;">
										<option value="all" selected="selected">정산 매체 전체</option>
										<option value=" ">-</option>
										<option value=" ">-</option>
										<option value=" ">-</option>
								</select> <select name="" class="inp_txt" style="width: 150px;">
										<option value="all" selected="selected">피정산 매체 전체</option>
										<option value=" ">-</option>
										<option value=" ">-</option>
										<option value=" ">-</option>
								</select></td>
							</tr>
							<tr>
								<th>결제 상황</th>
								<td><select name="select" class="inp_txt"
									style="width: 200px;">
										<option value="all" selected="selected">전체</option>
										<option value=" ">무통장 입금</option>
										<option value=" ">실시간 계좌이체</option>
										<option value=" ">오프라인 세금계산서 발행</option>
								</select></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_area" style="margin-top: 0;">
						<a href="admin10-1.html" class="btn_input2">검색</a>
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
			</div>
		</section>
	</div>
</body>
</html>