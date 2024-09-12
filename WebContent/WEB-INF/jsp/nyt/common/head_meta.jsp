<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="URL" value="${requestScope['javax.servlet.forward.servlet_path']}" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <meta name="keywords" content="보도사진, 스톡사진, 스톡이미지, 사진판매, 역사사진, 근현대사, 인물사진, 사진박물관,  photo, 다하미, 다하미커뮤니케이션즈, 사진 라이브러리, 사진구매, 교과서사진, 뉴욕타임스, 뉴욕타임즈, newyorktimes, newyork times, nyt, 뉴스뱅크, news bank, newsbank, 해외언론사 보도사진, 미국언론사, 미국신문">
        <meta name="description" content="언전 세계 각국의 현장을 그대로 담아 생동감 있게 전달해주는 뉴욕타임스 보도사진 라이브러리 뉴욕타임스 뉴스뱅크 | 스톡사진 스톡이미지 사진판매 역사사진 근현대사 인물사진 사진박물관 press photo">

        <meta property="og:title" content="뉴욕타임즈 X 뉴스뱅크">
        <meta property="og:url" content="https://nyt.newsbank.co.kr/">
        <meta property="og:description" content="전 세계 각국의 현장을 그대로 담아 생동감 있게 전달해주는 뉴욕타임스 보도사진 라이브러리 뉴욕타임스 뉴스뱅크 | 스톡사진 스톡이미지 사진판매 역사사진 근현대사 인물사진 사진박물관 press photo">

        <meta name="twitter:card" content="summary" />
        <meta name="twitter:url" content="https://nyt.newsbank.co.kr/">
        <meta name="twitter:title" content="뉴욕타임즈 X 뉴스뱅크" />
        <meta name="twitter:description" content="전 세계 각국의 현장을 그대로 담아 생동감 있게 전달해주는 뉴욕타임스 보도사진 라이브러리 뉴욕타임스 뉴스뱅크 | 스톡사진 스톡이미지 사진판매 역사사진 근현대사 인물사진 사진박물관 press photo" />
		
        <meta name="google-site-verification" content="ISt8j978EDEd7T6BGyffD3ZmHinjD8GojKpX74FmRVU" />
        <meta name="naver-site-verification" content="c1fa4c50c3ef66a8a068cd4a521375b70a47e095" />			
        
        <c:if test='${URL!="/index.jsp"}'>
        	<meta name="robots" content="noindex">
        </c:if>
        <link rel="SHORTCUT ICON" href="https://www.newsbank.co.kr/images/newsbank_favicon2.ico">  
        <jsp:include page="./google_analytics.jsp"></jsp:include>        
		<script src="js/nyt/jquery-1.12.4.min.js"></script>        
		<c:if test='${URL=="/" || URL=="/index.jsp" || URL=="/price.info" || URL=="/FAQ" || URL=="/contact"}'>
			<script src="js/nyt/headmeta.js"></script>
		</c:if>
		<script>
			function family_site_open() {
				if ($(this).attr('data-click-state') == 1) {
			        $(this).attr('data-click-state', 0);
			        $("#select-layer").css('display', 'none');
			    } else {
			        $(this).attr('data-click-state', 1);
			        $("#select-layer").css('display', 'block');
			    }
			}	
			
			$(document).on("keypress", "#keyword", function(e) {
				if (e.keyCode == 13) { // 엔터
					searchTop();
				}
			});
			
			$(document).on("click", "#btn_search", function(e) { // 검색 버튼
				searchTop();
			});

			function searchTop() {
				var oldKw = $("#keyword_current").val();
				var newKw = $("#keyword").val();
				if(oldKw == newKw) {
					return;
				}
				
				if($("input[name=pageNo]").length > 0) {
					$("input[name=pageNo]").val(1);	
				}
				
				if($("#serviceMode").length > 0) {
					$("#keyword_current").val($("#keyword").val());
					search();
				}
				else {
					var keyword = $("#keyword").val();
					keyword = $.trim(keyword);
					$("#keyword_current").val(keyword);
					searchform.submit();
				}
			}			
		</script>