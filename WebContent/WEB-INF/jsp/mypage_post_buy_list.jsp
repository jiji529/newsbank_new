<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 11. 16. 오전 09:49:20
  @comment   : 후불 결제내역 목록
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 25.   LEE.GWANGHO    postBuylist
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
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
<script src="js/mypage.js"></script>
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
					<c:if test="${MemberInfo.type eq 'M'}">
						<li>
							<a href="/account.mypage">정산 관리</a>
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
					<c:if test="${MemberInfo.deferred eq 'Y'}">
						<li>
							<a href="/download.mypage">다운로드 내역</a>
						</li>
						<li class="on">
							<a href="/postBuylist.mypage">구매내역</a>
						</li>
					</c:if>
					<c:if test="${MemberInfo.deferred eq 'N'}">
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
			<h3>구매 내역</h3>
		</div>
		<section class="order_list">
			<table cellpadding="0" cellspacing="0" class="tb03" style="border-top:0; margin-bottom:10px;">
				<colgroup>
				<col width="30">
				<col width="70">
				<col>
				<col width="120">
				<col width="60">
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
						<th>구매 이미지 정보</th>
						<th>콘텐츠가격</th>
						<th>파일</th>
						<th>구매일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><div class="tb_check">
								<input id="check1" name="check1" type="checkbox">
								<label for="check1">선택</label>
							</div></td>
						<td>1</td>
						<td><div class="cart_item">
								<div class="thumb"> <a href="view.html" target="_blank"><img src="https://www.newsbank.co.kr/datafolder/N0/2016/01/08/E006203286_T.jpg"></a> </div>
								<div class="cart_info"> <a href="view.html" target="_blank">
									<div class="brand">뉴시스</div>
									<div class="code">E006203286</div>
									</a>
									<div class="option_area">
										<ul class="opt_li">
											<li>출판용</li>
											<li>전시,디스플레이</li>
											<li>오프라인</li>
											<li>카달로그, 팜플렛, 브로슈어,리플렛, 메뉴얼,샘플북 e-카다로그,전자브로셔 </li>
											<li>5,000 ~ 10,000부 미만 </li>
										</ul>
									</div>
								</div>
							</div>
							</a></td>
						<td>\88,000</td>
						<td>jpg</td>
						<td>2016-08-04 10:29:19</td>
					</tr>
				</tbody>
				<tfoot>
				<td colspan="6">합계 : \88,000</td>
					</tfoot>
			</table>
		</section>
	</section>
	<%@include file="footer.jsp"%>
</div>
</body>
</html>