<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
// ################################################################################
// 페이지 로딩 완료시 실행
// 파라메터 초기화
// ################################################################################

	$(document).ready(function(key, val){
		initSearchParam();
	});
	
// ################################################################################
// 리스트화면에서 검색 관련
// ################################################################################

	$(document).on("keypress", "#cms_keyword", function(e) {
		if(e.keyCode == 13) {	// 엔터
			$("#cms_searchBtn").click();
		}
	});
	
	$(document).on("click", "#cms_searchBtn", function() {
		$("#cms_keyword_current").val($("#cms_keyword").val());
		$("input[name=pageNo]").val("1");
		search();
	});

// ################################################################################
// 리스트에서 선택해서 취하는 액션
// ################################################################################
	/** 전체선택 */
	$(document).on("click", "input[name='check_all']", function() {
		if($("input[name='check_all']").prop("checked")) {
			$("#cms_list2 input:checkbox").prop("checked", true);
		}else {
			$("#cms_list2 input:checkbox").prop("checked", false);
		}
	});
	
	// 체크해제 시, 전체선택 해제
	$(document).on("click", "input[type=checkbox]", function() {
		var chkTotal = $("input[type=checkbox]:not(#check_all)").length;
		var chkCount = $("input[type=checkbox]:checked:not(#check_all)").length;
		
		if(chkTotal == chkCount) {
			$("input[name='check_all']").prop("checked", true);
		}else {
			$("input[name='check_all']").prop("checked", false);
		}
	});
	
	/** 선택된 사진 리스트 읽기 */
	function getCheckedList() {
		var uciCode = new Array();
		
		var container = null;
		if($("#wish_list2").length > 0) {
			container = $("#wish_list2");
		}
		else if($("#cms_list2").length > 0) {
			container = $("#cms_list2");
		}
		
		container.find("input:checkbox:checked").each(function(index) {
			uciCode.push($(this).val());
		});
		return uciCode;
	}
	
	/** 선택 블라인드/해제 */
	function multi_blind(saleState) {
		var uciCode = getCheckedList();
		if(uciCode.length == 0) {
			alert("선택된 사진이 없습니다.");
			return;
		}
		
		var msg = "숨김";
		if(saleState == <%=PhotoDTO.SALE_STATE_OK%>) {
			msg = "숨김해제";
		}
		
		if(!confirm("선택된 사진을 "+msg+"처리 합니다. 진행합니까?\n이미 "+msg+"상태이거나 삭제된 사진은 적용되지 않습니다.")) {
			return;
		}
		
		for(var i=0; i < uciCode.length; i++) {
			changeOption(uciCode[i], "saleState", saleState);
		}
		alert("처리되었습니다");
		search();
	}
	
	/** 선택 삭제 */
	function multi_delete() {
		var uciCode = getCheckedList();
		if(uciCode.length == 0) {
			alert("선택된 사진이 없습니다.");
			return;
		}
		
		if(!confirm("이미지 삭제 후 복구할 수 없습니다.\n삭제합니까?")) {
			return;
		}
		if(uciCode.length > 1) {
			if(!confirm("여러개의 이미지가 선택되었습니다. 정말 삭제하시겠습니까?")) {
				return;
			}
		}
		
		for(var i=0; i < uciCode.length; i++) {
			changeOption(uciCode[i], "saleState", <%=PhotoDTO.SALE_STATE_DEL %>);
		}
		alert("삭제되었습니다");
		search();
	}
	
// ################################################################################
// 리스트 각 항목에 대한 액션
// ################################################################################
	/** 다운로드 버튼 클릭 */
	$(document).on("click", ".btn_down", function() {
		cmsDown($(this).attr("value"));
	});

	/** 블라인드/해제 버튼 클릭 */
	$(document).on("click", ".btn_view", function() {
		var uciCode = $(this).attr("value");
		var saleState;
		if($(this).hasClass("blind")) {
			$(this).removeClass("blind");
			saleState = <%=PhotoDTO.SALE_STATE_OK%>;
		}else {
			$(this).addClass("blind");
			saleState = <%=PhotoDTO.SALE_STATE_STOP%>;
		}
		changeOption(uciCode, "saleState", saleState);
		alert("변경되었습니다");
		search();
	});
	
	/** 삭제버튼 클릭 */
	$(document).on("click", ".btn_del", function() {
		var uciCode = $(this).attr("value");		
		if(!confirm("이미지 삭제 후 복구할 수 없습니다.\n삭제합니까?")) {
			return;
		}
		changeOption(uciCode, "saleState", <%=PhotoDTO.SALE_STATE_DEL %>);
		alert("삭제되었습니다");
		search();
	});
	
	/** 오류 신고내역 팝업 활성화 */
	$(document).on("click", "#popup_open", function() {
		// alert("기능 구현 예정");
		// 개발 이후 아래 주석해제
		errorReportList();
		$("#popup_wrap").css("display", "block"); 
		$(".mask").css("display", "block"); 
	});
	
	/** 오류 신고내역 팝업 닫기 */
	$(document).on("click", ".popup_close", function() {
		$("#popup_wrap").css("display", "none"); 
		$(".mask").css("display", "none"); 
	});
	
	/** 오류 신고하기 내역 보기  */
	function errorReportList(){
		var pageCnt = 0; // 전체 페이지 갯수
		$('#reportListForm :input[name=report_pageVol]').val($('#popup_wrap select[name=reportPageVol]').val());
		$('#reportListForm :input[name=report_status]').val($('#popup_wrap select[name=reportStatus]').val());
		$('#reportListForm :input[name=report_media]').val($('#popup_wrap select[name=reportMedia]').val());
		$.ajax({
			type:'post',
			url:'/list.report.error',
			dataType:'json',
			data:$('#reportListForm').serialize(),
			async: false,
			success:function(data){
				var pageVol = $('#popup_wrap select[name=reportPageVol]').val()*1;
				var dataSize = (data.data).length;
				var total = data.total;
				var pageVol = $('#reportListForm :input[name=report_pageVol]').val()*1;
				var lastPage = 0;
				var pageCycle = 0;
				var page = $('#reportListForm :input[name=report_page]').val()*1;
				pageCnt = parseInt(dataSize/pageVol)+((dataSize%pageVol) > 0 ? 1 : 0); 
				<!-- paging value setting -->
				if(total%pageVol > 0){
					lastPage = parseInt(total/pageVol) + 1;
				}else{
					lastPage = parseInt(total/pageVol);
				}
				pageCycle = parseInt(page/10)+(parseInt(page%10)==0?-1:0);
				<!--  -->
				
				var html = '';
				var statusName = ['','접수','수정완료']; <!-- 0:전체, 1:접수, 2:수정완료 -->
				$('#reportList tbody').empty();
				console.log("empty table"); 
				$.each(data.data, function(index,value){
					console.log("draw");
					html += "<tr onclick=\"$('.cont"+index+"').toggle()\"> \n";
					html += "<td>"+(total-((page-1)*pageVol)-index )+"</td> \n";
					html += "<td>"+value.regDate+"</td> \n";
					html += "<td>"+value.media+"</td> \n";
					html += "<td>"+value.uciCode+"</td> \n";
					html += "<td>"+value.compCode+"</td> \n";
					html += "<td>"+statusName[value.status*1]+"</td> \n";
					html += "</tr> \n";
					html += "<tr> \n";
					html += "<td class=\"error_cont cont"+index+"\" colspan=\"6\" style=\"display:none;\">";
					html += "<p>"+value.reason+"</p>";
				if(value.status*1 == 1){
					html += "<button onclick='reportModifyComplete(\""+value.seq+"\");'>수정완료</button>";
				}
					html += "</td>";
					html += "</tr>";
				})
				$('#reportList tbody').html(html);
				
				<!-- paging -->
				var pagingHtml = '';
				pagingHtml += "<li class=\"first\"> <a href=\"javascript:pageMove('1');\">첫 페이지</a> </li> \n";
				if(page > 1){
					pagingHtml += "<li class=\"prev\"> <a href=\"javascript:pageMove('"+(page-1)+"');\">이전 페이지 </a> </li> \n";
				}
<!-- 				console.log(page + " : " + pageCycle + " : " + lastPage + " : " + pageVol + " : " + dataSize + " : " + total); -->
<!-- 				console.log(pageCycle*10+1 + " : "+(pageCycle*10+10 > lastPage ? lastPage+1 : pageCycle*10+11)); -->
				for(var i = pageCycle*10+1; i < (pageCycle*10+10 > lastPage ? lastPage+1 : pageCycle*10+11); i++){
					pagingHtml += "<li class=\""+(page==i ? 'page active' : '')+"\"> <a href=\"javascript:void(0);\" onclick=\"pageMove('"+i+"');\">"+i+"</a> </li> \n";
				}
				if(page < lastPage){
					pagingHtml += "<li class=\"next\"> <a href=\"javascript:pageMove('"+(page+1)+"');\"> 다음 페이지 </a> </li> \n";
				}

				pagingHtml += "<li class=\"last\"> <a href=\"javascript:pageMove('"+lastPage+"');\"> 마지막 페이지 </a> </li> \n";
						
				$('#pagination-demo').empty();
				$('#pagination-demo').html(pagingHtml);		
				
			},
			error:function(request,error){
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		})
	}
	
	$(document).ready(function(){
		newErrorReport();
	})
	
	/** 오류 신고하기 완료되지 않은 내역 확인  **/
	function newErrorReport(){
		$.ajax({
			type:'post',
			url:'/new.report.error',
			success:function(data){
			console.log("check : "+data);
				if(data > 0){
					$('#popup_open span.new').text('N');
				}else{
					$('#popup_open span.new').text('');
				}
			},
			error:function(request,error){
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		})
	}
	<!-- 오류 신고하기 selectbox 선택시 -->
	$(document).on('change','#popup_wrap select', function(){
		var name = $(this).attr('name');
		if(name == 'reportMedia'){
			$("#reportListForm :input[name=report_media]").val($(this).val());
		}else if(name == 'reportPageVol'){
			$("#reportListForm :input[name=report_pageVol]").val($(this).val());
		}else{
			$("#reportListForm :input[name=report_status]").val($(this).val());
		}
		errorReportList();	
	})
	<!-- 오류 신고하기 수정 완료 -->
	function reportModifyComplete(seq){
		var msg = '정말 수정완료 하시겠습니까?';
		if(confirm(msg)){
			$.ajax({
				type:'post',
				url:'complete.report.error',
				data:{
					"seq":seq
				},
				success:function(){
					alert('수정완료 되었습니다.');
					errorReportList();
					newErrorReport();	
				},
				error:function(request,error){
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			})
		}
	}
	
	function pageMove(page){
		var pageVol = $("#reportListForm :input[name=report_pageVol]").val()*1;
		$("#reportListForm :input[name=report_page]").val(page);
		$("#reportListForm :input[name=report_startPage]").val((page-1)*pageVol);
		errorReportList();	
	}
	
	