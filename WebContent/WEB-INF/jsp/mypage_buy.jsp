<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 10. 12. 오전 11:20:00
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 16.   hoyadev        buy.mypage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
</head>
<body>
<div class="wrap">
	<nav class="gnb_dark">
		<div class="gnb"><a href="#" class="logo"></a>
			<ul class="gnb_left">
				<li class=""><a href="#">보도사진</a></li>
				<li><a href="#">뮤지엄</a></li>
				<li><a href="#">사진</a></li>
				<li><a href="#">컬렉션</a></li>
			</ul>
			<ul class="gnb_right">
				<%
					if (session.getAttribute("MemberInfo") == null) // 로그인이 안되었을 때
					{
						// 로그인 화면으로 이동
				%>
				<li>
					<a href="/login">로그인</a>
				</li>
				<li>
					<a href="/kind.join">가입하기</a>
				</li>
				<%
					} else { // 로그인 했을 경우
				%>
				<li>
					<a href="/logout">Log Out</a>
				</li>
				<li>
					<a href="/info.mypage">My Page</a>
				</li>
				<%
					}
				%>
			</ul>
		</div>
		<div class="gnb_srch">
			<form id="searchform">
				<input type="text" value="검색어를 입력하세요" />
				<a href="#" class="btn_search">검색</a>
			</form>
		</div>
	</nav>
	<section class="mypage">
		<div class="head">
			<h2>마이페이지</h2>
			<p>설명어쩌고저쩌고</p>
		</div>
		<div class="mypage_ul">
			<ul class="mp_tab1">
				<li>
					<a href="/acount.mypage">정산 관리</a>
				</li>
				<li>
					<a href="/cms">사진 관리</a>
				</li>
				<li>
					<a href="/info.mypage">회원정보 관리</a>
				</li>
				<li>
					<a href="#">찜관리</a>
				</li>
				<li>
					<a href="#">장바구니</a>
				</li>
				<li  class="on">
					<a href="/buy.mypage">구매내역</a>
				</li>
			</ul>
		</div>
		<div class="table_head">
			<h3>주문 상세 정보</h3>
		</div>
		<section id="order_list">
		<div class="calculate_info_area">주문번호 :  <span class="color">ADMIN_20160616142752</span></div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tb03">
				<colgroup>
				<col width="200">
				<col width="200">
				<col width="300">
				<col width="300">
				</colgroup>
				<tr>
					<th scope="col">결제방법</th>
					<th scope="col">결제상태</th>
					<th scope="col">거래번호</th>
					<th scope="col">가상계좌번호</th>
				</tr>
				<tr>
					<td><a href="my14.html">무통장입금</a></td>
					<td>입금완료</td>
					<td>daham2016061614285098825</td>
					<td>[신한] 63790118761202</td>
				</tr>
			</table>
					<table cellpadding="0" cellspacing="0" class="tb02">				<colgroup>
				<col width="150">
				<col width="100">
				<col width="120">
				<col width="100">
				<col width="60">
				<col width="100">
				<col width="100">
				<col width="100">
				<col width="100">
				<col width="200">
				</colgroup>

			<thead>
				<tr>
					<th>상품이미지</th>
					<th>카테고리</th>
					<th>상품코드</th>
					<th>콘텐츠가격</th>
					<th>파일</th>
					<th>구분</th>
					<th>상세</th>
					<th>용도</th>
					<th>기간</th>
					<th>다운로드 기간</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><a href="view.html"><img src="https://www.newsbank.co.kr/datafolder/N0/2016/01/08/E006203286_T.jpg" /></a></td>
					<td>보도사진</td>
					<td>E006203286</td>
					<td>\88,000</td>
					<td>jpg</td>
					<td>기록사진</td>
					<td>인쇄매체</td>
					<td>단행본,잡지내지</td>
					<td>1년 이내</td>
					<td>2016-08-04 10:29:19~<br />2016-08-05 10:29:19</td>
				</tr>
			</tbody>
			<tfoot>
			<td colspan="10">합계 : \88,000</td>
				</tfoot>
		</table>
		<a href="my13.html" class="mp_btn">목록</a>
		</section>
	</section>
</div>
</body>
</html>

