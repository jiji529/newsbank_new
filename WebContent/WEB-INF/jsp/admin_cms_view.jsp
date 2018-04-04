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

<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css">
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>
<script src="js/filter.js"></script>

<script src="js/cms.js.jsp"></script>
<script src="js/cms_view.js.jsp"></script>
<script src="js/search.js.jsp"></script>

<script> 
	//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
	$(document).ready(function() {
		$("[href]").each(function() {
			if (this.href == window.location.href) {
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
<title>뉴스뱅크</title>
</head>
<body>
	<div class="wrap admin">
		<%@include file="header_admin.jsp" %>
		<section class="wide">
			<%@include file="sidebar.jsp" %>
			<div class="mypage">
			<div class="table_head">
				<h3>사진관리</h3>
				<div class="cms_search">
					이미지 검색 <input id="cms_keyword" type="text" />
					<button id="cms_searchBtn">검색</button>
				</div>

			</div>
			<form class="view_form" method="post" action="/cms.manage" name="view_form" >
				<input type="hidden" id="cms_keyword_current" name="cms_keyword_current" />
			</form>
<%@include file="cms_content.jsp" %>
		</section>
	</div>
</body>
</html>