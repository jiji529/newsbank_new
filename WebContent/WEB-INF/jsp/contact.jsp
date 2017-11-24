<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 11. 13.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 13.   	  tealight        file_name
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크-직접문의하기</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/footer.js"></script>
</head>
<body>
<div class="wrap">
	<%@include file="header.jsp" %>
	<section class="mypage">
		<div class="head">
			<h2>이용안내</h2>
			<p>뉴스뱅크 사이트에 관하여 알려드립니다.</p>
		</div>
		<div class="mypage_ul">
			<ul class="mp_tab1 use">
				<li><a href="/price.info">구매안내</a></li>
				<li><a href="/board">공지사항</a></li>
				<li><a href="/FAQ">FAQ</a></li>
				<li class="on"><a href="/contact">직접 문의하기</a></li>
				<!-- <li><a href="sitemap.html">사이트맵</a></li> -->
			</ul>
		</div>
		<div class="table_head">
			<h3>직접 문의하기</h3>
		</div>
		<div class="call">
		<!-- 여기 내용들은 바뀔거에요 지금 다하미홈페이지에서 끌어온내용이라 내용 바뀝니다 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<th scope="col">문의사항</th>
						<th scope="col">연락처</th>
						<th scope="col">메일</th>
					</tr>
					<tr>
						<td>영업/계약</td>
						<td>02-593-4174 (206,220)</td>
						<td>kdhmns@dahami.com<br>
							khim83@dahami.com</td>
					</tr>
					<tr>
						<td>매체 제휴</td>
						<td>02-593-4174 (218)</td>
						<td>seoki@dahami.com</td>
					</tr>
					<tr>
						<td>기술지원</td>
						<td>02-593-4174 (414)</td>
						<td>helpdesk@dahami.com</td>
					</tr>
				</tbody>
			</table>
			<div class="call_box">
				<h3>개인정보 수집 및 이용동의</h3>
				<div class="agree_box"> <strong>[개인정보 수집 등에 대한 동의]</strong><br>
					<br>
					<strong>1. 개인정보 수집 항목 및 목적</strong><br>
					해당 페이지는 다하미커뮤니케이션즈 중간관리자 지원 시 문의하는 내용에 대해 문의자와의 원활한 의사소통을 위한 목적으로 아래와 같은 항목을 수집합니다.<br>
					: 이름, 이메일 주소, 연락처<br>
					<br>
					<strong>3. 개인정보의 보유 및 이용기간</strong><br>
					: 수집된 개인정보는 보유 및 이용 목적이 완료된 후 즉시 파기됩니다. 또한 ‘문의하기’를 통해 삭제 요청을 하는 경우 3일 이내 파기됩니다.<br>
					<br>
					※ 귀하는 이에 대한 동의를 거부할 수 있으며, 다만 동의하지 않으실 경우 문의가 불가능 할 수 있음을 알려드립니다.<br>
					<br>
				</div>
				<div class="agree_check">
					<p>
						<input type="checkbox">
						<label for="agree">개인정보 수집 및 이용에 동의합니다.</label>
					</p>
				</div>
				<h3>질문하기</h3>
				<dl>
					<dt>성명</dt>
					<dd>
						<input type="text"  />
					</dd>
					<dt>연락처</dt>
					<dd>
						<input type="text" class="num" />
						<span>-</span>
						<input type="text" class="num" />
						<span>-</span>
						<input type="text" class="num" />
					</dd>
					<dt>이메일</dt>
					<dd>
						<input type="text" class="mail"/>
						<span>@</span>
						<input type="text" class="mail"/>
					</dd>
					<dt>제목</dt>
					<dd>
						<input type="text" style="width:950px" />
					</dd>
					<dt class="main_cont">질문내용</dt>
					<dd class="main_cont">
						<textarea></textarea>
					</dd>
				</dl>
				<div class="call_send"><a href="javascript:void(0)">등록</a></div>
			</div>
		</div>
	</section>
</div>
</body>
</html>