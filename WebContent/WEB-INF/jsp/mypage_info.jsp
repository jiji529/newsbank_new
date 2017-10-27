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
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/common.js"></script>
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
</script>
</head>
<%
	String type = (String) request.getAttribute("type");
%>
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
					<%
						if (session.getAttribute("MemberInfo") == null) // 로그인이 안되었을 때
						{
							// 로그인 화면으로 이동
					%>
					<li>
						<a href="/login">로그인</a>
					</li>
					<li>
						<a href="/kind.join" target="_blank">가입하기</a>
					</li>
					<%
						} else { // 로그인 했을 경우
					%>
					<li>
						<a href="/logout">Log Out</a>
					</li>
					<li>
						<a href="/info.mypage">My Page</a>
					</li>
					<%
						}
					%>
				</ul>
			</div>
			<div class="gnb_srch">
				<form id="searchform">
					<input type="text" value="검색어를 입력하세요" />
					<a href="#" class="btn_search">검색</a>
				</form>
			</div>
		</nav>
		<section class="mypage" id="info_table">
			<div class="head">
				<h2>마이페이지</h2>
				<div class="mypage_ul">
					<ul class="mp_tab1">
						<%
							if (type.equals("C")) {
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
							<a href="/buy.mypage">구매내역</a>
						</li>
					</ul>
				</div>
				<div class="table_head">
					<h3>기본정보 관리</h3>
				</div>
				<h4>개인정보</h4>
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
								<input type="password" class="inp_txt" value="" size="40">
							</td>
						</tr>
						<tr>
							<th>비밀번호 재확인</th>
							<td>
								<input type="password" class="inp_txt" value="" size="40">
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<input type="text" class="inp_txt" value="${name}" size="40">
							</td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td class="phone">
								<input type="text" size="5" class="inp_txt" value="${phone}" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" size="5" class="inp_txt" value="${phone}" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" size="5" class="inp_txt" value="${phone}" maxlength="4" />
								<a href="#" class="btn_input1">수정</a>
								<!-- 수정 누르면 보이는 -->
								<div class="edit_phone">
									<span class="edit_phone_txt">변경할 휴대전화</span>
									<select name="" class="inp_txt" style="width: 70px;">
										<option value="010" selected="selected">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select>
									<span class=" bar">-</span>
									<input type="text" id="celphone" size="5" class="inp_txt" value="1234" maxlength="4">
									<span class=" bar">-</span>
									<input type="text" id="celphone2" size="5" class="inp_txt" value="1234" maxlength="4" />
									<a href="#" class="btn_input2">인증번호 요청</a>
									<div class="">
										<span class="edit_phone_txt">인증번호 입력</span>
										<input type="text" size="40" class="inp_txt" value="" maxlength="4" />
										<a href="#" class="btn_input1">확인</a>
									</div>
								</div>
								<!-- 여기까지 -->
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" class="inp_txt" size="80" value="${email}" />
							</td>
						</tr>
					</tbody>
				</table>
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
								<input type="text" class="inp_txt" size="60" />
							</td>
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td>
								<input type="text" size="3" class="inp_txt" value="${compNum1}" maxlength="3">
								<span class=" bar">-</span>
								<input type="text" size="2" class="inp_txt" value="${compNum2}" maxlength="2">
								<span class=" bar">-</span>
								<input type="text" size="5" class="inp_txt" value="${compNum3}" maxlength="6" />
								<a href="#" class="btn_input1">등록증 업로드</a>
								<a href="#" class="btn_input1">다운로드</a>
							</td>
						</tr>
						<tr>
							<th>사무실 전화</th>
							<td>
								<select name="" class="inp_txt" style="width: 70px;">
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
								<input type="text" id="celphone" size="5" class="inp_txt" value="1234" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" id="celphone2" size="5" class="inp_txt" value="1234" maxlength="4" />
							</td>
						</tr>
						<tr>
							<th>회사 주소</th>
							<td>
								<div class="my_addr">
									<input type="text" class="inp_txt" size="6" />
									<a href="#" class="btn_input1">수정</a>
								</div>
								<div class="my_addr">
									<input type="text" class="inp_txt" size="55" />
									<input type="text" class="inp_txt" size="55" />
								</div>
							</td>
						</tr>
						<tr>
							<th>정산 매체</th>
							<td>
								<input type="file" />
								<a href="#" class="btn_input1">매체선택</a>
								<a href="#" class="btn_input1">제호업로드</a>
								<a href="#" class="btn_input1">다운로드</a>
								<a class="file_add">파일 추가</a>
								<a class="file_del">파일 삭제</a>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_area">
					<a href="#" class="btn_input2">수정</a>
					<a href="#" class="btn_input1">취소</a>
				</div>
			</div>
		</section>
	</div>
</body>
</html>
