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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>NYT 뉴스뱅크</title>
<link rel="stylesheet" href="css/nyt/jquery-ui-1.12.1.min.css">
	<script src="js/nyt/jquery-1.12.4.min.js"></script>
	<script src="js/nyt/jquery-ui-1.12.1.min.js"></script>
	<link rel="stylesheet" href="css/nyt/base.css" />
	<link rel="stylesheet" href="css/nyt/sub.css" />
	<link rel="stylesheet" href="css/nyt/mypage.css" />
	<script src="js/nyt/footer.js"></script>
	<script src="js/nyt/mypage.js?v=20180421"></script>
</head>
<body>
	<div class="wrap">
		<%@include file="common/headerKR2.jsp"%>
		<section class="mypage">
		<div class="head">
			<h2>마이페이지</h2>
		</div>
		<div class="mypage_ul">
			<ul class="mp_tab1">
				<c:if test="${MemberInfo.type eq 'M' && MemberInfo.admission eq 'Y'}">
					<li class="on">
						<a href="/accountlist.mypage">정산 관리</a>
					</li>
					<li>
						<a href="/cms">사진 관리</a>
					</li>
				</c:if>
				
				<c:if test="${MemberInfo.type eq 'Q' && MemberInfo.admission eq 'Y'}">
					<li class="on">
						<a href="/cms">사진 관리</a>
					</li>
				</c:if>
				
				<c:if test="${MemberInfo.type eq 'W' && MemberInfo.admission eq 'Y'}">
					<li class="on">
						<a href="/accountlist.mypage">정산 관리</a>
					</li>
				</c:if>
				
				<li>
					<a href="/info.mypage">회원정보 관리</a>
				</li>
				<li>
					<a href="/dibs.myPage">찜관리</a>
				</li>
				<c:if test="${MemberInfo.deferred eq 2}">
					<li>
						<a href="/download.mypage">다운로드 내역</a>
					</li>
					<li>
						<a href="/postBuylist.mypage">구매내역</a>
					</li>
				</c:if>
				<c:if test="${MemberInfo.deferred eq 0}">
					<li>
						<a href="/cart.myPage">장바구니</a>
					</li>
					<li>
						<a href="/buylist.mypage">구매내역</a>
					</li>
				</c:if>
			</ul>
			<ul class="mp_tab2">
				<li>
					<a href="/accountyear.mypage">연도별 총 매출액</a>
				</li>
				<li>
					<a href="/accountlist.mypage">결제건별 정산내역</a>
				</li>
				<li>
					<a href="/account.mypage">정산 정보 관리</a>
				</li>
			</ul>
		</div>
		<div class="table_head">
			<h3>정산 정보 관리</h3>
		</div>
		<form id="frmMypage" action="/member.api" method="post">
			<input type="hidden" name="action" value="U" />
			<input type="hidden" id="type" name="type" value="M" />
			<input type="hidden" id="mediaCodes" name="mediaCodes" value=""/>
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
								<c:forEach var="media" items="${mediaList}">.
									<option value="${media.seq}" <c:if test="${media.seq eq MemberInfo.seq}">selected</c:if>>${media.compName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>입금 계좌</th>
						<td>
							<input type="text" class="inp_txt" size="40" name='compBankName' value="${MemberInfo.compBankName}" style="width: 120px;"/>
							<input type="text" class="inp_txt" size="40" name='compBankAcc' value="${MemberInfo.compBankAcc}" />
							<div class="upload-btn-wrapper">
								<button class="btn">통장사본 업로드</button>
								<input type="file" name="bank" accept="application/pdf, image/*" required />
							</div>
							<c:if test="${!empty MemberInfo.compBankPath}">
								<a href="/bank.down.photo?seq=${MemberInfo.seq}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" class="btn_input1 bank_down">다운로드</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>
							<span class="ex">*</span>
							계약기간
						</th>
						<td>
							<fmt:parseDate var="startStr" value="${MemberInfo.contractStart}" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${startStr}" var="contractStartYMD" pattern="yyyy-MM-dd"/>
							<fmt:parseDate var="endStr" value="${MemberInfo.contractEnd}" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${endStr}" var="contractEndYMD" pattern="yyyy-MM-dd"/>
							
							<input id="contractStart" name="contractStart" type="text" size="12" class="inp_txt" value="${contractStartYMD}" maxlength="10" disabled>
								<span class=" bar">~</span>
								<input id="contractEnd" name="contractEnd" type="text" size="12" class="inp_txt" value="${contractEndYMD}" maxlength="10" disabled>
									<div class="check">
										<input type="checkbox" id="contractAuto" />
										<input type="hidden" name="contractAuto" value='' />
										자동연장
									</div>
									<div class="upload-btn-wrapper">
										<button class="btn">계약서 업로드</button>
										<input type="file" name="contract" accept="application/pdf, image/*" required />
									</div>
							<c:if test="${!empty MemberInfo.contractPath}">
								<a href="/contract.down.photo?seq=${MemberInfo.seq}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" class="btn_input1 contract_down">다운로드</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>
							<span class="ex">*</span>
							정산 요율
						</th>
						<td>
							<span class=" bar">온라인 결제</span>
							<fmt:parseNumber var="preRateInt" value="${MemberInfo.preRate}" integerOnly="true "/>
							<fmt:parseNumber var="postRateInt" value="${MemberInfo.postRate}" integerOnly="true "/>
							
							<input type="text" size="5" class="inp_txt" name='preRate' value="${preRateInt}" maxlength="3" disabled>
								<span class=" bar">%</span>
								<span class=" bar" style="margin-left: 20px;">오프라인 결제</span>
								<input type="text" size="5" class="inp_txt" name='postRate' value="${postRateInt}" maxlength="3" disabled>
									<span class=" bar">%</span>
						</td>
					</tr>
					<tr>
						<th>세금계산서 담당자</th>
						<td>
							<input type="text" class="inp_txt" name='taxName' size="60" value="${MemberInfo.taxName}" />
						</td>
					</tr>
					<tr>
						<th>세금계산서 담당자 연락처</th>
						<td>
							<select id="taxPhone1" name="taxPhone1" class="inp_txt" style="width: 70px;">
								<option value="02" <c:if test="${taxPhone1 eq '02'}">selected</c:if>>02</option>
								<option value="031" <c:if test="${taxPhone1 eq '031'}">selected</c:if>>031</option>
								<option value="032" <c:if test="${taxPhone1 eq '032'}">selected</c:if>>032</option>
								<option value="033" <c:if test="${taxPhone1 eq '033'}">selected</c:if>>033</option>
								<option value="041" <c:if test="${taxPhone1 eq '041'}">selected</c:if>>041</option>
								<option value="042" <c:if test="${taxPhone1 eq '042'}">selected</c:if>>042</option>
								<option value="043" <c:if test="${taxPhone1 eq '043'}">selected</c:if>>043</option>
								<option value="044" <c:if test="${taxPhone1 eq '044'}">selected</c:if>>044</option>
								<option value="051" <c:if test="${taxPhone1 eq '051'}">selected</c:if>>051</option>
								<option value="052" <c:if test="${taxPhone1 eq '052'}">selected</c:if>>052</option>
								<option value="053" <c:if test="${taxPhone1 eq '053'}">selected</c:if>>053</option>
								<option value="054" <c:if test="${taxPhone1 eq '054'}">selected</c:if>>054</option>
								<option value="055" <c:if test="${taxPhone1 eq '055'}">selected</c:if>>055</option>
								<option value="061" <c:if test="${taxPhone1 eq '061'}">selected</c:if>>061</option>
								<option value="062" <c:if test="${taxPhone1 eq '062'}">selected</c:if>>062</option>
								<option value="063" <c:if test="${taxPhone1 eq '063'}">selected</c:if>>063</option>
								<option value="064" <c:if test="${taxPhone1 eq '064'}">selected</c:if>>064</option>
								<option value="070" <c:if test="${taxPhone1 eq '070'}">selected</c:if>>070</option>
								<option value="080" <c:if test="${taxPhone1 eq '080'}">selected</c:if>>080</option>
								<option value="010" <c:if test="${taxPhone1 eq '010'}">selected</c:if>>010</option>
								<option value="011" <c:if test="${taxPhone1 eq '011'}">selected</c:if>>011</option>
								<option value="016" <c:if test="${taxPhone1 eq '016'}">selected</c:if>>016</option>
								<option value="017" <c:if test="${taxPhone1 eq '017'}">selected</c:if>>017</option>
								<option value="018" <c:if test="${taxPhone1 eq '018'}">selected</c:if>>018</option>
								<option value="019" <c:if test="${taxPhone1 eq '019'}">selected</c:if>>019</option>
							</select>
							<span class=" bar">-</span>
							<input type="text" id="taxPhone2" name="taxPhone2" size="5" class="inp_txt" value="${taxPhone2}" maxlength="4">
							<span class=" bar">-</span>
							<input type="text" id="taxPhone3" name="taxPhone3" size="5" class="inp_txt" value="${taxPhone3}" maxlength="4" />
							<span class=" bar">내선</span>
							<input type="text" name="taxExtTell" id="taxExtTell" size="5" value="${MemberInfo.taxExtTell}"  class="inp_txt" maxlength="4" />
							<p class="txt_message" id="taxPhone_message" style="display: none;">형식이 올바르지 않은 번호입니다.</p>
							</td>
						</td>
					</tr>
					<tr>
						<th>세금계산서 담당자 이메일</th>
						<td>
							<input type="text" class="inp_txt" size="60" name="taxEmail" value="${MemberInfo.taxEmail}" />
						</td>
					</tr>
				</tbody>
			</table>
			<p class="ex_txt">*수정이 필요한 경우, 회사(02-593-4174) 또는 뉴스뱅크 서비스 담당자에게 연락 부탁드립니다.</p>
			<div class="media_all">
				<input id="check" name="check" type="checkbox">
				<label for="check">수정한 내용을 모든 정산 매체에 일괄 적용</label>
			</div>
			<div class="btn_area">
				<a href="javascript:;" id="btnSubmit" class="btn_input2">수정</a>
				<a href="javascript:location.reload();" class="btn_input1">취소</a>
			</div>
		</form>
		</section>
		<%@include file="common/footerKR.jsp"%>
	</div>
</body>
</html>
