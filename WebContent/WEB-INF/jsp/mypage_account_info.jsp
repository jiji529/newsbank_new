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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/footer.js"></script>
<script src="js/mypage.js"></script>
</head>
<body>
	<div class="wrap">
		<%@include file="header.jsp"%>
		<section class="mypage">
		<div class="head">
			<h2>마이페이지</h2>
		</div>
		<div class="mypage_ul">
			<ul class="mp_tab1">
				<c:if test="${MemberInfo.type eq 'M'}">
					<li class="on">
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
				<li>
					<a href="/cart.myPage">장바구니</a>
				</li>
				<li>
					<a href="/buylist.mypage">구매내역</a>
				</li>
			</ul>
			<ul class="mp_tab2">
				<li>
					<a href="/account.mypage">정산정보 관리</a>
				</li>
				<li>
					<a href="/accountlist.mypage">정산 내역</a>
				</li>
			</ul>
		</div>
		<div class="table_head">
			<h3>정산 정보 관리</h3>
		</div>
		<form id="frmMypage" action="/member.api" method="post">
			<input type="hidden" name="cmd" value="U" />
			<input type="hidden" id="type" name="type" value="M" />
			<table class="tb01" cellpadding="0" cellspacing="0">
				<colgroup>
					<col style="width: 240px;">
						<col style="width:;">
				</colgroup>
				<tbody>
					<tr>
						<th>매체명</th>
						<td>
							<select id="media" name="media_code" class="inp_txt" style="width: 450px;">
								<option value="">선택해주세요.</option>
								<c:forEach var="media" items="${mediaList}">.
									<option value="${media.seq}">${media.compName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>입금 계좌</th>
						<td>
							<select name="compBankName" class="inp_txt" style="width: 120px;">
								<option value="">선택</option>
								<option value="기업">기업</option>
								<option value="농협">농협</option>
								<option value="국민">국민</option>
								<option value="우리">우리</option>
								<option value="신한">신한</option>
								<option value="경남">경남</option>
								<option value="광주">광주</option>
								<option value="대구">대구</option>
								<option value="부산">부산</option>
								<option value="수협">수협</option>
								<option value="신협">신협</option>
								<option value="우체국">우체국</option>
								<option value="전북">전북</option>
								<option value="제주">제주</option>
								<option value="KEB하나">KEB하나</option>
								<option value="한국씨티">한국씨티</option>
								<option value="SC제일">SC제일</option>
							</select>
							<input type="text" class="inp_txt" size="40" name='compBankAcc' value="" />
							<a href="#" class="btn_input1">통장사본 업로드</a>
							<a href="#" class="btn_input1">다운로드</a>
						</td>
					</tr>
					<tr>
						<th>계약기간</th>
						<td>
							<input id="contractStart" name="contractStart" type="text" size="12" class="inp_txt" value="" maxlength="10">
								<span class=" bar">~</span>
								<input id="contractEnd" name="contractEnd" type="text" size="12" class="inp_txt" value="" maxlength="10">
									<div class="check">
										<input type="checkbox" id="contractAuto" />
										<input type="hidden" name="contractAuto" value='' />
										자동연장
									</div>
									<a href="#" class="btn_input1">계약서 업로드</a>
									<a href="#" class="btn_input1">다운로드</a>
						</td>
					</tr>
					<tr>
						<th>
							<span class="ex">*</span>
							정산 요율
						</th>
						<td>
							<span class=" bar">온라인 결제</span>
							<input type="text" size="5" class="inp_txt" name='preRate' value="" maxlength="3">
								<span class=" bar">%</span>
								<span class=" bar" style="margin-left: 20px;">후불 결제</span>
								<input type="text" size="5" class="inp_txt" name='postRate' value="" maxlength="3">
									<span class=" bar">%</span>
						</td>
					</tr>
					<tr>
						<th>세금계산서 담당자</th>
						<td>
							<input type="text" class="inp_txt" name='taxName' size="60" value="" />
						</td>
					</tr>
					<tr>
						<th>세금계산서 담당자 연락처</th>
						<td>
							<select id="taxPhone1" class="inp_txt" style="width: 70px;">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							<span class=" bar">-</span>
							<input type="text" id="taxPhone2" size="5" class="inp_txt" value="" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" id="taxPhone3" size="5" class="inp_txt" value="" maxlength="4" />
						</td>
					</tr>
					<tr>
						<th>세금계산서 담당자 이메일</th>
						<td>
							<input type="text" class="inp_txt" size="60" name="taxEmail" value="" />
						</td>
					</tr>
				</tbody>
			</table>
			<p class="ex_txt">*수정이 필요한 경우, 회사(02-593-4174) 또는 뉴스뱅크 서비스 담당자에게 연락 부탁드립니다.</p>
			<div class="btn_area">
				<a href="javascript:;" id="btnSubmit" class="btn_input2">수정</a>
				<a href="javascript:location.reload();" class="btn_input1">취소</a>
			</div>
		</form>
		</section>
	</div>
</body>
</html>
