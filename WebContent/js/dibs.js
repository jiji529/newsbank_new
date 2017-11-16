/** 개별 다운로드 */
$(document).on("click", ".btn_down", function() {
	var uciCode = $(this).parent().parent().find("div span:first").text();
	var imgPath = $(this).parent().parent().find("a img").attr("src");
	
	var link = document.createElement("a");
    link.download = uciCode;
    link.href = imgPath;
    link.click();
});

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
	
	var member_seq = "1002"; // 사용자 고유번호		
	var bookmark_seq = $(".filter_title:nth-of-type(2) .filter_list").find("[selected=selected]").val();
	
	var html = "";
	$.ajax({
		url: "/DibsJSON",
		type: "GET",
		dataType: "json",
		data: {
			"member_seq" : member_seq,
			"bookmark_seq" : bookmark_seq
		},
		success: function(data){ 
			$(data.result).each(function(key, val) {
				//html += '<li class="thumb"> <a href="/view.picture?uciCode='+val.uciCode+'"><img src="images/serviceImages' + val.viewPath + '&dummy=<%= currentTimeMills%>"/></a>';
				html += '<li class="thumb"> <a href="/view.picture?uciCode='+val.uciCode+'"><img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '&dummy=<%= currentTimeMills%>"/></a>';
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
	var uciCode = $(this).parent().parent().find("div span:first").text();
	$(this).closest(".thumb").remove();
	
	dibsDelete(uciCode);		
});

/** 다중선택 삭제 */
$(document).on("click", ".sort_del", function() {
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