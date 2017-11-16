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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
<fmt:formatDate value="${now}" pattern="yyyy" var="year" />
<fmt:formatDate value="${now}" pattern="MM" var="month" />
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
				<c:if test="${MemberInfo.deferred eq 'Y'}">
					<li>
						<a href="/download.mypage">다운로드 내역</a>
					</li>
					<li>
						<a href="/postBuylist.mypage">구매내역</a>
					</li>
				</c:if>
				<c:if test="${MemberInfo.deferred eq 'N'}">
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
					<a href="/account.mypage">정산정보 관리</a>
				</li>
				<li>
					<a href="/accountlist.mypage">정산 내역</a>
				</li>
			</ul>
		</div>
		<div class="table_head">
			<h3>정산 내역</h3>
			<!--<p class="txt">결제정보를 등록하시면 결제 시 자동으로 반영됩니다.</p>-->
		</div>
		<form id="frmAccountList" method="post">
			<table class="tb01" cellpadding="0" cellspacing="0">
				<colgroup>
					<col style="width: 240px;">
					<col style="width:;">
				</colgroup>
				<tbody>
					<tr>
						<th>조회기간 선택</th>
						<td>
							<input type="text" size="12" id="contractStart" name="start_date" class="inp_txt" value="${today }" maxlength="10">
							<span class=" bar">~</span>
							<input type="text" size="12" id="contractEnd" name="end_date" class="inp_txt" value="${today }" maxlength="10">
						</td>
					</tr>
					<tr>
						<th>기간별 조회</th>
						<td>
							<select id="customYear" class="inp_txt" style="width: 100px;">
								<c:forEach var="i" begin="2007" end="${year}" step="1">
									<option value="${i }" <c:if test="${i eq year}">selected</c:if>>${i}</option>
								</c:forEach>
							</select>
							<ul id="customDay">
								<li>
									<a href="javascript:;" class="btn">1월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">2월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">3월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">4월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">5월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">6월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">7월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">8월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">9월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">10월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">11월</a>
								</li>
								<li>
									<a href="javascript:;" class="btn">12월</a>
								</li>
							</ul>
						</td>
					</tr>
					<tr>
						<th>매체</th>
						<td>
							<c:forEach var="media" items="${mediaList}">
								<label class="per">
									<span class="media_name">
										<input type="checkbox" name="media_code" value="${media.seq}" />
										${media.compName}
									</span>
									<span>
										온라인 결제
										<b>${media.preRate }</b>
										%
									</span>
									<span>
										오프라인 결제
										<b>${media.postRate }</b>
										%
									</span>
								</label>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>아이디/이름/회사명</th>
						<td>
							<input name="keyword" type="text" class="inp_txt" size="50" />
						</td>
					</tr>
					<tr>
						<th>결제방법</th>
						<td>
							<select name="paytype" class="inp_txt" style="width: 380px;">
								<option value="">- 선택 -</option>
								<option value="SC0010">카드결제</option>
								<option value="SC0040">무통장입금</option>
								<option value="SC0030">실시간 계좌이체</option>
								<option value="000000">오프라인 세금계산서 발행</option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btn_area" style="margin-top: 0;">
			<a href="javascript:;" class="btn_input2" id="btnaccountSearch">검색</a>
		</div>
		<a href="javascript:;" style="float: right; padding: 10px 15px; font-size: 13px; border-radius: 2px; color: #666; border: 1px solid #aaa; margin-top: -20px;">엑셀 다운로드</a>
		<div class="calculate_info_area">
			기간 : ${year}-01-01 ~ ${today }
			<span style="margin: 0 20px;">l</span>
			건수 :
			<span class="color">0</span>
			건
			<span style="margin: 0 20px;">l</span>
			총 판매금액 :
			<span class="color">0</span>
			원
		</div>
		<div class="account_list">
			<div class="tb_total_account" style="display: block">
				<table cellpadding="0" cellspacing="0" class="tb03 ">
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
							<th>
								<p>12월</p>
							</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>온라인 결제</td>
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
						<tr>
							<td>오프라인 결제</td>
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
			</div>
			<div class="tb_online_account" style="display: none">
				<div class="table_head">
					<h3>온라인 판매대금 정산내역</h3>
				</div>
				<table cellpadding="0" cellspacing="0" class="tb02 ">
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
					</tbody>
					<tfoot>
						<td colspan="6">온라인 매출액 합계</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
					</tfoot>
				</table>
			</div>
			<div class="tb_offline_account" style="display: none">
				<div class="table_head">
					<h3>오프라인 판매대금 정산내역</h3>
				</div>
				<table cellpadding="0" cellspacing="0" class="tb02 ">
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
					</tbody>
					<tfoot>
						<td colspan="7">오프라인 매출액 합계</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
				</table>
			</div>
			<div class="tb_result_account" style="display: none">
				<table class="tb01 " cellpadding="0" cellspacing="0" style="float: right; width: 400px; margin-top: 60px;">
					<tbody>
						<tr>
							<td>공금가액</td>
							<td>0</td>
						</tr>
						<tr>
							<td>부가세</td>
							<td>0</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td>합계 (부가세 포함)</td>
							<td>0</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
		</section>
	</div>
</body>
</html>