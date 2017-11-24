var IMG_SERVER_URL_PREFIX = "http://www.dev.newsbank.co.kr";

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
			"keyword":keyword
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
				html += '<li><a href="javascript:void(0)"><img src="' + IMG_SERVER_URL_PREFIX + '/list.down.photo?uciCode=' + val.uciCode + '" /></a></li>';
			});
			$(html).appendTo(".cfix");
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}
	});
}

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