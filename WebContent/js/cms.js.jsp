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
	
	function isNotEmpty(value) { // 배열 빈값 제외
		return value != "";
	}
	
	
// ################################################################################
// 리스트/뷰 공통
// ################################################################################

	/** 검색에서 넘어온 파라메터로 화면 초기화 */
	function initSearchParam() {
		// 리스트와 상세화면의 키워드폼 이름이 다름
		if($("#cms_keyword").length > 0) {
			$("#cms_keyword").val(view_form.keyword.value);
		}
		if($("#cms_keywordFV").length > 0) {
			$("#cms_keywordFV").val(view_form.keyword.value);
		}
		
		// 필터가 존재할때만
		if($(".filters").length > 0) {
			// 페이징값
			if(view_form.pageNo.value > 1) {
				$(".page").val(view_form.pageNo.value);
			}
			
			// 페이지볼륨
			if(view_form.pageVol.value > 1) {
				var options = $("select[name=pageVol]").find("option");
				for(var i=0; i < options.length; i++) {
					if($(options[i]).attr("value") == view_form.pageVol.value) {
						$(options[i]).attr("selected", "selected");
					}
					else {
						$(options[i]).removeAttr("selected");
					}
				}
			}
			
			setFilter(view_form.media.value, $("li.filter_media"));
			setFilter(view_form.horiVertChoice.value, $("li.filter_horizontal"));
			setFilter(view_form.size.value, $("li.filter_size"));
			setFilter(view_form.saleState.value, $("li.filter_service"));
			//setFilter(view_form.durationReg.value, $("li.filter_durationReg"));
		}
	}

	function setFilter(value, filterForm) {
		var findF = false;
		filterForm.find("li").each(function(index) {
			if($(this).attr("value") == value) {
				findF = true;
			}
		});
	
		if(findF) {
			var itemName = "";
			filterForm.find("li").each(function(index) {
				if($(this).attr("value") == value) {
					$(this).attr("selected", "selected");
					itemName = $(this).text();
				}
				else {
					$(this).removeAttr("selected");
				}
			});
			var titleStr = filterForm.find("span").text();
			var header = titleStr.substring(0, titleStr.indexOf(":")+2);
			filterForm.find("span").text(header + itemName);
		}
	}

	function go_cmsView(uciCode) {
		view_form.uciCode.value = uciCode;
		view_form.submit();
	}

	/** 한건 다운로드 */
	function down(uciCode) {
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