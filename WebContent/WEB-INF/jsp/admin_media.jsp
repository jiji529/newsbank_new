<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2017. 12. 29. 오후 14:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 12. 29.   LEE GWANGHO    media.manage
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
<title>뉴스뱅크관리자</title>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery.twbsPagination.js"></script>

<script>
	$(document).ready(function() {
		$("#popup_open").click(function() {
			$("#popup_wrap").css("display", "block");
			$("#mask").css("display", "block");
		});
		$(".popup_close").click(function() {
			$("#popup_wrap").css("display", "none");
			$("#mask").css("display", "none");
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
	
	/** 전체선택 */
	$(document).on("click", "input[name='check_all']", function() {
		if($("input[name='check_all']").prop("checked")) {
			$("#mtBody input:checkbox").prop("checked", true);
		}else {
			$("#mtBody input:checkbox").prop("checked", false);
		}
	});
	
	// 페이징 번호 클릭
	$(document).on("click",".page",function() {
		var pages = $(this).text();
		if(pages == "") pages = 1;
		$("#startgo").val(pages);
		
		listJson();
	});

	// 첫번쨰 페이지
	$(document).on("click",".first",function() {
		var pages = "1";
		$("#startgo").val(pages);
		
		listJson();
	});

	// 마지막 페이지
	$(document).on("click",".last",function() {
		var pages = $("#lastvalue").val();
		$("#startgo").val(pages);
		
		listJson();
	});

	// 이전 페이지
	$(document).on("click",".prev",function() {
		var pages = $("#pagination-demo .page.active").text();
		$("#startgo").val(pages);
		
		listJson();
	});

	// 다음 페이지
	$(document).on("click",".next",function() {
		var pages = $("#pagination-demo .page.active").text();
		$("#startgo").val(pages);
		
		listJson();
	});
	
	function listJson() {
		var keyword = $("#keyword").val(); keyword = $.trim(keyword); // 아이디/이름/회사명
		var pageVol = $("#sel_pageVol option:selected").attr("value"); // 페이지 표시 갯수
		var startPage = ($("#startgo").val()-1) * pageVol; // 시작 페이지
		var pageCnt = 0; // 전체 페이지 갯수
		var totalCnt = 0; // 전체 갯수
		
		var searchParam = {
			"keyword":keyword
			, "pageVol":pageVol
			, "startPage":startPage
		};
		
		var html = "";
		$("#mtBody").empty();
		
		$.ajax({
			type: "POST",
			dataType: "json",
			data: searchParam,
			url: "/listMedia.api",
			success: function(data) { console.log(data);
				pageCnt = data.pageCnt; // 총 페이지 갯수
				totalCnt = data.totalCnt; // 총 갯수
				
				$(data.result).each(function(key, val) {
					var number = totalCnt - ( ($("#startgo").val() - 1) * pageVol + key );
					var id = val.id; // 아이디
					var compName = val.compName; // 매체사명
					var name = val.name; // 이름
					var phone = val.phone; // 휴대폰 번호
					var email = val.email; // 이메일
					var compNum = val.compNum; // 사업자등록번호
					var preRate = val.preRate; // 온라인 요율
					var postRate = val.postRate; // 오프라인 요율
					var totalRate = preRate + " | " + postRate;
					var contentCnt = "1 / 100"; // 콘텐츠 수량
					var service = "활성"; // 서비스 상태
					var calc = "정산"; // 정산 상태
					
					html += '<tr onclick="#">';
					html += '<td><div class="tb_check">';
					html += '<input id="check1" name="check1" type="checkbox">';
					html += '<label for="check1">선택</label>';
					html += '</div></td>';
					html += '<td>' + number + '</td>';
					html += '<td>' + id + '</td>';
					html += '<td>' + compName + '</td>';					
					html += '<td>' + name + '</td>';
					html += '<td>' + phone + '</td>';
					html += '<td>' + email + '</td>';
					html += '<td>' + compNum + '</td>';
					html += '<td>' + totalRate + '</td>';
					html += '<td>' + contentCnt + '</td>';
					html += '<td>' + service + '</td>';
					html += '<td>' + calc + '</td>';
					html += '<td><input type="file" /><a href="#">수정</a></td>';
					html += '</tr>';
					
				});
				$(html).appendTo("#mtBody");
			}
		});
	}
	
	function search() {
		var keyword = $("#keyword").val(); keyword = $.trim(keyword); // 아이디/이름/회사명
		var pageVol = $("#sel_pageVol option:selected").attr("value"); // 페이지 표시 갯수
		var startPage = ($("#startgo").val()-1) * pageVol; // 시작 페이지
		var pageCnt = 0; // 전체 페이지 갯수
		var totalCnt = 0; // 전체 갯수
		
		var searchParam = {
			"keyword":keyword
			, "pageVol":pageVol
			, "startPage":startPage
		};
		
		var html = "";
		$("#mtBody").empty();
		
		$.ajax({
			type: "POST",
			dataType: "json",
			data: searchParam,
			url: "/listMedia.api",
			success: function(data) { console.log(data);
				pageCnt = data.pageCnt; // 총 페이지 갯수
				totalCnt = data.totalCnt; // 총 갯수
				
				$(data.result).each(function(key, val) {
					var number = totalCnt - ( ($("#startgo").val() - 1) * pageVol + key );
					var id = val.id; // 아이디
					var compName = val.compName; // 매체사명
					var name = val.name; // 이름
					var phone = val.phone; // 휴대폰 번호
					var email = val.email; // 이메일
					var compNum = val.compNum; // 사업자등록번호
					var preRate = val.preRate; // 온라인 요율
					var postRate = val.postRate; // 오프라인 요율
					var totalRate = preRate + " | " + postRate;
					var contentCnt = "1 / 100"; // 콘텐츠 수량
					var service = "활성"; // 서비스 상태
					var calc = "정산"; // 정산 상태
					
					html += '<tr onclick="#">';
					html += '<td><div class="tb_check">';
					html += '<input id="check1" name="check1" type="checkbox">';
					html += '<label for="check1">선택</label>';
					html += '</div></td>';
					html += '<td>' + number + '</td>';
					html += '<td>' + id + '</td>';
					html += '<td>' + compName + '</td>';					
					html += '<td>' + name + '</td>';
					html += '<td>' + phone + '</td>';
					html += '<td>' + email + '</td>';
					html += '<td>' + compNum + '</td>';
					html += '<td>' + totalRate + '</td>';
					html += '<td>' + contentCnt + '</td>';
					html += '<td>' + service + '</td>';
					html += '<td>' + calc + '</td>';
					html += '<td><input type="file" /><a href="#">수정</a></td>';
					html += '</tr>';
					
				});
				$(html).appendTo("#mtBody");
			},
			complete: function() {			
				pagings(pageCnt);		
			}
		});
		
	}
	
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
</script>
</head>

<body>
<div class="wrap admin">
	<%@include file="header_admin.jsp" %>
	<section class="wide">
		<%@include file="sidebar.jsp" %>
		
		<div class="mypage">
			<div class="table_head">
				<h3>정산 매체사 관리</h3>
			</div>
			<div class="ad_sch_area">
				<table class="tb01" cellpadding="0" cellspacing="0">
					<colgroup>
					<col style="width:240px;">
					<col style="width:;">
					</colgroup>
					<tbody>
						<tr>
							<th>아이디/이름/회사명</th>
							<td><input type="text" class="inp_txt" id="keyword" size="50" /></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_area" style="margin-top:0;"><a href="#" class="btn_input2">검색</a></div>
			</div>
			<div class="ad_result">
				<div class="ad_result_btn_area">
					<a href="admin3-2.html" style="margin-left:0;">정산 매체사 추가</a>
					<a href="#">선택 승인</a>
					</div>
				<div class="ad_result_btn_area fr">
					<select id="sel_pageVol">
						<option value="20">20개</option>
						<option value="50">50개</option>
						<option value="100">100개</option>
					</select>
					<a href="#">엑셀저장</a></div>
				<table cellpadding="0" cellspacing="0" class="tb04">
					<colgroup>
					<col width="30" />
					<col width="30" />
					<col width="100" />
					<col width="100"  />
					<col width="80" />
					<col width="130" />
					<col/>
					<col width="120" />
					<col width="100" />
					<col width="120" />
					<col width="80" />
					<col width="100" />
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
							<th>매체사명</th>
							<th>이름</th>
							<th>휴대폰번호</th>
							<th>이메일</th>
							<th>사업자등록번호</th>
							<th>정산요율</th>
							<th>콘텐츠 수량</th>
							<th>서비스 상태</th>
							<th>정산</th>
							<th>제호</th>
						</tr>
					</thead>
					<tbody id="mtBody">
						
					</tbody>
				</table>
				<div id="popup_wrap">
					<div class="pop_tit">
						<h2>서비스 설정</h2>
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
							<button onclick="location.href='#'";>활성화</button>
							<button class="popup_close">비활성화</button>
						</div>
					</div>
				</div>
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
</div>
</body>
</html>