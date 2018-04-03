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
	goPage(prev);
});
$(document).on("click", "div .paging a.next", function() {
	var next = $("input[name=pageNo]").val() - (-1);
	goPage(next);
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

$(document).on("keypress", "#cms_keyword", function(e) {
	if(e.keyCode == 13) {	// 엔터
		//$("#keyword_current").val($("#keyword").val());

		// 키워드 바꾸면 페이지 번호 초기화
		$("input[name=pageNo]").val("1");
		cms_search();
	}
});

$(document).on("click", "#cms_searchBtn", function() {
	$("input[name=pageNo]").val("1");
	cms_search();
});

function checkNumber(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) 
		|| (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 16 || keyID == 35 || keyID == 36)		
	)
	{
		return;
	}
	else if(keyID == 13) {
		cms_search();
	}
	else
	{
		return false;
	}
}

function goPage(pageNo) {
	if(pageNo < 1) {
		pageNo = 1;
	}
	else if(pageNo > $("div .paging span.total").html()) {
		pageNo = $("div .paging span.total").html();
	}
	$("input[name=pageNo]").val(pageNo);
	cms_search();
}

$(document).on("click", ".filter_list li", function() {
	var choice = $(this).text();
	$(this).siblings().removeAttr("selected");
	$(this).attr("selected", "selected");
	
	if(!$(this).hasClass("choice")){			
		var filter_list = "<ul class=\"filter_list\">" + $(this).parents(".filter_list").html() + "</ul>";
		var titleTag = $(this).parents(".filter_title").find("span");
		var titleStr = titleTag.html();
		titleStr = titleStr.substring(0, titleStr.indexOf(":")) + ": " + choice;
		titleTag.html(titleStr);
		
		$(this).closest(".filter_list").stop().slideUp("fast");		
		
		// 필터 바꾸면 페이지 번호 초기화
		$("input[name=pageNo]").val("1");
		cms_search();
	}else {
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		var choice = startDate + "~" + endDate;
		var duration = $(".filter_duration").text();
	}
	
});



function go_cmsView(uciCode) {
	$("#uciCode").val(uciCode);
	view_form.submit();
}

// #사진관리 삭제
$(document).on("click", ".btn_del", function() {
	var uciCode = $(this).attr("value");		
	var param = "action=deletePhoto";
	
	$.ajax({
		url: "/cms?"+param,
		type: "POST",
		data: {
			"uciCode" : uciCode
		},
		success: function(data) {					
			
		},
		error : function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}
	});
});



	/** 전체선택 */
	$(document).on("click", "input[name='check_all']", function() {
		if($("input[name='check_all']").prop("checked")) {
			$("#cms_list2 input:checkbox").prop("checked", true);
		}else {
			$("#cms_list2 input:checkbox").prop("checked", false);
		}
	});

	// 상세화면 블라인드 변경
	$(document).on("change", "input[type=radio][name=blind]", function() {
		var saleState = $('input[type=radio][name=blind]:checked').val();
		changeOption("${photoDTO.uciCode}", "saleState", saleState);
	});
	// 상세화면 초상권 변경
	$(document).on("change", "input[type=radio][name=likeness]", function() {
		var portraitRightState = $('input[type=radio][name=likeness]:checked').val();
		changeOption("${photoDTO.uciCode}", "portraitRightState", portraitRightState);
	});

	/** 리스트화면 블라인드/해제 버튼 클릭 */
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
	});
	
	/** 선택 블라인드 */
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
		cms_search();
	}
	
	/** 블라인드/삭제 초상권 변경 */
	function changeOption(uciCode, name, value) {	
		$.ajax({
			type: "POST",
			url: "/view.cms?action=updateOne",
			data: {
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
			$.ajax({
				url: "/view.cms",
				type: "POST",
				data: {
					"action" : "deletePhoto"
					,"uciCode" : uciCode[i]
				},
				success: function(data) {					
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		}
		alert("삭제되었습니다");
		cms_search();
	}
	
	// 태그삭제
	$(document).on("click", ".tag_remove", function() {
		$(this).parent().remove();
		var uciCode = "${photoDTO.uciCode}";
		var tagName = $(this).parent().text().replace("×", "");
		
		deleteTag(uciCode, tagName)
	});

	function deleteTag(uciCode, tagName) {
		$.ajax({
			type: "POST",
			url: "/view.cms?action=deleteTag",
			data: {
				"uciCode" : uciCode,
				"tagName" : tagName
			},
			dataType: "text",
			success: function(data){
				
			}, error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
			
		});
	}
	
	// 태그 입력
	$(document).on("click", ".add_tag > button", function() {
		var uciCode = "${photoDTO.uciCode}";
		var tagName = $(this).prev().val();
		
		var tag_list = $(".tag_list").children().text(); 
		tag_list = tag_list.split("×");
		tag_list = tag_list.filter(isNotEmpty);		
		
		if(tag_list.indexOf(tagName) != -1) {
			alert("이미 존재하는 태그입니다.");
		}else {
			var html = "<li class=\"tag_self\"><span class=\"tag_remove\">×</span>"+tagName+"</li>";
			$(html).appendTo(".tag_list");
			$(this).prev().val("");
			
			insertTag(uciCode, tagName);
		}
	});
	
	function insertTag(uciCode, tagName) {
		$.ajax({
			type: "POST",
			url: "/view.cms?action=insertTag",
			data: {
				"uciCode" : uciCode,
				"tagName" : tagName
			},
			dataType: "text",
			success: function(data){
				
			}, error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
			
		});
	}