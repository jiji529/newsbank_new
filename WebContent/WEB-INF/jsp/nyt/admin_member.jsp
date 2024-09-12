<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2017. 11. 22. 오후 16:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 21.   LEE GWANGHO    member.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>NYT 뉴스뱅크관리자</title>
<link rel="stylesheet" href="css/nyt/base.css" />
<link rel="stylesheet" href="css/nyt/mypage.css" />

<script src="js/nyt/jquery-1.12.4.min.js"></script>
<script src="js/nyt/jquery.twbsPagination.js"></script>
<script src="js/nyt/admin.js?v=20180416"></script>
<script> 
$(document).ready(function(){ 
	$(".popup_close").click(function(){ 
		$("#popup_wrap").css("display", "none"); 
		$("#mask").css("display", "none"); 
	}); 
}); 
</script>
<script type="text/javascript">
//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
$(document).ready(function() {
	$("[href]").each(function() {
		if (this.href == window.location.href) {
			$(this).parent().addClass("on");
		}
	});
	$("#startgo").val(1); // 최초 1페이지로
	search();
});

$(document).on("click", ".btn_input2", function() {
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

// 첫번쨰 페이지
$(document).on("click",".first",function() {
	var pages = "1";
	$("#startgo").val(pages);
	
	search("not_paging");
});

// 마지막 페이지
$(document).on("click",".last",function() {
	var pages = $("#lastvalue").val();
	$("#startgo").val(pages);
	
	search("not_paging");
});

// 이전 페이지
$(document).on("click",".prev",function() {
	var pages = $("#pagination-demo .page.active").text();
	$("#startgo").val(pages);
	
	search("not_paging");
});

// 다음 페이지
$(document).on("click",".next",function() {
	var pages = $("#pagination-demo .page.active").text();
	$("#startgo").val(pages);
	
	search("not_paging");
});

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

/** 전체선택 */
$(document).on("click", "input[name='check_all']", function() {
	if($("input[name='check_all']").prop("checked")) {
		$("#mtBody input:checkbox").prop("checked", true);
	}else {
		$("#mtBody input:checkbox").prop("checked", false);
	}
});

// 그룹묶기 팝업창, 옵션선택에 따른 알림문구 변경
$(document).on("click", ".group_li input[type='radio']", function() {
	var id = $(this).val();
	$(".pop_foot > p").html('(<span class="color">' + id + '</span>) 아이디를 그룹명으로 하여 그룹을 묶습니다.');
	//$(".pop_foot > p").html('선택한 ID를 그룹(<span class="color">' + id + '</span>)으로 묶겠습니까?');
});

/** 그룹묶기 팝업  */
function popup_group() {
	var chk_total = $("#mtBody input:checkbox:checked").length;
	var groupDivision = new Array();
	
	if(chk_total == 0) { // 선택항목 갯수 체크
		alert("최소 1개 이상을 선택해주세요.");
		
	} else {
		
		if((!check_existGroup()) && check_corp() && check_payType()) { // 선택항목 중에 그룹이 포함되었는지 여부 확인 & 법인회원인지 유무 확인 & 오프라인 회원 유무 확인
			$("#popup_wrap").css("display", "block"); 
			$("#mask").css("display", "block"); 
			$(".group_li").empty();
			$(".pop_foot > p").text('그룹명으로 지정할 아이디를 선택해주세요');
			
			$("#mtBody input:checkbox:checked").each(function(index) {
				var id = $(this).closest("tr").find("td:eq(2)").text().trim();
				var compName = $(this).closest("tr").find("td:eq(3)").text().trim();
				
				//var option = $(this).val();
				//var id = option.split("(");
				//id = id[0];
				var popup_html = '<li>';
				popup_html += '<input type="radio" id="radio_chk' + index + '" name="group" value="' + id + '"/>';
				popup_html += '<label for="radio_chk' + index + '""> ' + id + '</label>';
				popup_html += '</li>';
				
				$(popup_html).appendTo(".group_li");
			});
		}
		
	}
}

// 탈퇴처리
function drop_out() {
	var chk_total = $("#mtBody input:checkbox:checked").length;
	
	if(chk_total == 0) { // 선택항목 갯수 체크
		alert("최소 1개 이상을 선택해주세요.");
	
	} else {
		
		if(confirm("선택한 회원을 정말로 탈퇴처리 하시겠습니까?")) {
			$("#mtBody input:checkbox:checked").each(function(index) {
				var seq = $(this).val();
				
				$.ajax({
					type: "POST",
					url: "/admin.member.api",
					data : ({
						action : 'D',
						seq : seq
					}),
					dataType : "json",
					success : function(data) {
						if (data.success) {
						} 
					}
				});
			});	
			alert("탈퇴 완료");
			location.href = "/member.manage";
		}
	}
}

function check_existGroup() { // 그룹포함여부 확인
	var result = false;
	$("#mtBody input:checkbox:checked").each(function(index) {
		var groupType = $(this).closest("tr").children().eq(9).text(); // 그룹 구분
		
		if(groupType != "개별"){ 
			result = true;				
		}
	});
	
	if(result) {
		alert("이미 그룹인 회원이 포함되어 있습니다.");
	}
	
	return result;
}

function check_corp() { // 법인 회원유무 확인
	var result = true;
	var other = new Array();
	
	$("#mtBody input:checkbox:checked").each(function(index) {
		var memberType = $(this).closest("tr").children().eq(4).text(); // 회원구분
		var id = $(this).closest("tr").children().eq(2).text();
		
		if(memberType != "법인") {
			result = false;
			other.push(id);			
		}
	});
	
	if(!result) {
		alert(other.join(", ")+" 계정은 개인/언론사 회원입니다.\n 그룹묶기는 법인 회원만 가능합니다.");
	}	
	return result;
}

function check_payType() { // 결제구분 확인
	var result = true;
	$("#mtBody input:checkbox:checked").each(function(index) {
		var payType = $(this).closest("tr").children().eq(8).text(); // 결제구분
		
		if(payType == "온라인 결제") {
			result = false;
		}
	});
	
	if(!result) {
		alert("오프라인 결제 회원만 그룹묶기가 지원됩니다");
	}
	return result;
}

// 그룹 생성
function make_group() {
	var chk_total = $(".group_li input:radio:checked").length;
	
	if(chk_total == 0) { // 선택항목 갯수 체크
		alert("최소 1개 이상을 선택해주세요.");
		
	}else {
		var groupName = $("input:radio[name='group']:checked").val();
		var radio_id = [];
		$("input:radio[name='group']").each(function(key, val) {
			radio_id.push($(this).val());
		});	
		
		var param = {
				"groupName" : groupName,
				"radio_id" : radio_id.join(",")
		};
		
		$.ajax({
			type: "POST",
			data: param,
			url: "/member.manage?action=makeGroup",
			success: function(data) { 
				alert("그룹이 생성되었습니다");
				$("#popup_wrap").css("display", "none"); 
				$("#mask").css("display", "none"); 
				
			}, complete: function() {
				search("not_paging");
			}
		});
	}
}

function makePhoneNumber(phoneNumber) { // 휴대폰 번호로 표현
	return phoneNumber.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
}

function reset_page() { // 시작 페이지 초기화
	$("#startgo").val(1);
}

function search(state) { // 검색
	var keyword = $("#keyword").val(); keyword = $.trim(keyword); // 아이디/이름/회사명
	var type = $("#sel_type option:selected").attr("value"); // 회원구분
	var deferred = $("#sel_deferred option:selected").attr("value"); // 결제구분
	var group = $("#sel_group option:selected").attr("value"); // 그룹구분
	var pageVol = $("#sel_pageVol option:selected").attr("value"); // 페이지 표시 갯수
	var startPage = ($("#startgo").val()-1) * pageVol; // 시작 페이지
	var pageCnt = 0; // 전체 페이지 갯수
	var totalCnt = 0; // 전체 갯수
	
	var searchParam = {
			"keyword":keyword
			, "type":type
			, "deferred":deferred
			, "group":group
			, "pageVol":pageVol
			, "startPage":startPage
	};
	
	var html = "";
	$("#mtBody").empty();
	
	console.log(searchParam);
	
	$.ajax({
		type: "POST",
		dataType: "json",
		data: searchParam,
		url: "/listMember.api",
		success: function(data) { //console.log(data);
			pageCnt = data.pageCnt; // 총 페이지 갯수
			totalCnt = data.totalCnt; // 총 갯수
			
			$(data.result).each(function(key, val) {
				var number = totalCnt - ( ($("#startgo").val() - 1) * pageVol + key );
				
				var type = val.type;
				if(type == "P") type = "개인";
				if(type == "C") type = "법인";
				if(type == "M") type = "언론사<br/>(최고관리자)";
				if(type == "Q") type = "언론사<br/>(사진관리자)";
				if(type == "W") type = "언론사<br/>(정산관리자)";
				
				var group = val.group_seq;
				var groupName = val.groupName;
				if(group == 0){ 
					group = "개별";  
				}else{
					group = "그룹("+groupName+")";  
				}
				
				var deferred = val.deferred;
				if(deferred == '0') deferred = "온라인 결제";
				if(deferred == '2') deferred = "오프라인 결제<br/>(별도 가격)";	
				
				var contractStart = val.contractStart;
				var contractEnd = val.contractEnd;
				var duration = "";
				if(contractStart == null || contractEnd == null) duration = "정보 미기재"; // 둘 중 하나라도 null이면 표시 
				if(contractStart != null && contractEnd != null) duration = contractStart.split(" ")[0] + " ~ " + contractEnd.split(" ")[0]; // 모든 정보가 있을 때 표시
				
				var regDate = val.regDate;
				regDate = regDate.substring(0, 10);
				
				html += '<tr>';
				html += '<td onclick="event.cancelBubble = true"><div class="tb_check">';
				html += '<input id="check' + key + '" name="check' + key + '" type="checkbox" value="' + val.seq + '">';
				html += '<label for="check' + key + '">선택</label>';
				html += '</div></td>';
				html += '<td>' + number + '</td>';
				html += '<td><a href="javascript:void(0);" onclick="go_memberView(\'' + val.seq + '\')">' + val.id + '</a></td>';
				html += '<td>' + val.compName + '</td>';
				html += '<td>' + type +'</td>';
				html += '<td>' + val.name + '</td>';
				html += '<td>' + val.email + '</td>';
				html += '<td>' + makePhoneNumber(val.phone) + '</td>';
				html += '<td>' + deferred + '</td>';
				html += '<td>' + regDate + '</td>';
				html += '</tr>';
			});
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

function go_memberView(member_seq) {
	$("#member_seq").val(member_seq);
	view_member_manage.submit();
}

function downInternal() {
	var keyword = $("#keyword").val(); keyword = $.trim(keyword); // 아이디/이름/회사명
	var type = $("#sel_type option:selected").attr("value"); // 회원구분
	var deferred = $("#sel_deferred option:selected").attr("value"); // 결제구분
	var group = $("#sel_group option:selected").attr("value"); // 그룹구분
	
	$("#currentKeyword").val(keyword);
	$("#type").val(type);
	$("#deferred").val(deferred);
	$("#group").val(group);
	$("#pageVol").val(1000);
	$("#startPage").val(0);
	$("#downForm").attr("action", "/excel.listMember.api");
	$("#downForm").submit();
}
</script>
</head>
<body>
<div class="wrap admin">
	<%@include file="header_admin.jsp" %>
	<section class="wide">
		<%@include file="sidebar.jsp" %>
		<div class="mypage">
			<div class="table_head">
				<h3>회원 현황</h3>
			</div>
			<div class="ad_sch_area">
				<table class="tb01" cellpadding="0" cellspacing="0" >
					<colgroup>
					<col style="width:240px;" />
					<col style="width:;" />
					</colgroup>
					<tbody>
						<tr>
							<th>아이디/이름/회사명</th>
							<td><input type="text" id="keyword" class="inp_txt" size="50" /></td>
						</tr>
						<tr>
							<th>회원구분</th>
							<td><select name="" id="sel_type" class="inp_txt" style="width:380px;">
									<option value="">전체</option>
									<option value="P">개인</option>
									<option value="C">법인</option>
									<option value="M">언론사(최고관리자)</option>
								</select></td>
						</tr>
						<tr>
							<th>결제구분</th>
							<td><select name="" id="sel_deferred" class="inp_txt" style="width:380px;">
									<option value="">전체</option>
									<option value="0">온라인결제</option>
									<option value="1">오프라인결제</option>
								</select></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_area" style="margin-top:0;"><a href="javascript:void(0)" class="btn_input2">검색</a></div>
			</div>
			<div class="ad_result">
				<div class="ad_result_btn_area">
					<a href="/add.member.manage" style="margin-left: 0;">회원추가</a>  
					<a href="javascript:void(0)" class="bk" onclick="drop_out()">탈퇴처리</a>
				</div>
				<div class="ad_result_btn_area fr">
					<select id="sel_pageVol" onchange="reset_page(); search();">
						<option value="20">20개</option>
						<option value="50">50개</option>
						<option value="100">100개</option>
					</select> 
					<!-- <a href="javascript:void(0)" onclick="downInternal()">엑셀저장</a> -->
					<a href="javascript:void(0)" onclick="saveExcel('/excel.listMember.api', 'member')">엑셀저장</a>
				</div>
				<table cellpadding="0" cellspacing="0" class="tb04" id="excelTable">
					<colgroup>
		                <col width="30" />
		                <col width="30" />
		                <col width="100" />
		                <col />
		                <col width="80" />
		                <col width="80" />
		                <col />
		                <col width="130" />
		                <col width="130" />
		                <col width="100" />
					</colgroup>
					<thead>
						<tr>
							<th><div class="tb_check">
									<input id="check_all" name="check_all" type="checkbox" />
									<label for="check_all">선택</label>
								</div></th>
							<th>No. </th>
							<th>아이디</th>
							<th>회사명</th>
							<th>회원구분</th>
							<th>이름</th>
							<th>이메일</th>
							<th>연락처</th>
							<th>결제구분</th>
							<th>가입일자</th>
						</tr>
					</thead>
					<tbody id="mtBody">
						
					</tbody>
				</table>
				<div id="mask"></div>
				<input type="hidden" id="totcnt" value="" />
				<input type="hidden" id="startgo" value="" />
				<input type="hidden" id="lastvalue" value="" />
				<div class="pagination">
					<ul id="pagination-demo" class="pagination-sm">
					</ul>
				</div>
			</div>
		</div>
	</section>
	
	<form class="excel_form" method="post" action="/excelDown.api" name="excel_form" >
		<input type="hidden" id="excelHtml" name="excelHtml" />
	</form>
	
	<form method="post" action="/view.member.manage" name="view_member_manage" >
		<input type="hidden" name="member_seq" id="member_seq"/>
	</form>
	
	<form id="downForm" method="post"  target="downFrame">
		<input type="hidden" id="currentKeyword" name="keyword" />
		<input type="hidden" id="type" name="type" />
		<input type="hidden" id="deferred" name="deferred" />
		<input type="hidden" id="group" name="group" />
		<input type="hidden" id="pageVol" name="pageVol" />
		<input type="hidden" id="startPage" name="startPage" value="file" />
	</form>
	<iframe id="downFrame" name="downFrame" style="display:none"></iframe>
</div>
</body>
</html>