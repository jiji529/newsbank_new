<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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