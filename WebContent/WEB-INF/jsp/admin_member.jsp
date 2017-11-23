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
	String IMG_SERVER_URL_PREFIX = "http://www.dev.newsbank.co.kr";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크관리자</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script> 
$(document).ready(function(){ 
$("#popup_open").click(function(){ 
$("#popup_wrap").css("display", "block"); 
$("#mask").css("display", "block"); 
}); 
}); 
</script>
<script> 
$(document).ready(function(){ 
$("#popup_open").click(function(){ 
$("#popup_wrap").css("display", "block"); 
$("#mask").css("display", "block"); 
}); 
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
	search();
});

$(document).on("click", ".btn_input2", function() {
	search();
});

$(document).on("keypress", "#keyword", function(e) {
	if (e.keyCode == 13) { // 엔터
		search();
	}
});

function search() { // 검색
	var keyword = $("#keyword").val(); keyword = $.trim(keyword); // 아이디/이름/회사명
	var type = $("#sel_type option:selected").attr("value"); // 회원구분
	var deferred = $("#sel_deferred option:selected").attr("value"); // 결제구분
	var group = $("#sel_group option:selected").attr("value"); // 그룹구분
	var pageVol = $("#sel_pageVol option:selected").attr("value"); // 페이지 표시 갯수
	
	var searchParam = {
			"keyword":keyword
			, "type":type
			, "deferred":deferred
			, "group":group
			, "pageVol":pageVol
	};
	
	var html = "";
	$("#mtBody").empty();
	
	$.ajax({
		type: "POST",
		dataType: "json",
		data: searchParam,
		url: "/listMember.api",
		success: function(data) { //console.log(data);
			$(data.result).each(function(key, val) {
				var type = val.type;
				if(type == "P") type = "개인";
				if(type == "C") type = "법인";
				
				var group = val.group_seq;
				if(group == 0){ 
					group = "개별";  
				}else{
					group = "그룹( )";  
				}
				
				var deferred = val.deferred;
				if(deferred == 'Y') deferred = "오프라인 결제";
				if(deferred == 'N') deferred = "온라인 결제";	
				
				var contractStart = val.contractStart;
				var contractEnd = val.contractEnd;
				var duration = "";
				if(contractStart == null || contractEnd == null) duration = "정보 미기재"; // 둘 중 하나라도 null이면 표시 
				if(contractStart != null && contractEnd != null) duration = contractStart + "~" + contractEnd; // 모든 정보가 있을 때 표시
				
				var regDate = val.regDate;
				regDate = regDate.substring(0, 10);
				
				html += '<tr onclick="javascript:void(0)">';
				html += '<td><div class="tb_check">';
				html += '<input id="check1" name="check1" type="checkbox">';
				html += '<label for="check1">선택</label>';
				html += '</div></td>';
				html += '<td>' + (key+1) + '</td>';
				html += '<td>' + val.id + '</td>';
				html += '<td>' + val.compName + '</td>';
				html += '<td>' + type +'</td>';
				html += '<td>' + val.name + '</td>';
				html += '<td>' + val.email + '</td>';
				html += '<td>' + val.phone + '</td>';
				html += '<td>' + deferred + '</td>';
				html += '<td>' + group + '</td>';
				html += '<td>' + duration + '</td>';
				html += '<td>' + regDate + '</td>';
				html += '</tr>';
			});
			$(html).appendTo("#mtBody");
		}
	});
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
					<col style="width:240px;">
					<col style="width:;">
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
								</select></td>
						</tr>
						<tr>
							<th>결제구분</th>
							<td><select name="" id="sel_deferred" class="inp_txt" style="width:380px;">
									<option value="">전체</option>
									<option value="N">온라인결제</option>
									<option value="Y">오프라인결제</option>
								</select></td>
						</tr>
						<tr>
							<th>그룹구분</th>
							<td><select name="" id="sel_group" class="inp_txt" style="width:380px;">
									<option value="">전체</option>
									<option value="I">개별</option>
									<option value="G">그룹</option>
								</select></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_area" style="margin-top:0;"><a href="javascript:void(0)" class="btn_input2">검색</a></div>
			</div>
			<div class="ad_result">
				<div class="ad_result_btn_area">
					<select id="sel_pageVol">
						<option value="20">20개</option>
						<option value="50">50개</option>
						<option value="100">100개</option>
					</select>
					<span  id="popup_open"><a href="#none">그룹묶기</a></span><a href="javascript:void(0)">엑셀저장</a></div>
				<table cellpadding="0" cellspacing="0" class="tb04">
					<colgroup>
					<col width="30" />
					<col width="30" />
					<col width="100" />
					<col />
					<col width="80" />
					<col width="80" />
					<col/>
					<col width="130" />
					<col width="80" />
					<col width="130" />
					<col/>
					<col width="100" />
					</colgroup>
					<thead>
						<tr>
							<th><div class="tb_check">
									<input id="check_all" name="check_all" type="checkbox">
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
							<th>그룹구분</th>
							<th>계약기간</th>
							<th>가입일자</th>
						</tr>
					</thead>
					<tbody id="mtBody">
						
					</tbody>
				</table>
				<div id="popup_wrap">
					<div class="pop_tit">
						<h2>그룹묶기</h2>
						<p>
							<button class="popup_close">닫기</button>
						</p>
					</div>
					<div class="pop_cont">
						<ul class="group_li">
							<li>
								<input type="radio" id="radio_chk1" name="group" />
								<label for="radio_chk1"> ottffssentottffssent(아이디스무자)</label>
							</li>
							<li>
								<input type="radio" id="radio_chk2" name="group" />
								<label for="radio_chk2"> ok0526(다하미)</label>
							</li>
							<li>
								<input type="radio" id="radio_chk3" name="group" />
								<label for="radio_chk3"> ok0526(다하미)</label>
							</li>
							<li>
								<input type="radio" id="radio_chk4" name="group" />
								<label for="radio_chk4"> ok0526(다하미)</label>
							</li>
							<li>
								<input type="radio" id="radio_chk5" name="group" />
								<label for="radio_chk5"> ok0526(다하미)</label>
							</li>
						</ul>
					</div>
					<div class="pop_foot">
						<p>선택한 ID를 그룹(<span class="color">ottffssentottffssent</span>)으로 묶겠습니까?</p>
						<div class="pop_btn">
							<button onclick="location.href='#'";>확인</button>
							<button class="popup_close">취소</button>
						</div>
					</div>
				</div>
				<div id="mask"></div>
				<div class="page">
					<ul>
						<li class="first"> <a href="javascript:void(0)">첫 페이지</a> </li>
						<li class="prev"> <a href="javascript:void(0)">이전 페이지</a> </li>
						<li> <a href="javascript:void(0)">1</a> </li>
						<li class="active"> <a href="javascript:void(0)">2</a> </li>
						<li> <a href="javascript:void(0)">3</a> </li>
						<li> <a href="javascript:void(0)">4</a> </li>
						<li> <a href="javascript:void(0)">5</a> </li>
						<li> <a href="javascript:void(0)">6</a> </li>
						<li> <a href="javascript:void(0)">7</a> </li>
						<li> <a href="javascript:void(0)">8</a> </li>
						<li> <a href="javascript:void(0)">9</a> </li>
						<li> <a href="javascript:void(0)">10</a> </li>
						<li class="next"> <a href="javascript:void(0)"> 다음 페이지 </a> </li>
						<li class="last"> <a href="javascript:void(0)"> 마지막 페이지 </a> </li>
					</ul>
				</div>
			</div>
		</div>
	</section>
</div>
</body>
</html>