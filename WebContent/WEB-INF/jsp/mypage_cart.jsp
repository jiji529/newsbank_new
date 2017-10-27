<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 10. 25. 오후 03:25:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 25.   hoyadev        cart.mypage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
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
					<li><a href="#">로그인</a></li>
					<li><a href="#">가입하기</a></li>
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
					<li><a href="#">정산 관리</a></li>
					<li><a href="#">사진 관리</a></li>
					<li><a href="#">회원정보 관리</a></li>
					<li><a href="#">찜관리</a></li>
					<li class="on"><a href="#">장바구니</a></li>
					<li><a href="#">구매내역</a></li>
				</ul>
			</div>
			<div class="table_head">
				<h3>장바구니</h3>
			</div>
			<section id="order_list">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tb03" style="border-top:0; margin-bottom:15px;">
					<colgroup>
					<col width="40">
					<col>
					<col width="110">
					<col width="100">
					<col width="110">
					<col width="160">
					</colgroup>
					<tr>
						<th scope="col"> <div class="tb_check">
								<input id="check_all" name="check_all" type="checkbox">
								<label for="check_all">선택</label>
							</div>
						</th>
						<th scope="col">상품정보</th>
						<th scope="col">판매가</th>
						<th scope="col">부가세</th>
						<th scope="col">구매금액</th>
						<th scope="col">선택</th>
					</tr>
					<tr>
						<td><div class="tb_check">
								<input id="check1" name="check1" type="checkbox">
								<label for="check1">선택</label>
							</div></td>
						<td><div class="cart_item">
								<div class="thumb"><a href="view.html" target="_blank"><img src="https://www.newsbank.co.kr/datafolder/N0/2016/01/08/E006203286_T.jpg" /></a></div>
								<div class="cart_info"> <a href="view.html" target="_blank">
									<div class="brand">뉴시스</div>
									<div class="code">E006203286</div>
									</a>
									<div class="option_area">
										<ul class="opt_li">
											<li>상업용</li>
											<li>신문광고</li>
											<li>중앙지,스포츠지,경제지 등</li>
											<li>1~9단</li>
											<li>1년 이내</li>
										</ul>
										<ul class="opt_li">
											<li>출판용</li>
											<li>교육용</li>
											<li>전집, 백과사전, 도감, 학술논문 발표자료 등</li>
											<li>1~9단</li>
											<li>1년 이내</li>
										</ul>
										<a href= "main.html" onClick="window.open('pop_opt.html','new','resizable=no width=420 height=600');return false">옵션 변경/추가</a></div>
								</div>
							</div></td>
						<td>480,000원</td>
						<td>48,000원</td>
						<td><strong class="color">528,000원</strong></td>
						<td><div class="btn_group">
								<button type="button" class="btn_o" name="btn_buy">바로구매</button>
								<button type="button" class="btn_b" name="btn_zzim">찜 하기</button>
								<button type="button" class="btn_g" name="btn_delete">삭제</button>
							</div></td>
					</tr>
					
					<c:forEach items="${cartList}" var="CartDTO">
						<tr>
						<td><div class="tb_check">
								<input id="check1" name="check1" type="checkbox">
								<label for="check1">선택</label>
							</div></td>
						<td><div class="cart_item">
								<div class="thumb"><a href="view.html" target="_blank"><img src="images/serviceImages${CartDTO.getViewPath()}" /></a></div>
								<div class="cart_info"> <a href="view.html" target="_blank">
									<div class="brand">뉴시스</div>
									<div class="code">${CartDTO.uciCode}</div>
									</a>
									<div class="option_area">
										<ul class="opt_li">
											<li>${CartDTO.usage}</li>
											<li>${CartDTO.division1}</li>
											<li>${CartDTO.division2}</li>
											<li>${CartDTO.division3}</li>
											<li>${CartDTO.division4}</li>
										</ul>										
										<a href= "main.html" onClick="window.open('pop_opt.html','new','resizable=no width=420 height=600');return false">옵션 변경/추가</a></div>
								</div>
							</div></td>
						<td>480,000원</td>
						<td>48,000원</td>
						<td><strong class="color">${CartDTO.price}원</strong></td>
						<td><div class="btn_group">
								<button type="button" class="btn_o" name="btn_buy">바로구매</button>
								<button type="button" class="btn_b" name="btn_zzim">찜 하기</button>
								<button type="button" class="btn_g" name="btn_delete">삭제</button>
							</div></td>
					</tr>
					</c:forEach>
				</table>
	<a href="#" class="mp_btn" style="float:left;">선택 삭제</a>
			<div class="calculate_info_area">총 금액<strong>480,000</strong>원<span style="margin:0 20px;">+</span> 부가세<strong>48,000</strong>원<span style="margin:0 20px;">=</span> 총 판매금액 : <strong class="color">528,000</strong>원</div>
			<div class="btn_area"><a href="#" class="btn_input2">결제하기</a></div>
	
	</section>
		</section>
	</div>
</body>
</html>
