<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2018. 01. 04. 오전 10:11:23
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2018. 01. 04.   LEE GWANGHO    add.member.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크관리자</title>

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css" />
<script src="js/footer.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- <script src="js/mypage.js"></script> -->
<!-- <script src="js/join.js"></script> --> <!-- 기존의 회원가입의 형식과는 다른 부분이 있어서 admin.js를 생성해서 필요한 부분만 커스터마이징 -->
<script src="js/admin.js?v=20180416"></script>
<script>

	$(document).ready(function() {
		// 법인, 오프라인 별도가격 항목 숨김처리
		$(".offline_area").hide();
		$(".media_only").hide();
		$(".corp_area").hide();
		
		setDatepicker();
	});
	
	// 회원구분 선택박스
	function member_choice() {
		var type = $("select[name=type]").val();
		
		switch(type) {
			case 'P': // 개인
				$(".media_only").hide();
				$(".corp_area").hide();
				break;
				
			case 'C': // 법인
				$(".media_only").hide();
				$(".corp_area").show();
				break;
				
			case 'M' : case 'Q': case 'W': // 언론사(공통, 사진관리자, 정산관리자)
				$(".media_only").show();
				$(".corp_area").show();
				break;
		}
	}
	
	// 결제 구분 옵션 선택박스
	function deferred_choice() { 
		var deferred = parseInt($("select[name=deferred]").val());
		
		switch(deferred) {
			case 0:
				// 온라인
				$(".offline_area").hide();
				$(".photoUsage").hide();
				break;
				
			case 1:
				// 오프라인
				$(".offline_area").show();
				$(".photoUsage").hide();
				break;
				
			case 2:
				// 오프라인 별도가격
				$(".offline_area").show();
				$(".photoUsage").show();
				break;
		}
	}
	
	// 회원 추가 버튼 클릭
	function member_submit() {
		$('#frmJoin').submit(); // 회원 추가 
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
					<h3>회원 추가</h3>
				</div>
				<h4>기본 정보</h4>
				<!-- <form id="frmJoin" action="/member.api" name="frmJoin"> -->
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
								<th> 비밀번호 </th>
								<td>
									<input type="password" name="pw" id="pw" class="inp_txt" size="40">
									<p class="txt_message" id="pw_message" style="display: none;">영대소문자, 숫자, 특수기호를 모두 사용해주세요.</p>
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
								<td><input type="text" id="name" name="name" class="inp_txt" size="5" ></td>
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
								<td><select name="type" class="inp_txt" style="width:120px;" onchange="member_choice()">
										<option value="P" selected="selected">개인</option>
										<option value="C">법인</option>
										<option value="M">언론사</option>
										<option value="Q">언론사(사진관리자)</option>
										<option value="W">언론사(정산관리자)</option>
									</select></td>
							</tr>
						</tbody>
					</table>
				
					<!--여기부터 법인-->
					<div class="corp_area">
						<h4>법인 회원 추가 정보</h4>
						<table class="tb01" cellpadding="0" cellspacing="0">
							<colgroup>
							<col style="width:240px;">
							<col style="width:;">
							</colgroup>
							<tbody>
								<tr>
									<th>회사/기관명</th>
									<td><input type="text" id="compName" name="compName" class="inp_txt" size="60" value="" /></td>
								</tr>
								<tr>
									<th>사업자등록번호</th>
									<td><input type="text" id="compNum1" size="3"  class="inp_txt" value="" maxlength="3">
										<span class=" bar">-</span>
										<input type="text" id="compNum2" size="2"  class="inp_txt" value="" maxlength="2">
										<span class=" bar">-</span>
										<input type="text" id="compNum3" size="5"  class="inp_txt" value="" maxlength="6" />
										<a href="#" class="btn_input1" id="compDoc" name="uploadFile" accept="application/pdf, image/*">사업자등록증 업로드</a>
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
											<a href="#" id="findAddress" class="btn_input1">주소찾기</a></div>
										<div class="my_addr">
											<input type="text" id="compAddress" name="compAddress" class="inp_txt" size="50" />
											<input type="text" id="compAddDetail" name="compAddDetail" class="inp_txt" size="50" />
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
								<!-- 법인, 언론사 둘다 오프라인 결제 시에만 노출  -->
								<tr class="offline_area">
									<th>계약 기간</th>
									<td><input type="text" name="contractStart" class="inp_txt datepicker" size="12" value="" />
										<span class=" bar">~</span>
										<input type="text" name="contractEnd" class="inp_txt datepicker" size="12" value="" />
										<a href="#" class="btn_input1">계약서 업로드</a> 
									</td>
								</tr>
								<tr class="offline_area photoUsage" style="display: none;">
									<th>사진 용도</th>
									<td><input type="text" class="inp_txt" size="43" placeholder="교과서, 전단지, 뭐 기타등등 여기 직접 입력하는 칸" />
										<b class=" bar" style="margin-left:50px;">사진단가 (VAT 포함)</b>
										<input type="text" class="inp_txt" size="10" value="" />
										<span class=" bar">원</span> <a class="file_add">파일 추가</a><a class="file_del">파일 삭제</a></td>
								</tr>
								<tr class="offline_area">
									<th>세금계산서 담당자</th>
									<td><input type="text" name="taxName" class="inp_txt" size="43" value="" /></td>
								</tr>
								<tr class="offline_area">
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
										<input type="text" name="taxPhone2" id="taxPhone2" size="5"  class="inp_txt" maxlength="4">
										<span class=" bar">-</span>
										<input type="text" name="taxPhone3" id="taxPhone3" size="5"  class="inp_txt" maxlength="4">
										<span class=" bar2">내선</span>
										<input type="text" name="taxExtTell" id="taxExtTell" size="5"  class="inp_txt" maxlength="4" /></td>
								</tr>
								<tr class="offline_area">
									<th>세금계산서 담당자 이메일</th>
									<td><input type="text" name="taxEmail" class="inp_txt" size="50" value="" /></td>
								</tr>
								<!-- 여기부터 언론사만 노출 -->
								<tr class="media_only">
									<th>정산 매체</th>
									<td>
										<select name="admission" class="inp_txt" style="width:180px;">
											<option value="Y" >승인</option>
											<option value="N" selected="selected">비승인</option>
										</select>
										<!-- <a href="#" class="btn_input1">정산정보 보기</a> -->
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</form>
			<div class="btn_area">
				<a href="javascript:void(0)" class="btn_input2" onclick="member_submit()">회원 추가</a>
				<a href="/member.manage" class="btn_input1">취소</a>
			</div>
		</div>
		</section>
	</div>
</body>
</html>