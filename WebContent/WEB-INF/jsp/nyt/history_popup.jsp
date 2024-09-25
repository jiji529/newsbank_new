<%---------------------------------------------------------------------------
  Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2018. 4. 5. 오전 9:15:17
  @comment   : CMS 사진 수정 히스토리 보기 숨김레이어
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2018. 4. 5.     
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
<%-- 수정기록 읽어와서 팝업에 띄우기 --%>
$(document).on("click", "#history_open", function() {
	setModLog();
	$("#popup_wrap").css("display", "block"); 
	$(".mask").css("display", "block");
});

<%-- 팝업 닫기 --%>
$(document).on("click", ".popup_close", function() { 
	$("#popup_wrap").css("display", "none"); 
	$(".mask").css("display", "none");
	$(".pop_history .pop_cont tbody").html(""); 
});

<%-- 수정이력 관리 팝업 띄우기 --%>
$(document).on("click", "#history_popup", function() {
	$("#popup_wrap").css("display", "block"); 
	$(".mask").css("display", "block");
});

function excel() { // form, iframe을 이용한 엑셀저장
	var url = "modLog.cms" + $("#manage").val();
	var uciCode = $("#uciCode").val();
	
	//console.log(url);
	//console.log(uciCode);
	
	$("#choiceUciCode").val(uciCode);
	$("#downFile").val("excel");
	$("#excelDownForm").attr("action", url);
	$("#excelDownForm").submit();
}

function popupModLog(uciCode) {
	var url = "modLog.cms" + $("#manage").val();
	$("#uciCode").val(uciCode);
	
	$.ajax({
		type: "POST",
		url: url,
		async: false,
		data: {
			"uciCode" : uciCode
		},
		dataType: "json",
		success: function(data){
			var html = "";
			$(data.result).each(function(key, val) {
				html += "<tr>"
					+ "<td>" + val.no + "</td>"
					+ "<td>" + val.regDateStr + "</td>"
					+ "<td>" + val.memberId + "</td>"
					+ "<td>" + val.memberName + "</td>"
					+ "<td>" + val.actionTypeStr + "</td>"
					+ "</tr>";
			});
			$(".pop_history .pop_cont tbody").html(html); 
			$("#popup_wrap").css("display", "block"); 
			$(".mask").css("display", "block");
			
		}, error:function(request,status,error){
        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       	}
	});
}

function setModLog() {
	var url = "modLog.cms" + $("#manage").val();
	$.ajax({
		type: "POST",
		url: url,
		async: false,
		data: {
			"uciCode" : $("#uciCode").val()
		},
		dataType: "json",
		success: function(data){
			var html = "";
			$(data.result).each(function(key, val) {
				html += "<tr>"
					+ "<td>" + val.no + "</td>"
					+ "<td>" + val.regDateStr + "</td>"
					+ "<td>" + val.memberId + "</td>"
					+ "<td>" + val.memberName + "</td>"
					+ "<td>" + val.actionTypeStr + "</td>"
					+ "</tr>";
			});
			$(".pop_history .pop_cont tbody").html(html); 
		}, error:function(request,status,error){
        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       	}
	});
}
</script>

   <div id="popup_wrap" class="pop_group wd2 pop_history">
		<div class="pop_tit">
			<h2>수정 이력 보기</h2>
			<a href="javascript:void(0)" onclick="excel()" class="pop_tit_btn">엑셀저장</a>
			<p>
				<button class="popup_close">닫기</button>
			</p>
		</div>
		<div class="pop_cont">
			<table cellpadding="0" cellspacing="0" class="tb04">
				<colgroup>
				<col width="40">
				<col width="200">
				<col width="100">
				<col width="100">
				<col>
				</colgroup>
				<thead>
					<tr>
						<th>No. </th>
						<th>수정일</th>
						<th>아이디</th>
						<th>이름</th>
						<th>수정 항목</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>yyyy-MM-dd hh:mm:ss</td>
						<td>dahami</td>
						<td>관리자</td>
						<td>무슨짓했나?</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="pop_foot">
			<div class="pop_btn">
				<button class="popup_close">닫기</button>
			</div>
		</div>
	</div>
	<div class="mask"></div>
	
	<!-- Excel 저장 form -->
	<form id="excelDownForm" method="post"  target="excelDownFrame">
		<input type="hidden" id="choiceUciCode" name="uciCode" />
		<input type="hidden" id="downFile" name="downFile" />
	</form>
	<iframe id="excelDownFrame" name="excelDownFrame" style="display:none"></iframe>