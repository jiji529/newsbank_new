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
<script src="js/jquery.twbsPagination.js"></script>
<script src="js/filter.js"></script>
<script src="js/mypage.js"></script>
<script src="js/admin.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
		$("[href]").each(function() {
			if (this.href == window.location.href) {
				$(this).parent().addClass("on");
			}
		});
		
		$("#startgo").val(1); // 최초 1페이지로
		search();		
	});
	
	$(document).on("click", "#btn_search", function() {
		$("#startgo").val(1); // 최초 1페이지로
		search();
	});
	
	// 페이징 번호 클릭
	$(document).on("click",".page",function() {
		var pages = $(this).text();
		if(pages == "") pages = 1;
		$("#startgo").val(pages);
		
		search("not_paging");
	});
	
	$(document).on("keypress", "#keyword", function(e) {
		if (e.keyCode == 13) { // 엔터
			$("#startgo").val(1); // 최초 1페이지로
			search();
		}
	});
	
	function search(state) {
		var keywordType = $("select[name='keywordType'] option:selected").val(); // 선택 옵션
		var keyword = $("#keyword").val(); keyword = $.trim(keyword);
		var pageVol = parseInt($("#sel_pageVol option:selected").attr("value")); // 페이지 표시 갯수
		var startPage = ($("#startgo").val()-1) * pageVol; // 시작 페이지
		var paytype = $("select[name=paytype]").val(); // 결제 방법
		var paystatus = $("select[name=paystatus]").val(); // 결제 상황
		var start_date = $("input[name=start_date]").val(); // 시작일
		var end_date = $("input[name=end_date]").val(); // 종료일
		var pageCnt = 0; // 전체 페이지 갯수
		var totalCnt = 0; // 전체 갯수
		var totalPrice = 0; // 총 판매금액
		
		var select_period = start_date + " ~ " + end_date;
		$("#select_period").text(select_period);
		
		var searchParam = {
			"keywordType":keywordType
			, "keyword":keyword
			, "pageVol":pageVol
			, "startPage":startPage
			, "start_date":start_date
			, "end_date":end_date
			, "paytype":paytype
			, "paystatus":paystatus
		};
		//console.log(searchParam);
		
		var html = "";
		
		$("#mtBody").empty();
		
		$.ajax({
			type: "POST",
			dataType: "json",
			data: searchParam,
			url: "/onlinePay.api",
			success: function(data) { console.log(data);
				totalPrice = data.totalPrice;
				pageCnt = data.pageCnt;
				totalCnt = data.totalCnt; 
				
				// 검색결과 표시
				$("#totalPrice").text(comma(totalPrice));
				$("#totalCnt").text(comma(totalCnt));
				
				var data = data.result; 
				if(data.length != 0) {
					$(data).each(function(key, val){
						var number = totalCnt - ( ($("#startgo").val() - 1) * pageVol + key );
						var member_seq = val.member_seq;
						var LGD_PAYDATE = val.LGD_PAYDATE;
						var paydate = LGD_PAYDATE.replace(
							    /^(\d{4})(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)$/,
							    '$1-$2-$3 $4:$5:$6'
							);
						var LGD_BUYERID = val.LGD_BUYERID;
						var LGD_BUYER = val.LGD_BUYER;
						var LGD_OID = val.LGD_OID;
						var LGD_PAYTYPE = trans_paytype(val.LGD_PAYTYPE);						
						var LGD_RESPMSG = val.LGD_RESPMSG;
						var LGD_AMOUNT = (val.LGD_AMOUNT == null) ? 0 : val.LGD_AMOUNT;
						var LGD_PAYSTATUS = val.LGD_PAYSTATUS;
						var LGD_PAYSTATUS_STR = val.LGD_PAYSTATUS_STR;
						
						html += '<tr>';
						html += '<td>' + number + '</td>';
						html += '<td>' + paydate + '</td>';
						html += '<td> <a href="javascript:void(0)" onclick="go_memberView(\'' + val.member_seq + '\')">' + LGD_BUYERID + '</a></td>';
						html += '<td>' + LGD_BUYER + '</td>';
						html += '<td> <a href="javascript:void(0)" onclick="go_detailView(\'' + LGD_OID + '\')">' + LGD_OID + '</a></td>';
						html += '<td>' + LGD_PAYTYPE + '</td>';
						html += '<td>' + LGD_PAYSTATUS_STR + '</td>';
						
						if(LGD_PAYSTATUS == 5) { // 결제 취소는 취소선 표기
							html += '<td><del>' + comma(LGD_AMOUNT) + '</del></td>';
						}else {
							html += '<td>' + comma(LGD_AMOUNT) + '</td>';	
						}						
						html += '</tr>';
						
					});
				}else {
					html += '<tr>';
					html += '<td colspan="9">검색 결과가 없습니다.</td>';
					html += '</tr>';		
				}
				$(html).appendTo("#mtBody");
			
			}, complete: function() {
				if(state == undefined){
					pagings(pageCnt);	
				}
			}
		});
	}
	
	// 결제방법 코드를 한글로 치환
	function trans_paytype(type) {
		var result;
		switch(type) {
		
		case "SC0010":
			result = "신용카드";
			break;
			
		case "SC0030":
			result = "계좌이체";
			break;
			
		case "SC0040":
			result = "무통장입금";
			break;
			
		case "SC9999":
			result = "후불결제";
			break;
		}
		
		return result;
	}
	
	function pagings(tot) {

		var firval = 1;
		var realtot = 1;
		var startpage = $("#startgo").val();
		$("#lastvalue").val(tot);

		if ($("#totcnt").val() != "") {
			if (startpage == "1") {
				firval = parseInt(startpage);
			} else {
				firval = parseInt($("#totcnt").val());
			}
		}
		if (tot == "0") {
			tot = 1;
		}

		realtot = parseInt(tot);

		$('.pagination').empty();
		$('.pagination').html(
				'<ul id="pagination-demo" class="pagination-sm"></ul>');

		$('#pagination-demo').twbsPagination({
			startPage : firval,
			totalPages : realtot,
			visiblePages : 10,
			onPageClick : function(event, page) {

				$('#page-content').text('Page ' + page);
			}
		});
	}	
	
	// 회원 상세페이지로 이동
	function go_memberView(member_seq) {
		$("#member_seq").val(member_seq);
		view_member_manage.submit();
	}
	
	// 주문번호 상세페이지 이동
	function go_detailView(LGD_OID) {
		$("#LGD_OID").val(LGD_OID);
		view_online_manage.submit();
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
							<col style="width: 180px;">
								<col style="width:;">
						</colgroup>
						<tbody>
							<tr>
								<th>검색</th>
								<td>
								<select name="keywordType" class="inp_txt" style="width:200px;">
									<option value="member" selected="selected">회사/기관명, 아이디, 이름</option>
									<option value="photo">UCI코드, 언론사 사진번호</option>
								</select>	
								<input type="text" class="inp_txt" size="80" id="keyword" placeholder="회사/기관명, 아이디, 이름" />
								
								</td>
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
								</td>
						</tr>
							<tr>
								<th>결제 방법</th>
								<td><select name="paytype" class="inp_txt" style="width: 150px;">
										<option value="all" selected="selected">전체</option>
										<option value="SC0010">신용카드</option>
										<option value="SC0040">무통장입금</option>
										<option value="SC0030">계좌이체</option>
								</select></td>
							</tr>
							<tr>
								<th>결제 상황</th>
								<td><select name="paystatus" class="inp_txt"
									style="width: 150px;">
										<option value="all" selected="selected">전체</option>
										<option value="3">미입금</option>
										<option value="1">결제완료</option>
										<option value="5">결제취소</option>
								</select></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_area" style="margin-top: 0;">
						<a href="javascript:void(0)" id="btn_search" class="btn_input2">검색</a>
					</div>
				</div>
				<div class="calculate_info_area">
					기간 : <span id="select_period"></span> <span class="bar3">l</span> 
					건수 : <span id="totalCnt" class="color"> </span>건 <span class="bar3">l</span> 
					총 판매금액 : <span	id="totalPrice" class="color"> </span>원 <span class="bar3">l</span>
					<p style="color:#888;" id="search_result"></p>
				</div>
				<div class="ad_result">
					<div class="ad_result_btn_area fr">
						<select id="sel_pageVol" onchange="search()">
							<option value="20">20개</option>
							<option value="50">50개</option>
							<option value="100">100개</option>
						</select> 
						<a href="javascript:void(0)" onclick="saveExcel('/excel.onlinePay.api', 'online')">엑셀저장</a>
					</div>
					<table cellpadding="0" cellspacing="0" class="tb04" id="excelTable">
						<colgroup>
							<col width="50" />
							<col width="120" />
							<col width="100" />
							<col width="80" />
							<col width="150" />
							<col width="150" />
							<col width="80" />
							<col width="80" />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>주문일자</th>
								<th>아이디</th>
								<th>이름</th>
								<th>주문번호</th>
								<th>결제방법</th>
								<th>결제상태</th>
								<th>결제금액</th>
							</tr>
						</thead>
						<tbody id="mtBody">
							<!-- 검색 결과 -->							
						</tbody>
					</table>
					<input type="hidden" id="totcnt" value="" />
					<input type="hidden" id="startgo" value="" />
					<div class="pagination">
						<ul id="pagination-demo" class="pagination-sm">
							<!-- 페이징 -->
						</ul>
					</div>
				</div>
			</div>
		</section>
		
		<!-- Excel 출력 -->
		<form class="excel_form" method="post" action="/excelDown.api" name="excel_form" >
			<input type="hidden" id="excelHtml" name="excelHtml" />
		</form>
		
		<!-- 회원 상세페이지  -->
		<form method="post" action="/view.member.manage" name="view_member_manage" >
			<input type="hidden" name="member_seq" id="member_seq"/>
		</form>
		
		<!-- 주문번호 상세페이지  -->
		<form method="post" action="/view.online.manage" name="view_online_manage" >
			<input type="hidden" name="LGD_OID" id="LGD_OID"/>
		</form>
		
		<form id="downForm" method="post"  target="downFrame">
			<input type="hidden" id="currentKeyword" name="keyword" />
			<input type="hidden" id="currentKeywordType" name="keywordType" />
			<input type="hidden" id="currentPayType" name="paytype" />
			<input type="hidden" id="currentPayStatus" name="paystatus" />
			<input type="hidden" id="startDate" name="start_date" />
			<input type="hidden" id="endDate" name="end_date" />
			<input type="hidden" id="pageVol" name="pageVol" />
			<input type="hidden" id="startPage" name="startPage" value="file" />
		</form>
		<iframe id="downFrame" name="downFrame" style="display:none"></iframe>
	</div>
</body>
</html>