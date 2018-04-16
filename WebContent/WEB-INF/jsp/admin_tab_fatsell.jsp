<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/admin.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		$("#startgo").val(1); // 최초 1페이지로
		search();
	});
	
	// 키워드 검색
	$(document).on("keypress", "#keyword", function(e) {
		if (e.keyCode == 13) { 
			$("#startgo").val(1); 
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
		var pageVol = parseInt($("#sel_pageVol option:selected").attr("value")); // 페이지 표시 갯수
		var startPage = ($("#startgo").val()-1) * pageVol; // 시작 페이지
		var pageCnt = 0; // 전체 페이지 갯수
		var totalCnt = 0; // 전체 갯수
		
		var searchParam = {
			"keyword":keyword
			, "pageVol":pageVol
			, "startPage":startPage
		};
		
		$("#loading").show();
		$("#mtBody").empty();
		var html = "";
		
		$.ajax({
			type: "POST",
			dataType: "json",
			data: searchParam,
			url: "/notSell.api",
			success: function(data) { //console.log(data);
				totalCnt = data.totalCnt;
				pageCnt = data.pageCnt;
				
				var data = data.result;
				
				if(data.length != 0) {
					$(data).each(function(key, val){
						var number = totalCnt - ( ($("#startgo").val() - 1) * pageVol + key );
						var compName = val.compName;
						var id = val.id;
						var name = val.name;
						var phone = val.phone;
						
						html += '<tr>';
						html += '<td>' + number + '</td>';
						html += '<td>' + val.compName + '</td>';
						html += '<td>' + val.id + '</td>';
						html += '<td>' + val.name + '</td>';
						html += '<td>' + val.phone + '</td>';
						html += '</tr>';							
					});
				}else {
					
					html += '<tr>';
					html += '<td colspan="5">검색 결과가 없습니다.</td>';
					html += '</tr>';
				}
				$(html).appendTo("#mtBody");
				
			},
			complete: function() {
				if(state == undefined){
					pagings(pageCnt);	
					$("#loading").hide();
				}
			}
		});
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
				<td><input type="text" class="inp_txt" id="keyword" size="80"
					placeholder="회사/기관명, 아이디, 이름" /></td>
			</tr>
		</tbody>
	</table>
	<div class="btn_area" style="margin-top: 0;">
		<a href="#" class="btn_input2">검색</a>
	</div>
</div>
<div class="ad_result">
	<div class="ad_result_btn_area fr">
		<select id="sel_pageVol" onchange="search()">
			<option value="20">20개</option>
			<option value="50">50개</option>
			<option value="100">100개</option>
		</select>  
		<a href="javascript:void(0)" onclick="saveExcel('/excel.notSell.api', 'fatsell')">엑셀저장</a>
	</div>
	<table cellpadding="0" cellspacing="0" class="tb04" id="excelTable">
		<colgroup>
			<col width="50" />
			<col width="180" />
			<col width="150" />
			<col width="80" />
			<col width="150" />
		</colgroup>
		<thead>
			<th>No.</th>
			<th>회사/기관명</th>
			<th>아이디</th>
			<th>이름</th>
			<th>전화번호</th>
			</tr>
		</thead>
		<tbody id="mtBody">
			
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