<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<script src="js/nyt/admin.js?v=20180419"></script>
<script type="text/javascript">

	$(document).ready(function(){
		$(".calculate_info_area").hide();
		$(".ad_result").hide();
		search();
	});
	
	//검색 클릭이벤트
	$(document).on("click", ".btn_input2", function() {
		search();
	});
	
	// 키워드 엔터 이벤트
	$(document).on("keypress", "#keyword", function(e) {
		if (e.keyCode == 13) { // 엔터
			search();
		}
	});
	
	//정산목록 전체검색(기간변 온라인/오프라인 목록)
	function search() {
		var keywordType = $("select[name='keywordType'] option:selected").val(); // 선택 옵션
		var keyword = $("#keyword").val(); // 키워드
		var paytype = $("#paytype").val(); // 결제방법
		var start_date = $("input[name=start_date]").val(); // 시작일
		var end_date = $("input[name=end_date]").val(); // 종료일
		var totalCount = 0; // 총 갯수 
		var totalPrice = 0; // 총 판매금액
		var period = start_date + " ~ " + end_date; // 조회기간
		var adjMaster = $("#adjMaster").val(); // 정산매체
		var adjSlave = $("#adjSlave").val(); // 피정산매체
		
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
				"action" : "S",
				"start_date" : start_date,
				"end_date" : end_date,
				"keyword" : keyword,
				"seqArr" : seqArr,
				"payType" : paytype
		};		
		
		//console.log(param);
		
		// 초기화
		$("#sell_thead").empty();
		$("#sell_tbody").empty();
		$("#sell_tfoot").empty();
		
		// 테이블 생성 (기간 월별로 온라인/오프라인 만들어 놓고, 기간별 해당하는 위치에 값을 넣기)
		var thead = "<tr><th>구분</th>";
		var online_html = "<tr><td>온라인 결제</td>";
		var offline_html = "<tr><td>오프라인 결제</td>";
		var tfoot = "<tr><td>총 합계</td>";
		
		$.ajax({
			type: "POST",
			url: "/calculation.api",
			dataType: "json",
			data: param,
			success: function(data) { 
				var result = data.result;
				var monthlyTotal = 0; // 월별 합계금액
				
				$(result).each(function(key, val){
					var price = val.price;
					var type = val.type;
					var count = val.count; 
					totalCount += count;
					var YearOfMonth = val.YearOfMonth;
					var month = YearOfMonth.substring(YearOfMonth.length -2, YearOfMonth.length);
					
					if(key % 2 == 0){ // 짝수 인덱스일 때 monthlyTotal Reset
						monthlyTotal = 0;
					} 
					monthlyTotal += price;
					
					if(type == 0) { // 온라인
						thead += "<th>" + month + "월</th>";						
						online_html += '<td>' + comma(price) + "</td>";
					}else { // 오프라인
						tfoot += "<td>" + comma(monthlyTotal) + "</td>";
						offline_html += '<td>' + comma(price) + "</td>";
						totalPrice += monthlyTotal; // 총 금액
					}					
					
				});
				
				thead += "</tr>";
				online_html += "</tr>";
				offline_html += "</tr>";
				tfoot += "</tr>";
			}, 
			complete: function() {
				
				$(thead).appendTo("#sell_thead");
				$(online_html).appendTo("#sell_tbody");
				$(offline_html).appendTo("#sell_tbody");
				$(tfoot).appendTo("#sell_tfoot");
				
				// 검색결과
				$("#s_period").text(period);
				$("#s_count").text(comma(totalCount));
				$("#s_price").text(comma(totalPrice));
				
				$(".calculate_info_area").show();
				$(".ad_result").show();
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
				<td>
				<select name="keywordType" class="inp_txt" style="width:200px;">
					<option value="member" selected="selected">회사/기관명, 아이디, 이름</option>
					<option value="photo">언론사 사진번호</option>
				</select>
				<input type="text" class="inp_txt" size="80" id="keyword"
					placeholder="" />
				</td>
			</tr>
			<tr>
				<th>기간 선택</th>
				<td><select id="customYear" class="inp_txt"
					style="width: 100px;">
						<c:forEach var="i" begin="2015" end="${year}" step="1">
							<option value="${i }" <c:if test="${i eq year}">selected</c:if>>${i}년</option>
						</c:forEach>
				</select> 
				<!-- customDay select 태그 지우면 안됨! -->
				<select id="customDay" class="inp_txt" style="width: 95px; display:none;">
						<option value="all" selected="selected">전체(월)</option>
						<c:forEach var="m" begin="1" end="${month}" step="1">
							<option value="${m}">${m}월</option>
						</c:forEach>
				</select>
					
				<div class="period">
					<input type="text" size="12" id="contractStart" name="start_date"
						class="inp_txt" value="${year}-01-01" maxlength="10" disabled />
					<span class=" bar">~</span> <input type="text" size="12"
						id="contractEnd" name="end_date" class="inp_txt"
						value="${today }" maxlength="10" disabled />
				</div>
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
<div class="calculate_info_area">
	기간 : <span id="s_period"></span> <span class="bar3">l</span> 
	건수 : <span id="s_count" class="color"></span>건 <span class="bar3">l</span> 
	총 판매금액 : <span id="s_price" class="color"></span>원
</div>
<div class="ad_result">
	<div class="ad_result_btn_area fr">
		<a href="javascript:void(0)" onclick="saveExcel('/excel.calculation.api', 'sellyear')">엑셀저장</a></div>
	</div>

	<div id="tb_total">
		<table cellpadding="0" cellspacing="0" class="tb04" id="excelTable">
			<thead id="sell_thead">
				<!-- 월별 -->
			</thead>
			<tbody id="sell_tbody">
				<!-- 온라인 / 오프라인결제 내역 -->
			</tbody>
			<tfoot id="sell_tfoot">
				<!-- 총 합계 -->
			</tfoot>
		</table>
	</div>
</div>

<form class="excel_form" method="post" action="/excelDown.api" name="excel_form" >
	<input type="hidden" id="excelHtml" name="excelHtml" />
</form>