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
				<li><a href="/login">로그인</a></li>
				<li><a href="/kind.join">가입하기</a></li>
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
				<li class="on">
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
				<li>
					<a href="#">구매내역</a>
				</li>
			</ul>
		</div>
		<div class="table_head">
			<h3>정산 내역</h3>
			<!--<p class="txt">결제정보를 등록하시면 결제 시 자동으로 반영됩니다.</p>-->
		</div>
		<table class="tb01" cellpadding="0" cellspacing="0">
			<colgroup>
				<col style="width: 240px;">
					<col style="width:;">
			</colgroup>
			<tbody>
				<tr>
					<th>조회기간 선택</th>
					<td>
						<input type="text" size="12" class="inp_txt" value="2017-05-01" maxlength="10">
							<span class=" bar">~</span>
							<input type="text" size="12" class="inp_txt" value="2017-05-01" maxlength="10">
					</td>
				</tr>
				<tr>
					<th>기간별 조회</th>
					<td>
						<select name="" class="inp_txt" style="width: 100px;">
							<option value="010" selected="selected">2017</option>
						</select>
						<ul>
							<li>
								<a href="#" class="btn">1월</a>
							</li>
							<li>
								<a href="#" class="btn">2월</a>
							</li>
							<li>
								<a href="#" class="btn">3월</a>
							</li>
							<li>
								<a href="#" class="btn">4월</a>
							</li>
							<li>
								<a href="#" class="btn">5월</a>
							</li>
							<li>
								<a href="#" class="btn">6월</a>
							</li>
							<li>
								<a href="#" class="btn on">7월</a>
							</li>
							<li>
								<a href="#" class="btn on">8월</a>
							</li>
							<li>
								<a href="#" class="btn">9월</a>
							</li>
							<li>
								<a href="#" class="btn">10월</a>
							</li>
							<li>
								<a href="#" class="btn">11월</a>
							</li>
							<li>
								<a href="#" class="btn">12월</a>
							</li>
						</ul>
					</td>
				</tr>
				<tr>
					<th>매체</th>
					<td>
						<label class="per">
							<span class="media_name">
								<input type="checkbox" />
								한국경제
							</span>
							<span>
								온라인 결제
								<b>20</b>
								%
							</span>
							<span>
								후불 결제
								<b>80</b>
								%
							</span>
						</label>
						<label class="per">
							<span class="media_name">
								<input type="checkbox" />
								한국경제 매거진
							</span>
							<span>
								온라인 결제
								<b>20</b>
								%
							</span>
							<span>
								후불 결제
								<b>80</b>
								%
							</span>
						</label>
						<label class="per">
							<span class="media_name">
								<input type="checkbox" />
								한국일보
							</span>
							<span>
								온라인 결제
								<b>20</b>
								%
							</span>
							<span>
								후불 결제
								<b>80</b>
								%
							</span>
						</label>
						<label class="per">
							<span class="media_name">
								<input type="checkbox" />
								헤럴드경제
							</span>
							<span>
								온라인 결제
								<b>20</b>
								%
							</span>
							<span>
								후불 결제
								<b>80</b>
								%
							</span>
						</label>
						<label class="per">
							<span class="media_name">
								<input type="checkbox" />
								C.영상미디어
							</span>
							<span>
								온라인 결제
								<b>20</b>
								%
							</span>
							<span>
								후불 결제
								<b>80</b>
								%
							</span>
						</label>
					</td>
				</tr>
				<tr>
					<th>결제구분</th>
					<td>
						<select name="" class="inp_txt" style="width: 380px;">
							<option value="010" selected="selected"></option>
						</select>
					</td>
				</tr>
				<tr>
					<th>결제방법</th>
					<td>
						<select name="" class="inp_txt" style="width: 380px;">
							<option value="010" selected="selected"></option>
						</select>
					</td>
				</tr>
				<tr>
					<th>검색어</th>
					<td>
						<input type="text" class="inp_txt" size="60" placeholder="주문자(이름/회사명), UCI ID, 매체사 고유 사진 ID로 검색 가능합니다." />
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn_area" style="margin-top: 0;">
			<a href="#" class="btn_input2">검색</a>
		</div>
		<a href="#" style="float: right; padding: 10px 15px; font-size: 13px; border-radius: 2px; color: #666; border: 1px solid #aaa; margin-top: -20px;">엑셀 다운로드</a>
		<div class="calculate_info_area">
			기간 : 2017-01-01 ~ 2017-10-15
			<span style="margin: 0 20px;">l</span>
			건수 :
			<span class="color">1258</span>
			건
			<span style="margin: 0 20px;">l</span>
			총 판매금액 :
			<span class="color">15,000,000</span>
			원
		</div>
		<div class="table_head">
			<h3>온라인 판매대금 정산내역</h3>
		</div>
		<table cellpadding="0" cellspacing="0" class="tb02">
			<thead>
				<tr>
					<th>구매일자</th>
					<th>주문자</th>
					<th>사진ID</th>
					<th>사용용도</th>
					<th>판매자</th>
					<th>결제종류</th>
					<th>과세금액</th>
					<th>과세부가세</th>
					<th>결제금액</th>
					<th>빌링수수료</th>
					<th>총매출액</th>
					<th>
						<p>회원사</p>
						<p>매출액</p>
					</th>
					<th>공급가액</th>
					<th>공급부가세</th>
					<th>
						<p>다하미</p>
						<p>매출액</p>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>2017-07-27</td>
					<td>최란경</td>
					<td>C004200107</td>
					<td>내지</td>
					<td>조선영상</td>
					<td>신용카드</td>
					<td>80,000</td>
					<td>8,000</td>
					<td>88,000</td>
					<td>3,098</td>
					<td>84,902</td>
					<td>59,431</td>
					<td>54,028</td>
					<td>5,403</td>
					<td>25,471</td>
				</tr>
				<tr>
					<td>2017-07-27</td>
					<td>최란경</td>
					<td>E003183746</td>
					<td>내지</td>
					<td>조선일보</td>
					<td>신용카드</td>
					<td>80,000</td>
					<td>8,000</td>
					<td>88,000</td>
					<td>3,098</td>
					<td>84,902</td>
					<td>59,431</td>
					<td>54,028</td>
					<td>5,403</td>
					<td>25,471</td>
				</tr>
				<tr>
					<td>2017-08-31</td>
					<td>메디치미디어</td>
					<td>E003181461</td>
					<td>내지</td>
					<td>조선일보</td>
					<td>신용카드</td>
					<td>80,000</td>
					<td>8,000</td>
					<td>88,000</td>
					<td>3,098</td>
					<td>84,902</td>
					<td>59,431</td>
					<td>54,028</td>
					<td>5,403</td>
					<td>25,471</td>
				</tr>
				<tr>
					<td>2017-08-31</td>
					<td>메디치미디어</td>
					<td>E001876694</td>
					<td>내지</td>
					<td>조선일보</td>
					<td>신용카드</td>
					<td>80,000</td>
					<td>8,000</td>
					<td>88,000</td>
					<td>3,098</td>
					<td>84,902</td>
					<td>59,431</td>
					<td>54,028</td>
					<td>5,403</td>
					<td>25,471</td>
				</tr>
			</tbody>
			<tfoot>
				<td colspan="6">8월 조선일보 온라인 매출액 합계</td>
				<td>560,000</td>
				<td>56,000</td>
				<td>616,000</td>
				<td>21,686</td>
				<td>594,314</td>
				<td>416,017</td>
				<td>378,197</td>
				<td>37,820</td>
				<td>178,297</td>
			</tfoot>
		</table>
		<div class="table_head">
			<h3>후불 판매대금 정산내역</h3>
		</div>
		<table cellpadding="0" cellspacing="0" class="tb02">
			<thead>
				<tr>
					<th>구매일자</th>
					<th>주문자</th>
					<th>사진ID</th>
					<th>사용용도</th>
					<th>판매자</th>
					<th colspan="2">결제종류</th>
					<th>과세금액</th>
					<th>과세부가세</th>
					<th>결제금액</th>
					<th>총매출액</th>
					<th>
						<p>회원사</p>
						<p>매출액</p>
					</th>
					<th>공금가액</th>
					<th>공급부가세</th>
					<th>
						<p>다하미</p>
						<p>매출액</p>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>2017-08-18</td>
					<td>북앤포토</td>
					<td>E003183746</td>
					<td>내지</td>
					<td>조선일보</td>
					<td>무통장입금</td>
					<td>세금계산서</td>
					<td>60,000</td>
					<td>6,000</td>
					<td>66,000</td>
					<td>66,000</td>
					<td>46,200</td>
					<td>42,000</td>
					<td>4,200</td>
					<td>19,800</td>
				</tr>
				<tr>
					<td>2017-08-21</td>
					<td>북앤포토</td>
					<td>E003181461</td>
					<td>내지</td>
					<td>조선일보</td>
					<td>무통장입금</td>
					<td>세금계산서</td>
					<td>60,000</td>
					<td>6,000</td>
					<td>66,000</td>
					<td>66,000</td>
					<td>46,200</td>
					<td>42,000</td>
					<td>4,200</td>
					<td>19,800</td>
				</tr>
				<tr>
					<td>2017-08-23</td>
					<td>북앤포토</td>
					<td>E001876694</td>
					<td>내지</td>
					<td>조선일보</td>
					<td>무통장입금</td>
					<td>세금계산서</td>
					<td>60,000</td>
					<td>6,000</td>
					<td>66,000</td>
					<td>66,000</td>
					<td>46,200</td>
					<td>42,000</td>
					<td>4,200</td>
					<td>19,800</td>
				</tr>
			</tbody>
			<tfoot>
				<td colspan="7">8월 조선일보 오프라인 매출액 합계</td>
				<td>300,000</td>
				<td>30,000</td>
				<td>330,000</td>
				<td>330,000</td>
				<td>231,000</td>
				<td>21,000</td>
				<td>21,000</td>
				<td>99,000</td>
		</table>
		<table class="tb01" cellpadding="0" cellspacing="0" style="float: right; width: 400px; margin-top: 60px;">
			<tbody>
				<tr>
					<td>공금가액</td>
					<td>588,197</td>
				</tr>
				<tr>
					<td>부가세</td>
					<td>58,820</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td>합계 (부가세 포함)</td>
					<td>647,017</td>
				</tr>
			</tfoot>
		</table>
		</section>
	</div>
</body>
</html>
