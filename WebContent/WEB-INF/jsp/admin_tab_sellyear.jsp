<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	//검색 클릭이벤트
	$(document).on("click", ".btn_input2", function() {
		$("#startgo").val(1); // 최초 1페이지로
		search();
	});
	
	//정산목록 전체검색(기간변 온라인/오프라인 목록)
	function search() {
		var keyword = $("#keyword").val(); // 키워드
		var paytype = $("#paytype").val(); // 결제 상황
		var start_date = $("input[name=start_date]").val(); // 시작일
		var end_date = $("input[name=end_date]").val(); // 종료일
		
		var param = {
				"cmd" : "S",
				"start_date" : start_date,
				"end_date" : end_date,
				"keyword" : keyword,
				"paytype" : paytype
		};
		
		// 테이블 생성 (기간 월별로 온라인/오프라인 만들어 놓고, 기간별 해당하는 위치에 값을 넣기)
		
		$.ajax({
			type: "POST",
			url: "/calculation.api",
			dataType: "json",
			data: param,
			success: function(data) {
				var result = data.result;
				console.log(result);
				
				$(result).each(function(key, val){
					var price = val.price;
					var type = val.type;
					var YearOfMonth = val.YearOfMonth;
					
					
				});
			}, 
			complete: function() {
				
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
				<td><input type="text" class="inp_txt" size="80" id="keyword"
					placeholder="아이디, 이름, 회사명" /></td>
			</tr>
			<tr>
				<th>기간 선택</th>
				<td><select id="customYear" class="inp_txt"
					style="width: 100px;">
						<c:forEach var="i" begin="2015" end="${year}" step="1">
							<option value="${i }" <c:if test="${i eq year}">selected</c:if>>${i}년</option>
						</c:forEach>
				</select> 
				<select id="customDay" class="inp_txt" style="width: 95px;" disabled>
						<option value="all" selected="selected">전체(월)</option>
						<c:forEach var="m" begin="1" end="${month}" step="1">
							<option value="${m}">${m}월</option>
						</c:forEach>
				</select>
					<%-- <ul id="customDayOption" class="period">
						<c:forEach var="pastMonth" items="${pastMonths}">
							<li><a href="javascript:;" class="btn" value="${pastMonth}">${fn:substring(pastMonth, 4, 6)}월</a>
							</li>
						</c:forEach>
					</ul> --%>
					<div class="period">
						<input type="text" size="12" id="contractStart" name="start_date"
							class="inp_txt" value="${year}-${month}-01" maxlength="10" disabled />
						<span class=" bar">~</span> <input type="text" size="12"
							id="contractEnd" name="end_date" class="inp_txt"
							value="${today }" maxlength="10" disabled />
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
						<option value=" ">선택안함</option>
				</select> <input type="hidden" id="adjSlave_arr" value=""></td>
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

	<div id="tb_total">
		<table cellpadding="0" cellspacing="0" class="tb04" id="sell_table">
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