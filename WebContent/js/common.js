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

// 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
$(document).ready(function() {
	$("[href]").each(function() {
		if (this.href == window.location.href) {
			$(this).parent().addClass("on");
		}
	});
});

// mypage 메뉴 개수에 따라 길이 조절
$(document).ready(function() {
	var len = $(".mypage .mypage_ul .mp_tab1 li").length;
	var liWidth = 100 / len;
	$(".mypage .mypage_ul .mp_tab1 li").css('width', liWidth + '%');

})

// kink.join 회원종류에 따른 약관동의 페이지 이동
$(document).ready(
		function() {
			$('.join_choice a').click(
					function() {
						$(this).parent().attr('action', '/terms.join').attr(
								'method', 'post').submit();

					});

		})

// terms.join 약관 동의 체크 및 페이지 이동
$(document).ready(function() {
	$("#frmJoinTerms").submit(function() {
		if($("#copyAgree").is(":checked")==false){
			alert($("#copyAgree").attr("title"));
			return false;
		}
		
		if($("#policyAgree").is(":checked")==false){
			alert($("#policyAgree").attr("title"));
			return false;
		}
		

		 $(this).attr('action', '/form.join').attr('method', 'post').submit();
		return false;
	});
})
