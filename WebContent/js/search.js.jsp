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
	
	// 다른 페이지에서 검색 시
	function go_cmsSearch_from_cmsView() {
		view_form.action = "/cms" + $("#manage").val();
		view_form.target="_self";
		view_form.submit();
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
		
		view_form.keyword.value = keyword;
		view_form.pageNo.value = pageNo;
		view_form.pageVol.value = pageVol;
		view_form.media.value = media;
		view_form.durationReg.value = durationReg;
		view_form.durationTake.value = durationTake;
		view_form.colorMode.value = colorMode;
		view_form.horiVertChoice.value = horiVertChoice;
		view_form.saleState.value = saleState;
		view_form.size.value = size;
		
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
			url: searchTarget,
			success : function(data) { 
				$(data.result).each(function(key, val) {	
					var blind = (val.saleState == <%=PhotoDTO.SALE_STATE_STOP%>) ? "blind" : "";
					var deleted = (val.saleState == <%=PhotoDTO.SALE_STATE_DEL%>) ? "deleted" : "";
					html += "<li class=\"thumb\"> <a href=\"#\" onclick=\"go_cmsView('" + val.uciCode + "')\"><img src=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>\" /></a>";
					html += "<div class=\"thumb_info\"><input type=\"checkbox\" value=\""+ val.uciCode +"\"/><span>" + val.uciCode + "</span><span>" + val.copyright + "</span></div>";
					html += "<ul class=\"thumb_btn\">";
					if(deleted.length == 0) {
						html += "<li class=\"btn_down\" value=\"" + val.uciCode + "\"><a>다운로드</a></li>"
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
	
	//#연관사진
	function relation_photo() {
		var keyword = "";
		keyword = $.trim(keyword);
		var pageNo = "1";
		var pageVol = "10";
		var contentType = $(".filter_contentType .filter_list").find("[selected=selected]").attr("value");
		var media = 0;
		var duration = "";
		var colorMode = "0";
		var horiVertChoice = "0";
		var size = "0";
		var portRight = $(".filter_portRight .filter_list").find("[selected=selected]").attr("value");
		var includePerson = $(".filter_incPerson .filter_list").find("[selected=selected]").attr("value");
		var group = $(".filter_group .filter_list").find("[selected=selected]").attr("value");

		var searchParam = {
				"uciCode":$('#uciCode').val()
				,"keyword":keyword
				, "pageNo":pageNo
				, "pageVol":pageVol
				, "contentType":contentType
				, "media":media
				, "duration":duration
				, "colorMode":colorMode
				, "horiVertChoice":horiVertChoice
				, "size":size
				, "portRight":portRight
				, "includePerson":includePerson
				, "group":group
		};
		
		$("#keyword").val($("#keyword_current").val());
		console.log(searchParam);
		var html = "";
		$.ajax({
			type: "POST",
			async: false,
			dataType: "json",
			data: searchParam,
			timeout: 1000000,
			url: "search",
			success : function(data) {
				$(data.result).each(function(key, val) {
					html += '<li><a href="javascript:void(0)"><img src="<%= IMG_SERVER_URL_PREFIX %>/list.down.photo?uciCode=' + val.uciCode + '" /></a></li>';
				});
				$(html).appendTo(".cfix");
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}