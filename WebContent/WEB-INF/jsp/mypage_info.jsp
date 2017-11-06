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
  2017. 10. 16.   hoyadev        info.mypage
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/mypage.js"></script>
<script type="text/javascript">
	$(document).on("click", ".mp_tab2 li:nth-child(1)", function() {
		$(".mp_tab2 li:nth-child(1)").addClass("on");
		$(".mp_tab2 li:nth-child(2)").removeClass("on");
		$("#info_table").css("display", "block");
		$("#account_table").css("display", "none");
	});

	$(document).on("click", ".mp_tab2 li:nth-child(2)", function() {
		$(".mp_tab2 li:nth-child(2)").addClass("on");
		$(".mp_tab2 li:nth-child(1)").removeClass("on");
		$("#info_table").css("display", "none");
		$("#account_table").css("display", "block");
	});
	$(document).ready(function() {

		$("#compTel1 option").each(function() {

			if ($(this).val() == "${compTel1}") {

				$(this).attr("selected", "selected"); // attr적용안될경우 prop으로

			}

		});

	});
</script>
</head>
<%
	String type = (String) request.getAttribute("type");
%>
<body>
	<div class="wrap">
		<%@include file="header.jsp" %>
		<section class="mypage" id="info_table">
			<div class="head">
				<h2>마이페이지</h2>
				<div class="mypage_ul">
					<ul class="mp_tab1">
						<%
							if (type.equals("M")) {
								//임시
						%>
						<li>
							<a href="/acount.mypage">정산 관리</a>
						</li>
						<li>
							<a href="/cms">사진 관리</a>
						</li>
						<%
							}
						%>
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
				</div>
				<div class="table_head">
					<h3>기본정보 관리</h3>
				</div>
				<h4>개인정보</h4>
				<form id="frmMypage" action="/member.api" method="post">
					<table class="tb01" cellpadding="0" cellspacing="0">
						<colgroup>
							<col style="width: 240px;">
							<col style="width:;">
						</colgroup>
						<tbody>
							<tr>
								<th>
									아이디
									<em class="ico ico_require">필수항목</em>
								</th>
								<td>${id}</td>
							</tr>
							<tr>
								<th>비밀번호 변경</th>
								<td>
									<input type="password" id="pw"  class="inp_txt" size="40" maxlength="16" placeholder="비밀번호 (6~16자의 영문 대소문자, 숫자, 특수문자를 조합)">
									<p class="txt_message" id="pw_message" style="display: none;">일반적인 단어는 추측하기 쉽습니다. 다시 만드시겠어요?</p>
								</td>
							</tr>
							<tr>
								<th>비밀번호 재확인</th>
								<td>
									<input type="password" id="pw_check" class="inp_txt"  size="40" maxlength="16" placeholder="비밀번호 재확인">
									<p class="txt_message" id="pw_check_message" style="display: none;">비밀번호가 일치하지 않습니다.</p>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<input type="text" id="name" name="name" class="inp_txt" value="${name}" size="40" required>
								</td>
							</tr>
							<tr>
								<th>휴대전화</th>
								<td class="phone">
									<input type="text" size="5" class="inp_txt" value="${phone1}" maxlength="4" readonly />
									<span class=" bar">-</span>
									<input type="text" size="5" class="inp_txt" value="${phone2}" maxlength="4" readonly />
									<span class=" bar">-</span>
									<input type="text" size="5" class="inp_txt" value="${phone3}" maxlength="4" readonly />
									<a href="javascrpit:;" id="btnEdit" class="btn_input1">수정</a>
									<!-- 수정 누르면 보이는 -->
									<div class="edit_phone" style="display: none" id="editView">
										<span class="edit_phone_txt">변경할 휴대전화</span>
										<select id="phone1" class="inp_txt" style="width: 70px;">
											<option value="010" selected="selected">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>
										<span class=" bar">-</span>
										<input type="text" id="phone2" size="5" class="inp_txt" value="" maxlength="4">
										<span class=" bar">-</span>
										<input type="text" id="phone3" size="5" class="inp_txt" value="" maxlength="4" />
										<a href="javascrpit:;" id="phone_certify" class="btn_input2">인증번호 요청</a>
										<div class="">
											<span class="edit_phone_txt">인증번호 입력</span>
											<input type="text" size="40" id="certify_number" name="CertiNum"  class="inp_txt" value="" maxlength="6" />
											<a href="javascrpit:;" id="certify_submit" class="btn_input1">확인</a>
										</div>
										<p class="txt_message" id="phone_message" style="display: none;">형식이 올바르지 않은 휴대폰 번호입니다.</p>
										<p class="txt_message" id="certify_message" style="display: none;">인증번호를 다시 확인해주세요.</p>
									</div>
									<!-- 여기까지 -->
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>
									<input type="text" id="email" name="email" class="inp_txt" size="80" value="${email}" required/>
								</td>
							</tr>
						</tbody>
					</table>
					<%
						if (!type.equalsIgnoreCase("P")) {
					%>
					<h4>법인 정보</h4>
					<table class="tb01" cellpadding="0" cellspacing="0">
						<colgroup>
							<col style="width: 240px;">
							<col style="width:;">
						</colgroup>
						<tbody>
							<tr>
								<th>회사/기관명</th>
								<td>
									<input type="text" id="compName" name="compName" class="inp_txt" size="60" value="${compName}" required/>
								</td>
							</tr>
							<tr>
								<th>사업자등록번호</th>
								<td>
									<input type="text" size="3" id="compNum1" class="inp_txt" value="${compNum1}" maxlength="3" required />
									<span class=" bar">-</span>
									<input type="text" size="2" id="compNum2" class="inp_txt" value="${compNum2}" maxlength="2" required />
									<span class=" bar">-</span>
									<input type="text" size="5" id="compNum3" class="inp_txt" value="${compNum3}" maxlength="5" required />
									<a href="#" class="btn_input1">등록증 업로드</a>
									<a href="#" class="btn_input1">다운로드</a>
								</td>
							</tr>
							<tr>
								<th>사무실 전화</th>
								<td>
									<select id="compTel1" class="inp_txt" style="width: 70px;">
										<option value="">선택</option>
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
										<option value="02">02</option>
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
										<option value="0130">0130</option>
									</select>
									<span class=" bar">-</span>
									<input type="text" id="compTel2" size="5" class="inp_txt" value="${compTel2}" maxlength="4" required />
									<span class=" bar">-</span>
									<input type="text" id="compTel3" size="5" class="inp_txt" value="${compTel3}" maxlength="4" required />
								</td>
							</tr>
							<tr>
								<th>회사 주소</th>
								<td>
									<div class="my_addr">
										<input type="text" id="compZipcode" name="compZipcode" class="inp_txt" size="6" value="${compZipcode}" readonly required />
										<a href="javascript:;" id="findAddress" class="btn_input1">수정</a>
									</div>
									<div class="my_addr">
										<input type="text" id="compAddress" name="compAddress" class="inp_txt" size="55" value="${compAddress}" readonly  required />
										<input type="text" id="compAddDetail" name="compAddDetail" class="inp_txt" size="55" value="${compAddDetail}" />
									</div>
								</td>
							</tr>
							<%
								if (type.equalsIgnoreCase("M")) {
							%>
							<tr>
								<th>정산 매체</th>
								<td>
									<input type="file" />
									<a href="javascript:;" class="btn_input1">매체선택</a>
									<a href="javascript:;" class="btn_input1">제호업로드</a>
									<a href="javascript:;" class="btn_input1">다운로드</a>
									<a class="file_add">파일 추가</a>
									<a class="file_del">파일 삭제</a>
								</td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<%
						}
					%>
					<div class="btn_area">
						<a href="javascript:;" id="btnSubmit" class="btn_input2">수정</a>
						<a href="javascript:location.reload();" class="btn_input1">취소</a>
					</div>
					<input type="hidden" name="cmd" value="U" />
					<input type="hidden" id="type" name="type" value="<%=type%>" />
				</form>
			</div>
		</section>
	</div>
</body>
</html>
