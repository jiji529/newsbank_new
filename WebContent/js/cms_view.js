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