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
  2017. 11. 21.   LEE GWANGHO    online.manage
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
					<h3>온라인 결제 관리</h3>
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
									placeholder="아이디, 이름, 주문번호" /></td>
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
								<th>결제 방법</th>
								<td><select name="" class="inp_txt" style="width: 150px;">
										<option value="all" selected="selected">전체</option>
										<option value=" ">신용카드</option>
										<option value=" ">무통장입금</option>
										<option value=" ">계좌이체</option>
								</select></td>
							</tr>
							<tr>
								<th>결제 상황</th>
								<td><select name="select" class="inp_txt"
									style="width: 150px;">
										<option value="all" selected="selected">전체</option>
										<option value=" ">미입금</option>
										<option value=" ">결제완료</option>
										<option value=" ">결제취소</option>
								</select></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_area" style="margin-top: 0;">
						<a href="#" class="btn_input2">검색</a>
					</div>
				</div>
				<div class="calculate_info_area">
					기간 : 2017-01-01 ~ 2017-10-15 <span class="bar3">l</span> 건수 : <span
						class="color">101</span>건 <span class="bar3">l</span> 총 판매금액 : <span
						class="color">15,000,000</span>원 <span class="bar3">l</span>
					<p style="color: #888;">
						( 결제 완료 : 20,000,000원/ 90건 <span class="bar3">l</span> 결제 취소 :
						4,000,000원/ 9건 <span class="bar3">l</span>미입금 : 1,000,000원/ 1건 )
					</p>
				</div>
				<div class="ad_result">
					<div class="ad_result_btn_area fr">
						<select>
							<option>20개</option>
							<option>50개</option>
							<option>100개</option>
						</select> <a href="#">엑셀저장</a>
					</div>
					<table cellpadding="0" cellspacing="0" class="tb04">
						<colgroup>
							<col width="40" />
							<col width="50" />
							<col width="120" />
							<col width="100" />
							<col width="80" />
							<col width="150" />
							<col width="150" />
							<col width="100" />
							<col width="100" />
							<col width="150" />
							<col width="80" />
							<col width="80" />
						</colgroup>
						<thead>
							<tr>
								<th><div class="tb_check">
										<input id="check_all" name="check_all" type="checkbox">
											<label for="check_all">선택</label>
									</div></th>
								<th>No.</th>
								<th>주문일자</th>
								<th>아이디</th>
								<th>이름</th>
								<th>주문번호</th>
								<th>결제방법</th>
								<th>결제상황</th>
								<th>결제금액</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><div class="tb_check">
										<input id="check1" name="check1" type="checkbox"> <label
											for="check1">선택</label>
									</div></td>
								<td>5</td>
								<td>2017-07-27</td>
								<td><a href="admin2.html" target="_blank">crk0526</a></td>
								<td>김기동</td>
								<td><a href="admin9-1.html">20180227164321-1</a></td>
								<td>신용카드</td>
								<td>결제완료</td>
								<td>167,000</td>
							</tr>
							<tr>
								<td><div class="tb_check">
										<input id="check1" name="check1" type="checkbox"> <label
											for="check1">선택</label>
									</div></td>
								<td>4</td>
								<td>2017-07-25</td>
								<td><a href="admin2.html" target="_blank">influential</a></td>
								<td>나영환</td>
								<td><a href="admin9-1.html">20180227164321-1</a></td>
								<td>무통장입금</td>
								<td>미입금</td>
								<td>440,000</td>
							</tr>
							<tr>
								<td><div class="tb_check">
										<input id="check1" name="check1" type="checkbox"> <label
											for="check1">선택</label>
									</div></td>
								<td>3</td>
								<td>2017-07-20</td>
								<td><a href="admin2.html" target="_blank">dolbegae</a></td>
								<td>다하미</td>
								<td><a href="admin9-1.html">20180227164321-1</a></td>
								<td>무통장입금</td>
								<td>결제완료</td>
								<td>165,000</td>
							</tr>
							<tr>
								<td><div class="tb_check">
										<input id="check1" name="check1" type="checkbox"> <label
											for="check1">선택</label>
									</div></td>
								<td>2</td>
								<td>2017-07-16</td>
								<td><a href="admin2.html" target="_blank">gaeam</a></td>
								<td>마동석</td>
								<td><a href="admin9-1.html">20180227164321-1</a></td>
								<td>계좌이체</td>
								<td>결제완료</td>
								<td>165,000</td>
							</tr>
							<tr>
								<td><div class="tb_check">
										<input id="check1" name="check1" type="checkbox"> <label
											for="check1">선택</label>
									</div></td>
								<td>1</td>
								<td>2017-07-07</td>
								<td><a href="admin2.html" target="_blank">maywood</a></td>
								<td>박소현</td>
								<td><a href="admin9-1.html">20180227164321-1</a></td>
								<td>계좌이체</td>
								<td>결제완료</td>
								<td>88,0000</td>
							</tr>
						</tbody>
					</table>
					<div class="pagination">
						<ul>
							<li class="first"><a href="#">첫 페이지</a></li>
							<li class="prev"><a href="#">이전 페이지</a></li>
							<li><a href="#">1</a></li>
							<li class="active"><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">5</a></li>
							<li><a href="#">6</a></li>
							<li><a href="#">7</a></li>
							<li><a href="#">8</a></li>
							<li><a href="#">9</a></li>
							<li><a href="#">10</a></li>
							<li class="next"><a href="#"> 다음 페이지 </a></li>
							<li class="last"><a href="#"> 마지막 페이지 </a></li>
						</ul>
					</div>
				</div>
			</div>
		</section>
	</div>
</body>
</html>