<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>

$(document).on("click", ".btn_cal", function() {
	// 기간 : 직접선택
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	var choice = startDate + "~" + endDate;
	$(".choice").attr("value", choice);
	$(this).closest(".filter_list").stop().slideUp("fast");
	
	// 필터 바꾸면 페이지 번호 초기화
	$("input[name=pageNo]").val("1");
	search();
});

$(document).on("click", "div .paging a.prev", function() {
	var prev = $("input[name=pageNo]").val() - 1;
	if(prev != 0) { // 이전 페이지가 있을 경우만
		goPage(prev);
	}
	
});
$(document).on("click", "div .paging a.next", function() {
	var totalPage = parseInt($(".total").text());
	var next = $("input[name=pageNo]").val() - (-1);
	if(next <= totalPage) { // 다음 페이지가 있을 경우만
		goPage(next);
	}	
});

$(document).on("click", "a[name=nextPage]", function() {
	var next = $("input[name=pageNo]").val() - (-1);
	goPage(next);
});

$(document).on("keypress", "#keyword", function(e) {
	if(e.keyCode == 13) {	// 엔터
		//$("#keyword_current").val($("#keyword").val());

		// 키워드 바꾸면 페이지 번호 초기화
		$("input[name=pageNo]").val("1");
		
		search();
	}
});
	
	function isNotEmpty(value) { // 배열 빈값 제외
		return value != "";
	}
	
	
// ################################################################################
// 리스트/뷰 공통
// ################################################################################

	function go_cmsView(uciCode) {
		view_form.uciCode.value = uciCode;
		view_form.submit();
	}

	/** 한건 다운로드 */
	function cmsDown(uciCode) {
		if(!confirm("원본을 다운로드 하시겠습니까?")) {
			return;
		}
		
		$("#downUciCode").val(uciCode);
		$("#downType").val("file");
		$("#downForm").attr("action", "/service.down.photo");
		$("#downForm").submit();
	}

	/** 블라인드/삭제 초상권 변경 */
	function changeOption(uciCode, name, value) {
		var url = "/view.cms" + $("#manage").val();	
		$.ajax({
			type: "POST",
			url: url,
			data: {
				"action" : "updateOne",
				"uciCode" : uciCode,
				"columnName" : name,
				"columnValue" : value
			},
			success: function(data){
				
			}, error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
		});
	}