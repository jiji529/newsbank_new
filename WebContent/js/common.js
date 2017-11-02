//새창 열기
function popup_window(url, winname, opt) {
	window.open(url, winname, opt);
}

// 패스워드 찾기 팝업창
var password_lost = function(href) {
	popup_window(href, "비밀번호 찾기",
			"left=50, top=50, width=617, height=330, scrollbars=1");
}
// 비밀번호 찾기 버튼 클릭
$(document).ready(function() {
	$("#login_password_lost, #mypage_password_lost").click(function() {
		password_lost(this.href);
		return false;
	});
});



