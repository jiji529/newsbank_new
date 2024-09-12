// 최초 1페이지로
$(document).ready(function() {
	$("#startgo").val(1); 
	search();
});

// 검색 버튼 클릭
$(document).on("click", ".btn_input2", function() {
	$("#startgo").val(1); // 최초 1페이지로
	search();
});

//페이징 번호 클릭
$(document).on("click",".page",function() {
	var pages = $(this).text();
	if(pages == "") pages = 1;
	$("#startgo").val(pages);
	
	search("not_paging");
});

// 검색어 입력창 이벤트
$(document).on("keypress", "#keyword", function(e) {
	if (e.keyCode == 13) { // 엔터
		$("#startgo").val(1); // 최초 1페이지로
		search();
	}
});

// 첫번쨰 페이지
$(document).on("click",".first",function() {
	var pages = "1";
	$("#startgo").val(pages);
	
	search("not_paging");
});

// 마지막 페이지
$(document).on("click",".last",function() {
	var pages = $("#lastvalue").val();
	$("#startgo").val(pages);
	
	search("not_paging");
});

// 이전 페이지
$(document).on("click",".prev",function() {
	var pages = $("#pagination-demo .page.active").text();
	$("#startgo").val(pages);
	
	search("not_paging");
});

// 다음 페이지
$(document).on("click",".next",function() {
	var pages = $("#pagination-demo .page.active").text();
	$("#startgo").val(pages);
	
	search("not_paging");
});

function pagings(tot) {

	var firval = 1;
	var realtot = 1;
	var startpage = $("#startgo").val();
	$("#lastvalue").val(tot);

	if ($("#totcnt").val() != "") {
		if (startpage == "1") {
			firval = parseInt(startpage);
		} else {
			firval = parseInt($("#totcnt").val());
		}
	}
	if (tot == "0") {
		tot = 1;
	}

	realtot = parseInt(tot);

	$('.pagination').empty();
	$('.pagination').html(
			'<ul id="pagination-demo" class="pagination-sm"></ul>');

	$('#pagination-demo').twbsPagination({
		startPage : firval,
		totalPages : realtot,
		visiblePages : 10,
		onPageClick : function(event, page) {

			$('#page-content').text('Page ' + page);
		}
	});
}