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
						<a href="/kind.join">가입하기</a>
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
						<li>
							<a href="/acount.mypage">정산 관리</a>
						</li>
						<li>
							<a href="/cms">사진 관리</a>
						</li>
						<li class="on">
							<a href="/info.mypage">회원정보 관리</a>
						</li>
						<li>
							<a href="#">찜관리</a>
						</li>
						<li>
							<a href="#">장바구니</a>
						</li>
						<li>
							<a href="/buy.mypage">구매내역</a>
						</li>
					</ul>
					<ul class="mp_tab2">
						<li class="on">
							<a href="#">기본정보 관리</a>
						</li>
						<li>
							<a href="#">정산정보 관리</a>
						</li>
					</ul>
				</div>
				<div class="table_head">
					<h3>기본정보 관리</h3>
					<h4>개인정보</h4>
				</div>
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
								<input type="text" size="5" class="inp_txt" value="${phone[0]}" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" size="5" class="inp_txt" value="${phone[1]}" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" size="5" class="inp_txt" value="${phone[2]}" maxlength="4" />
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
								<input type="text" size="3" class="inp_txt" value="${compNum[0]}" maxlength="3">
								<span class=" bar">-</span>
								<input type="text" size="2" class="inp_txt" value="${compNum[1]}" maxlength="2">
								<span class=" bar">-</span>
								<input type="text" size="5" class="inp_txt" value="${compNum[2]}" maxlength="6" />
								<a href="#" class="btn_input1">등록증 업로드</a>
								<a href="#" class="btn_input1">다운로드</a>
							</td>
						</tr>
						<tr>
							<th>사무실 전화</th>
							<td>
								<select name="" class="inp_txt" style="width: 70px;">
									<option value="010" selected="selected">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								<span class=" bar">-</span>
								<input type="text" size="5" class="inp_txt" value="${compTel[1]}" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" size="5" class="inp_txt" value="${compTel[2]}" maxlength="4" />
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
		<section class="mypage" id="account_table" style="display: none;">
			<div class="head">
				<h2>마이페이지</h2>
				<p>설명어쩌고저쩌고</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1">
					<li>
						<a href="#">정산 관리</a>
					</li>
					<li>
						<a href="#">사진 관리</a>
					</li>
					<li class="on">
						<a href="#">회원정보 관리</a>
					</li>
					<li>
						<a href="#">찜관리</a>
					</li>
					<li>
						<a href="#">장바구니</a>
					</li>
					<li>
						<a href="#">구매내역</a>
					</li>
				</ul>
				<ul class="mp_tab2">
					<li class="on">
						<a href="#">기본정보 관리</a>
					</li>
					<li>
						<a href="#">정산정보 관리</a>
					</li>
				</ul>
			</div>
			<div class="table_head">
				<h3>정산 정보 관리</h3>
			</div>
			<table class="tb01" cellpadding="0" cellspacing="0">
				<colgroup>
					<col style="width: 240px;">
					<col style="width:;">
				</colgroup>
				<tbody>
					<tr>
						<th>매체명</th>
						<td>
							<select name="" class="inp_txt" style="width: 450px;">
								<option value="010" selected="selected">선택해주세요.</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>입금 계좌</th>
						<td>
							<select name="" class="inp_txt" style="width: 120px;">
								<option value="010" selected="selected">기업은행</option>
							</select>
							<input type="text" class="inp_txt" size="40" />
							<a href="#" class="btn_input1">통장사본 업로드</a>
							<a href="#" class="btn_input1">다운로드</a>
						</td>
					</tr>
					<tr>
						<th>계약기간</th>
						<td>
							<input type="text" size="12" class="inp_txt" value="2017-05-01" maxlength="10">
							<span class=" bar">~</span>
							<input type="text" size="12" class="inp_txt" value="2017-05-01" maxlength="10">
							<div class="check">
								<input type="checkbox" />
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
							<input type="text" size="5" class="inp_txt" value="" maxlength="3">
							<span class=" bar">%</span>
							<span class=" bar" style="margin-left: 20px;">후불 결제</span>
							<input type="text" size="5" class="inp_txt" value="" maxlength="3">
							<span class=" bar">%</span>
						</td>
					</tr>
					<tr>
						<th>세금계산서 담당자</th>
						<td>
							<input type="text" class="inp_txt" size="60" />
						</td>
					</tr>
					<tr>
						<th>세금계산서 담당자 연락처</th>
						<td>
							<select name="" class="inp_txt" style="width: 70px;">
								<option value="010" selected="selected">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							<span class=" bar">-</span>
							<input type="text" size="5" class="inp_txt" value="1234" maxlength="4">
							<span class=" bar">-</span>
							<input type="text" size="5" class="inp_txt" value="1234" maxlength="4">
						</td>
					</tr>
					<tr>
						<th>세금계산서 담당자 이메일</th>
						<td>
							<input type="text" class="inp_txt" size="60" />
						</td>
					</tr>
				</tbody>
			</table>
			<p class="ex_txt">*수정이 필요한 경우, 회사(02-593-4174) 또는 뉴스뱅크 서비스 담당자에게 연락 부탁드립니다.</p>
			<div class="btn_area">
				<a href="#" class="btn_input2">수정</a>
				<a href="#" class="btn_input1">취소</a>
			</div>
		</section>
	</div>
</body>
</html>
