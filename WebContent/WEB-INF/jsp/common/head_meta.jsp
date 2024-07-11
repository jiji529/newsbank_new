<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String serverName = request.getServerName();
	int serverPort = request.getServerPort();
	String contextPath = request.getContextPath();
	String requestURL = request.getRequestURL().toString();
%>
<c:set var="URL" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<c:set var="serverName" value="<%= serverName %>" />
<c:set var="serverPort" value="<%= serverPort %>" />
<c:set var="contextPath" value="<%= contextPath %>" />
<c:set var="requestURL" value="<%= requestURL %>" />

<c:choose>
	<c:when test='${serverName=="www.newsbank.co.kr"}'>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <meta name="keywords" content="보도사진, 스톡사진, 스톡이미지, 사진판매, 역사사진, 근현대사, 인물사진, 사진박물관, korea press, photo, 다하미, 다하미커뮤니케이션즈, 사진 라이브러리, 사진구매, 교과서사진, 경향신문, 한국일보, 뉴시스, 동아일보, 세계일보, 조선일보, 아시아경제, 스포츠조선, 아주경제, 한겨레, 한국경제, 헤럴드경제">
        <meta name="description" content="언론사 보도사진 통합 라이브러리 뉴스뱅크 | 스톡사진 스톡이미지 사진판매 역사사진 근현대사 인물사진 사진박물관 press photo">

        <meta property="og:title" content="뉴스뱅크">
        <meta property="og:url" content="https://www.newsbank.co.kr/">
        <meta property="og:description" content="언론사 보도사진 통합 라이브러리 뉴스뱅크 | 스톡사진 스톡이미지 사진판매 역사사진 근현대사 인물사진 사진박물관 press photo">

        <meta name="twitter:card" content="summary" />
        <meta name="twitter:url" content="https://www.newsbank.co.kr/">
        <meta name="twitter:title" content="뉴스뱅크" />
        <meta name="twitter:description" content="언론사 보도사진 통합 라이브러리 뉴스뱅크 | 스톡사진 스톡이미지 사진판매 역사사진 근현대사 인물사진 사진박물관 press photo" />
		
        <meta name="google-site-verification" content="ISt8j978EDEd7T6BGyffD3ZmHinjD8GojKpX74FmRVU" />
        <meta name="naver-site-verification" content="4dbebe344ed878162a51f7268781126dad69ced7" />			
        
        <c:if test='${URL!="/index.jsp"}'>
        	<meta name="robots" content="noindex">
        </c:if>
        <link rel="SHORTCUT ICON" href="https://www.newsbank.co.kr/images/newsbank_favicon2.ico">  
        <jsp:include page="./google_analytics.jsp"></jsp:include>        
	</c:when>
	<c:otherwise>
		
	</c:otherwise>
</c:choose>        
<script src="js/jquery-1.12.4.min.js"></script>
<script>
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
</script>