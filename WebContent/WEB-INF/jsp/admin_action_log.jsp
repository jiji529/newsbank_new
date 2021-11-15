<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2021. 11. 10. 오전 09:06:10
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2021. 11. 10.   LEE GWANGHO    actionlog.manage
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
<script src="js/admin.js"></script>
<script src="js/paging.js"></script>
<script>

	function search(state) {
		var keyword = $("#keyword").val(); keyword = $.trim(keyword);
		var start_date = $("input[name=start_date]").val(); // 시작일
		var end_date = $("input[name=end_date]").val(); // 종료일
		var startgo = $("#startgo").val(); // 페이지 번호
		var totalPage = 0;
		
		var searchParam = {
			"keyword":keyword
			, "start_date":start_date
			, "end_date":end_date
			, "startgo":startgo
		};
		
		var listHTML = "";
		$.ajax({
			type: "POST",
			dataType: "json",
			data: searchParam,
			url: "/actionlog.api",
			success: function(data) {
				totalPage = data.totalPage;
				var coverClass = "";
				
				$(data.result).each(function(key, val) {
					//listHTML += "<li class=\"thumb " + coverClass + "\"> <a href=\"/view.photo?uciCode=" + val.uciCode + "\" target=\"_blank\"><img src=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>\" /></a>";
					listHTML += "<li class=\"thumb " + coverClass + "\"> <a onclick=\"popupModLog('" + val.uciCode + "')\" href=\"#none\"><img src=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>\" /></a>";
					listHTML += "<div class=\"thumb_info\">";
					listHTML += "<span>" + val.uciCode + "</span><span>" + val.memberName + "</span></div>";
					listHTML +=  "</div>";
				});
				$("#cms_list2 ul").html(listHTML);		
			}, complete: function() {
				if(state == undefined) {
					pagings(totalPage);
				}
			}
		});
	}

</script>

<title>뉴스뱅크</title>
</head>
<body>
	<div class="wrap admin">
		<%@include file="header_admin.jsp"%>
		<section class="wide"> 
			<%@include file="sidebar.jsp"%>
			<%@include file="view_form.jsp" %>
			<%@include file="history_popup.jsp"%>
			<div class="mypage">
				<div class="table_head">
					<h3>수정이력 관리</h3>
				</div>
				
				<div class="ad_sch_area">
					<table class="tb01" cellpadding="0" cellspacing="0">
						<colgroup>
							<col style="width: 180px;">
							<col style="width:;">
						</colgroup>
						<tbody>
							<tr>
								<th>기간선택</th>
								<td>
									<ul id="customDayOption" class="period">
										<c:forEach var="pastMonth" items="${pastMonths}">
											<li><a href="javascript:;" class="btn" value="${pastMonth}">${fn:substring(pastMonth, 4, 6)}월</a> </li>
										</c:forEach>
									</ul>
									<div class="period">
										<input type="text"  size="12" id="contractStart" name="start_date"  class="inp_txt" value="${year}-${month-1}-01" maxlength="10">
										<span class=" bar">~</span>
										<input type="text"  size="12" id="contractEnd" name="end_date"  class="inp_txt" value="${today }" maxlength="10">
									</div>
								</td>
							</tr>
							
							<tr>
								<th>키워드</th>
								<td>
									<input type="text" id="keyword" class="period" size="80" placeholder="UCI코드" />
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_area" style="margin-top: 0;">
						<a href="#" id="actionLog_search" class="btn_input2">검색</a>
					</div>
				</div>
				
				<section id="cms_list2">
					<ul>
						<!-- 수정 이력 사진목록 -->
					</ul>
				</section>
				<input type="hidden" id="uciCode" value="" />
				<input type="hidden" id="totcnt" value="" />
				<input type="hidden" id="startgo" value="" />
				<input type="hidden" id="lastvalue" value="" />		
				<div class="pagination">
					<ul id="pagination-demo" class="pagination-sm">
						<!-- 페이징 -->
					</ul>
				</div>
			</div>
		</section>
	</div>
	
	<form id="downForm" method="post"  target="downFrame">
		<input type="hidden" id="currentKeyword" name="keyword" />
		<input type="hidden" id="startDate" name="start_date" />
		<input type="hidden" id="endDate" name="end_date" />
		<input type="hidden" id="pageVol" name="pageVol" />
		<input type="hidden" id="startPage" name="startPage" value="file" />
	</form>	
</body>
</html>