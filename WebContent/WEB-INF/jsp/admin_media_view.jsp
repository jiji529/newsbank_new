<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2018. 03. 02. 오후 15:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 12. 29.   LEE GWANGHO    media_add
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크관리자</title>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/mypage.css" />
<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css" />

<style type="text/css">
	#loading {
	 display: none;
	 width: 100%;   
	 height: 100%;   
	 top: 0px;
	 left: 0px;
	 position: fixed;   
	 display: block;   
	 opacity: 0.7;   
	 background-color: #fff;   
	 z-index: 99;   
	 text-align: center; }  
	 
	#loading-image {   
	 position: absolute;   
	 top: 50%;   
	 left: 50%;   
	 z-index: 100; } 
</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>
<script src="js/jquery.twbsPagination.js"></script>
<script src="js/admin.js?v=20180307"></script>
<script type="text/javascript">

	$(document).ready(function() {
		setDatepicker();
		
		$(".lnb [href]").each(function() {
			var lng_path = (this.pathname).substr(1, (this.pathname).length);
			var location_path = (window.location.pathname).substr(1, (window.location.pathname).length);
			
			if (location_path.match(lng_path)) {
				$(this).parent().addClass("on");
			} 
		});
	});
	
	//회원정보 수정
	function member_update() {
		$('#frmJoin').submit(); // 회원 정보 수정
		console.log("member_update");
	}
	
	// 정산정보 수정
	function media_update() {		
		var count = $(".frmMedia").length;
		var json_data = new Array;
		
		$(".frmMedia").each(function(key, value){
			var id = "#frmMedia_"+key;
			var taxPhone = $("#taxPhone1_"+ key + " option:selected").val() + $("#taxPhone2_" + key).val() + $("#taxPhone3_" + key).val();
			
			if($("#frmMedia_" + key).find("[name=taxPhone]").length > 0) {
				$("#frmMedia").find("[name=taxPhone]").val(taxPhone);
			}else {
				$('<input>').attr({
					type : 'hidden',
					name : 'taxPhone',
					value : taxPhone
				}).appendTo('.frmMedia');
			}
			
			var formData = $(id).serializeArray();
			var jsonObj = jQFormSerializeArrToJson(formData);
			
			json_data.push(jsonObj);
		});
		
		console.log(json_data);
		var adjustData = {"ajdustList" : JSON.stringify(json_data)}; // json 데이터
		
		$.ajax({
			type: "POST",
			url: "/admin.member.api",
			data: adjustData,
			success: function(data) {
				var success = data.success;
				var message = data.message;
				
				if(success) {
					console.log(message);
					//alert(message);					
				}
			}
		});
		
	}
	
	// serialArray를 {name, value}로 변환하는 함수
	function jQFormSerializeArrToJson(formSerializeArr){
		 var jsonObj = {};
		 jQuery.map( formSerializeArr, function( n, i ) {
		     jsonObj[n.name] = n.value;
		 });

		 return jsonObj;
	} 
</script>
</head>
<body>
<div class="wrap admin">
	<%@include file="header_admin.jsp" %>
	<section class="wide">
		<%@include file="sidebar.jsp" %>
		
		<div class="mypage">
			<div class="table_head">
				<h3>정산 매체사 관리</h3>
			</div>
			<h4>기본 정보</h4>
			<form id="frmJoin" action="/admin.member.api" name="frmJoin" method="post">
				<input type="hidden" name="cmd" value="U" />
				<input type="hidden" name="seq" value="${MemberDTO.seq}" />
				<input type="hidden" id="type" name="type" value="${MemberDTO.type}" />
				<table class="tb01" cellpadding="0" cellspacing="0">
					<colgroup>
					<col style="width:240px;">
					<col style="width:;">
					</colgroup>
					<tbody>
						<tr>
							<th>아이디 </th>
							<td>${MemberDTO.id}</td>
						</tr>
						<tr>
							<th> 비밀번호 변경 </th>
							<td>
								<input type="password" id="pw" name="pw" class="inp_txt" size="40">
								<p class="txt_message" id="pw_message" style="display: none;">일반적인 단어는 추측하기 쉽습니다. 다시 만드시겠어요?</p>
							</td>
						</tr>
						<tr>
							<th>비밀번호 재확인</th>
							<td>
								<input type="password" id="pw_check" name="pw_check" class="inp_txt" size="40">
								<p class="txt_message" id="pw_check_message" style="display: none;">비밀번호가 일치하지 않습니다.</p>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>${MemberDTO.name}</td>
						</tr>
						<tr>
							<th>휴대전화번호</th>
							<td class="phone"><select id="phone1" name="" class="inp_txt" style="width:70px;">
									<option value="010" <c:if test="${phone1 eq '010'}">selected</c:if>>010</option>
									<option value="011" <c:if test="${phone1 eq '011'}">selected</c:if>>011</option>
									<option value="016" <c:if test="${phone1 eq '016'}">selected</c:if>>016</option>
									<option value="017" <c:if test="${phone1 eq '017'}">selected</c:if>>017</option>
									<option value="018" <c:if test="${phone1 eq '018'}">selected</c:if>>018</option>
									<option value="019" <c:if test="${phone1 eq '019'}">selected</c:if>>019</option>
								</select>
								<span class="bar">-</span>
								<input type="text" id="phone2" size="5"  class="inp_txt" value="${phone2}" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" id="phone3" size="5"  class="inp_txt" value="${phone3}" maxlength="4" /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input id="email" name="email" type="text" class="inp_txt" size="50" value="${MemberDTO.email}" /></td>
						</tr>
						<tr>
							<th>회원구분</th>
							<td>
								<select name="type" class="inp_txt" style="width: 120px;" onchange="member_choice()">
									<option value="P" <c:if test="${MemberDTO.type eq 'P'}">selected</c:if>>개인</option>
									<option value="C" <c:if test="${MemberDTO.type eq 'C'}">selected</c:if>>법인</option>
									<option value="M" <c:if test="${MemberDTO.type eq 'M'}">selected</c:if>>언론사</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				<h4>언론사 회원 추가 정보</h4>
				<table class="tb01" cellpadding="0" cellspacing="0">
					<colgroup>
					<col style="width:240px;">
					<col style="width:;">
					</colgroup>
					<tbody>
						<tr>
							<th>회사/기관명</th>
							<td><input type="text" id="compName" name="compName" class="inp_txt" size="60" value="${MemberDTO.compName}" /></td>
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td><input type="text" id="compNum1" name="compNum1"  size="3"  class="inp_txt" value="${compNum1}" maxlength="3">
								<span class=" bar">-</span>
								<input type="text" id="compNum2" name="compNum2" size="2"  class="inp_txt" value="${compNum2}" maxlength="2">
								<span class=" bar">-</span>
								<input type="text" id="compNum3" name="compNum3" size="5"  class="inp_txt" value="${compNum3}" maxlength="6" />
								<a href="#" class="btn_input1">사업자등록증 업로드</a> <a href="#" class="btn_input1">사업자등록증 다운로드</a></td>
						</tr>
						<tr>
							<th>회사/기관 전화</th>
							<td>
								<select id="compTel1" name="compTel1" class="inp_txt" style="width:70px;">											
									<option value="02" <c:if test="${compTel1 eq '02'}">selected</c:if>>02</option>
									<option value="031" <c:if test="${compTel1 eq '031'}">selected</c:if>>031</option>
									<option value="032" <c:if test="${compTel1 eq '032'}">selected</c:if>>032</option>
									<option value="033" <c:if test="${compTel1 eq '033'}">selected</c:if>>033</option>
									<option value="041" <c:if test="${compTel1 eq '041'}">selected</c:if>>041</option>
									<option value="042" <c:if test="${compTel1 eq '042'}">selected</c:if>>042</option>
									<option value="043" <c:if test="${compTel1 eq '043'}">selected</c:if>>043</option>
									<option value="044" <c:if test="${compTel1 eq '044'}">selected</c:if>>044</option>
									<option value="051" <c:if test="${compTel1 eq '051'}">selected</c:if>>051</option>
									<option value="052" <c:if test="${compTel1 eq '052'}">selected</c:if>>052</option>
									<option value="053" <c:if test="${compTel1 eq '053'}">selected</c:if>>053</option>
									<option value="054" <c:if test="${compTel1 eq '054'}">selected</c:if>>054</option>
									<option value="055" <c:if test="${compTel1 eq '055'}">selected</c:if>>055</option>
									<option value="061" <c:if test="${compTel1 eq '061'}">selected</c:if>>061</option>
									<option value="062" <c:if test="${compTel1 eq '062'}">selected</c:if>>062</option>
									<option value="063" <c:if test="${compTel1 eq '063'}">selected</c:if>>063</option>
									<option value="064" <c:if test="${compTel1 eq '064'}">selected</c:if>>064</option>
									<option value="070" <c:if test="${compTel1 eq '070'}">selected</c:if>>070</option>
									<option value="080" <c:if test="${compTel1 eq '080'}">selected</c:if>>080</option>
									<option value="010" <c:if test="${compTel1 eq '010'}">selected</c:if>>010</option>
									<option value="011" <c:if test="${compTel1 eq '011'}">selected</c:if>>011</option>
									<option value="016" <c:if test="${compTel1 eq '016'}">selected</c:if>>016</option>
									<option value="017" <c:if test="${compTel1 eq '017'}">selected</c:if>>017</option>
									<option value="018" <c:if test="${compTel1 eq '018'}">selected</c:if>>018</option>
									<option value="019" <c:if test="${compTel1 eq '019'}">selected</c:if>>019</option>
								</select>
								<span class=" bar">-</span>
								<input type="text" id="compTel2" name="compTel2" size="5"  class="inp_txt" value="${compTel2}" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" id="compTel3" name="compTel3" size="5"  class="inp_txt" value="${compTel3}" maxlength="4">
								<span class=" bar2">내선</span>
								<input type="text" id="compExtTel" name="compExtTel" size="5"  class="inp_txt" value="${compExtTel}" maxlength="4" />
								<p class="txt_message" id="compExtTel_message" style="display: none;">형식이 올바르지 않은 번호입니다.</p><br/>
							</td>
								
						</tr>
						<tr>
							<th>회사/기관 주소</th>
							<td>
								<div class="my_addr">
									<input type="text" id="compZipcode" name="compZipcode" class="inp_txt" value="${MemberDTO.compZipcode}" size="6" />
									<a href="#" id="findAddress" class="btn_input1">수정</a></div>
								<div class="my_addr">
									<input type="text" id="compAddress" name="compAddress" class="inp_txt" value="${MemberDTO.compAddress}" size="50" />
									<input type="text" id="compAddDetail" name="compAddDetail" class="inp_txt" value="${MemberDTO.compAddDetail}" size="50" />
								</div>
							</td>
						</tr>
						<tr>
							<th>결제구분</th>
							<td>
								<select name="deferred" class="inp_txt" style="width:180px;" onchange="deferred_choice()">
									<option value="0" <c:if test="${MemberDTO.deferred eq '0'}">selected</c:if>>온라인결제</option>
									<option value="1" <c:if test="${MemberDTO.deferred eq '1'}">selected</c:if>>오프라인결제</option>
									<option value="2" <c:if test="${MemberDTO.deferred eq '2'}">selected</c:if>>오프라인 별도 요금</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>정산 매체</th>
							<td>
								<select name="admission" class="inp_txt" style="width:180px;">
									<option value="Y" selected="selected">승인</option>
									<option value="N" >비승인</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				<h4>정산 정보</h4>
				<table class="tb01" cellpadding="0" cellspacing="0">
					<colgroup>
					<col style="width:240px;">
					<col style="width:;">
					</colgroup>
					<tbody>
						<tr>
							<th>정산 매체</th>
							<td><span class="bar">${mediaList}</span>
								<a href="#" class="btn_input1">수정</a></td>
						</tr>
					</tbody>
				</table>
			</form>
			
			<c:forEach var="media" items="${adjustMedia}" varStatus="status">
				<form class="frmMedia" id="frmMedia_${status.index}" name="frmMedia" method="post" action="">
					<input type="hidden" name="type" value="${media.type}" />
					<input type="hidden" name="cmd" value="M" />
					<h5>${media.compName} 정산 정보</h5>
					<table class="tb01" cellpadding="0" cellspacing="0">
					<colgroup>
					<col style="width:240px;">
					<col style="width:;">
					</colgroup>
					<tbody>
						<tr>
							<th>결제 계좌</th>
							<td><input type="text" name="compBankName" id="compBankName_${status.index}" class="inp_txt" size="14" value="${media.compBankName}" />
								<span class=" bar"></span>
								<input type="text" name="compBankAcc" id="compBankAcc_${status.index}" class="inp_txt" size="26" value="${media.compBankAcc}" />
								<a href="#" class="btn_input1">통장사본 업로드</a><a href="#" class="btn_input1">통장사본 다운로드</a></td>
						</tr>
						<tr>
							<fmt:parseDate value="${media.contractStart}" var="contractStart" pattern="yyyy-MM-dd"/>
							<fmt:parseDate value="${media.contractEnd}" var="contractEnd" pattern="yyyy-MM-dd"/>
							
							<th>계약 기간</th>
							<td><input type="text" name="contractStart" id="contractStart_${status.index}" class="inp_txt datepicker" size="12" value="<fmt:formatDate value="${contractStart}" pattern="yyyy-MM-dd"/>" />
								<span class=" bar">~</span>
								<input type="text" name="contractEnd" id="contractEnd_${status.index}" class="inp_txt datepicker" size="12" value="<fmt:formatDate value="${contractEnd}" pattern="yyyy-MM-dd"/>" />
								<a href="#" class="btn_input1">계약서 업로드</a> <a href="#" class="btn_input1">계약서 다운로드</a></td>
						</tr>
						<tr>
							<th>정산요율</th>
							<td><span class=" bar">온라인 결제</span>
								<input type="text" name="preRate" id="preRate_${status.index}" class="inp_txt" size="4" value="${media.preRate}" />
								<span class=" bar">%</span><span class=" bar" style="margin-left:10px;">오프라인 결제</span>
								<input type="text" name="postRate" id="postRate_${status.index}" class="inp_txt" size="4" value="${media.postRate}" />
								<span class=" bar">%</span> </td>
						</tr>
						<tr>
							<th>세금계산서 담당자</th>
							<td><input type="text" name="taxName" id="taxName_${status.index}" class="inp_txt" size="43" value="${media.taxName}" /></td>
						</tr>
						
						<c:if test="${fn:substring(media.taxPhone,0,2) eq '02'}">
							<c:set var="taxPhone1" value="${fn:substring(media.taxPhone,0,2)}"/>
							
							<c:choose>
								<c:when test="${fn:length(media.taxPhone) eq '9'}">
									<c:set var="taxPhone2" value="${fn:substring(media.taxPhone,2,5)}"/>
								</c:when>
								<c:otherwise>
									<c:set var="taxPhone2" value="${fn:substring(media.taxPhone,2,6)}"/>
								</c:otherwise>								
							</c:choose>
							
						</c:if>
						
						<c:if test="${fn:substring(media.taxPhone,0,2) ne '02'}">
							<c:set var="taxPhone1" value="${fn:substring(media.taxPhone,0,3)}"/>
							
							<c:choose>
								<c:when test="${fn:length(media.taxPhone) eq 10}">
									<c:set var="taxPhone2" value="${fn:substring(media.taxPhone,3,6)}"/>
								</c:when>
								<c:otherwise>
									<c:set var="taxPhone2" value="${fn:substring(media.taxPhone,3,7)}"/>
								</c:otherwise>								
							</c:choose>
							
						</c:if>
						
						<c:set var="taxPhone3" value="${fn:substring(media.taxPhone, fn:length(media.taxPhone) - 4, fn:length(media.taxPhone))}"/>
						
						<tr>
							<th>세금계산서 담당자 전화번호</th>
							<td><select id="taxPhone1_${status.index}" class="inp_txt" style="width:70px;">
									<option value="02"  <c:if test="${taxPhone1 eq '02'}">selected</c:if>>02</option>
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
								<input type="text" id="taxPhone2_${status.index}" size="5"  class="inp_txt" value="${taxPhone2}" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" id="taxPhone3_${status.index}" size="5"  class="inp_txt" value="${taxPhone3}" maxlength="4">
								<span class=" bar2">내선</span>
								<input type="text" id="taxExtTell_${status.index}" name="taxExtTell" size="5"  class="inp_txt" value="${media.taxExtTell}" maxlength="4" /></td>
						</tr>
						<tr>
							<th>세금계산서 담당자 이메일</th>
							<td><input type="text" name="taxEmail" id="taxEmail_${status.index}" class="inp_txt" size="50" value="${media.taxEmail}" /></td>
						</tr>
						<tr>
							<th>제호</th>
							<td><span class="bar">${media.logo}</span><a href="#" class="btn_input1">업로드</a> <a href="#" class="btn_input1">다운로드</a></td>
	
						</tr>
						<tr>
							<th>서비스 상태</th>
							<td><select id="activate_${status.index}" name="activate" class="inp_txt" style="width:100px;">
									<option value="1" <c:if test="${media.activate eq '1'}">selected</c:if>>활성</option>
									<option value="2" <c:if test="${media.activate eq '2'}">selected</c:if>>비활성</option></select>
							</td>
						</tr>
				</tbody>
				<input type="hidden" name="media_seq" value="${media.seq}" />
				</table>
				</form>	
			</c:forEach>		
			<div class="btn_area"><a href="#" class="btn_input2" onclick="member_update(); media_update();">회원정보 수정</a><a href="/media.manage" class="btn_input1">목록</a></div>
		</div>
	</section>
</div>
</body>
</html>
