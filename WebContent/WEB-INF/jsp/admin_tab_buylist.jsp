<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/admin.js?v=20180416"></script>
<script src="js/paging.js?v=20180508"></script>

<script type="text/javascript">
	
	/** 전체선택 */
	$(document).on("click", "input[name='check_all']", function() {
		if($("input[name='check_all']").prop("checked")) {
			$("#mtBody input:checkbox").prop("checked", true);
		}else {
			$("#mtBody input:checkbox").prop("checked", false);
		}
	});
	
	function search(state) {		
		var keywordType = $("select[name='keywordType'] option:selected").val(); // 선택 옵션
		var keyword = $("#keyword").val(); keyword = $.trim(keyword);
		var pageVol = parseInt($("#sel_pageVol option:selected").attr("value")); // 페이지 표시 갯수
		var startPage = ($("#startgo").val()-1) * pageVol; // 시작 페이지
		var status = $("select[name='status'] option:selected").val(); // 결제구분
		var start_date = $("input[name=start_date]").val(); // 시작일
		var end_date = $("input[name=end_date]").val(); // 종료일
		var pageCnt = 0; // 전체 페이지 갯수
		var totalCnt = 0; // 전체 갯수
		var totalPrice = 0; // 총 판매금액
		
		var select_period = start_date + " ~ " + end_date;
		$("#select_period").text(select_period);
		
		var searchParam = {
			"keywordType":keywordType
			,"keyword":keyword
			, "pageVol":pageVol
			, "startPage":startPage 
			, "start_date":start_date + "000000"
			, "end_date":end_date + "240000"
			, "status":status
		};
		//console.log(searchParam);
		
		var html = "";
		
		$("#loading").show();
		$("#mtBody").empty();
		
		$.ajax({
			type: "POST",
			dataType: "json",
			data: searchParam,
			url: "/buy.api",
			success: function(data) { //console.log(data);
				totalPrice = data.totalPrice;
				pageCnt = data.pageCnt;
				totalCnt = data.totalCnt; 
				
				setCountPrice(data.totalList);
				
				// 검색결과 표시
				$("#totalPrice").text(totalPrice);
				$("#totalCnt").text(totalCnt);
				
				var data = data.result;
				
				if(data.length != 0) {	
					$(data).each(function(key, val){
						var number = totalCnt - ( ($("#startgo").val() - 1) * pageVol + key );
						
						var seq = val.paymentDetail_seq
						var compName = val.compName;
						var id = val.id;
						var name = val.name;
						var LGD_OID = val.LGD_OID;
						var LGD_PAYDATE = val.LGD_PAYDATE;
						var paydate = LGD_PAYDATE.replace(
						    /^(\d{4})(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)$/,
						    '$1-$2-$3 $4:$5:$6'
						);
						var LGD_PAYSTATUS = val.LGD_PAYSTATUS;
						var status = val.status;
						var copyright = val.copyright;						
						var uciCode = val.photo_uciCode;
						var compCode = val.compCode;
						var usage = val.usage;
						var usageList_seq = val.usageList_seq;
						var price = val.price;
						var postRate = val.postRate;
						
						switch(status) {
						case 0:
							status = "구매 신청";
							break;
							
						case 1:
							status = "승인 취소";
							break;
							
						case 2:
							status = "정산 승인";
							break;
							
						case 3:
							status = "구매 반려";
							break;
						}
						
						html += '<tr>';
						html += '<td><div class="tb_check">';
						html += '<input id="check' + key + '" name="check' + key + '" type="checkbox" value="' + seq + '">';
						html += '<label for="check' + key + '">선택</label>';
						html += '</div></td>';
						html += '<td>' + number + '</td>';
						html += '<td>' + compName + '</td>';
						html += '<td>' + id + '</td>';
						html += '<td>' + name + '</td>';
						//html += '<td>' + LGD_OID + '</td>';
						html += '<td>' + paydate + '</td>';
						html += '<td>' + status + '</td>';
						html += '<td>' + copyright + '</td>';
						html += '<td><a href="/view.photo?uciCode=' + uciCode + '" target="_blank">' + uciCode + '</a></td>';
						html += '<td>' + compCode + '</td>';
						html += '<td seq="' + usageList_seq + '">' + usage + '</td>';
						html += '<td>' + price + '</td>';
						html += '<input type="hidden" name="postRate" value="' + postRate + '"/>';
						html += '</tr>';
					});
					
				}else {
					html += '<tr>';
					html += '<td colspan="12">검색 결과가 없습니다.</td>';
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
	
	// 종류별 건수, 합계금액
	function setCountPrice(totalList) {
		var apply_price = 0; // 구매신청
		var apply_cnt = 0;
		var approve_price = 0; // 정산승인
		var approve_cnt = 0;
		var disapprove_price = 0; // 승인 취소
		var disapprove_cnt = 0; 
		
		var result = new Array();
		
		$(totalList).each(function(key, val){
			var status = val.status;
			var price = val.price;
			
			switch(status) {
			
				case 0:
					apply_price += price;
					apply_cnt += 1;
					break;
					
				case 2:
					approve_price += price;
					approve_cnt += 1;
					break;
					
				case 3:
					disapprove_price += price;
					disapprove_cnt += 1;
					break;
			
			}
		});
		
		if(apply_cnt > 0) {
			var text = "구매 신청 : " + apply_price + "원 /" + apply_cnt + "건";
			result.push(text);
		}
		
		if(approve_cnt > 0) {
			var text = "정산 승인 : " + apply_price + "원 /" + apply_cnt + "건";
			result.push(text);
		}
		
		if(disapprove_cnt > 0) {
			var text = "정산 승인 : " + apply_price + "원 /" + apply_cnt + "건";
			result.push(text);
		}
		
		if(result.length > 0) {
			$("#buy_result").text("( " + result.join("|") + " )");	
		}
	}
	
	// 오프라인 구매/정산 상태값 변경 (승인 취소 : 1 / 정산 승인: 2 / 구매 반려: 3)
	function update_calculations(status) {
		
		var count = $("#mtBody input:checkbox:checked").length;
		var msg = "";
		
		switch(status){
			case 1:
				msg = "승인 취소";
				break;
			
			case 2:
				msg = "정산 승인";
				break;
				
			case 3:
				msg = "구매 반려";
				break;
			
		}
		
		if(count != 0){
			if(confirm("선택하신 항목을 " + msg + " 처리하시겠습니까?")) {
				
				$("#mtBody input:checkbox:checked").each(function(index) {
					
					var paymentDetail_seq = $(this).val();
					
					var uciCode = $(this).closest("tr").find("td").eq(8).text();
					var id = $(this).closest("tr").find("td").eq(3).text();
					var price = $(this).closest("tr").find("td").eq(11).text();
					var rate = $(this).closest("tr").find("input[name=postRate]").val(); 
					rate = rate / 100;
					
					var fees = 0; // 후불회원은 PG수수료가 없음.
					var usage = parseInt($(this).closest("tr").find("td").eq(10).attr("seq"));
					var payType = "SC9999"; // 후불
					//var usuage = ""; // 사용용도
					
					if(status == 1) {
						price = -(price);
						fees = -(fees);
					}
					
					var param = {
							"paymentDetail_seq" : paymentDetail_seq,
							"cmd" : "U",
							"status" : status,
							"id": id,
							"uciCode": uciCode,
							"price": price,
							"fees": fees,
							"payType": payType,
							"usage":usage
					};	
					//console.log(param);
					
					$.ajax({
						type: "POST",
						url: "/calculation.api",
						data: param,
						dataType: "json",
						success: function(data) { 
							//console.log(data);
						},
						complete: function() {
							search();
						}
					});
					
				});
			}
		}else {
			alert("원하는 항목을 체크해주세요");
		}
		
	}
</script>

<div class="ad_sch_area">
	<form id="frmBuyList" method="post">
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
						<input type="text" id="keyword" class="inp_txt" size="80"
							placeholder="회사/기관명, 아이디, 이름, UCI코드, 언론사 사진번호" />
					</td>
				</tr>
				<tr>
					<th>기간 선택</th>
					<td>
						<select id="customYear" class="inp_txt" class="inp_txt" style="width:100px;">
							<c:forEach var="i" begin="2015" end="${year}" step="1">
								<option value="${i }" <c:if test="${i eq year}">selected</c:if>>${i}년</option>
							</c:forEach>
						</select>
						<select id="customDay" name="" class="inp_txt" style="width: 95px;">
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
						
						<ul id="customDayOption" class="period">
							<c:forEach var="pastMonth" items="${pastMonths}">
								<li><a href="javascript:;" class="btn" value="${pastMonth}">${fn:substring(pastMonth, 4, 6)}월</a> </li>
							</c:forEach>
						</ul>
						<div class="period">
							<input type="text"  size="12" id="contractStart" name="start_date"  class="inp_txt" value="${year}-01-01" maxlength="10">
							<span class=" bar">~</span>
							<input type="text"  size="12" id="contractEnd" name="end_date"  class="inp_txt" value="${today }" maxlength="10">
						</div>
					</td>
				</tr>
				<tr>
					<th>상태 구분</th>
					<td><select name="status" class="inp_txt" style="width: 150px;">
							<option value="all" selected="selected">전체</option>
							<option value="0">구매 신청</option>
							<option value="1">정산 승인취소</option>
							<option value="2">정산 승인</option>
							<option value="3">구매 반려</option>
					</select></td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="btn_area" style="margin-top: 0;">
		<a href="javascript:void(0)" class="btn_input2">검색</a>
	</div>
	
	
	<div class="calculate_info_area"> 기간 : <span id="select_period"></span> <span class="bar3">l</span> 건수 : <span id="totalCnt" class="color"> </span>건 <span class="bar3">l</span> 총 판매금액 : <span class="color" id="totalPrice"> </span>원 <span class="bar3">l</span>
		<p style="color:#888;" id="buy_result"></p>
	</div>
	<div class="ad_result">
		<div class="ad_result_btn_area">
			<a href="javascript:void(0)" onclick="update_calculations(3)">구매 반려</a>
			<a href="javascript:void(0)" onclick="update_calculations(2)">정산 승인</a> 
			<a href="javascript:void(0)" onclick="update_calculations(1)">정산 승인 취소</a> 
		</div>
		<div class="ad_result_btn_area fr">
			<select id="sel_pageVol" onchange="search()">
			<option value="20">20개</option>
			<option value="50">50개</option>
			<option value="100">100개</option>
		</select> 
		<a href="javascript:void(0)" onclick="saveExcel('/excel.buy.api', 'buylist')">엑셀저장</a>
		</div>
		<table cellpadding="0" cellspacing="0" class="tb04" id="excelTable">
			<colgroup>
			<col width="40" />
			<col width="50" />
			<col width="120" />
			<col width="100" />
			<col width="80" />
			<%-- <col width="150" /> --%>
			<col width="150" />
			<col width="100" />
			<col width="100" />
			<col width="150" />
			<col width="80" />
			<col width="80" />
			<col width="80" />
			</colgroup>
			<thead>
				<tr>
					<th><div class="tb_check">
							<input id="check_all" name="check_all" type="checkbox">
							<label for="check_all">선택</label>
						</div></th>
					<th>No. </th>
					<th>회사/기관명</th>
					<th>아이디</th>
					<th>이름</th>
					<!-- <th>주문번호</th> -->
					<th>구매 신청일</th>
					<th>상태</th>
					<th>매체</th>
					<th>UCI코드</th>
					<th>언론사 사진번호</th>
					<th>용도</th>
					<th>금액</th>
				</tr>
			</thead>
			<tbody id="mtBody">
				<!-- 구매내역 표시 -->
			</tbody>
		</table>
		<input type="hidden" id="totcnt" value="" />
		<input type="hidden" id="startgo" value="" />
		<input type="hidden" id="lastvalue" value="" />
		<div class="pagination">
			<ul id="pagination-demo" class="pagination-sm">
				<!-- 페이징 -->
			</ul>
		</div>
	</div>
</div>

<form class="excel_form" method="post" action="/excelDown.api" name="excel_form" >
	<input type="hidden" id="excelHtml" name="excelHtml" />
</form>

<div id="loading"><img id="loading-image" src="/images/ajax-loader.gif" alt="loading" /></div>