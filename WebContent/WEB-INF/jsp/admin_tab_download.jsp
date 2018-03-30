<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/admin.js"></script>

<script>
	$(document).ready(function() {
		$("#startgo").val(1); // 최초 1페이지로
		search();
	});
	
	// 검색 클릭이벤트
	$(document).on("click", "#downTab_Search", function() {
		$("#startgo").val(1); // 최초 1페이지로
		search();
	});

	$(document).on("keypress", "#keyword", function(e) {
		if (e.keyCode == 13) { // 엔터
			$("#startgo").val(1); // 최초 1페이지로
			search();
		}
	});
	
	// 페이징 번호 클릭
	$(document).on("click",".page",function() {
		var pages = $(this).text();
		if(pages == "") pages = 1;
		$("#startgo").val(pages);
		
		search("not_paging");
	});
	
	function search(state) {
		var keyword = $("#keyword").val(); keyword = $.trim(keyword);
		var pageVol = $("#sel_pageVol option:selected").attr("value"); // 페이지 표시 갯수
		var startPage = ($("#startgo").val()-1) * pageVol; // 시작 페이지
		var contractStart = $("#contractStart").val();
		var contractEnd = $("#contractEnd").val();
		var pageCnt = 0; // 전체 페이지 갯수
		var totalCnt = 0; // 전체 갯수
		
		var select_period = contractStart + " ~ " + contractEnd;
		$("#select_period").text(select_period);
		
		var searchParam = {
			"keyword":keyword
			, "pageVol":pageVol
			, "startPage":startPage
			, "contractStart":contractStart
			, "contractEnd":contractEnd
		};
		console.log(searchParam);
		
		var html = "";
		$("#loading").show();
		$("#mtBody").empty();	
		
		$.ajax({
			type: "POST",
			dataType: "json",
			data: searchParam,
			url: "/download.api",
			success: function(data) { //console.log(data);
				pageCnt = data.pageCnt;
				totalCnt = data.totalCnt; 
				$("#totalCnt").text(totalCnt);
				
				if(data.result.length != 0) {
					$(data.result).each(function(key, val) {					
						var number = totalCnt - ( ($("#startgo").val() - 1) * pageVol + key );
						var id = val.id;
						var name = val.name;
						var media = val.media;
						var compName = val.compName;
						var uciCode = val.uciCode;
						var regDate = val.regDate;
						
						html += '<tr>';
						html += '<td><div class="tb_check">';
						html += '<input id="check1" name="check1" type="checkbox"> <label for="check1">선택</label>';
						html += '</div></td>';
						html += '<td>' + number + '</td>';
						html += '<td>' + compName + '</td>';
						html += '<td>' + id + '</td>';
						html += '<td>' + name + '</td>';
						html += '<td>' + media + '</td>';
						html += '<td><a href="#">' + uciCode + '</a></td>';
						html += '<td>' + regDate + '</td>';
						html += '</tr>';
						
					});
					
				}else {
					html += '<tr>';
					html += '<td colspan="8">검색 결과가 없습니다.</td>';
					html += '</tr>';
				}
				
				$(html).appendTo("#mtBody");
			},
			complete: function() {
				if(state == undefined){
					pagings(pageCnt);	
				}
				
				$("#loading").hide();
			}
		});
	}
	
	function pagings(tot){
		
		var firval = 1;
		var realtot = 1;
		var startpage = $("#startgo").val();
		$("#lastvalue").val(tot);
		
		if($("#totcnt").val() != ""){
			if(startpage == "1"){
				firval = parseInt(startpage);
			}else{
				firval = parseInt($("#totcnt").val());
			}
		}
		if(tot == "0"){
			tot = 1;
		}
		
		realtot = parseInt(tot);
			
		
		$('.pagination').empty();
		$('.pagination').html('<ul id="pagination-demo" class="pagination-sm"></ul>');
		
		$('#pagination-demo').twbsPagination({
			startPage: firval,
		    totalPages: realtot,
		    visiblePages: 10,
		    onPageClick: function (event, page) {
		    	
		    	$('#page-content').text('Page ' + page);
	        }
		});
	}
	
</script>

<div class="ad_sch_area">
	<table class="tb01" cellpadding="0" cellspacing="0">
		<colgroup>
			<col style="width: 180px;">
			<col style="width:;">
		</colgroup>
		<tbody>
			<tr>
				<th>검색</th>
				<td><input type="text" id="keyword" class="inp_txt" size="80"
					placeholder="회사/기관명, 아이디, 이름, UCI코드, 언론사 사진번호" /></td>
			</tr>
			 
			<tr>
				<th>기간별 조회</th>
				<td>
					<select id="customYear" class="inp_txt" class="inp_txt" style="width:100px;">
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
		</tbody>
	</table>
	<div class="btn_area" style="margin-top: 0;">
		<a href="#" id="downTab_Search" class="btn_input2">검색</a>
	</div>
</div>
<div class="calculate_info_area">
	기간 : <span id="select_period"></span> </span><span class="bar3">l</span> 
	건수 :<span id="totalCnt" class="color"> </span>건
</div>
<div class="ad_result">
	<div class="ad_result_btn_area fr">
		<select id="sel_pageVol" onchange="search()">
			<option value="20">20개</option>
			<option value="50">50개</option>
			<option value="100">100개</option>
		</select> <a href="javascript:void(0)" onclick="excel()">엑셀저장</a>
	</div>
	<table id="excelTable" cellpadding="0" cellspacing="0" class="tb04">
		<colgroup>
			<col width="40" />
			<col width="50" />
			<col width="180" />
			<col width="150" />
			<col width="80" />
			<col width="150" />
			<col width="150" />
			<col width="250" />
		</colgroup>
		<thead>
			<tr>
				<th><div class="tb_check">
						<input id="check_all" name="check_all" type="checkbox"> <label
							for="check_all">선택</label>
					</div></th>
				<th>No.</th>
				<th>회사/기관명</th>
				<th>아이디</th>
				<th>이름</th>
				<th>매체</th>
				<th>UCI코드</th>
				<th>다운로드일</th>
			</tr>
		</thead>
		<tbody id="mtBody">
			<!-- 다운로드 내역 표시 -->			 
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

<form class="excel_form" method="post" action="/excelDown.api" name="excel_form" >
	<input type="hidden" id="excelHtml" name="excelHtml" />
</form>	
	
<div id="loading"><img id="loading-image" src="/images/ajax-loader.gif" alt="loading" /></div>