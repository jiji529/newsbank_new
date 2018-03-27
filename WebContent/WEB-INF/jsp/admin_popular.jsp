<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2018. 03. 07. 오후 14:24:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 21.   LEE GWANGHO    popular.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.dahami.newsbank.web.service.bean.SearchParameterBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
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
<script type="text/javascript">
	$(document).ready(function() {
		//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
		$("[href]").each(function() {
			if (this.href == window.location.href) {
				$(this).parent().addClass("on");
			}
		});		
		
	});
	
	function tabSwitch(tabName) {
		$("#tabName").val(tabName);
		popular_form.submit();
	}
</script>

<title>뉴스뱅크</title>
</head>
<body>
	<div class="wrap admin">
		<%@include file="header_admin.jsp"%>
		<section class="wide"> <%@include file="sidebar.jsp"%>

			<div class="mypage">
				<div class="table_head">
					<h3>인기사진 관리</h3>
				</div>
				<div class="tab">
					<ul class="tabs">
						<li><a href="javascript:tabSwitch('selected')" <c:if test="${tabName eq 'selected'}">class="active"</c:if>>엄선한 사진</a></li>
						<li><a href="javascript:tabSwitch('download')" <c:if test="${tabName eq 'download'}">class="active"</c:if>>다운로드</a></li>
						<li><a href="javascript:tabSwitch('zzim')" <c:if test="${tabName eq 'zzim'}">class="active"</c:if>>찜</a></li>
						<li><a href="javascript:tabSwitch('detail')" <c:if test="${tabName eq 'detail'}">class="active"</c:if>>상세보기</a></li>
					</ul>
				</div>
				
				<div class="popular_list">
					<c:if test="${tabName eq 'selected'}">
						<%@include file="admin_tab_photo_selected.jsp"%>
					</c:if>
					
					<c:if test="${tabName eq 'download'}">
						<%@include file="admin_tab_photo_download.jsp"%>
					</c:if>
					
					<c:if test="${tabName eq 'zzim'}">
						<%@include file="admin_tab_photo_zzim.jsp"%>
					</c:if>
					
					<c:if test="${tabName eq 'detail'}">
						<%@include file="admin_tab_photo_detail.jsp"%>
					</c:if>
				</div>
				
				<div id="photo_area">
					<img
						src="http://www.dev.newsbank.co.kr/view.down.photo?uciCode=I011-M001047566&amp;dummy=LZsxEkUOqaAHHg14cFQjxA%3D%3D"
						alt="미리보기인데 제가 구현할 수 없으니 통이미지로 넣었습니다. 이 영역에 미리보기 넣어주세요!"
						style="float: left; width: 100%;">
				</div>
			</div>

		</section>
	</div>
	
	<form method="post" action="/popular.manage" name="popular_form" >
		<input type="hidden" id="tabName" name="tabName" />
	</form>
</body>
</html>