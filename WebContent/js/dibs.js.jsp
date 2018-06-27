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
	if(prev != 0) { // 이전 페이지가 있을 경우만
		goPage(prev);
	}
	
});
$(document).on("click", "div .paging a.next", function() {
	var totalPage = $(".total").text();
	var next = $("input[name=pageNo]").val() - (-1);
	if(next <= totalPage) { // 다음 페이지가 있을 경우만
		goPage(next);
	}	
});

$(document).on("click", "a[name=nextPage]", function() {
	var next = $("input[name=pageNo]").val() - (-1);
	goPage(next);
});

function goPage(pageNo) {
	$("input:checkbox[name='checkAll']").attr("checked", false);
	
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
		}
		$("input:checkbox[name='checkAll']").attr("checked", false);
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
		success: function(data){ console.log(data);
			var totalCount = data.totalCount;
			var totalPage = data.totalPage;
			var deferred = data.deferred;
			
			$(data.result).each(function(key, val) { 
			
				if(val.admission == 'Y' && val.activate == 1 && val.withdraw == 0 && val.saleState == 1) { // 매체사 회원권한 확인 & 사진 판매상태 확인
					html += '<li class="thumb"> <a href="javascript:void(0)" onclick="go_photoView(\'' + val.uciCode + '\')"><img src="<%= IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>"/></a>';
					html += '<div class="thumb_info">';
					html += '<input type="checkbox" value="'+val.uciCode+'"/>';
				}else {
					html += '<li class="thumb"> <a href="javascript:void(0)" onclick="stopSaleMessage()"><img src="<%= IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>"/></a>';
					html += '<div class="thumb_info">';
				}							
				
				html += '<span>'+val.uciCode+'</span><span>'+val.copyright+'</span></div>';
				html += '<ul class="thumb_btn">';
				
				if(val.admission == 'Y' && val.activate == 1 && val.withdraw == 0 && val.saleState == 1) { // 매체사 회원권한 확인 & 사진 판매상태 확인
					if(deferred == 2) {
						html += '<li class="btn_down" onclick="downDiferred(\''+ val.uciCode +'\')">다운로드</li>';
					}else if(deferred == 0) {
						html += '<li class="btn_cart" onclick="insertBasket(\''+ val.uciCode +'\')">장바구니</li>';
					}
				}else{
					if(deferred == 2) {
						html += '<li class="btn_down" onclick="stopSaleMessage()">다운로드</li>';
					}else if(deferred == 0) {
						html += '<li class="btn_cart" onclick="stopSaleMessage()">장바구니</li>';
					}
				}
				
				html += '<li class="btn_del">삭제</li>';
				html += '</ul></li>';					
			});			
			$(html).appendTo("#wish_list2 ul:first");
			
			$("div .result b").html(totalCount);
			$("div .paging span.total").html(totalPage);
			
			//console.log(pageVol + " / " + data.result.length);
			if(pageVol > data.result.length) { // 총 갯수가 표현단위보다 작을 때, [다음 페이지] 숨김
				$(".more").hide();
			}else {
				$(".more").show();
			}
		}, 
		error:function(request,status,error){
        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       	}
	});
} 

/** DB 삭제함수 */
function dibsDelete(uciCode) {
	var param = "action=deleteBookmark";
	
	$.ajax({
		url: "/bookmark.api?"+param,
		type: "POST",
		data: {
			"uciCode" : uciCode
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
	dibsList();		
});

/** 다중선택 삭제 */
$(document).on("click", ".sort_del", function() {
	var total = $(".count").text();
	var chk_total = $("#wish_list2 input:checkbox:checked").length;
	
	var rest = total - chk_total;
				
	if(chk_total == 0) {
		alert("최소 1개 이상을 선택해주세요.");
	} else {
		if(!confirm("선택항목을 정말로 삭제하시겠습니까?")) {
			return;
		}
		$("#wish_list2 input:checkbox:checked").each(function(index) {
			var uciCode = $(this).val();
			dibsDelete(uciCode);
			$(this).closest(".thumb").remove();
		});
		
		$("input:checkbox[name='checkAll']").attr("checked", false);
		$(".count").text(rest);		
	}
	
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
	view_form.target = '_blank';
	view_form.submit();
}

/** 찜관리-폴더이동 */
function change_folder(bookmark_seq, bookmark_name) {
	var chk_total = $("#wish_list2 input:checkbox:checked").length;
	var filter_title = $(".filter_list").find("[selected=selected]").text();
	var uciCode = new Array();
				
	if(chk_total == 0) {
		alert("최소 1개 이상을 선택해주세요.");
	} else {
		$("#wish_list2 input:checkbox:checked").each(function(index) {
			uciCode.push($(this).val());
			
			if(filter_title == "찜한 사진 전체" || filter_title == "") { 
				$(this).attr("checked", false);
			} else { // 카테고리를 선택했을 떄만 이미지 지우기
				$(this).closest(".thumb").remove();
			}
		});
		
		dibsUpdate(uciCode, bookmark_seq);
		$("input:checkbox[name='checkAll']").attr("checked", false);
		var count = $("#wish_list2 .thumb").length;
		$(".count").text(count);
		
		alert("선택하신 사진이 " + bookmark_name + "폴더로 이동되었습니다.");
	}
}

/** DB 수정함수 */
function dibsUpdate(uciCode, bookmark_seq) {
	var param = "action=updateBookmark";
	//console.log(uciCode.join("|"), bookmark_seq);
	
	$.ajax({
		url: "/bookmark.api?"+param,
		type: "POST",
		data: {
			"uciCode" : uciCode.join("|"),
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
	$("#uciCode").val(uciCode); // 선택 uciCode 배열로 전달
	
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
		insertBasket(uciCode);		
	}
}




