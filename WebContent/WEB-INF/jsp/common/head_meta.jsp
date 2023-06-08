<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="URL" value="${requestScope['javax.servlet.forward.servlet_path']}" />

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
        <meta name="naver-site-verification" content="fec92bb31ce9d47a98c8ad565560618e261813d3" />
        <c:if test='${URL!="/index.jsp"}'>
        	<meta name="robots" content="noindex">
        </c:if>
        <link rel="SHORTCUT ICON" href="https://www.newsbank.co.kr/images/newsbank_favicon2.ico">  
        <jsp:include page="./google_analytics.jsp"></jsp:include>        