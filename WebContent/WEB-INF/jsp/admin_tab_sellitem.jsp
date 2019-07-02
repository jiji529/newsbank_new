<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<script src="js/admin.js?v=20180419"></script>
<script type="text/javascript">
	$(document).ready(function() {
		search();
	});
	
	//정산매체 선택에 따른 피정산 매체 목록
	$(document).on("change", "#adjMaster", function() {
		var master = $(this).val();
		var masterName = $("#adjMaster option:selected").text();
		
		$("#adjSlave").children().remove();
		var html = "";
		var adjSlave_arr = new Array(); // 피정산 매체목록 seq
		
		if(master != "all") { // 주정산 매체를 별도로 선택했을 시
			$.ajax({
				type: "POST",
				dataType: "json",
				data: {
					"adjMaster" : master
				},
				url: "/adjust.media.api",
				success: function(data){ 
					var result = data.result;
					
					
					if(result.length > 0) {
						// 피정산 매체목록이 존재할 경우만 추가
						html += '<option value="all" selected="selected">정산 매체 전체</option>';
						html += '<option value=" ">' + masterName + '</option>';
						
						$(result).each(function(key, val){
							html += '<option value="' + val.seq + '">' + val.compName + '</option>';
							adjSlave_arr.push(val.seq);
						});	
					}else {
						//피정산 매체가 없음.
						html += '<option value=" ">없음</option>';
					}
				},
				complete: function() {
					$("#adjSlave_arr").val(adjSlave_arr); // 피정산매체 전체
					$(html).appendTo("#adjSlave");
				}
			});
		}else {
			html += '<option value="all" selected="selected">피정산 매체 전체</option>';
			$(html).appendTo("#adjSlave");
		}	
	});
	
	// 검색 클릭이벤트
	$(document).on("click", ".btn_input2", function() {
		$("#startgo").val(1); // 최초 1페이지로
		search();
	});
	
	// 키워드 엔터 이벤트
	$(document).on("keypress", "#keyword", function(e) {
		if (e.keyCode == 13) { // 엔터
			search();
		}
	});
	
	// 정산목록 검색(정산매체 선택)
	function search() {
		if(!checkPeriod()) {
			alert("날짜 옵션을 정확히 입력해주세요.");
			return;
		}
		
		var keywordType = $("select[name='keywordType'] option:selected").val(); // 선택 옵션
		var keyword = $("#keyword").val(); // 키워드
		var start_date = $("input[name=start_date]").val(); // 시작일
		var end_date = $("input[name=end_date]").val(); // 종료일
		var adjMaster = $("#adjMaster").val(); // 정산매체
		var adjSlave = $("#adjSlave").val(); // 피정산매체
		var paytype = $("#paytype").val(); // 결제방법
		var seqArr = 0; // 피정산 매체
		
		// 피정산 매체 선택여부 확인
		if(adjMaster == "all") { // 정산 매체 선택 시
			seqArr = '';
		}else{
			// 피정산 매체 선택여부 확인
			if(adjSlave == " ") { // 없음 or 선택안함
				seqArr = adjMaster;
			}else if(adjSlave == "all") { // 전체 선택 (주정산 + 피정산 매체 모두 포함)
				var adjSlave_arr = $("#adjSlave_arr").val();
				var split_arr = adjSlave_arr.split(",");
				split_arr.push(adjMaster);
				seqArr = split_arr.join(",");
			}else { // 개별선택
				seqArr = adjSlave;
			}
		}
		
		var param = {
				"keywordType":keywordType,
				"seqArr" : seqArr,
				"action" : "R",
				"start_date" : start_date,
				"end_date" : end_date,
				"keyword" : keyword,
				"payType" : paytype
		};		
		//console.log(param);
					
		$("#tf_media").empty();
		$("#tb_media_tbody").empty();
		
		var html = ""; // tbody 데이터
		var foot_html = ""; // tfoot 데이터
		var total = 0; // 검색결과 갯수
		
		// 매출합계 변수
		var sum_customValue = 0; // 과세금액 합계
		var sum_customTax = 0; // 과세부가세 합계
		var sum_billingAmount = 0; // 결제금액 합계
		var sum_billingTax = 0; // 빌링수수료 합계
		var sum_totalSalesAccount = 0; // 총매출액 합계
		var sum_salesAccount = 0; // 회원사 합계
		var sum_valueOfSupply = 0; // 공급가액 합계
		var sum_addedTaxOfSupply = 0; // 공급부가세 합계
		var sum_dahamiAccount = 0; // 다하미매출액 합계
		
		$.ajax({
			type: "POST",
			url: "/calculation.api",
			data: param,
			dataType: "json",
			success: function(data) { 
				var result = data.result; console.log(result);
				total = result.length;
				
				 $(result).each(function(key, val){				
					
					html += '<tr>';
					html += '<td>' + (key+1) + '</td>';
					html += '<td>' + val.regDate + '</td>';
					html += '<td>' + val.name + '\n(' + val.id + ')</td>';
					html += '<td>' + val.compName + '</td>';
					// 매체사의 승인, 탈퇴여부에 따른 uciCode 하이퍼링크 활성/비활성 표시
					if(val.withdraw == 0 && val.admission == "Y") { 
						html += '<td><a href="/view.photo?uciCode=' + val.uciCode + '" target="_blank">' + val.uciCode + '</a></td>';	
					}else {
						html += '<td>' + val.uciCode + '</td>';
					}
					html += '<td>' + val.copyright + '</td>';
					html += '<td>' + val.payType + '</td>';
					
					if(val.division1) { // 온라인 결제 
						html += '<td>' + val.division1 + '</td>';	
					}else { // 후불 결제
						html += '<td>' + val.usage + '</td>';
					}				
					
					html += '<td>' + comma(val.customValue) + '</td>';
					html += '<td>' + comma(val.customTax) + '</td>';
					html += '<td>' + comma(val.billingAmount) + '</td>';
					html += '<td>' + comma(val.billingTax) + '</td>';
					html += '<td>' + comma(val.totalSalesAccount) + '</td>';
					html += '<td>' + comma(val.salesAccount) + '</td>';
					html += '<td>' + comma(val.valueOfSupply) + '</td>';
					html += '<td>' + comma(val.addedTaxOfSupply) + '</td>';
					html += '<td>' + comma(val.dahamiAccount) + '</td>';
					html += '</tr>';	
					
					sum_customValue += val.customValue; // 과세금액 합계
					sum_customTax += val.customTax; // 과세부가세 합계
					sum_billingAmount += val.billingAmount; // 결제금액 합계
					sum_billingTax += val.billingTax; // 빌링수수료 합계
					sum_totalSalesAccount += val.totalSalesAccount; // 총매출액 합계
					sum_salesAccount += val.salesAccount; // 회원사 합계
					sum_valueOfSupply += val.valueOfSupply; // 공급가액 합계
					sum_addedTaxOfSupply += val.addedTaxOfSupply; // 공급부가세 합계
					sum_dahamiAccount += val.dahamiAccount; // 다하미매출액 합계
				
				}); 
			},
			complete: function(){
				
				foot_html += '<tr>';
				foot_html += '<td colspan="8"> 월 매출액 합계</td>';
				foot_html += '<td>' + comma(sum_customValue) + "</td>";
				foot_html += '<td>' + comma(sum_customTax) + "</td>";
				foot_html += '<td>' + comma(sum_billingAmount) + "</td>";
				foot_html += '<td>' + comma(sum_billingTax) + "</td>";
				foot_html += '<td>' + comma(sum_totalSalesAccount) + "</td>";
				foot_html += '<td><font color="#FF0000">' + comma(sum_salesAccount) + "</font></td>";
				foot_html += '<td>' + comma(sum_valueOfSupply) + "</td>";
				foot_html += '<td>' + comma(sum_addedTaxOfSupply) + "</td>";
				foot_html += '<td><font color="#0000FF">' + comma(sum_dahamiAccount) + "</font></td>";
				foot_html += '</tr>';
					
				$(foot_html).appendTo("#tf_media");
				$(html).appendTo("#tb_media_tbody");
				
				// 검색결과 (기간, 건수, 총 판매금액)
				var search_period = start_date + " ~ " + end_date;
				
				$("#search_period").text(search_period);
				$("#search_total").text(total);
				$("#search_price").text(comma(sum_billingAmount));
				
				$(".calculate_info_area").css("display", "block"); 
				
			},
			error:function(request,status,error){
				console.log(request, error);	
			}
		});
	}
	
	function setYearOfMonth(object) { // 선택년도에 따른 월별옵션 자동완성 
		var year = $(object).val();
		var name = $(object).attr("name");
		var month = 12;
		var option = "<option value='all'>전체(월)</option>";
		
		var now = new Date();
		var thisYear = now.getFullYear(); // 금년
		var thisMonth = now.getMonth() + 1; // 금월
		
		if(year == thisYear) { // 선택년도가 금년도
			month = thisMonth;
		}else if(year < thisYear){ // 과거년도
			month = 12;
		}
		
		for(var i=1; i<=month; i++) {
			option += "<option value='" + i + "'>" + i + "월</option>";
		}
		
		switch(name) {
			case "startYear":
				$("select[name=startMonth]").html(option);
				var startDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, 0, 1));
				$("#contractStart").val(startDate);
				break;
			
			case "endYear":
				$("select[name=endMonth]").html(option);
				var lastDay = (new Date(thisYear, thisMonth, 0)).getDate();
				var endDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, month-1, lastDay));
				$("#contractEnd").val(endDate);
				break;
		}
	}
	
	function setPeriod(object) { // 기간옵션 설정
		var month = $(object).val();
		var name = $(object).attr("name");
		var year;
		var date = new Date();
		
		// 선택 년도가 금년이면 1월 1일 ~ 금년도 월까지 
		
		switch(name) {
			case "startMonth": // 시작 날짜
				year = $("select[name=startYear] option:selected").val();
				if(month == "all") { // 전체는 1월부터 시작
					month = 1;
				}							
				var startDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, month-1, 1));
				$("#contractStart").val(startDate);
				break;
			
			case "endMonth": // 마지막 날짜
				year = $("select[name=endYear] option:selected").val();
				if(month == "all") {
					if(year == date.getFullYear()) {
						month = date.getMonth() + 1;
					}else if(year < date.getFullYear()) {
						month = 12;
					}
				}
				var lastDay = (new Date(year, month, 0)).getDate();
				var endDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, month-1, lastDay));
				$("#contractEnd").val(endDate);
				break;
		}
		
		$('#customDayOption a').removeClass("on");
	}
	
	function checkPeriod() { // 기간 옵션 체크 
		var result = true;
		var startDate = $("#contractStart").val();
		var endDate = $("#contractEnd").val();
		
		startDate = startDate.split("-").join("");
		endDate = endDate.split("-").join("");
		
		if(startDate == null || endDate == null) { // 유효성 여부 확인
			result = false;
		}else if(startDate > endDate) { // (시작 일자 > 마지막 일자)
			result = false;
		}
		return result;
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
				<td>
					<select name="keywordType" class="inp_txt" style="width:200px;">
					    <option value="member" selected="selected">회사/기관명, 아이디, 이름</option>
					    <option value="photo">UCI코드, 언론사 사진번호</option>
					</select>
					<input type="text" class="inp_txt" size="80" id="keyword"
					placeholder="아이디, 이름, 회사명" />
				</td>
			</tr>
			<tr>
				<th>정산(월) 선택</th>
				<td>
					<%-- <select id="customYear" class="inp_txt"
						style="width: 100px;">
							<c:forEach var="i" begin="2015" end="${year}" step="1">
								<option value="${i }" <c:if test="${i eq year}">selected</c:if>>${i}년</option>
							</c:forEach>
					</select> 
					<select id="customDay" class="inp_txt" style="width: 95px;">
						<option value="all" selected="selected">전체(월)</option>
						
						<c:forEach var="m" begin="1" end="${month}" step="1">
							<option value="${m}">${m}월</option>
						</c:forEach>
					</select> --%>
					<ul id="customDayOption" class="period">
						<c:forEach var="pastMonth" items="${pastMonths}">
							<li><a href="javascript:;" class="btn" value="${pastMonth}">${fn:substring(pastMonth, 4, 6)}월</a>
							</li>
						</c:forEach>
					</ul>
					
					<select name="startYear" class="inp_txt" style="width:100px;" onchange="setYearOfMonth(this)">
						<c:forEach var="i" begin="2015" end="${year}" step="1">
							<option value="${i }" <c:if test="${i eq year}">selected</c:if>>${i}년</option>
						</c:forEach>
					</select>
					<select name="startMonth" class="inp_txt" style="width:95px;" onchange="setPeriod(this)">
						<option value="all" selected="selected">전체(월)</option>
						
						<c:forEach var="m" begin="1" end="${month}" step="1">
							<option value="${m}">${m}월</option>
						</c:forEach>
					</select>
					<span class=" bar">~</span>
					<select name="endYear" class="inp_txt" style="width:100px;" onchange="setYearOfMonth(this)">
						<c:forEach var="i" begin="2015" end="${year}" step="1">
							<option value="${i }" <c:if test="${i eq year}">selected</c:if>>${i}년</option>
						</c:forEach>
					</select>
					<select name="endMonth" class="inp_txt" style="width:95px;" onchange="setPeriod(this)">
						<option value="all" selected="selected">전체(월)</option>
						
						<c:forEach var="m" begin="1" end="${month}" step="1">
							<option value="${m}">${m}월</option>
						</c:forEach>
					</select>
					
					<div class="period">
						<input type="text" size="12" id="contractStart" name="start_date"
							class="inp_txt" value="${year}-01-01" maxlength="10" disabled>
						<span class=" bar">~</span> <input type="text" size="12"
							id="contractEnd" name="end_date" class="inp_txt"
							value="${today }" maxlength="10" disabled>
					</div>
			</tr>
			<tr>
				<th>매체</th>
				<td><select name="" id="adjMaster" class="inp_txt"
					style="width: 150px;">
						<option value="all" selected="selected">정산 매체 전체</option>
						<c:forEach var="mediaList" items="${mediaList}">
							<option value="${mediaList.seq }">${mediaList.compName }</option>
						</c:forEach>


				</select> <select name="" id="adjSlave" class="inp_txt" style="width: 150px;">
						<option value="all" selected="selected">피정산 매체 전체</option>
				</select> <input type="hidden" id="adjSlave_arr" value=""></td>
			</tr>
			<tr>
				<th>결제방법</th>
				<td><select name="select" class="inp_txt" id="paytype" name="paytype"
					style="width: 200px;">
						<option value="all" selected="selected">전체</option>
						<option value="SC0040">무통장 입금</option>
						<option value="SC0030">실시간 계좌이체</option>
						<option value="SC9999">오프라인 세금계산서 발행</option>
						<option value="SC0010">신용카드</option>
				</select></td>
			</tr>
		</tbody>
	</table>
	<div class="btn_area" style="margin-top: 0;">
		<a href="javascript:void(0)" class="btn_input2">검색</a>
	</div>
</div>
<div class="calculate_info_area" style="display:none;">
	기간 : <span id="search_period"></span> <span class="bar3">l</span> 
	건수 : <span id="search_total" class="color"></span>건 <span class="bar3">l</span> 
	총 판매금액 : <span	id="search_price" class="color"></span>원
</div>
<div class="ad_result">

	<div class="ad_result_btn_area fr">
		<a href="javascript:void(0)" onclick="saveExcel('/excel.calculation.api', 'sellitem')">엑셀저장</a></div>
	</div>

	<div id="tb_media">
		<table cellpadding="0" cellspacing="0" class="tb02" id="excelTable">
			<thead>
				<tr>
					<th>No.</th>
					<th>구매일자</th>
					<th>이름 (아이디)</th>
					<th>기관/회사</th>
					<th>사진ID</th>
					<th>판매자</th>
					<th>결제종류</th>
					<th>용도</th>
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
				<!-- 정산 내역 -->
			</tbody>
			<tfoot id="tf_media">
				<!-- 정산 매출액 합계 -->
			</tfoot>
		</table>
	</div>
</div>

<form class="excel_form" method="post" action="/excelDown.api" name="excel_form" >
	<input type="hidden" id="excelHtml" name="excelHtml" />
</form>