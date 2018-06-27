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

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>
<script src="js/jquery.twbsPagination.js"></script>
<script src="js/admin.js?v=20180307"></script>
<script type="text/javascript">

	$(document).ready(function(){
		setDatepicker();
	});
	
	//언론사 회원 추가 버튼 클릭
	function member_submit() {
		$('#frmJoin').submit(); // 회원 추가 
	}
	
	// 언론사 회사/기관명 입력값 전달
	function send_compName() {
		var compName = $("#compName").val();
		$("#re_compName").html(compName);
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
				<h3>정산 매체사 관리 - 언론사 추가</h3>
			</div>
			<h4>기본 정보</h4>
			<form id="frmJoin" action="/admin.member.api" name="frmJoin" method="post">
				<input type="hidden" name="cmd" value="C" />
				<table class="tb01" cellpadding="0" cellspacing="0">
					<colgroup>
					<col style="width:240px;">
					<col style="width:;">
					</colgroup>
					<tbody>
						<tr>
							<th>아이디 </th>
							<!-- <td><input type="text"  class="inp_txt"   value=""  size="15" ></td> -->
							<td>
								<input type="text" class="inp_txt" id="id" name="id" maxlength="15" pattern="[A-Za-z0-9]*" title="숫자와 영문만 입력 하세요." required />
								<p class="txt_message" id="id_message" style="display: none;">이미 사용된 아이디입니다. 다른 아이디를 입력하세요.</p>
								<p class="txt_message" id="id_message2" style="display: none;">숫자와 영문만 입력 하세요.</p>
							</td>
						</tr>
						<tr>
							<th> 비밀번호 변경 </th>
							<td>
								<input type="password" name="pw" id="pw" class="inp_txt" size="40">
								<p class="txt_message" id="pw_message" style="display: none;">영대소문자, 숫자, 특수기호를 모두 사용해주세요</p>
							</td>
						</tr>
						<tr>
							<th>비밀번호 재확인</th>
							<td>
								<input type="password" name="pw_check" id="pw_check" class="inp_txt" size="40">
								<p class="txt_message" id="pw_check_message" style="display: none;">비밀번호가 일치하지 않습니다.</p>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text"  id="name" name="name" class="inp_txt" size="40"  maxlength="15" ></td>
						</tr>
						<tr>
							<th>휴대전화번호</th>
							<td class="phone"><select id="phone1" name="" class="inp_txt" style="width:70px;">
									<option value="010" selected="selected">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								<span class=" bar">-</span>
								<input type="text" id="phone2" size="5"  class="inp_txt" value="" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" id="phone3" size="5"  class="inp_txt" value="" maxlength="4" /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" id="email" name="email" class="inp_txt" size="50" value="" /></td>
						</tr>
						<tr>
							<th>회원구분</th>
							<td>
								<select name="type" class="inp_txt" style="width:120px;" onchange="member_choice()">
									<option value="M" selected="selected">언론사</option>
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
							<td><input type="text" id="compName" name="compName" class="inp_txt" size="60" value="" onblur="send_compName()"/></td>
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td><input type="text" id="compNum1" size="3"  class="inp_txt" value="" maxlength="3">
								<span class=" bar">-</span>
								<input type="text" id="compNum2" size="2"  class="inp_txt" value="" maxlength="2">
								<span class=" bar">-</span>
								<input type="text" id="compNum3" size="5"  class="inp_txt" value="" maxlength="6" />
								<a href="#" class="btn_input1" id="compDoc" name="uploadFile" accept="application/pdf, image/*">사업자등록증 업로드</a>
								<p class="txt_message" id="compNum_message" style="display: none;">형식이 올바르지 않은 번호입니다.</p>
						    </td>
						</tr>
						<tr>
							<th>회사/기관 전화</th>
							<td><select id="compTel1" name="" class="inp_txt" style="width:70px;">
									<option value="02" selected="selected">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
									<option value="041">041</option>
									<option value="042">042</option>
									<option value="043">043</option>
									<option value="044">044</option>
									<option value="051">051</option>
									<option value="052">052</option>
									<option value="053">053</option>
									<option value="054">054</option>
									<option value="055">055</option>
									<option value="061">061</option>
									<option value="062">062</option>
									<option value="063">063</option>
									<option value="064">064</option>
									<option value="070">070</option>
									<option value="080">080</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
							 </select>
								<span class=" bar">-</span>
								<input type="text" id="compTel2" size="5"  class="inp_txt" value="" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" id="compTel3" size="5"  class="inp_txt" value="" maxlength="4">
								<span class=" bar2">내선</span>
								<input type="text" id="compExtTel" name="compExtTel" size="5"  class="inp_txt" value="" maxlength="4" />
								
								<p class="txt_message" id="compTel_message" style="display: none;">형식이 올바르지 않은 번호입니다.</p><br/>
								<p class="txt_message" id="compExtTel_message" style="display: none;">형식이 올바르지 않은 내선번호입니다.</p>
							</td>
						</tr>
						<tr>
							<th>회사/기관 주소</th>
							<td><div class="my_addr">
									<input type="text" id="compZipcode" name="compZipcode" class="inp_txt" size="6" />
									<a href="#" id="findAddress" class="btn_input1">우편번호 찾기</a></div>
								<div class="my_addr">
									<input type="text" id="compAddress" name="compAddress" class="inp_txt" size="50" />
									<input type="text" id="compAddDetail" name="compAddDetail" class="inp_txt" size="50" placeholder="상세주소 직접 입력"/>
								</div></td>
						</tr>
						<tr>
							<th>결제구분</th>
							<td><select name="deferred" class="inp_txt" style="width:180px;" onchange="deferred_choice()">
									<option value="0" selected="selected">온라인결제</option>
									<option value="1">오프라인결제</option>
									<option value="2">오프라인 별도가격</option>
								</select></td>
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
							<td><span class="bar"></span></td>
						</tr>
					</tbody>
				</table>
				<h5><span id="re_compName"></span> 정산 정보</h5>
				<table class="tb01" cellpadding="0" cellspacing="0">
					<colgroup>
					<col style="width:240px;">
					<col style="width:;">
					</colgroup>
					<tbody>
						<tr>
							<th>결제 계좌</th>
							<td><input type="text" name="compBankName" id="compBankName" placeholder="은행 입력" class="inp_txt" size="14" value=" " />
								<span class=" bar"></span>
								<input type="text" name="compBankAcc" id="compBankAcc" placeholder="계좌번호 입력" class="inp_txt" size="26" value=" " />
								<a href="#" class="btn_input1">통장사본 업로드</a></td>
						</tr>
						<tr>
							<th>계약 기간</th>
							<td><input type="text" name="contractStart" id="contractStart" class="inp_txt datepicker" size="12" value=" " />
								<span class=" bar">~</span>
								<input type="text" name="contractEnd" id="contractEnd" class="inp_txt datepicker" size="12" value=" " />
								<a href="#" class="btn_input1">계약서 업로드</a> </td>
						</tr>
						<tr>
							<th>정산요율</th>
							<td><span class=" bar">온라인 결제</span>
								<input type="text" name="preRate" id="preRate" class="inp_txt" size="4" value=" " />
								<span class=" bar">%</span><span class=" bar" style="margin-left:10px;">오프라인 결제</span>
								<input type="text" name="postRate" id="postRate" class="inp_txt" size="4" value=" " />
								<span class=" bar">%</span> </td>
						</tr>
						<tr>
							<th>세금계산서 담당자</th>
							<td><input type="text" name="taxName" id="taxName" class="inp_txt" size="43" value=" " /></td>
						</tr>
						<tr>
							<th>세금계산서 담당자 전화번호</th>
							<td><select name="taxPhone1" id="taxPhone1" class="inp_txt" style="width:70px;">
									<option value="02" selected="selected">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
									<option value="041">041</option>
									<option value="042">042</option>
									<option value="043">043</option>
									<option value="044">044</option>
									<option value="051">051</option>
									<option value="052">052</option>
									<option value="053">053</option>
									<option value="054">054</option>
									<option value="055">055</option>
									<option value="061">061</option>
									<option value="062">062</option>
									<option value="063">063</option>
									<option value="064">064</option>
									<option value="070">070</option>
									<option value="080">080</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								<span class=" bar">-</span>
								<input type="text" id="taxPhone2" size="5"  class="inp_txt" value=" " maxlength="4">
								<span class=" bar">-</span>
								<input type="text" id="taxPhone3" size="5"  class="inp_txt" value=" " maxlength="4">
								<span class=" bar2">내선</span>
								<input type="text" id="taxExtTell" name="taxExtTell" size="5"  class="inp_txt" value=" " maxlength="4" /></td>
						</tr>
						<tr>
							<th>세금계산서 담당자 이메일</th>
							<td><input type="text" name="taxEmail" id="taxEmail" class="inp_txt" size="50" value="" /></td>
						</tr>
						<tr>
							<th>제호</th>
							<td><span class="bar"></span><a href="#" class="btn_input1">업로드</a></td>
	
						</tr>
						<tr>
							<th>서비스 상태</th>
							<td>
								<select id="activate" name="activate" class="inp_txt" style="width:100px;">
									<option value="1" selected="selected">활성</option>
									<option value="2">비활성</option>
								</select>
							</td>
						</tr>
				</tbody>
				</table>
			</form>
			<div class="btn_area"><a href="javascript:void(0);" class="btn_input2" onclick="member_submit()">추가</a><a href="/media.manage" class="btn_input1">취소</a></div>
		</div>
	</section>
</div>
</body>
</html>
