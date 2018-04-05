<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>

// ################################################################################
// 페이지 로딩 완료시 실행
// 화면초기화 : 숨김처리, 초상권, 외부연계 관련
// 연관이미지 검색
// ################################################################################

	$(document).ready(function(key, val){
		// 수정기록 읽어오기
		$("#history_open").click(function(){ 
			setModLog();
			$("#popup_wrap").css("display", "block"); 
			$("#mask").css("display", "block");
		}); 
		$(".popup_close").click(function(){ 
			$("#popup_wrap").css("display", "none"); 
			$("#mask").css("display", "none");
			$(".pop_history .pop_cont tbody").html(""); 
		});
		
		initSearchParam();
		var saleState = $("#saleState").val();
		var portraitRightState = $("#portraitRightState").val();
		var mediaExActive = $("#mediaExActive").val();
		
		if(saleState == 1) { // 판매중
			$('input:radio[name="blind"][value="1"]').attr('checked', true);
		}else if(saleState == 2) { // 판매중지
			$('input:radio[name="blind"][value="2"]').attr('checked', true);
		}else {
			$('input:radio[name="blind"][value="2"]').attr('checked', true);
		}
		
		/*
		# 항목 숨기기 처리   -- 2018.02.20. hoyadev 
		if(portraitRightState == 1) {
			$('input:radio[name="likeness"][value="1"]').attr('checked', true);
		}else if(portraitRightState == 2) {
			$('input:radio[name="likeness"][value="2"]').attr('checked', true);
		}
		*/
		
		if(mediaExActive == 0) {
			$('input:radio[name="mediaExActive"][value="0"]').attr('checked', true);
		}else if(mediaExActive == 1) {
			$('input:radio[name="mediaExActive"][value="1"]').attr('checked', true);
		}else{
			$('input:radio[name="mediaExActive"][value="0"]').attr('checked', true);
		}
		
		relation_photo();
	});
	
// ################################################################################
// 수정기록 읽어오기
// ################################################################################
	
	function setModLog() {
		var url = "modLog.cms" + $("#manage").val();
		$.ajax({
			type: "POST",
			url: url,
			async: false,
			data: {
				"uciCode" : $("#uciCode").val()
			},
			dataType: "json",
			success: function(data){
				var html = "";
				$(data.result).each(function(key, val) {
					html += "<tr>"
						+ "<td>" + val.no + "</td>"
						+ "<td>" + val.regDateStr + "</td>"
						+ "<td>" + val.memberId + "</td>"
						+ "<td>" + val.memberName + "</td>"
						+ "<td>" + val.actionTypeStr + "</td>"
						+ "</tr>";
				});
				$(".pop_history .pop_cont tbody").html(html); 
			}, error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
		});
	}

// ################################################################################
// 상세화면에서 검색 관련
// ################################################################################
	
	$(document).on("keypress", "#cms_keyword", function(e) {
		if(e.keyCode == 13) {	// 엔터
			go_cmsSearch_from_cmsView();
		}
	});
	
	$(document).on("click", "#cms_searchBtn", function() {
		go_cmsSearch_from_cmsView();
	});
	
// ################################################################################
// 연관사진 검색 관련
// ################################################################################
	$(document).on("click", ".in_prev", function() {
	    var slide_width = $(".cfix").width();
	    var li_width = $(".cfix li:nth-child(1)").width();
	    var view_count = slide_width / li_width;
	    var slide_count = $(".cfix li").size();
	    
	    $(".cfix").animate({
	    	left: + li_width 
	    }, 200, function() {
	    	$(".cfix li:last-child").prependTo(".cfix");
	    	$(".cfix").css("left", "");
	    });
	});
	
	$(document).on("click", ".in_next", function() {
		var slide_width = $(".cfix").width();
	    var li_width = $(".cfix li:nth-child(1)").width();
	    var view_count = slide_width / li_width;
	    var slide_count = $(".cfix li").size();	    
	    
	    $('.cfix').animate({
	        left: - li_width
	    }, 200, function () {
	        $('.cfix li:first-child').appendTo('.cfix');
	        $('.cfix').css('left', '');
	    });
	});

// ################################################################################
// 블라인드 / 초상권 등 설정
// ################################################################################

	// 블라인드 변경
	$(document).on("change", "input[type=radio][name=blind]", function() {
		var saleState = $('input[type=radio][name=blind]:checked').val();
		changeOption($('#uciCode').val(), "saleState", saleState);
	});
	// 초상권 변경
	$(document).on("change", "input[type=radio][name=likeness]", function() {
		var portraitRightState = $('input[type=radio][name=likeness]:checked').val();
		changeOption($('#uciCode').val(), "portraitRightState", portraitRightState);
	});
	
// ################################################################################
// 원본 다운로드 버튼 클릭
// ################################################################################
	$(document).on("click", ".btn_down", function() {
		down($(this).attr("value"));
	});

// ################################################################################
// 태그 관리
// ################################################################################

	// 태그삭제
	$(document).on("click", ".tag_remove", function() {
		$(this).parent().remove();
		var uciCode = $('#uciCode').val();
		var tagName = $(this).parent().text().replace("×", "");
		
		deleteTag(uciCode, tagName)
	});

	function deleteTag(uciCode, tagName) {
		var url = "/view.cms" + $("#manage").val();
		$.ajax({
			type: "POST",
			url: url,
			data: {
				"action" : "deleteTag",
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
		var uciCode = $('#uciCode').val();
		var tagName = $(this).prev().val();
		if($.trim(tagName).length == 0) {
			alert("공백은 입력할 수 없습니다.");
			return
		}
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
		var url = "/view.cms" + $("#manage").val();
		$.ajax({
			type: "POST",
			url: url,
			data: {
				"action" : "insertTag",
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
	
// ################################################################################
// 삭제 / 수정버튼 처리
// ################################################################################

	/** 삭제버튼 클릭 */
	$(document).on("click", "#open_del", function() {
		var uciCode = $("#uciCode").val();		
		if(!confirm("이미지 삭제 후 복구할 수 없습니다.\n삭제합니까?")) {
			return;
		}
		changeOption(uciCode, "saleState", <%=PhotoDTO.SALE_STATE_DEL %>);
		alert("삭제되었습니다");
		go_cmsView(uciCode);
	});

	$(document).on("click", "#open_edit", function() {
		$("#open_edit").hide();
		$("#save_edit").show();
		$("#close_edit").show();
		$("#open_del").hide();
		
		$(".viewTitle").hide();
		$(".viewCont").hide();
		$(".editTitle").text($(".orgTitle").text());
		$(".editTitle").show();
		$(".editCont").text($(".orgCont").text());
		$(".editCont").show();
		
		$(".editTitle").focus()
	});
	
	$(document).on("click", "#close_edit", function() {
		if(!confirm("수정사항 반영하지 않고 취소합니다.")) {
			return;
		}
		$("#open_edit").show();
		$("#save_edit").hide();
		$("#close_edit").hide();
		$("#open_del").show();
		
		$(".viewTitle").show();
		$(".viewCont").show();
		$(".editTitle").text("");
		$(".editTitle").hide();
		$(".editCont").text("");
		$(".editCont").hide();
	});
	
	$(document).on("click", "#save_edit", function() {
		if(!confirm("수정사항을 저장합니다.")) {
			return;
		}
		var uciCode = $('#uciCode').val();
		var newTitle = $(".editTitle").text();
		var newCont = $(".editCont").text();
		
		var url = "/view.cms" + $("#manage").val();
		$.ajax({
			type: "POST",
			url: url,
			data: {
				"action" : "updateCMS",
				"uciCode" : uciCode,
				"titleKor" : newTitle,
				"descriptionKor" : newCont
			},
			success: function(data){
				// 저장 성공 후 화면 정리
			
				// 버튼 갱신
				$("#open_edit").show();
				$("#save_edit").hide();
				$("#close_edit").hide();
				$("#open_del").show();
				
				// 표시 텍스트 수정/보임
				$(".viewTitle").text(newTitle);
				$(".viewCont").text(newCont);
				$(".viewTitle").show();
				$(".viewCont").show();
				
				// 에디트폼 숨김
				$(".editTitle").hide();
				$(".editCont").hide();
				$(".editTitle").text("");
				$(".editCont").text("");
				
				// 원본 데이터 수정
				$(".orgTitle").text(newTitle);
				$(".orgCont").text(newCont);
	//			go_cmsView(uciCode);
				alert("저장했습니다");
			}, error:function(request,status,error){
				alert("저장중 오류가 발생했습니다. " + error);
		       	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	});
