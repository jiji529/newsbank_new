<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 10. 16. 오후 16:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 16.   hoyadev        cms
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>NYT 뉴스뱅크</title>

<link rel="stylesheet" href="css/nyt/jquery-ui-1.12.1.min.css">
<link rel="stylesheet" href="css/nyt/base.css" />
<link rel="stylesheet" href="css/nyt/sub.css" />
<link rel="stylesheet" href="css/nyt/mypage.css" />

<script src="js/nyt/jquery-1.12.4.min.js"></script>
<script src="js/nyt/jquery-ui-1.12.1.min.js"></script>

<script src="js/nyt/filter.js"></script>
<script src="js/nyt/footer.js"></script>
<script src="js/nyt/mypage.js"></script>
</head>

<body>
	<div class="wrap">
		<%@include file="common/headerKR2.jsp" %>
		<section class="collection">
			<div class="head">
				<h2>컬렉션</h2>
				<p>뉴스뱅크 회원들이 직접 고른 가장 핫하고 크리에이티브한 이미지가 담긴 컬렉션이 실시간으로 업데이트 됩니다.</p>
			</div>
			
			<div class="tile">
				<ul>
					<c:forEach items="${collectionList}" var="collection">
						<li class="collect_li"><a href="#"></a>
							<div class="cover" style="background-image:url(<%=IMG_SERVER_URL_PREFIX%>/view.down.photo?uciCode=${collection.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>)">
							<h3>
								<div class="profile"></div>
								<a href="#">${collection.id}</a></h3>
							<strong>${collection.bookName}<span>${collection.photo_count} images</span></strong></div>
						</li>
					</c:forEach>
				</ul>
			</div>
			
		</section>
	</div>
</body>
</html>