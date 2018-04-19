<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 11. 16. 오전 09:49:20
  @comment   : 후불다운로드 목록
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 25.   LEE.GWANGHO    download
---------------------------------------------------------------------------%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
 SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
 int beginYear = Integer.parseInt(yearFormat.format(new Date())) - 2; // 현재 년도 -2
 int endYear = Integer.parseInt(yearFormat.format(new Date())); // 현재 년도
%>
<c:set var="endYear" value="<%=endYear%>"/>
<c:set var="beginYear" value="<%=beginYear%>"/>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/mypage.js?v=20180410"></script>
<script type="text/javascript">
	
	//사용용도 선택
	function popup_usage() { 
		var chk_total = $("#mtBody input:checkbox:checked").length;
		if(chk_total == 0) { // 선택항목 갯수 체크 필수
			alert("최소 1개 이상을 선택해주세요.");	
		}else {
			var uciCode_arr = new Array();
			$("#mtBody input:checkbox:checked").each(function(index) {
				var uciCode = $(this).val();
				uciCode_arr.push(uciCode);
			});
			$("#uciCode_arr").val(uciCode_arr);
			
			var frm = document.download_popOption;
			frm.action = "/postBuylist.mypage";
			frm.method = "post";
			frm.submit();
		}
	}
	
	$(document).on("click", ".btn_input2", function() {
		popup_usage(); // 사용용도 선택
	});
	
	// 페이지 이동
	function pageMove(page){
		$("#pagingForm input[name=page]").val(page);
		$("#pagingForm input[name=year]").val($('#selectYear option:selected').val());
		
		$("#pagingForm").attr("action","/download.mypage");
		$("#pagingForm").attr("method","post");
		
		$("#pagingForm").submit();
	}
	

</script>
</head>
<body>
<div class="wrap">
	<%@include file="header.jsp" %>
	<section class="mypage">
		<div class="head">
			<h2>마이페이지</h2>
			<p>설명어쩌고저쩌고</p>
		</div>
		<div class="mypage_ul">
				<ul class="mp_tab1">
					<c:if test="${MemberInfo.type eq 'M' && MemberInfo.admission eq 'Y'}">
						<li>
							<a href="/accountlist.mypage">정산 관리</a>
						</li>
						<li>
							<a href="/cms">사진 관리</a>
						</li>
					</c:if>
					<li>
						<a href="/info.mypage">회원정보 관리</a>
					</li>
					<li>
						<a href="/dibs.myPage">찜관리</a>
					</li>
					<c:if test="${MemberInfo.deferred eq 2}">
						<li class="on">
							<a href="/download.mypage">다운로드 내역</a>
						</li>
						<li>
							<a href="/postBuylist.mypage">구매내역</a>
						</li>
					</c:if>
					<c:if test="${MemberInfo.deferred eq 0}">
						<li>
							<a href="/cart.myPage">장바구니</a>
						</li>
						<li>
							<a href="/buylist.mypage">구매내역</a>
						</li>
					</c:if>
				</ul>
				<!-- 컬렉션 생기면 추가 <ul class="mp_tab2">
					<li class="on"><a href="javascript:void(0)">사진 찜 관리</a></li>
					<li><a href="javascript:void(0)">컬렉션 찜 관리</a></li>
				</ul> -->
			</div>
		<div class="table_head">
			<h3>다운로드 내역</h3>
			<div class="cms_search"> 
				<c:if test="${MemberInfo.group_seq != 0}">
					<span class="mess">※고객님과 같은 그룹으로 묶인 계정에서 다운로드 받은 내역이 모두 공유됩니다.</span>
				</c:if>
				
				<select onchange="select_year(this.value, '/download.mypage')" id="selectYear">
<%-- 					<option <c:if test="${year eq '0'}">selected</c:if> value="0">전체</option> --%>
					<option <c:if test="${returnMap['year'][0] eq '0'}">selected</c:if> value="0">전체</option>
					<c:forEach var="yearOpt" begin="${beginYear}" end="${endYear}" step="1">
						<option <c:if test="${returnMap['year'][0] eq (beginYear-yearOpt+endYear)}">selected</c:if> value="${beginYear-yearOpt+endYear}">${beginYear-yearOpt+endYear}년</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<section class="order_list">
			<table cellpadding="0" cellspacing="0" class="tb03" style="border-top:0; margin-bottom:10px;">
				<colgroup>
				<col width="30">
				<col width="70">
				<col>
				<col width="220">
				</colgroup>
				<thead>
					<tr>
					<th scope="col"> <div class="tb_check">
							<input id="check_all" name="check_all" type="checkbox">
							<label for="check_all">선택</label>
						</div>
					</th>
						<th>번호</th>
						<th>다운로드 이미지 정보</th>
						<th>다운로드 날짜</th>
					</tr>
				</thead>
				<tbody id="mtBody">
					<c:forEach items="${downList}" var="download" varStatus="loop">
					<tr>
						<td>
							<div class="tb_check">
								<input id="check${loop.index+1}" name="check${loop.index+1}" type="checkbox" value="${download.photo_uciCode }"> <label
									for="check${loop.index+1}">선택</label>
							</div>
						</td>
						<td>${loop.index+1}</td>
						<td>
							<div class="cart_item">
								<div class="thumb">
									<a href="javascript:void(0);" onclick="go_View('${download.photo_uciCode}', '/view.photo', '_blank')">
										<img src="<%=IMG_SERVER_URL_PREFIX%>/view.down.photo?uciCode=${download.photo_uciCode}"/>
									</a>
								</div>
								<div class="cart_info">
									<a href="javascript:void(0);" onclick="go_View('${download.photo_uciCode}', '/view.photo', '_blank')">
										<div class="brand">${download.copyright}</div>
										<div class="code">${download.photo_uciCode}</div>
									</a>
								</div>
							</div> </a>
						</td>
						<td>${download.regDate}</td>
					</tr>
					</c:forEach>
					<c:if test="${fn:length(downList) == 0}">
						<tr>
							<td colspan="4">다운로드한 이미지가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<c:if test="${returnMap['total'][0]%returnMap['bundle'][0] == 0 }">
				<c:set value="${returnMap['total'][0]/returnMap['bundle'][0] }" var="lastPage" />
			</c:if>
			<c:if test="${returnMap['total'][0]%returnMap['bundle'][0] != 0 }">
				<c:set value="${returnMap['total'][0]/returnMap['bundle'][0]+1 }" var="lastPage" />
			</c:if>	
			<fmt:parseNumber var="lp" value="${lastPage}" integerOnly="true"/>
			<fmt:parseNumber var="cycleStart" value="${returnMap['page'][0]/10}" integerOnly="true"/>
			<c:if test="${lp > 0}">
			<div class="pagination">
				<ul style="margin-bottom:0;">
					<li class="first"> <a href="javascript:pageMove('1');">첫 페이지</a> </li>
					<c:if test="${returnMap['page'][0] > 1 }">
					<li class="prev"> <a href="javascript:pageMove('${returnMap['page'][0] - 1 }');">이전 페이지</a> </li>
					</c:if>
					<c:forEach  begin="${(cycleStart)*10+1}" end="${((cycleStart)*10 + 10) > lastPage ? lastPage:((cycleStart)*10 + 10)}" var="i" >
						<li class="active"> <a href="javascript:;" onclick="pageMove('${i}');">${i}</a> </li>
					</c:forEach>
					<c:if test="${returnMap['page'][0] < lp }">
					<li class="next"> <a href="javascript:pageMove('${returnMap['page'][0] + 1 }');"> 다음 페이지 </a> </li>
					</c:if>
					<li class="last"> <a href="javascript:pageMove('${lp}');"> 마지막 페이지 </a> </li>
				</ul>
			</div>
			</c:if>	
			<div class="btn_area">
				<c:if test="${fn:length(downList) > 0}">
					<a href="#" class="btn_input2">구매하기</a>
				</c:if>
				<!-- <a href="main.html" onclick="window.open('/download.popOption','new','resizable=no width=420 height=600');return false" class="btn_input2">구매하기</a> -->
			</div>
		</section>
	</section>
	<%@include file="footer.jsp"%>
</div>
<form method="post" action="/download.popOption" name="download_popOption">
	<input type="hidden" name=uciCode_arr id="uciCode_arr"/>
</form>

<form id="pagingForm">
	<input type="hidden" name="year" />
	<input type="hidden" name="page" value="${returnMap['page'][0]}"/>
	<input type="hidden" name="bundle" value="20"/>
</form>
	
<form id="dateForm" method="post"  target="dateFrame">
	<input type="hidden" id="year" name="year" />
</form>
<%@include file="down_frame.jsp" %>
<%@include file="view_form.jsp" %>
</body>
</html>