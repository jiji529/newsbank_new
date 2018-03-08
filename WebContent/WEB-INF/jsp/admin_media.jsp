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
<style type="text/css">
	#loading {
	 display: none;
	 width: 100%;   
	 height: 100%;   
	 top: 0px;
	 left: 0px;
	 position: fixed;   
	 display: block;   
	 opacity: 0.7;   
	 background-color: #fff;   
	 z-index: 99;   
	 text-align: center; }  
	 
	#loading-image {   
	 position: absolute;   
	 top: 50%;   
	 left: 50%;   
	 z-index: 100; } 
</style>

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery.twbsPagination.js"></script>

<script>
	$(document).ready(function() {
		//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
		$("[href]").each(function() {
			if (this.href == window.location.href) {
				$(this).parent().addClass("on");
			}
		});		
		
		$("#startgo").val(1); // 최초 1페이지로
		search();
	});
	
	// 팝업창 오픈
	$(document).on("click", ".popup_open", function() {
		$("#popup_wrap").css("display", "block");
		$("#mask").css("display", "block");
	});
	
	// 팝업창 닫기
	$(document).on("click", ".popup_close", function() {
		$("#popup_wrap").css("display", "none");
		$("#mask").css("display", "none");
	});
	
	// 검색 클릭이벤트
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
		$("#loading").show();
		$("#mtBody").empty();
		
		$.ajax({
			type: "POST",
			dataType: "json",
			data: searchParam,
			url: "/listMedia.api",
			success: function(data) { //console.log(data);
				pageCnt = data.pageCnt; // 총 페이지 갯수
				totalCnt = data.totalCnt; // 총 갯수
				
				$(data.result).each(function(key, val) {
					var seq = val.seq;
					var number = totalCnt - ( ($("#startgo").val() - 1) * pageVol + key );
					var id = val.id; // 아이디
					var compName = val.compName; // 매체사명
					var name = val.name; // 이름
					var phone = val.phone; // 휴대폰 번호
					
					if(phone != null && phone.length >= 10) {
						var phone1, phone2, phone3;
						phone1 = phone.substring(0, 3);
						if(phone.length == 11) {
							phone2 = phone.substring(3, 7);
						}else {
							phone2 = phone.substring(3, 6);
						}
						phone3 = phone.substring(phone.length-4, phone.length);
						phone = phone1 + "-" + phone2 + "-" + phone3;
					}
					
					var email = val.email; // 이메일
					var compNum = val.compNum; // 사업자등록번호
					if(compNum != null && compNum.length == 10) {
						var comp1, comp2, comp3;					
						var comp1 = compNum.substring(0, 3);
						var comp2 = compNum.substring(3, 5);
						var comp3 = compNum.substring(compNum.length-5, compNum.length);
						compNum = comp1 + "-" + comp2 + "-" + comp3;	
					}else {
						compNum = "-";
					}
					
					var preRate = val.preRate; // 온라인 요율
					var postRate = val.postRate; // 오프라인 요율
					var totalRate;
					// 온/오프라인 요율
					if(preRate != null && postRate != null) {
						totalRate = "온라인<br/>" + preRate + "%<br/> 오프라인<br/>" + postRate + "%";	
					}else {
						preRate = (preRate == null) ? "" : preRate;
						postRate = (postRate == null) ? "" : postRate;
						totalRate = "온라인<br/>" + preRate + " - <br/> 오프라인<br/>" + postRate + "-";
					}
					var contentCnt = (val.contentCnt).split("|");
					var blind = contentCnt[0]; // 블라인드 수량
					var total = contentCnt[1]; // 전체 수량
					var contentCnt = blind + " / " + total; // 콘텐츠 수량 (블라인드/전체)
					//var contentCnt = "-";					
					var service = "활성"; // 서비스 상태
					var calc = "정산"; // 정산 상태
					var masterID = val.masterID;
					if(masterID != null) {
						calc = "피정산<br/>" + "(" + masterID + ")";								
					}					
					
					//html += '<tr>';
					html += '<tr onclick="go_mediaView(\'' + seq + '\')">';
					html += '<td onclick="event.cancelBubble = true"><div class="tb_check">';
					html += '<input id="check' + key + '" name="check' + key + '" type="checkbox" value="' + val.seq + '">';
					html += '<label for="check' + key + '">선택</label>';
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
					html += '<td><span class="popup_open"><a href="#none" class="table_btn">' + service + '</a></span></td>';
					html += '<td>' + calc + '</td>';
					html += '<td><div class="file_edit"><a href="#" class="table_btn">수정<input type="file" /></a></div></td>';
					html += '</tr>';
					
				});
				$(html).appendTo("#mtBody");
			},
			complete: function() {
				$("#loading").hide();
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
		$("#loading").show();
		$("#mtBody").empty();	
				
		$.ajax({
			type: "POST",
			dataType: "json",
			data: searchParam,
			url: "/listMedia.api",
			success: function(data) { //console.log(data);
				pageCnt = data.pageCnt; // 총 페이지 갯수
				totalCnt = data.totalCnt; // 총 갯수
				
				$(data.result).each(function(key, val) {
					var seq = val.seq;
					var number = totalCnt - ( ($("#startgo").val() - 1) * pageVol + key );
					var id = val.id; // 아이디
					var compName = val.compName; // 매체사명
					var name = val.name; // 이름
					var phone = val.phone; // 휴대폰 번호
					
					if(phone != null && phone.length >= 10) {
						var phone1, phone2, phone3;
						phone1 = phone.substring(0, 3);
						if(phone.length == 11) {
							phone2 = phone.substring(3, 7);
						}else {
							phone2 = phone.substring(3, 6);
						}
						phone3 = phone.substring(phone.length-4, phone.length);
						phone = phone1 + "-" + phone2 + "-" + phone3;
					}
					
					var email = val.email; // 이메일
					var compNum = val.compNum; // 사업자등록번호
					if(compNum != null && compNum.length == 10) {
						var comp1, comp2, comp3;					
						var comp1 = compNum.substring(0, 3);
						var comp2 = compNum.substring(3, 5);
						var comp3 = compNum.substring(compNum.length-5, compNum.length);
						compNum = comp1 + "-" + comp2 + "-" + comp3;	
					}else {
						compNum = "-";
					}
					
					var preRate = val.preRate; // 온라인 요율
					var postRate = val.postRate; // 오프라인 요율
					var totalRate;
					// 온/오프라인 요율
					if(preRate != null && postRate != null) {
						totalRate = "온라인<br/>" + preRate + "%<br/> 오프라인<br/>" + postRate + "%";	
					}else {
						preRate = (preRate == null) ? "" : preRate;
						postRate = (postRate == null) ? "" : postRate;
						totalRate = "온라인<br/>" + preRate + " - <br/> 오프라인<br/>" + postRate + "-";
					}
					var contentCnt = (val.contentCnt).split("|");
					var blind = contentCnt[0]; // 블라인드 수량
					var total = contentCnt[1]; // 전체 수량
					var contentCnt = blind + " / " + total; // 콘텐츠 수량 (블라인드/전체)
					//var contentCnt = "-";					
					var service = "활성"; // 서비스 상태
					var calc = "정산"; // 정산 상태
					var masterID = val.masterID;
					if(masterID != null) {
						calc = "피정산<br/>" + "(" + masterID + ")";								
					}					
					
					//html += '<tr>';
					html += '<tr onclick="go_mediaView(\'' + seq + '\')">';
					html += '<td onclick="event.cancelBubble = true"><div class="tb_check">';
					html += '<input id="check' + key + '" name="check' + key + '" type="checkbox" value="' + val.seq + '">';
					html += '<label for="check' + key + '">선택</label>';
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
					html += '<td><span class="popup_open"><a href="#none" class="table_btn">' + service + '</a></span></td>';
					html += '<td>' + calc + '</td>';
					html += '<td><div class="file_edit"><a href="#" class="table_btn">수정<input type="file" /></a></div></td>';
					html += '</tr>';
					
				});
				$(html).appendTo("#mtBody");
			},
			complete: function() {			
				pagings(pageCnt);		
				$("#loading").hide();
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
	
	// 콘텐츠 수량(블라인드 / 전체 갯수)
	function countContents(member_seq) {
				
		$.ajax({
			type: "POST",
			async: false,
			dataType: "json",
			data: searchParam,
			url: "search",
			success: function(data) {
				//console.log(data);
			}
		});
	}
	
	function go_mediaView(member_seq) {
		$("#member_seq").val(member_seq);
		view_media_manage.submit();
	}
	
	// 정산 매체사 - 선택 승인
	function check_approve() {
		var chk_total = $("#mtBody input:checkbox:checked").length;
		//var arr_seq = new Array();
		
		if(chk_total == 0) { // 선택항목 갯수 체크
			alert("최소 1개 이상을 선택해주세요.");
		} else {
			$("#mtBody input:checkbox:checked").each(function(index) {
				var seq = $(this).val();
				//arr_seq.push(seq);
				
				if(confirm("선택한 항목을 승인하시겠습니까?")) {
					$.ajax({
						type: "POST",
						url: "/admin.member.api",
						data : ({
							cmd : 'U',
							seq : seq,
							admission : 'Y',
							type : 'M'
						}),
						dataType : "json",
						success : function(data) {
							if (data.success) {
								console.log(index + "번째 승인 처리 완료");
							} else {
														
							}
						}
					});	
				}
			});	
			alert("선택 승인 완료");
			location.href = "/media.manage";
		}		
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
					<a href="/add.media.manage" style="margin-left:0;">정산 매체사 추가</a>
					<a href="javascript:void(0)" onclick="check_approve()">선택 승인</a>
					</div>
				<div class="ad_result_btn_area fr">
					<select id="sel_pageVol" onchange="search()">
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
							<th>회사/기관명</th>
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

<p class="alert"><b>뉴시스</b>의 서비스 상태를 변경하시겠습니까?<br /><br />비활성화 시 뉴스뱅크 사이트에서 <br />서비스 매체 노출, 사진 검색, 구매가 모두 제한됩니다.</p>

					</div>
					<div class="pop_foot">
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
		<div id="loading"><img id="loading-image" src="/images/ajax-loader.gif" alt="loading" /></div>
	</section>
	<form method="post" action="/view.media.manage" name="view_media_manage" >
		<input type="hidden" name="member_seq" id="member_seq"/>
	</form>
</div>
</body>
</html>