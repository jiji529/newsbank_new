<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<script src="js/nyt/admin.js?v=20180419"></script>
<script type="text/javascript">
	$(document).ready(function() {
		search();
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
				"action" : "N",
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
		var sum_price = 0; // 총 금액 합계
		var sum_nyt_share = 0; // 총 NYT 로열티 합계
		
		$.ajax({
			type: "POST",
			url: "/calculation.api",
			data: param,
			dataType: "json",
			success: function(data) {
				var result = data.result;
				total = result.length;
				
				 $(result).each(function(key, val){				
					
					html += '<tr>';
					html += '<td>' + (key+1) + '</td>';
					html += '<td>' + val.clientName + '</td>';
					html += '<td>' + val.compAddress + '</td>';					
					html += '<td>' + val.description + '</td>';
					html += '<td>' + val.shotPerson + '</td>';
					html += '<td>' + val.regDate + '</td>';
					html += '<td>' + val.PurposeOfUse + '</td>';
					html += '<td>' + val.InvoiceNum + '</td>';
					html += '<td>' + val.currency + '</td>';
					html += '<td>' + val.nyt_royalty + '</td>';
					html += '<td>' + val.price + '</td>';
					html += '<td>' + val.nyt_share + '</td>';
					html += '</tr>';	
					
					sum_price += val.price; // 총 금액 합계
					sum_nyt_share += val.nyt_share; // 총 NYT 로열티 합계
				});
			},
			complete: function(){
				
				foot_html += '<tr>';
				foot_html += '<td colspan="10"> 월 매출액 합계</td>';
				foot_html += '<td><font color="#FF0000">' + comma(sum_price) + "</font></td>";
				foot_html += '<td><font color="#0000FF">' + comma(sum_nyt_share) + "</font></td>";
				foot_html += '</tr>';
					
				$(foot_html).appendTo("#tf_media");
				$(html).appendTo("#tb_media_tbody");
				
				// 검색결과 (기간, 건수, 총 판매금액)
				var search_period = start_date + " ~ " + end_date;
				
				$("#search_period").text(search_period);
				$("#search_total").text(total);
				$("#search_price").text(comma(sum_price));
				
				$(".calculate_info_area").css("display", "block"); 
				
			},
			error:function(request,status,error){
				console.log(request, error);	
			}
		});
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
	
	// 년도 분기, 반기 계산해주는 메소드
	function adjustDateByMonths(date, monthsToSubtract) {
	    // 원래 날짜에서 월을 조정
	    date.setMonth(date.getMonth() - monthsToSubtract);
	    return date;
	}
	
	// yyyy-mm-dd 형식으로 출력해주는 메소드
	function formatDateToYYMMDD(date) {
	    let year = date.getFullYear().toString(); // 연도를 두 자리로 변환
	    let month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월을 1부터 시작하고 두 자리로 변환
	    let day = date.getDate().toString().padStart(2, '0'); // 일을 두 자리로 변환
	    let returnDate = year + "-" + month + "-" + day;
	    return returnDate;
	}	
	
	// 날짜가 바뀔때마다 체크하는 옵션
	function dateChange(object) {		
		setYearOfMonth(object);
		
		var year = `${year}`;
		var today = `${today}`;	
		var selectYear = $('select[name="selectYear"]').val();
		var selectMonth = $('select[name="selectMonth"]').val();
		var selectDateType = $('select[name="dateType"]').val();		
		
		if(selectDateType=='year') {
			// 년
			$('select[name="selectMonth"]').css('display','none');
			$("#contractStart").val(selectYear + "-01-01");
			if(year==selectYear) {
				$('#contractEnd').val(today);				
			} else {
				var last = new Date(selectYear, 11, 0).getDate();
				var formattedDate = selectYear + "-12-" + last;
				$('#contractEnd').val(formattedDate);
			}
		} else if(selectDateType=='half') {
			// 분기
			$('select[name="selectMonth"]').css('display','none');
			var specificDate;
						
			if(year==selectYear) {
				$('#contractEnd').val(today);
				specificDate = new Date(today.split('-')[0], today.split('-')[1], today.split('-')[2]);
			} else {
				var last = new Date(selectYear, 11, 0).getDate();
				var endDate = selectYear + "-12-" + last;
				$('#contractEnd').val(endDate);
				specificDate = new Date(selectYear, 11, last);
			}
			// 분기(-6) 계산
			let formattedDate = formatDateToYYMMDD(adjustDateByMonths(new Date(specificDate), 6));
			$('#contractStart').val(formattedDate);
			
		} else if(selectDateType=='quater') {
			// 반기
			$('select[name="selectMonth"]').css('display','none');
			
			var specificDate;
			
			if(year==selectYear) {
				$('#contractEnd').val(today);
				specificDate = new Date(today.split('-')[0], today.split('-')[1], today.split('-')[2]);
			} else {
				var last = new Date(selectYear, 11, 0).getDate();
				var endDate = selectYear + "-12-" + last;
				$('#contractEnd').val(endDate);
				specificDate = new Date(selectYear, 11, last);
			}
			// 반기(-3) 계산
			let formattedDate = formatDateToYYMMDD(adjustDateByMonths(new Date(specificDate), 3));
			$('#contractStart').val(formattedDate);
			
		} else if(selectDateType=='month'){
			// 월
			$('select[name="selectMonth"]').css('display','block');
			selectMonth = selectMonth > 9 ? selectMonth : "-0" + selectMonth;
			
			if(year==selectYear) {
				thisMonth = today.split('-')[1].substr(1);
				if(selectMonth==thisMonth) {					
					// 같은달일때는 오늘 날짜를 마지막 날짜로 세팅한다.
					$("#contractStart").val(selectYear + selectMonth +  "-01");
					$('#contractEnd').val(today);
				} else {
					// 년도는 같지만 다른 달일때
					$("#contractStart").val(selectYear + selectMonth +  "-01");
					var last = new Date(selectYear, selectMonth, 0).getDate();
					var formattedDate = selectYear + selectMonth + "-" + last;
					$('#contractEnd').val(formattedDate);
				}
			} else {
				$("#contractStart").val(selectYear + selectMonth +  "-01");
				var last = new Date(selectYear, selectMonth, 0).getDate();
				var formattedDate = selectYear + selectMonth + "-" + last;
				$('#contractEnd').val(formattedDate);
			}
		}
	}	
	
	function setYearOfMonth(object) { // 선택년도에 따른 월별옵션 자동완성 
		var year = $(object).val();
		var name = $(object).attr("name");
		var month = 12;
		var option = "";
		
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
			case "selectYear":
				$("select[name=selectMonth]").html(option);
				var startDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, 0, 1));
				$("#contractStart").val(startDate);
				break;
		}
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
				<td><select name="keywordType" class="inp_txt" style="width: 200px;">
						<option value="member" selected="selected">회사/기관명, 아이디, 이름</option>
						<option value="photo">언론사 사진번호</option>
				</select><input type="text" class="inp_txt" size="80" id="keyword" placeholder="" /></td>
			</tr>
			<tr>
				<th>기간 선택</th>
				<td><select name="dateType" class="inp_txt" style="width: 100px;" onchange="dateChange(this)">
						<option value="year" selected="selected">년</option>
						<option value="half">반기</option>
						<option value="quater">분기</option>
						<option value="month">월</option>
				</select> 
				<select name="selectYear" class="inp_txt" style="width: 95px;" onchange="dateChange(this)">
						<c:forEach var="i" begin="2015" end="${year}" step="1">
							<option value="${i }" <c:if test="${i eq year}">selected</c:if>>${i}년</option>
						</c:forEach>
				</select>
				
				<select name="selectMonth" class="inp_txt" style="width:95px; display:none;" onchange="dateChange(this)">
						<c:forEach var="m" begin="1" end="${month}" step="1">
							<option value="${m}">${m}월</option>
						</c:forEach>
				</select>
				
				<div class="period">
						<input type="hidden" size="12" id="contractStart" name="start_date"
							class="inp_txt" value="${year}-01-01" maxlength="10" disabled>
						<span class=" bar" style="display:none">~</span> 
						<input type="hidden" size="12" id="contractEnd" name="end_date" 
							class="inp_txt" value="${today }" maxlength="10" disabled>
				</div>
				</td>
			</tr>
			<tr>
				<th>결제 방법</th>
				<td><select name="payType" id="paytype" class="inp_txt" style="width: 200px;">
						<option value="all" selected="selected">전체</option>
						<option value="0">온라인 결제</option>
						<option value="1">오프라인 결제</option>
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
		<a href="javascript:void(0)" onclick="saveExcel('/excel.calculation.api', 'sellReport')">엑셀저장</a>
	</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="tb02">
		<thead>

			<tr>
				<th scope="col">No.</th>
				<th scope="col">고객/클라이언트/최종 사용자 이름</th>
				<th scope="col">고객/클라이언트/최종 사용자 국가</th>
				<th scope="col">항목/사진설명</th>
				<th scope="col">사진사</th>
				<th scope="col">판매날짜</th>
				<th scope="col">사용 형식/목적</th>
				<th scope="col">송장/문서 번호</th>
				<th scope="col">통화</th>
				<th scope="col">로열티 비율 %</th>
				<th scope="col">총 금액</th>
				<th scope="col">NYT 로열티</th>
			</tr>
		</thead>
		<tbody id="tb_media_tbody">
		</tbody>
		<tfoot id="tf_media">
		</tfoot>
	</table>

</div>