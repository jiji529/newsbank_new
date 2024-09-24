/**
 * DATE : 2024-09-23 
 * Author : HA.J.S
 * Description : 쿠키 사용 관련 메소드 모음
 */

// 쿠키값이 있을때 검색조건 사전 세팅
function initSearchParamByCookie(searchOption, searchValue, contextPath) {
	if(searchOption=='keyword') {		
		if(searchValue != getCookie('keyword')) {			
			searchValue = unescape(getCookie('keyword'));				
			$('input[name="keyword"]').val(searchValue);
			$('#view_form').find('input[name="keyword"]').val(searchValue);									
		}			
	} else if(searchOption=='media') {
		// 검색이벤트를 직접 발생시킨 경우가 아닌 경우에만 여기로 들어온다.
		if(getCookie('media')!='') {			
			// 파라미터 세팅 전에, 쿠키에 값이 있는 경우 사용한다.				
			if(searchValue != getCookie('media')) {				
				// 값이 있으나, 쿠키에 저장된 값과 다를 경우
				searchValue = getCookie('media');
				$(".filter_media .filter_list li").each(function() {
					if ($(this).attr('value') == searchValue) {
						$(this).attr('selected', 'selected');
						var html = "";
						if(contextPath.indexOf('photo')!=-1) {
							html = "<font>매체</font> :  " + $(this).text();							
						} else {
							html = "<font>매체</font><br/>" + $(this).text();
						}
						$(".filter_media").find("span").html(html);  
        				return false;  // 반복 중단
					} else {
						$(this).removeAttr('selected');
					}
				})
			}					
		}
	} else if(searchOption=='durationReg') {
		
	} else if(searchOption=='durationTake') {
		
	} else if(searchOption=='horizontal') {
		
	} else if(searchOption=='size') {
		
	}
	return searchValue;
}

// 쿠키 세팅
function setCookie(name, value) {
    document.cookie = name + '=' + escape(value) + '; path=/;';
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