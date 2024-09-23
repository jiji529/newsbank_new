/**
 * DATE : 2024-09-23 
 * Author : HA.J.S
 * Description : 쿠키 사용 관련 메소드 모음
 */

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