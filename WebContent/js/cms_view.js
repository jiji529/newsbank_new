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

/** 수정기능 처리 */
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
