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
		var choice = $(this).text();
		$(this).attr("selected", "selected");
		$(this).siblings().removeAttr("selected");
		var filter_list = "<ul class=\"filter_list\">"+$(this).parents(".filter_list").html()+"</ul>";
		$(this).parents(".filter_title").children().remove().end().html(choice+filter_list);
		
		// 필터 바꾸면 페이지 번호 초기화
		$("input[name=pageNo]").val("1");
		cms_search();
	}else {
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		var choice = startDate + "~" + endDate;
		var duration = $(".filter_duration").text();
		//console.log(duration);
		/* var titleTag = $(this).parents(".filter_title").find("span");
		var titleStr = titleTag.html();
		console.log(titleStr);
		titleStr = titleStr.substring(0, titleStr.indexOf(":")) + ": " + choice;
		titleTag.html(titleStr); */
	}
	
});

function search() {
	var keyword = $("#keyword").val();
	
	var pageNo = $("input[name=pageNo]").val();
	var transPageNo = pageNo.match(/[0-9]/g).join("");
	if(pageNo != transPageNo) {
		pageNo = transPageNo;
		$("input[name=pageNo]").val(pageNo);
	}
	
	var pageVol = $("select[name=pageVol]").val();
	var media = $(".filter_media .filter_list").find("[selected=selected]").attr("value");
	var duration = $(".filter_duration .filter_list").find("[selected=selected]").attr("value");
	var colorMode = $(".filter_color .filter_list").find("[selected=selected]").attr("value");
	var horiVertChoice = $(".filter_horizontal .filter_list").find("[selected=selected]").attr("value");
	var size = $(".filter_size .filter_list").find("[selected=selected]").attr("value");
	
	var searchParam = {
			"keyword":keyword
			, "pageNo":pageNo
			, "pageVol":pageVol
			, "media":media
			, "duration":duration
			, "colorMode":colorMode
			, "horiVertChoice":horiVertChoice
			, "size":size
			//, "id":id
	};
	
	$("#keyword").val(keyword);
	
	var html = "";
	$.ajax({
		type: "POST",
		async: false,
		dataType: "json",
		data: searchParam,
		timeout: 1000000,
		url: "cms.search",
		success : function(data) { console.log(data);
			$("#cms_list2 ul").empty();
			$(data.result).each(function(key, val) {	
				var blind = (val.saleState == 2 || val.saleState == 3) ? "blind" : "";
				html += '<li class="thumb"> <a href="#" onclick="go_cmsView(\'' + val.uciCode + '\')"><img src="<%= IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>"></a>';
				html += '<div class="thumb_info"><input type="checkbox" /><span>' + val.uciCode + '</span><span>' + val.copyright + '</span></div>';
				html += '<ul class="thumb_btn"><li class="btn_down"><a href="<%= IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '" download>다운로드</a></li> <li class="btn_del" value="' + val.uciCode + '"><a>삭제</a></li> <li class="btn_view "' + blind + ' value="' + val.uciCode + '"><a>블라인드</a></li> </ul>';
			});
			$("#cms_list2 ul").html(html);
			var totalCount = $(data.count)[0];
			var totalPage = $(data.totalPage)[0];
			$("div .result b").html(totalCount);
			$("div .paging span.total").html(totalPage);
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}
	});
}

function cms_search() {
	var keyword = $("#cms_keyword").val();
	
	var pageNo = $("input[name=pageNo]").val();
	var transPageNo = pageNo.match(/[0-9]/g).join("");
	if(pageNo != transPageNo) {
		pageNo = transPageNo;
		$("input[name=pageNo]").val(pageNo);
	}
	
	var pageVol = $("select[name=pageVol]").val();
	var media = $(".filter_media .filter_list").find("[selected=selected]").attr("value");
	var duration = $(".filter_duration .filter_list").find("[selected=selected]").attr("value");
	var colorMode = $(".filter_color .filter_list").find("[selected=selected]").attr("value");
	var horiVertChoice = $(".filter_horizontal .filter_list").find("[selected=selected]").attr("value");
	var size = $(".filter_size .filter_list").find("[selected=selected]").attr("value");
	
	var searchParam = {
			"keyword":keyword
			, "pageNo":pageNo
			, "pageVol":pageVol
			, "media":media
			, "duration":duration
			, "colorMode":colorMode
			, "horiVertChoice":horiVertChoice
			, "size":size
			//, "id":id
	};
	
	console.log(searchParam);
	
	$("#keyword_current").val(keyword);
	
	var html = "";
	$.ajax({
		type: "POST",
		async: false,
		dataType: "json",
		data: searchParam,
		timeout: 1000000,
		url: "cms.search",
		success : function(data) { 
			$("#cms_list2 ul").empty();
			$(data.result).each(function(key, val) {	
				var blind = (val.saleState == <%=PhotoDTO.SALE_STATE_STOP %>) ? "blind" : "";
				html += '<li class="thumb"> <a href="#" onclick="go_cmsView(\'' + val.uciCode + '\')"><img src="<%= IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>"></a>';
				html += '<div class="thumb_info"><input type="checkbox" /><span>' + val.uciCode + '</span><span>' + val.copyright + '</span></div>';
				html += '<ul class="thumb_btn"><li class="btn_down"><a href="<%= IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '" download>다운로드</a></li>'
					+' <li class="btn_del" value="' + val.uciCode + '"><a>삭제</a></li>'
					+ ' <li class="btn_view "' + blind + ' value="' + val.uciCode + '"><a>블라인드</a></li> </ul>';					
			});
			$("#cms_list2 ul").html(html);
			var totalCount = $(data.count)[0];
			var totalPage = $(data.totalPage)[0];
			$("div .result b").html(totalCount);
			$("div .paging span.total").html(totalPage);
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}
	});
}

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
		changeBlind(uciCode, saleState)
	});
	
	/** 블라인드/삭제 변경 */
	function changeBlind(uciCode, saleState) {
		changeOption(uciCode, "saleState", saleState);
	}