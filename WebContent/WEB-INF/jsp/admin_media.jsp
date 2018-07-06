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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
	
	//확장자 검사(admin.js와 중복 - 목록을 ajax 후처리로 불러와서 중복으로 추가)
	function validFileType(file) {
		var fileTypes = [ 'image/jpeg', 'image/pjpeg', 'image/png', 'application/pdf'

			];
		
		for (var i = 0; i < fileTypes.length; i++) {
			if (file.type === fileTypes[i]) {
				return true;
			}
		}

		return false;
	}
	
	// 파일 업로드 (admin.js와 중복 - 목록을 ajax 후처리로 불러와서 중복으로 추가)
	$(document).on("change", 'input[type=file]', function() {
		var page = (location.pathname).split(".")[0];
		var seq = $(this).parents("tr").find("input[type=checkbox]").val();
		
		var uType = $(this).attr("name");	
		var tmpFile = $(this)[0].files[0];
		var sizeLimit = 1024 * 1024 * 15;
		if (tmpFile.size > sizeLimit) {
			alert("파일 용량이 15MB를 초과했습니다");
			$(this).val("");
			return;
		}

		if (validFileType(tmpFile)) {
			var formData = new FormData();
			//첫번째 파일태그
			formData.append("uploadFile", tmpFile);
			formData.append("seq", seq); // 회원현황, 정산매체사(member_seq) / 공지사항(notice_seq)
			formData.append("page", page); // 접근페이지: 회원현황(member), 정산매체사(media), 공지사항(board)

			$.ajax({
				url : '/'+uType+'.upload',
				data : formData,
				dataType : "json",
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					console.log(data);
					if (data.success) {
						alert(data.message);
					} else {
						alert(data.message);
					}
					location.reload();
				},
				error : function(data) {
					console.log("Error: " + data.statusText);
					alert("잘못된 접근입니다.");
				},

			});

		} else {
			alert("파일 형식이 올바르지 않습니다.");
			$(this).val("");
		}
	});
	
	// 행 클릭
	$(document).on("click", ".row", function(e) {
		var clickTarget = $(e.target);
		
		if(clickTarget.is('td')){ // td 태그 클릭했을 때만 상세페이지 이동
			var seq = $(this).find("input:checkbox:first").val();
			go_mediaView(seq); // 상세 페이지 이동
		}
	});
	
	// 팝업창 오픈
	$(document).on("click", ".popup_open", function() {
		var seq = $(this).closest("tr").find("input:checkbox:first").val();
		var compName = $(this).closest("tr").find("td:eq(3)").text();
		$("#member_seq").val(seq);
		$("#popup_wrap").find("b").text(compName);
		
		$("#popup_wrap").css("display", "block");
		$("#mask").css("display", "block");
	});
	
	// 팝업창 닫기
	$(document).on("click", ".popup_close", function() {
		$("#member_seq").val("");
		$("#popup_wrap").css("display", "none");
		$("#mask").css("display", "none");
	});
	
	function activate() { // 매체 활성화
		var member_seq = $("#member_seq").val();
		
		var param = {
			"cmd" : "U",
			"type" : "M",
			"seq" : member_seq,
			"activate" : 1		
		};
		
		$.ajax({
			type: "POST",
			dataType: "json",
			data: param,
			url: "/admin.member.api",
			success: function(data) {
				var result = data.success;
				
			},
			complete: function() {
				$("#popup_wrap").css("display", "none");
				$("#mask").css("display", "none");
				location.reload();
			}
		});
	}
	
	function deactivate() { // 매체 비활성화
		var member_seq = $("#member_seq").val();
		
		var param = {
			"cmd" : "U",
			"type" : "M",
			"seq" : member_seq,
			"activate" : 2		
		};
		
		$.ajax({
			type: "POST",
			dataType: "json",
			data: param,
			url: "/admin.member.api",
			success: function(data) {
				var result = data.success;
			},
			complete: function() {
				location.reload();
			}
		});
	}
	
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
	
	// 제호 (추가/수정) 버튼 클릭시
	$(document).on("click", ".logo", function() {
		var seq = $(this).closest("tr").find("[type=checkbox]").val();
		$("input[name='seq']").val(seq);
	});
	
	function reset_page() { // 시작 페이지 초기화
		$("#startgo").val(1);
	}
	
	function search(state) {
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
			success: function(data) { console.log(data);
				pageCnt = data.pageCnt; // 총 페이지 갯수
				totalCnt = data.totalCnt; // 총 갯수
				
				$(data.result).each(function(key, val) {
					var seq = val.seq;
					var number = totalCnt - ( ($("#startgo").val() - 1) * pageVol + key );
					var id = val.id; // 아이디
					var compName = val.compName; // 매체사명
					var name = val.name; // 이름
					var phone = val.phone; // 휴대폰 번호
					var activate = val.activate; // 1: 노출, 2: 비노출
					
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
						totalRate = "온라인" + preRate + "%<br/> 오프라인" + postRate + "%";	
					}else {
						preRate = (preRate == null) ? "" : preRate;
						postRate = (postRate == null) ? "" : postRate;
						totalRate = "온라인" + preRate + " - <br/> 오프라인" + postRate + "-";
					}
					var contentCnt = (val.contentCnt).split("|");
					var blind = contentCnt[0]; // 블라인드 수량
					var total = contentCnt[1]; // 전체 수량
					var contentCnt = comma(blind) + " / " + comma(total); // 콘텐츠 수량 (블라인드/전체)
					//var contentCnt = "-";					
					var service = ""; // 서비스 상태
					if(activate == 1){ service = "활성"; } else if(activate == 2){ service = "비활성"; }
					var calc = "정산"; // 정산 상태
					var masterID = val.masterID;
					if(masterID != null) {
						calc = "피정산<br/>" + "(" + masterID + ")";								
					}					
					var logo = val.logo; // 로고 파일경로
					
					html += '<tr class="row">';
					//html += '<tr onclick="go_mediaView(\'' + seq + '\')">';
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
					
					if(logo) {
						// 제호가 있을 떄
						html += '<td><span class="popup_open"><a href="#none" class="table_btn">' + service + '</a></span></td>';
					}else {
						// 없을 때는 버튼 보여주지 않기
						html += '<td><span>제호 업로드</td>';
					}
					html += '<td>' + calc + '</td>';
					
					if(logo) {
						html += '<td><a class="file" href="/logo.down.photo?seq=' + seq + '" download="" target="_blank">제호있으면 다운</a><div class="file_edit"><a href="#" class="table_btn">수정<input type="file" name="logo" class="logo" accept="application/pdf, image/*" required /></a></div></td>';
					}else {
						html += '<td><div class="upload-btn-wrapper file_edit"><a href="#" class="table_btn btn_input1">추가</a><input type="file" name="logo" class="logo" accept="application/pdf, image/*" required /></div></td>';						
					}
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
	
	// 정산 매체사 - 선택 활성화
	function check_approve() {
		var chk_total = $("#mtBody input:checkbox:checked").length;
		var chk_logo = $("input:checkbox:checked").map(function() {
			return $(this).closest("tr").find("td").eq(12).text();
			//return this.value;
		}).get();
		console.log(chk_logo);
		
		
		
		if(chk_total == 0) { // 선택항목 갯수 체크
			alert("최소 1개 이상을 선택해주세요.");
		}else if($.inArray("추가", chk_logo) != -1) {
			alert("제호(로고)파일이 업로드 되어 있어야 서비스 사이트에 정상 적용됩니다.\n제호(로고) 파일을 업로드 해주세요.");
		}else {
			
			if(confirm("언론사의 서비스 상태를 활성으로 변경하시겠습니까?\n 서비스 상태가 활성이면 뉴스뱅크 서비스 사이트에서 사진 노출 및 검색, 구매가 가능합니다.")) {
				
				$("#mtBody input:checkbox:checked").each(function(index) {
					var seq = $(this).val();
					
					var param = {
						cmd : 'U',
						seq : seq,
						admission : 'Y',
						type : 'M'
					};
					
					$.ajax({
						type: "POST",
						url: "/admin.member.api",
						data: param,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								console.log(index + "번째 승인 처리 완료");
							} else {
														
							}
						}
					});
				});
				alert("선택 활성화 완료");
				location.href = "/media.manage";
			}
		}		
	}
</script>
<script src="js/admin.js?v=20180415"></script>
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
					<a href="javascript:void(0)" onclick="check_approve()">선택 활성화</a>
					</div>
				<div class="ad_result_btn_area fr">
					<select id="sel_pageVol" onchange="reset_page(); search();">
						<option value="20">20개</option>
						<option value="50">50개</option>
						<option value="100">100개</option>
					</select>
					<a href="javascript:void(0)" onclick="saveExcel('/excel.listMedia.api', 'member')">엑셀저장</a></div>
				<table cellpadding="0" cellspacing="0" class="tb04" id="excelTable">
					<colgroup>
					<col width="30" />
					<col width="50" />
					<col width="100" />
					<col width="130"  />
					<col width="80" />
					<col width="130" />
					<col/>
					<col width="120" />
					<col width="150" />
					<col width="120" />
					<col width="100" />
					<col width="100" />
					<col width="130" />
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
							<th>콘텐츠 수량<br/>(블라인드/전체)</th>
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

<p class="alert"><b>회사/기관명</b>의 서비스 상태를 변경하시겠습니까?<br /><br />비활성화 시 뉴스뱅크 사이트에서 <br />서비스 매체 노출, 사진 검색, 구매가 모두 제한됩니다.</p>

					</div>
					<div class="pop_foot">
						<div class="pop_btn">
							<button onclick="activate()">활성화</button>
							<button onclick="deactivate()" class="popup_close">비활성화</button>
						</div>
					</div>
				</div>
				
				<div id="mask"></div>
				<input type="hidden" id="totcnt" value="" />
				<input type="hidden" id="startgo" value="" />
				<input type="hidden" id="lastvalue" value="" />
				<input type="hidden" name="seq" value="" /> <!-- 제호 업로드 시 선택한 회원 고유번호 값 전달용도 -->
				<div class="pagination">
					<ul id="pagination-demo" class="pagination-sm">
					</ul>
				</div>
			</div>
		</div>
		<div id="loading"><img id="loading-image" src="/images/ajax-loader.gif" alt="loading" /></div>
	</section>
	
	<form class="excel_form" method="post" action="/excelDown.api" name="excel_form" >
		<input type="hidden" id="excelHtml" name="excelHtml" />
	</form>
	
	<form method="post" action="/view.media.manage" name="view_media_manage" >
		<input type="hidden" name="member_seq" id="member_seq"/>
	</form>
	
	<form id="downForm" method="post"  target="downFrame">
		<input type="hidden" id="currentKeyword" name="keyword" />
		<input type="hidden" id="pageVol" name="pageVol" />
		<input type="hidden" id="startPage" name="startPage" value="file" />
	</form>
	<iframe id="downFrame" name="downFrame" style="display:none"></iframe>
	
</div>
</body>
</html>