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
				<li class="on"><a href="#">정산 관리</a></li>
				<li><a href="#">사진 관리</a></li>
				<li><a href="#">회원정보 관리</a></li>
				<li><a href="#">찜관리</a></li>
				<li><a href="#">장바구니</a></li>
				<li><a href="#">구매내역</a></li>
			</ul>
		</div>
		<div class="table_head">
			<h3>정산 내역</h3>
			<!--<p class="txt">결제정보를 등록하시면 결제 시 자동으로 반영됩니다.</p>-->
		</div>
		<table class="tb01" cellpadding="0" cellspacing="0">
			<colgroup>
			<col style="width:240px;">
			<col style="width:;">
			</colgroup>
			<tbody>
				<tr>
					<th>조회기간 선택</th>
					<td><input type="text"  size="12"  class="inp_txt" value="2017-05-01" maxlength="10">
						<span class=" bar">~</span>
						<input type="text"  size="12"  class="inp_txt" value="2017-05-01" maxlength="10"></td>
				</tr>
				<tr>
					<th>기간별 조회</th>
					<td><select name="" class="inp_txt" style="width:100px;">
							<option value="010" selected="selected">2017</option>
						</select>
						<ul>
							<li><a href="#" class="btn">1월</a> </li>
							<li><a href="#" class="btn">2월</a> </li>
							<li><a href="#" class="btn">3월</a> </li>
							<li><a href="#" class="btn">4월</a> </li>
							<li><a href="#" class="btn">5월</a> </li>
							<li><a href="#" class="btn">6월</a> </li>
							<li><a href="#" class="btn on">7월</a> </li>
							<li><a href="#" class="btn on">8월</a> </li>
							<li><a href="#" class="btn">9월</a> </li>
							<li><a href="#" class="btn">10월</a> </li>
							<li><a href="#" class="btn">11월</a> </li>
							<li><a href="#" class="btn">12월</a> </li>
						</ul></td>
				</tr>
				<tr>
					<th>매체</th>
					<td>
						<label class="per"> <span class="media_name">
							<input type="checkbox" />
							한국경제</span> <span>온라인 결제<b>20</b>%</span><span>후불 결제<b>80</b>%</span></label>
						<label class="per"> <span class="media_name">
							<input type="checkbox" />
							한국경제 매거진</span> <span>온라인 결제<b>20</b>%</span><span>후불 결제<b>80</b>%</span></label>
						<label class="per"> <span class="media_name">
							<input type="checkbox" />
							한국일보</span> <span>온라인 결제<b>20</b>%</span><span>후불 결제<b>80</b>%</span></label>
						<label class="per"> <span class="media_name">
							<input type="checkbox" />
							헤럴드경제</span> <span>온라인 결제<b>20</b>%</span><span>후불 결제<b>80</b>%</span></label>
						<label class="per"> <span class="media_name">
							<input type="checkbox" />
							C.영상미디어</span> <span>온라인 결제<b>20</b>%</span><span>후불 결제<b>80</b>%</span></label>
</td>
				</tr>
				<tr>
					<th>아이디/이름/회사명</th>
					<td><input type="text" class="inp_txt" size="50" /></td>
				</tr>
				<tr>
					<th>결제구분</th>
					<td><select name="" class="inp_txt" style="width:380px;">
							<option value="010" selected="selected"></option>
						</select></td>
				</tr>
				<tr>
					<th>결제방법</th>
					<td><select name="" class="inp_txt" style="width:380px;">
							<option value="010" selected="selected"></option>
						</select></td>
				</tr>
			</tbody>
		</table>
		<div class="btn_area" style="margin-top:0;"><a href="#" class="btn_input2">검색</a></div>
		<a href="#"  style="float:right; padding:10px 15px; font-size:13px; border-radius:2px;color: #666; border: 1px solid #aaa; margin-top:-20px;
">엑셀 다운로드</a>
		<div class="calculate_info_area">기간 : 2017-01-01 ~ 2017-10-15<span style="margin:0 20px;">l</span> 건수 :<span class="color">1258</span>건<span style="margin:0 20px;">l</span> 총 판매금액 : <span class="color">15,000,000</span>원</div>
		<table cellpadding="0" cellspacing="0" class="tb03">
			<thead>
				<tr>
					<th>-</th>
					<th>1월</th>
					<th>2월</th>
					<th>3월</th>
					<th>4월</th>
					<th>5월</th>
					<th>6월</th>
					<th>7월</th>
					<th>8월</th>
					<th>9월</th>
					<th>10월</th>
					<th>11월</th>
					<th><p>12월</p></th>
					<th>합계</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>온라인 결제</td>
					<td>요율적용<br>
						정산금액</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>후불 결제</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</tbody>
			<tfoot>
			<td>총 합계</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				</tfoot>
		</table>
	</section>
</div>
</body>
</html>
