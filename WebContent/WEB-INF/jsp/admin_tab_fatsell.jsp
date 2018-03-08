<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<div class="ad_sch_area">
	<table class="tb01" cellpadding="0" cellspacing="0">
		<colgroup>
			<col style="width: 180px;">
			<col style="width:;">
		</colgroup>
		<tbody>
			<tr>
				<th>검색</th>
				<td><input type="text" class="inp_txt" size="80"
					placeholder="회사/기관명, 아이디, 이름, UCI코드, 주문번호,  언론사 사진번호" /></td>
			</tr>
			<tr>
				<th>기간 선택</th>
				<td><select name="" class="inp_txt" style="width: 100px;">
						<option value="all" selected="selected">전체(년)</option>
						<option value="2018">2018년</option>
						<option value="2017">2017년</option>
						<option value="2016">2016년</option>
						<option value="2015">2015년</option>
				</select> <select name="" class="inp_txt" style="width: 95px;">
						<option value="all" selected="selected">전체(월)</option>
						<option value="1">1월</option>
						<option value="2">2월</option>
						<option value="3">3월</option>
						<option value="4">4월</option>
						<option value="5">5월</option>
						<option value="6">6월</option>
						<option value="7">7월</option>
						<option value="8">8월</option>
						<option value="9">9월</option>
						<option value="10">10월</option>
						<option value="11">11월</option>
						<option value="12">12월</option>
				</select>
					<ul class="period">
						<li><a href="#" class="btn">2월</a></li>
						<li><a href="#" class="btn">1월</a></li>
						<li><a href="#" class="btn">12월</a></li>
						<li><a href="#" class="btn">11월</a></li>
						<li><a href="#" class="btn">10월</a></li>
						<li><a href="#" class="btn">9월</a></li>
					</ul>
					<div class="period">
						<input type="text" size="12" class="inp_txt" value="2017-05-01"
							maxlength="10"> <span class=" bar">~</span> <input
							type="text" size="12" class="inp_txt" value="2017-05-01"
							maxlength="10">
					</div></td>
			</tr>
			<tr>
				<th>상태 구분</th>
				<td><select name="" class="inp_txt" style="width: 150px;">
						<option value="all" selected="selected">전체</option>
						<option value=" ">구매 신청</option>
						<option value=" ">정산 승인</option>
						<option value=" ">승인 취소</option>
				</select></td>
			</tr>
		</tbody>
	</table>
	<div class="btn_area" style="margin-top: 0;">
		<a href="#" class="btn_input2">검색</a>
	</div>
</div>
<div class="calculate_info_area">
	기간 : 2017-01-01 ~ 2017-10-15 <span class="bar3">l</span> 건수 : <span
		class="color">101</span>건 <span class="bar3">l</span> 총 판매금액 : <span
		class="color">15,000,000</span>원 <span class="bar3">l</span>
	<p style="color: #888;">
		( 구매 신청 : 20,000,000원/ 100건 <span class="bar3">l</span> 정산 승인 :
		16,000,000원/ 50건 <span class="bar3">l</span>정산 승인 취소 : 1,000,000원/ 1건
		)
	</p>
</div>
<div class="ad_result">
	<div class="ad_result_btn_area">
		<a href="#">정산 승인</a></span> <a href="#">정산 승인 취소</a>
	</div>
	<div class="ad_result_btn_area fr">
		<select>
			<option>20개</option>
			<option>50개</option>
			<option>100개</option>
		</select> <a href="#">엑셀저장</a>
	</div>
	<table cellpadding="0" cellspacing="0" class="tb04">
		<colgroup>
			<col width="40" />
			<col width="50" />
			<col width="120" />
			<col width="100" />
			<col width="80" />
			<col width="150" />
			<col width="150" />
			<col width="100" />
			<col width="100" />
			<col width="150" />
			<col width="80" />
			<col width="80" />
		</colgroup>
		<thead>
			<tr>
				<th><div class="tb_check">
						<input id="check_all" name="check_all" type="checkbox"> <label
							for="check_all">선택</label>
					</div></th>
				<th>No.</th>
				<th>회사/기관명</th>
				<th>아이디</th>
				<th>이름</th>
				<th>주문번호</th>
				<th>구매 신청일</th>
				<th>상태</th>
				<th>매체</th>
				<th>UCI코드</th>
				<th>용도</th>
				<th>금액</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><div class="tb_check">
						<input id="check1" name="check1" type="checkbox"> <label
							for="check1">선택</label>
					</div></td>
				<td>5</td>
				<td>다하미</td>
				<td>crk0526</td>
				<td>김기동</td>
				<td>20180227164321-1</td>
				<td>2018-02-27 16:43:21</td>
				<td>구매 신청</td>
				<td>조선일보</td>
				<td><a href="http://www.dev.newsbank.co.kr/view.photo"
					target="_blank">I011-M005775178</a></td>
				<td>교과서</td>
				<td>55,000</td>
			</tr>
			<tr>
				<td><div class="tb_check">
						<input id="check1" name="check1" type="checkbox"> <label
							for="check1">선택</label>
					</div></td>
				<td>4</td>
				<td>다하미</td>
				<td>influential</td>
				<td>나영환</td>
				<td>20180227164321-1</td>
				<td>2018-02-27 16:43:21</td>
				<td>정산 승인</td>
				<td>중앙일보</td>
				<td><a href="http://www.dev.newsbank.co.kr/view.photo"
					target="_blank">I011-M005775178</a></td>
				<td>교과서</td>
				<td>55,000</td>
			</tr>
			<tr>
				<td><div class="tb_check">
						<input id="check1" name="check1" type="checkbox"> <label
							for="check1">선택</label>
					</div></td>
				<td>3</td>
				<td>다하미</td>
				<td>dolbegae</td>
				<td>다하미</td>
				<td>20180227164321-1</td>
				<td>2018-02-27 16:43:21</td>
				<td>정산 승인</td>
				<td>동아일보</td>
				<td><a href="http://www.dev.newsbank.co.kr/view.photo"
					target="_blank">I011-M005775178</a></td>
				<td>참고서</td>
				<td>55,000</td>
			</tr>
			<tr>
				<td><div class="tb_check">
						<input id="check1" name="check1" type="checkbox"> <label
							for="check1">선택</label>
					</div></td>
				<td>2</td>
				<td>다하미</td>
				<td>gaeam</td>
				<td>마동석</td>
				<td>20180227164321-1</td>
				<td>2018-02-27 16:43:21</td>
				<td>정산 승인 취소</td>
				<td>한경닷컴</td>
				<td><a href="http://www.dev.newsbank.co.kr/view.photo"
					target="_blank">I011-M005775178</a></td>
				<td>참고서</td>
				<td>55,000</td>
			</tr>
			<tr>
				<td><div class="tb_check">
						<input id="check1" name="check1" type="checkbox"> <label
							for="check1">선택</label>
					</div></td>
				<td>1</td>
				<td>천재교육</td>
				<td>maywood</td>
				<td>박소현</td>
				<td>20180227164321-1</td>
				<td>2018-02-27 16:43:21</td>
				<td>구매 신청</td>
				<td>뉴시스</td>
				<td><a href="http://www.dev.newsbank.co.kr/view.photo"
					target="_blank">I011-M005775178</a></td>
				<td>-</td>
				<td>55,000</td>
			</tr>
		</tbody>
	</table>
	<div class="pagination">
		<ul>
			<li class="first"><a href="#">첫 페이지</a></li>
			<li class="prev"><a href="#">이전 페이지</a></li>
			<li><a href="#">1</a></li>
			<li class="active"><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li><a href="#">6</a></li>
			<li><a href="#">7</a></li>
			<li><a href="#">8</a></li>
			<li><a href="#">9</a></li>
			<li><a href="#">10</a></li>
			<li class="next"><a href="#"> 다음 페이지 </a></li>
			<li class="last"><a href="#"> 마지막 페이지 </a></li>
		</ul>
	</div>
</div>