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
		var saleState = ${photoDTO.saleState};
		var portraitRightState = ${photoDTO.portraitRightState};
		var mediaExActive = ${photoDTO.mediaExActive};
		
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
// 검색 관련
// ################################################################################
	
	$(document).on("keypress", "#cms_keyword", function(e) {
		if(e.keyCode == 13) {	// 엔터
			go_cms();
		}
	});
	
	$(document).on("click", "#cms_searchBtn", function() {
		go_cms();
	});
	
	function go_cms() {
		var keyword = $("#cms_keyword").val();
		$("#cms_keyword_current").val(keyword);
		view_form.submit();
	}

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
		var uciCode = $('#uciCode').val();
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
	
// ################################################################################
// 수정기능 처리
// ################################################################################
$(document).on("click", ".btn_edit", function() {
	var title = $(".img_tit").last().text();
	var content = $(".img_cont").text();		
	
	if($(".btn_edit").hasClass("complete")) {
		// DB에 기사 제목, 내용을 수정 기능 필요
		var titleKor = $(".hTitle").val(); 
		var descriptionKor = $(".img_cont").text();
		var uciCode = "${photoDTO.uciCode}";
		
		$(".btn_edit").text("수정");		
		$(".btn_edit").removeClass("complete");
		$(".img_tit").last().replaceWith("<h3 class=\"img_tit\">"+titleKor+"</h3>");
		$(".img_cont").replaceWith("<p class=\"img_cont\">"+descriptionKor+"</p>");
		
		$.ajax({
			type: "POST",
			url: "/view.cms?action=updateCMS",
			data: {
				"uciCode" : uciCode,
				"titleKor" : titleKor,
				"descriptionKor" : descriptionKor
			},
			success: function(data){
				
			}, error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
			
		});
	}else {
		$(".img_tit").last().replaceWith("<textarea class=\"img_tit hTitle\" style=\"width:100%; font-size:14px; line-height:22px; color:#666;\">"+title+"</textarea>");
		$(".img_cont").replaceWith("<textarea class=\"img_cont\" style=\"height:300px; width:100%; font-size:14px; line-height:22px; color:#666;\">"+content+"</textarea>");	
		$(".btn_edit").text("수정 완료");		
		$(".btn_edit").addClass("complete");
	}
});