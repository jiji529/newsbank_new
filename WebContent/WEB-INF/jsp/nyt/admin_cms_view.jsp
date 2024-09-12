<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2017. 10. 16. 오후 16:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 21.   LEE GWANGHO    cms.view.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<link rel="stylesheet" href="css/nyt/jquery-ui-1.12.1.min.css">
<link rel="stylesheet" href="css/nyt/base.css" />
<link rel="stylesheet" href="css/nyt/sub.css" />
<link rel="stylesheet" href="css/nyt/mypage.css" />

<script src="js/nyt/jquery-1.12.4.min.js"></script>
<script src="js/nyt/jquery-ui-1.12.1.min.js"></script>
<script src="js/nyt/filter.js"></script>

<script src="js/nyt/nyt/cms.js.jsp"></script>
<script src="js/nyt/nyt/cms_view.js.jsp"></script>
<script src="js/nyt/nyt/search.js.jsp"></script>

<script>
	var searchTarget = "admin.search";
	
	//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
	$(document).ready(function() {
		//side bar 메뉴 class on 
		$(".lnb [href]").each(function() {
			var lng_path = (this.pathname).substr(1, (this.pathname).length);
			var location_path = (window.location.pathname).substr(1, (window.location.pathname).length);
			
			if (location_path.match(lng_path)) {
				$(this).parent().addClass("on");
			} 
		});	
	});
	
	$(document).ready(function() {
		$("#popup_open").click(function() {
			$("#popup_wrap").css("display", "block");
			$("#mask").css("display", "block");
		});
		
		$("#popup_open").click(function() {
			$("#popup_wrap").css("display", "block");
			$("#mask").css("display", "block");
		});
		$(".popup_close").click(function() {
			$("#popup_wrap").css("display", "none");
			$("#mask").css("display", "none");
		});
	});
</script>
<title>NYT 뉴스뱅크</title>
</head>
<body>
	<div class="wrap admin">
<%@include file="header_admin.jsp" %>
		<section class="wide">
<%@include file="sidebar.jsp" %>
			<section class="mypage">
<%@include file="cms_content.jsp" %>
			<section class="mypage">
		</section>
	</div>
</body>
</html>