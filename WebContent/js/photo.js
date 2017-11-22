//var IMG_SERVER_URL_PREFIX = "http://www.dev.newsbank.co.kr";
var IMG_SERVER_URL_PREFIX = "";

function down(uciCode) {
	if(!confirm("원본을 다운로드 하시겠습니까?")) {
		return;
	}
	var url = IMG_SERVER_URL_PREFIX + "/service.down.photo?uciCode="+uciCode+"&type=file";
	$("#downFrame").attr("src", url);
}

function setDatepicker() {
	$( ".datepicker" ).datepicker({
     changeMonth: true, 
     dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
     dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
     monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
     monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
     showButtonPanel: true, 
     currentText: '오늘 날짜', 
     closeText: '닫기', 
     dateFormat: "yymmdd"
  });
}
