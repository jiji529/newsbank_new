<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript">
	$(document).ready(function() {
		search();
	});
	
	//정산매체 선택에 따른 피정산 매체 목록
	$(document).on("change", "#adjMaster", function() {
		var master = $(this).val();
		
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
						html += '<option value="all" selected="selected">피정산 매체 전체</option>';
						html += '<option value=" ">선택안함</option>';
						
						$(result).each(function(key, val){
							html += '<option value="' + val.seq + '">' + val.name + '</option>';
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
	
	// 정산목록 검색(정산매체 선택)
	function search() {
		var keyword = $("#keyword").val(); // 키워드
		var start_date = $("input[name=start_date]").val(); // 시작일
		var end_date = $("input[name=end_date]").val(); // 종료일
		var adjMaster = $("#adjMaster").val(); // 정산매체
		var adjSlave = $("#adjSlave").val(); // 피정산매체
		var paytype = $("#paytype").val(); // 결제 상황
		var seqArr = 0; // 피정산 매체
		
		// 피정산 매체 선택여부 확인
		if(adjSlave == " ") { // 없음 or 선택안함
			seqArr = adjMaster;
		}else if(adjSlave == "all") { // 전체 선택
			seqArr = $("#adjSlave_arr").val();
		}else { // 개별선택
			seqArr = adjSlave;
		}
		
		var param = {
				"seqArr" : seqArr,
				"cmd" : "R",
				"start_date" : start_date,
				"end_date" : end_date,
				"keyword" : keyword,
				"paytype" : paytype
		};		
					
		$("#tf_media").empty();
		$("#tb_media_tbody").empty();
		
		var html = ""; // tbody 데이터
		var foot_html = ""; // tfoot 데이터
		var total = 0; // 검색결과 갯수
		
		// 매출합계 변수
		var sum_taxAmount = 0; // 과세금액 합계
		var sum_taxAddedTax = 0; // 과세부가세 합계
		var sum_price = 0; // 결제금액 합계
		var sum_billingTax = 0; // 빌링수수료 합계
		var sum_totalSales = 0; // 총매출액 합계
		var sum_memberSales = 0; // 회원사 합계
		var sum_supplyPriceAmount = 0; // 공급가액 합계
		var sum_supplyTax = 0; // 공급부가세 합계
		var sum_dahamiSales = 0; // 다하미매출액 합계
		
		$.ajax({
			type: "POST",
			url: "/calculation.api",
			data: param,
			dataType: "json",
			success: function(data) { 
				var result = data.result;
				total = result.length;
				
				$(result).each(function(key, val){
					
					var billingTax = Math.round(val.price * 0.0352); // 빌링 수수료
					var taxAddedTax = Math.round(val.price * 0.1); // 과세부가세
					var taxAmount = Math.round(val.price - taxAddedTax); // 과세금액
					var totalSales = Math.round(val.price - billingTax); // 총 매출액
					var memberSales = Math.round(totalSales * 0.7); // 회원사 매출액
					var supplyTax = Math.round((memberSales / 110) * 10); // 공급부가세
					var supplyPriceAmount = Math.round(memberSales - supplyTax); // 공급가액
					var dahamiSales = Math.round(totalSales - memberSales); // 다하미 매출액
					
					sum_taxAmount += taxAmount;
					sum_taxAddedTax += taxAddedTax;
					sum_price += val.price;
					sum_billingTax += billingTax; 
					sum_totalSales += totalSales;
					sum_memberSales += memberSales;
					sum_supplyPriceAmount += supplyPriceAmount;
					sum_supplyTax += supplyTax;
					sum_dahamiSales += dahamiSales; 						
					
					html += '<tr>';
					html += '<td>' + (key+1) + '</td>';
					html += '<td>' + val.regDate + '</td>';
					html += '<td>' + val.name + '\n(' + val.id + ')</td>';
					html += '<td>' + val.compName + '</td>';
					html += '<td>' + val.uciCode + '</td>';
					html += '<td>' + val.copyright + '</td>';
					html += '<td>' + val.payType + '</td>';
					html += '<td>' + comma(taxAmount) + '</td>';
					html += '<td>' + comma(taxAddedTax) + '</td>';
					html += '<td>' + comma(val.price) + '</td>';
					html += '<td>' + comma(billingTax) + '</td>';
					html += '<td>' + comma(totalSales) + '</td>';
					html += '<td>' + comma(memberSales) + '</td>';
					html += '<td>' + comma(supplyPriceAmount) + '</td>';
					html += '<td>' + comma(supplyTax) + '</td>';
					html += '<td>' + comma(dahamiSales) + '</td>';
					html += '</tr>';						
				
				});
			},
			complete: function(){
				
				foot_html += '<tr>';
				foot_html += '<td colspan="7"> 월 매출액 합계</td>';
				foot_html += '<td>' + comma(sum_taxAmount) + "</td>";
				foot_html += '<td>' + comma(sum_taxAddedTax) + "</td>";
				foot_html += '<td>' + comma(sum_price) + "</td>";
				foot_html += '<td>' + comma(sum_billingTax) + "</td>";
				foot_html += '<td>' + comma(sum_totalSales) + "</td>";
				foot_html += '<td><font color="#FF0000">' + comma(sum_memberSales) + "</font></td>";
				foot_html += '<td>' + comma(sum_supplyPriceAmount) + "</td>";
				foot_html += '<td>' + comma(sum_supplyTax) + "</td>";
				foot_html += '<td><font color="#0000FF">' + comma(sum_dahamiSales) + "</font></td>";
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
				</select> <select id="customDay" class="inp_txt" style="width: 95px;">
						<option value="all" selected="selected">전체(월)</option>
						
						<c:forEach var="m" begin="1" end="${month}" step="1">
							<option value="${m}">${m}월</option>
						</c:forEach>
				</select>
					<ul id="customDayOption" class="period">
						<c:forEach var="pastMonth" items="${pastMonths}">
							<li><a href="javascript:;" class="btn" value="${pastMonth}">${fn:substring(pastMonth, 4, 6)}월</a>
							</li>
						</c:forEach>
					</ul>
					<div class="period">
						<input type="text" size="12" id="contractStart" name="start_date"
							class="inp_txt" value="${year}-${month}-01" maxlength="10">
						<span class=" bar">~</span> <input type="text" size="12"
							id="contractEnd" name="end_date" class="inp_txt"
							value="${today }" maxlength="10">
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
<div class="calculate_info_area" style="display:none;">
	기간 : <span id="search_period"></span> <span class="bar3">l</span> 
	건수 : <span id="search_total" class="color"></span>건 <span class="bar3">l</span> 
	총 판매금액 : <span	id="search_price" class="color"></span>원
</div>
<div class="ad_result">

	<div class="ad_result_btn_area fr">
		<a href="#">엑셀저장</a>
	</div>

	<div id="tb_media">
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
				<!-- 정산 내역 -->
			</tbody>
			<tfoot id="tf_media">
				<!-- 정산 매출액 합계 -->
			</tfoot>
		</table>
	</div>
	
	
</div>