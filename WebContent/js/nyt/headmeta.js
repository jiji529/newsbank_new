document.addEventListener('DOMContentLoaded', function() {
    const langElement = document.querySelector('.lang');

    langElement.addEventListener('mouseover', function() {
        langElement.classList.add('active');
    });

    langElement.addEventListener('mouseout', function(e) {
        if (!e.relatedTarget || !e.relatedTarget.closest('.lang')) {
            langElement.classList.remove('active');
        }
    });
});

// 2024-07-11 양준수 전무님 요청으로, 기본 영문페이지로 보이도록 세팅한다.
$(document).ready(function() {
	if(getCookie('language')=='') {
		setCookie('language', 'EN', 1);
	}
})

// 쿠키 세팅
function setCookie(name, value, expiredays) {
	var today = new Date();
    today.setDate(today.getDate() + expiredays);

    document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
}

// 쿠키 가져오기
function getCookie(name) {
    var wcname = name + '=',
        wcstart, wcend, end, i = 0;
    while (i <= document.cookie.length) {
        wcstart = i;
        wcend = (i + wcname.length);
        if (document.cookie.substring(wcstart, wcend) == wcname) {
            if ((end = document.cookie.indexOf(';', wcend)) == -1)
                end = document.cookie.length;
            return document.cookie.substring(wcend, end);
        }
        i = document.cookie.indexOf('', i) + 1;
        if (i == 0) break;
    }
    return '';
}

// 쿠키 삭제
function deleteCookie(name) {
	document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

// 언어 교체
function languageChange(lang) {
	setCookie('language', lang, 1);
	
	reloadPage();
}

// 페이지 리로드
function reloadPage() {
	location.reload(true);
}