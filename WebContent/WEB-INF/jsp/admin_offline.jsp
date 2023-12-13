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
  2017. 11. 21.   LEE GWANGHO    offline.manage
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
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
<fmt:formatDate value="${now}" pattern="yyyy" var="year" />
<fmt:formatDate value="${now}" pattern="MM" var="month" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css">

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>
<script src="js/jquery.twbsPagination.js"></script>
<script src="js/admin.js?v=20231213"></script>

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
		offline_form.submit();
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
					<h3>오프라인 결제 관리</h3>
				</div>
				<div class="tab">
					<ul class="tabs">
					
						<li><a href="javascript:tabSwitch('download')" <c:if test="${tabName eq 'download'}">class="active"</c:if>>다운로드 내역</a></li>
						<li><a href="javascript:tabSwitch('buylist')" <c:if test="${tabName eq 'buylist'}">class="active"</c:if>>구매 내역</a></li>
						<li><a href="javascript:tabSwitch('fatsell')" <c:if test="${tabName eq 'fatsell'}">class="active"</c:if>>다운로드 후 비구매 계정</a></li>
					</ul>
				</div>
				
				<div class="tab_download">
					<c:if test="${tabName eq 'download'}">
						<%@include file="admin_tab_download.jsp"%>
					</c:if>				
				</div>
				
				<div class="tab_buylist">
					<c:if test="${tabName eq 'buylist'}">
						<%@include file="admin_tab_buylist.jsp"%>
					</c:if>
				</div>
				
				<div class="tab_fatsell">
					<c:if test="${tabName eq 'fatsell'}">
						<%@include file="admin_tab_fatsell.jsp"%>
					</c:if>
				</div>
				
			</div>
		</section>
	</div>
	
	<form method="post" action="/offline.manage" name="offline_form" >
		<input type="hidden" id="tabName" name="tabName" />
	</form>
	
	<form id="downForm" method="post"  target="downFrame">
		<input type="hidden" id="currentKeyword" name="keyword" />
		<input type="hidden" id="currentKeywordType" name="keywordType" />
		<input type="hidden" id="currentStatus" name="status" />
		<input type="hidden" id="startDate" name="start_date" />
		<input type="hidden" id="endDate" name="end_date" />
		<input type="hidden" id="currentContractStart" name="contractStart" />
		<input type="hidden" id="currentContractEnd" name="contractEnd" />
		<input type="hidden" id="pageVol" name="pageVol" />
		<input type="hidden" id="startPage" name="startPage" value="file" />
	</form>
	<iframe id="downFrame" name="downFrame" style="display:none"></iframe>
</body>
</html>