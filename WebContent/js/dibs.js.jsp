<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>

/** 개별 다운로드 */
/*$(document).on("click", ".btn_down", function() {
	var uciCode = $(this).parent().parent().find("div span:first").text();
	var imgPath = $(this).parent().parent().find("a img").attr("src");
	
	var link = document.createElement("a");
    link.download = uciCode;
    link.href = imgPath;
    link.click();
});*/

/** 찜 카테고리 선택 */
$(document).on("click", ".filter_list li", function() {		
	var choice = $(this).text();
	$(this).attr("selected", "selected");
	$(this).siblings().removeAttr("selected");
	var filter_list = "<ul class=\"filter_list\">" + $(this).parents(".filter_list").html() + "</ul>";
	$(this).parents(".filter_title").children().remove().end().html(choice + filter_list);
	
	dibsList();
});

/** 찜 목록 */
function dibsList() {
	$("#wish_list2 ul:first").empty();
	
	//var member_seq = "1002"; // 사용자 고유번호		
	var bookmark_seq = $(".filter_title:nth-of-type(2) .filter_list").find("[selected=selected]").val();
	
	var html = "";
	$.ajax({
		url: "/DibsJSON",
		type: "GET",
		dataType: "json",
		data: {
			"bookmark_seq" : bookmark_seq
		},
		success: function(data){ 
			$(data.result).each(function(key, val) {
				//html += '<li class="thumb"> <a href="/view.picture?uciCode='+val.uciCode+'"><img src="images/serviceImages' + val.viewPath + '&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>"/></a>';
				html += '<li class="thumb"> <a href="/view.picture?uciCode='+val.uciCode+'"><img src="<%= IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>"/></a>';
				html += '<div class="thumb_info">';
				html += '<input type="checkbox" value="'+val.uciCode+'"/>';
				html += '<span>'+val.uciCode+'</span><span>'+val.copyright+'</span></div>';
				html += '<ul class="thumb_btn">';
				html += '<li class="btn_down">다운로드</li>';
				html += '<li class="btn_del">삭제</li>';
				html += '</ul></li>';					
			});
			$(html).appendTo("#wish_list2 ul:first");
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
	$("#uciCode").val(uciCode);
	view_form.submit();
}

/** 찜관리-폴더이동 */
function change_folder(bookmark_seq) {
	var chk_total = $("#wish_list2 input:checkbox:checked").length;
		
	if(chk_total == 0) {
		alert("최소 1개 이상을 선택해주세요.");
	} else {
		$("#wish_list2 input:checkbox:checked").each(function(index) {
			var uciCode = $(this).val();
			dibsUpdate(uciCode, bookmark_seq);
			$(this).closest(".thumb").remove();
		});
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
