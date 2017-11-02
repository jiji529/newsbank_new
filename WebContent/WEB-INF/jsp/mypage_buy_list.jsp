<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 11. 1.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 1.   	  tealight        file_name
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/mypage.js"></script>
<%
	String type = (String) request.getAttribute("type");
%>
</head>
<body>
	<div class="wrap">
		<nav class="gnb_dark">
			<div class="gnb">
				<a href="/home" class="logo"></a>
				<ul class="gnb_left">
					<li class="">
						<a href="/picture">보도사진</a>
					</li>
					<li>
						<a href="#">뮤지엄</a>
					</li>
					<li>
						<a href="#">사진</a>
					</li>
					<li>
						<a href="#">컬렉션</a>
					</li>
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
						<a href="/kind.join" target="_blank">가입하기</a>
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
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1">
						<%
							if (type.equals("M")) {
								//임시
						%>
						<li>
							<a href="/acount.mypage">정산 관리</a>
						</li>
						<li>
							<a href="/cms">사진 관리</a>
						</li>
						<%
							}
						%>
						<li>
							<a href="/info.mypage">회원정보 관리</a>
						</li>
						<li>
							<a href="/dibs.myPage">찜관리</a>
						</li>
						<li>
							<a href="/cart.myPage">장바구니</a>
						</li>
						<li>
							<a href="/buylist.mypage">구매내역</a>
						</li>
					</ul>
			</div>
			<div class="table_head">
				<h3>구매내역</h3>
			</div>
			<section id="order_list">
				<table width="100%" id="" border="0" cellspacing="0" cellpadding="0" class="tb03" style="border-top: 0;">
					<colgroup>
						<col width="40">
						<col>
						<col width="200">
						<col width="200">
						<col width="200">
					</colgroup>
					<tr>
						<th scope="col">No</th>
						<th scope="col">주문번호</th>
						<th scope="col">결제방법</th>
						<th scope="col">결제금액</th>
						<th scope="col">결제상태</th>
					</tr>
					<tr>
						<td>1</td>
						<td>
							<a href="/buy.mypage">admin_20160616142752</a>
						</td>
						<td>무통장입금</td>
						<td>\88,000</td>
						<td>입금완료</td>
					</tr>
				</table>
			</section>
		</section>
	</div>
</body>
</html>