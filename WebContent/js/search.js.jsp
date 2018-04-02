<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>

<%
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>

	function setDatepicker() {
		$( ".datepicker" ).datepicker({
	     changeMonth: true, 
	     dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	     dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	     monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	     monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	     showButtonPanel: true, 
	     currentText: '오늘 날짜', 
	     closeText: '닫기', 
	     dateFormat: "yymmdd"
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
		var durationReg = $(".filter_durationReg .filter_list").find("[selected=selected]").attr("value");
		var durationTake = $(".filter_durationTake .filter_list").find("[selected=selected]").attr("value");
		var colorMode = $(".filter_color .filter_list").find("[selected=selected]").attr("value");
		var horiVertChoice = $(".filter_horizontal .filter_list").find("[selected=selected]").attr("value");
		var saleState = $(".filter_service .filter_list").find("[selected=selected]").attr("value");
		var size = $(".filter_size .filter_list").find("[selected=selected]").attr("value");
		
		var searchParam = {
				"keyword":keyword
				, "pageNo":pageNo
				, "pageVol":pageVol
				, "media":media
				, "durationReg":durationReg
				, "durationTake":durationTake
				, "colorMode":colorMode
				, "horiVertChoice":horiVertChoice
				, "saleState":saleState
				, "size":size
				//, "id":id
		};
		
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
				$(data.result).each(function(key, val) {	
					var blind = (val.saleState == <%=PhotoDTO.SALE_STATE_STOP%>) ? "blind" : "";
					var deleted = (val.saleState == <%=PhotoDTO.SALE_STATE_DEL%>) ? "deleted" : "";
					html += "<li class=\"thumb\"> <a href=\"#\" onclick=\"go_cmsView('" + val.uciCode + "')\"><img src=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>\" /></a>";
					html += "<div class=\"thumb_info\"><input type=\"checkbox\" value=\""+ val.uciCode +"\"/><span>" + val.uciCode + "</span><span>" + val.copyright + "</span></div>";
					html += "<ul class=\"thumb_btn\">";
					if(deleted.length == 0) {
						html += "<li class=\"btn_down\"><a href=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "\" download>다운로드</a></li>"
						html += "<li class=\"btn_del " + deleted + "\" value=\"" + val.uciCode + "\"><a>삭제</a></li>";
						html += "<li class=\"btn_view " + blind + "\" value=\"" + val.uciCode + "\"><a>숨김</a></li>";
					}
					else {
						html += "<li class=\"btn_down hide\"></li>"
						html += "<li class=\"" + deleted + "\" value=\"" + val.uciCode + "\"></li>";
						html += "<li class=\"btn_view hide" + blind + "\" value=\"" + val.uciCode + "\"></li>";
					}
					html += " </ul>";
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