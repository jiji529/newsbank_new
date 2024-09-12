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
 SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
 int beginYear = Integer.parseInt(yearFormat.format(new Date())) - 2; // 현재 년도 -2
 int endYear = Integer.parseInt(yearFormat.format(new Date())); // 현재 년도
 int currentMonth = Integer.parseInt(monthFormat.format(new Date())); // 현재 월
%>
<c:set var="endYear" value="<%=endYear%>"/>
<c:set var="beginYear" value="<%=beginYear%>"/>
<c:set var="currentMonth" value="<%=currentMonth%>"/>    
<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>NYT 뉴스뱅크</title>

<link rel="stylesheet" href="css/nyt/base.css" />
<link rel="stylesheet" href="css/nyt/sub.css" />
<link rel="stylesheet" href="css/nyt/mypage.css" />

<script src="js/nyt/jquery-1.12.4.min.js"></script>
<script src="js/nyt/filter.js"></script>
<script src="js/nyt/footer.js"></script>
<script src="js/nyt/mypage.js?v=20180412"></script>
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
			
			// 구매내역 페이지 이동
			window.open("", "openWin", "toolbar=no, resizable=no, width=420, height=600, directories=no, status=no, scrollbars=no");
			var frm = document.download_popOption;
			//frm.action = "/postBuylist.mypage";
			frm.method = "post";
			frm.target = "openWin";
			frm.submit();
		}
	}
	
	$(document).on("click", ".btn_input2", function() {
		popup_usage(); // 사용용도 선택
	});
	

</script>
</head>
<body>
<div class="wrap">
	<%@include file="common/headerKR2.jsp" %>
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
				
				<c:if test="${MemberInfo.type eq 'Q' && MemberInfo.admission eq 'Y'}">
					<li>
						<a href="/cms">사진 관리</a>
					</li>
				</c:if>
				
				<c:if test="${MemberInfo.type eq 'W' && MemberInfo.admission eq 'Y'}">
					<li>
						<a href="/accountlist.mypage">정산 관리</a>
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
					<span class="mess">※ 다운로드 시일이 오래 된 사진을 이용하시려는 경우, 사진이 판매중지 상태가 아닌지 반드시 확인 부탁드립니다.</span>
				</c:if>
				
				<select onchange="select_year('/download.mypage')" id="selectYear">
					<option <c:if test="${returnMap['year'][0] eq '0'}">selected</c:if> value="0">년도 전체</option>
					<c:forEach var="yearOpt" begin="${beginYear}" end="${endYear}" step="1">
						<option <c:if test="${returnMap['year'][0] eq (beginYear-yearOpt+endYear)}">selected</c:if> value="${beginYear-yearOpt+endYear}">${beginYear-yearOpt+endYear}년</option>
					</c:forEach>
				</select>
				
				<select onchange="select_month('/download.mypage')" id="selectMonth">
					<option value="0">월 전체</option>
					
					<!-- (선택년도 == 현재년도) -> 현재월까지 표시  -->
					<c:if test="${returnMap['year'][0] eq endYear}">
						<c:forEach var="monthOpt" begin="1" end="${currentMonth}" step="1">
							<option <c:if test="${returnMap['month'][0] eq monthOpt}">selected</c:if> value="${monthOpt}">${monthOpt}월</option>
						</c:forEach>
					</c:if>
					
					<!-- 과거년도는 (1~12월) 표시 -->
					<c:if test="${returnMap['year'][0] < endYear}">
						<c:forEach var="monthOpt" begin="1" end="12" step="1">
							<option <c:if test="${returnMap['month'][0] eq monthOpt}">selected</c:if> value="${monthOpt}">${monthOpt}월</option>
						</c:forEach>
					</c:if>
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
							<c:if test="${download.withdraw eq 0 && download.admission eq 'Y' && download.activate eq 1 && download.saleState eq 1}">
								<input id="check${loop.index+1}" name="check${loop.index+1}" type="checkbox" value="${download.photo_uciCode }"> <label
									for="check${loop.index+1}">선택</label>
							</c:if>
							</div>
						</td>
						<c:set value="${returnMap['bundle'][0] * (returnMap['page'][0] - 1) + loop.index+1 }" var="number"/>
						<td>${number}</td>
						<td>
							<div class="cart_item">
								<div class="thumb">
									<c:choose>
										<c:when test="${download.withdraw eq 0 && download.admission eq 'Y' && download.activate eq 1 && download.saleState eq 1}">
											<a href="javascript:void(0);" onclick="go_View('${download.photo_uciCode}', '/view.photo', '_blank')">
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0);" onclick="stopSaleMessage()">
										</c:otherwise>
									</c:choose>
									<img src="<%=IMG_SERVER_URL_PREFIX%>/view.down.photo?uciCode=${download.photo_uciCode}"/>
											</a>
								</div>
								<div class="cart_info">
									<c:choose>
										<c:when test="${download.withdraw eq 0 && download.admission eq 'Y' && download.activate eq 1 && download.saleState eq 1}">
											<a href="javascript:void(0);" onclick="go_View('${download.photo_uciCode}', '/view.photo', '_blank')">
												<div class="brand">${download.copyright}</div>
												<div class="code">${download.photo_uciCode}</div>
											</a>
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0);" onclick="stopSaleMessage()">
												<div class="brand">${download.copyright}</div>
												<div class="code">${download.photo_uciCode}</div>
											</a>
										</c:otherwise>
									</c:choose>
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
			<fmt:parseNumber var="cycleStart" value="${returnMap['page'][0]/10 + (returnMap['page'][0]%10==0?-1:0)}" integerOnly="true"/>
			<c:if test="${lp > 0}">
			<div class="pagination">
				<ul style="margin-bottom:0;">
					<li class="first"> <a href="javascript:pageMove('1', '${path}');">첫 페이지</a> </li>
					<c:if test="${returnMap['page'][0] > 1 }">
					<li class="prev"> <a href="javascript:pageMove('${returnMap['page'][0] - 1 }', '${path}');">이전 페이지</a> </li>
					</c:if>
					<c:forEach  begin="${(cycleStart)*10+1}" end="${((cycleStart)*10 + 10) > lastPage ? lastPage:((cycleStart)*10 + 10)}" var="i" >
						<li class="${returnMap['page'][0]==i?'active':''}"> <a href="javascript:;" onclick="pageMove('${i}', '${path}');">${i}</a> </li>
					</c:forEach>
					<c:if test="${returnMap['page'][0] < lp }">
					<li class="next"> <a href="javascript:pageMove('${returnMap['page'][0] + 1 }', '${path}');"> 다음 페이지 </a> </li>
					</c:if>
					<li class="last"> <a href="javascript:pageMove('${lp}', '${path}');"> 마지막 페이지 </a> </li>
				</ul>
			</div>
			</c:if>	
			<div class="btn_area">
				<c:if test="${fn:length(downList) > 0}">
					<a href="#" class="btn_input2">구매하기</a>
				</c:if>
			</div>
		</section>
	</section>
	<%@include file="common/footerKR.jsp"%>
</div>
<form method="post" action="/download.popOption" name="download_popOption">
	<input type="hidden" name=uciCode_arr id="uciCode_arr"/>
</form>

<form id="pagingForm">
	<input type="hidden" name="year" />
	<input type="hidden" name="month" />
	<input type="hidden" name="page" value="${returnMap['page'][0]}"/>
	<input type="hidden" name="bundle" value="20"/>
</form>
	
<form id="dateForm" method="post">
	<input type="hidden" id="month" name="month" />
	<input type="hidden" id="year" name="year" />
</form>
<%@include file="down_frame.jsp" %>
<%@include file="view_form.jsp" %>
</body>
</html>