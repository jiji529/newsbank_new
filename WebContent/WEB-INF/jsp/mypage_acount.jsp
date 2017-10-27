<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 10. 19.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 19.   	  tealight        file_name
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/footer.js"></script>
<script src="js/common.js"></script>
</head>
<%
	String type = (String) request.getAttribute("type");
%>
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
					<a href="/dibs.myPage">찜관리</a>
				</li>
				<li>
					<a href="/cart.myPage">장바구니</a>
				</li>
				<li>
					<a href="/buy.mypage">구매내역</a>
				</li>
			</ul>
			<ul class="mp_tab2">
				<li class="on">
					<a href="#">정산정보 관리</a>
				</li>
				<li>
					<a href="my07.html">정산 내역</a>
				</li>
			</ul>
		</div>
		<div class="table_head">
			<h3>정산 정보 관리</h3>
		</div>
		<table class="tb01" cellpadding="0" cellspacing="0">
			<colgroup>
			<col style="width:240px;">
			<col style="width:;">
			</colgroup>
			<tbody>
				<tr>
					<th>매체명</th>
					<td><select name="" class="inp_txt" style="width:450px;">
							<option value="010" selected="selected">선택해주세요.</option>
						</select></td>
				</tr>
				<tr>
					<th>입금 계좌</th>
					<td><select name="" class="inp_txt" style="width:120px;">
							<option value="010" selected="selected">기업은행</option>
						</select>
						<input type="text" class="inp_txt" size="40" />
						<a href="#" class="btn_input1">통장사본 업로드</a> <a href="#" class="btn_input1">다운로드</a></td>
				</tr>
				<tr>
					<th>계약기간</th>
					<td><input type="text"  size="12"  class="inp_txt" value="2017-05-01" maxlength="10">
						<span class=" bar">~</span>
						<input type="text"  size="12"  class="inp_txt" value="2017-05-01" maxlength="10">
						<div class="check">
							<input type="checkbox" />
							자동연장</div>
						<a href="#" class="btn_input1">계약서 업로드</a> <a href="#" class="btn_input1">다운로드</a></td>
				</tr>
				<tr>
					<th><span class="ex">*</span>정산 요율</th>
					<td><span class=" bar">온라인 결제</span>
						<input type="text" size="5"  class="inp_txt" value="" maxlength="3"><span class=" bar">%</span>
						<span class=" bar" style="margin-left:20px;">후불 결제</span>
						<input type="text" size="5"  class="inp_txt" value="" maxlength="3"><span class=" bar">%</span></td>
				</tr>
				<tr>
					<th>세금계산서 담당자</th>
					<td><input type="text" class="inp_txt" size="60" /></td>
				</tr>
				<tr>
					<th>세금계산서 담당자 연락처</th>
					<td><select name="" class="inp_txt" style="width:70px;">
							<option value="010" selected="selected">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select>
						<span class=" bar">-</span>
						<input type="text" id="celphone" size="5"  class="inp_txt" value="1234" maxlength="4">
						<span class=" bar">-</span>
						<input type="text" id="celphone2" size="5"  class="inp_txt" value="1234" maxlength="4" /></td>
				</tr>
				<tr>
					<th>세금계산서 담당자 이메일</th>
					<td><input type="text" class="inp_txt" size="60" /></td>
				</tr>
			</tbody>
		</table>
		<p class="ex_txt">*수정이 필요한 경우, 회사(02-593-4174) 또는 뉴스뱅크 서비스 담당자에게 연락 부탁드립니다.</p>
		<div class="btn_area"><a href="#" class="btn_input2">수정</a><a href="#" class="btn_input1">취소</a></div>
	</section>
</div>
</body>
</html>
