<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>

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
		dibsList();
	}
	else
	{
		return false;
	}
}

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

function goPage(pageNo) {
	if(pageNo < 1) {
		pageNo = 1;
	}
	else if(pageNo > $("div .paging span.total").html()) {
		pageNo = $("div .paging span.total").html();
	}
	$("input[name=pageNo]").val(pageNo);
	dibsList();
}

/** 찜 카테고리 선택 */
$(document).on("click", ".filter_list li", function() {
	if(!$(this).hasClass("folder_edit")) { // 폴더관리를 제외한 나머지
		var seq = $(this).val();
		var choice = $(this).text();
		$(this).attr("selected", "selected");
		$(this).siblings().removeAttr("selected");
		var filter_list = "<ul class=\"filter_list\">" + $(this).parents(".filter_list").html() + "</ul>";
		$(this).parents(".filter_title").children().remove().end().html(choice + filter_list);
		$("input[name=pageNo]").val(1); // 1페이지로 이동
		
		$(".sort_folder .list_layer li").css("display", "block");
		if(seq != "") {
			$(".sort_folder .list_layer").find("[value=" + seq + "]").css("display", "none");
			console.log("list_layer : " + seq);
		}
		
		dibsList();
	}		
	
});

/** 찜 목록 */
function dibsList() {
	$("#wish_list2 ul:first").empty();
	
	var bookmark_seq = $(".filter_title:nth-of-type(2) .filter_list").find("[selected=selected]").val();
	var pageVol = $("select[name=limit]").val(); // 페이지당 표현 갯수
	var pageNo = $("input[name=pageNo]").val(); // 현재 페이지
	
	var html = "";
	$.ajax({
		url: "/DibsJSON",
		type: "GET",
		dataType: "json",
		data: {
			"bookmark_seq" : bookmark_seq,
			"pageVol" : pageVol,
			"pageNo" : pageNo
		},
		success: function(data){ //console.log(data);
			var totalCount = data.totalCount;
			var totalPage = data.totalPage;
			
			$(data.result).each(function(key, val) { 
				html += '<li class="thumb"> <a href="/view.picture?uciCode='+val.uciCode+'"><img src="<%= IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>"/></a>';
				html += '<div class="thumb_info">';
				html += '<input type="checkbox" value="'+val.uciCode+'"/>';
				html += '<span>'+val.uciCode+'</span><span>'+val.copyright+'</span></div>';
				html += '<ul class="thumb_btn">';
				html += '<li class="btn_down" onclick="down(\''+ val.uciCode +'\')">다운로드</li>';
				html += '<li class="btn_del">삭제</li>';
				html += '</ul></li>';					
			});
			$(html).appendTo("#wish_list2 ul:first");
			
			$("div .result b").html(totalCount);
			$("div .paging span.total").html(totalPage);
		}, 
		error:function(request,status,error){
        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       	}
	});
} 

/** DB 삭제함수 */
function dibsDelete(uciCode) {
	var param = "action=delete";
	
	$.ajax({
		url: "/dibs.myPage?"+param,
		type: "POST",
		data: {
			"photo_uciCode" : uciCode
		},
		success: function(data){ }, 
		error:function(request,status,error){
        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       	}
	}); 
}

/** 개별 삭제 */
$(document).on("click", ".btn_del", function() {
	if(!confirm("정말로 삭제하시겠습니까?")) {
		return;
	}
	var uciCode = $(this).parent().parent().find("div span:first").text();
	$(this).closest(".thumb").remove();
	
	dibsDelete(uciCode);
	
	$("input:checkbox[name='checkAll']").attr("checked", false);
	var count = $("#wish_list2 .thumb").length;
	$(".count").text(count);		
});

/** 다중선택 삭제 */
$(document).on("click", ".sort_del", function() {
	if(!confirm("선택항목을 정말로 삭제하시겠습니까?")) {
		return;
	}
	$("#wish_list2 input:checkbox:checked").each(function(index) {
		var uciCode = $(this).val();
		dibsDelete(uciCode);
		$(this).closest(".thumb").remove();
	});
	
	$("input:checkbox[name='checkAll']").attr("checked", false);
	var count = $("#wish_list2 .thumb").length;
	$(".count").text(count);
});

/** 전체선택 */
$(document).on("click", "input[name='checkAll']", function() {
	if($("input[name='checkAll']").prop("checked")) {
		$("#wish_list2 input:checkbox").prop("checked", true);
	}else {
		$("#wish_list2 input:checkbox").prop("checked", false);
	}
});

function go_photoView(uciCode) {
	$("#uci_code").val(uciCode);
	view_form.submit();
}

/** 찜관리-폴더이동 */
function change_folder(bookmark_seq, bookmark_name) {
	var chk_total = $("#wish_list2 input:checkbox:checked").length;
	var filter_title = $(".filter_list").find("[selected=selected]").text();
			
	if(chk_total == 0) {
		alert("최소 1개 이상을 선택해주세요.");
	} else {
		$("#wish_list2 input:checkbox:checked").each(function(index) {
			var uciCode = $(this).val();
			dibsUpdate(uciCode, bookmark_seq);
			
			if(filter_title == "찜한 사진 전체" || filter_title == "") { 
				$(this).attr("checked", false);
			} else { // 카테고리를 선택했을 떄만 이미지 지우기
				$(this).closest(".thumb").remove();
			}
		});
		$("input:checkbox[name='checkAll']").attr("checked", false);
		var count = $("#wish_list2 .thumb").length;
		$(".count").text(count);
		
		alert("선택하신 사진이 " + bookmark_name + "폴더로 이동되었습니다.");
	}
}

/** DB 수정함수 */
function dibsUpdate(uciCode, bookmark_seq) {
	var param = "action=update";
	
	$.ajax({
		url: "/dibs.myPage?"+param,
		type: "POST",
		data: {
			"photo_uciCode" : uciCode,
			"bookmark_seq" : bookmark_seq
		},
		success: function(data){ }, 
		error:function(request,status,error){
        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       	}
	}); 
}

/** 단일 장바구니 추가 */
function insertBasket(uciCode) {
	//window.open('/cart.popOption?page=dibs.myPage&uciCode=' + uciCode,'new','resizable=no width=420 height=600');
	$("#page").val("dibs.myPage");
	$("#uciCode").val(uciCode);
	
	window.open("", "openWin", "toolbar=no, resizable=no, width=420, height=600, directories=no, status=no, scrollbars=no");
	cart_form.method = "post";
	cart_form.action = "/cart.popOption";
	cart_form.target = "openWin";
	cart_form.submit();
}

/** 선택항목-장바구니 추가 */
function insertMultiBasket() {
	var chk_total = $("#wish_list2 input:checkbox:checked").length;
	var uciCode = new Array();
	
	if(chk_total == 0) {
		alert("최소 1개 이상을 선택해주세요.");
	} else {
		$("#wish_list2 input:checkbox:checked").each(function(index) {
			uciCode.push($(this).val());
		});
		insertBasket(uciCode.join("|"));
	}
}

function down(uciCode) {
	if(!confirm("원본을 다운로드 하시겠습니까?")) {
		return;
	}
	var url = "<%= IMG_SERVER_URL_PREFIX%>/service.down.photo?uciCode="+uciCode+"&type=file";
	$("#downFrame").attr("src", url);
}	

function mutli_download() {
	var uciCode = new Array();
	if(!confirm("선택파일을 압축파일로 다운로드하시겠습니까?")) {
		return;
	}
	$("#wish_list2 input:checkbox:checked").each(function(index) {
		uciCode.push($(this).val());
	});
	
	var param = uciCode.join("&uciCode=");
	
	var url = "<%= IMG_SERVER_URL_PREFIX%>/zip.down.photo?&type=file&uciCode=";
	url += param;
	
	$("#downFrame").attr("src", url);
}
