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
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>뉴스뱅크</title>
<link rel="stylesheet" href="css/join.css" />
<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css">
<script src="js/jquery-1.12.4.min.js"></script>
<script src='js/jquery.form.min.js'></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="js/join.js"></script>
<script>



//등록증 업로드
$(function() {

	var fileTypes = [ 'image/jpeg', 'image/pjpeg', 'image/png', 'application/pdf'

	]
	//확장자 검사
	function validFileType(file) {
		for (var i = 0; i < fileTypes.length; i++) {
			if (file.type === fileTypes[i]) {
				return true;
			}
		}

		return false;
	}
	
	$('input[name=compDoc]').bind('change', function() {
		var tmpFile = $(this)[0].files[0];
		var sizeLimit = 1024 * 1024 * 15;
		if (tmpFile.size > sizeLimit) {
			alert("파일 용량이 15MB를 초과했습니다");
			$(this).val("");
			return;
		}

		if (!validFileType(tmpFile))  {
			alert("파일 형식이 올바르지 않습니다.");
			$(this).val("");
			return;
		}

	});

});

</script>
</head>
<body>
	<div class="wrap">
		<header>
			<a href="/home" class="logo">
				<h1>뉴스뱅크</h1>
			</a>
		</header>
		<section class="join">
			<ul class="navi">
				<li class="">종류 선택</li>
				<li>약관 동의</li>
				<li class="selected">정보 입력</li>
				<li>가입 완료</li>
			</ul>
			<div class="wrap_tit">
				<h3 class="tit_join">가입 정보 입력</h3>
				<div class="txt_desc">가입 정보를 입력하세요.</div>
			</div>
			<form id="frmJoin" name="frmJoin">
				<input type="hidden" name="cmd" value="C" />
				<input type="hidden" name="type" value="${type }" />
				<fieldset class="fld_comm">
					<legend class="blind">가입 정보</legend>
					<div class="wrap_info">
						<div class="box_info">
							<dl class="item_info">
								<dt>아이디</dt>
								<dd>
									<div class="inp">
										<input type="text" id="id" name="id" maxlength="15" placeholder="아이디" pattern="[A-Za-z0-9]*" title="숫자와 영문만 입력 하세요." required />
									</div>
									<p class="txt_message" id="id_message" style="display: none;">이미 사용된 아이디입니다. 다른 아이디를 입력하세요.</p>
									<p class="txt_message" id="id_message2" style="display: none;">숫자와 영문만 입력 하세요.</p>
								</dd>
							</dl>
							<dl class="item_info">
								<dt>비밀번호</dt>
								<dd>
									<div class="inp">
										<input type="password" id="pw" name="pw" maxlength="16" placeholder="비밀번호 (6~16자의 영문 대소문자, 숫자, 특수문자를 조합)" required />
									</div>
									<p class="txt_message" id="pw_message" style="display: none;">영대소문자, 숫자, 특수기호를 모두 사용해주세요.</p>
								</dd>
							</dl>
							<dl class="item_info">
								<dt>비밀번호 재확인</dt>
								<dd>
									<div class="inp">
										<input type="password" id="pw_check" class="inp_info" maxlength="15" placeholder="비밀번호 재확인" required />
									</div>
									<p class="txt_message" id="pw_check_message" style="display: none;">비밀번호가 일치하지 않습니다.</p>
								</dd>
							</dl>
							<dl class="item_info">
								<dt>이메일</dt>
								<dd>
									<div class="inp">
										<input type="email" id="email" name="email" placeholder="이메일" required />
									</div>
									<p class="txt_message" id="email_message" style="display: none;">형식이 올바르지 않은 이메일입니다.</p>
								</dd>
							</dl>
							<dl class="item_info">
								<dt>이름</dt>
								<dd>
									<div class="inp">
										<input type="text" id="name" name="name" placeholder="이름" maxlength="40" required />
									</div>
								</dd>
							</dl>
							<dl class="item_info">
								<dt>휴대폰 번호</dt>
								<dd class="inp_num">
									<select id="phone1" name="" class="inp_txt" style="width: 85px;">
										<option value="010" selected="selected">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select>
									<span class=" bar">-</span>
									<input type="text" id="phone2" size="5" class="inp_txt" value="" maxlength="4" required pattern="[0-9]*" title="숫자만 입력 하세요." />
									<span class=" bar">-</span>
									<input type="text" id="phone3" size="5" class="inp_txt" value="" maxlength="4" required pattern="[0-9]*" title="숫자만 입력 하세요." />
									<a href="javascript:void(0)" id="phone_certify" class="btn_input1">인증</a>
								</dd>
								<dd>
									<p class="txt_message" id="phone_message" style="display: none;">형식이 올바르지 않은 휴대폰 번호입니다.</p>
								</dd>
								<!-- <dd class="btn_inp">
									<div class="inp">
										<input type="tel" id="phone" name="phone" maxlength="16" placeholder="휴대폰 번호" pattern="[0-9]*" title="숫자만 입력 하세요." required />
										<button type="button" id="phone_certify">인증</button>
									</div>
									<p class="txt_message" id="phone_message" style="display: none;">형식이 올바르지 않은 휴대폰 번호입니다.</p>
								</dd> -->
								<dd class="btn_inp">
									<div class="inp">
										<input type="number" id="certify_number" name="CertiNum" placeholder="인증번호" required />
										<button type="button" id="certify_submit">확인</button>
									</div>
									<p class="txt_message" id="certify_message" style="display: none;">인증번호를 다시 확인해주세요.</p>
								</dd>
							</dl>
						</div>
						<c:if test="${type ne 'P'}">
							<!--여기부턴 기업회원-->
							<div class="box_info">
								<dl class="item_info">
									<dt>소속/기관명</dt>
									<dd>
										<div class="inp">
											<input type="text" id="compName" name="compName" placeholder="소속/기관명" required />
										</div>
										<p class="txt_message">뉴스뱅크에 사진 데이터를 제공하시는 경우 반드시 매체명으로 가입해주세요.</p>
									</dd>
								</dl>
								<dl class="item_info">
									<dt>사업자등록번호</dt>
									<dd>
										<div class="inp num2">
											<input type="text" id="compNum1" placeholder="" maxlength="3" style="width: 60px;" pattern="[0-9]*" title="숫자만 입력 하세요." required />
											<span class=" bar">-</span>
											<input type="text" id="compNum2" placeholder="" maxlength="2" style="width: 45px;" pattern="[0-9]*" title="숫자만 입력 하세요." required />
											<span class=" bar">-</span>
											<input type="text" id="compNum3" placeholder="" maxlength="5" style="width: 75px;" pattern="[0-9]*" title="숫자만 입력 하세요." required />
										</div>
										<p class="txt_message" id="compNum_message" style="display: none;">형식이 올바르지 않은 번호입니다.</p>
									</dd>
									<!--언론사 회원한테만 파일첨부 창 보여주기-->
									<dt>사업자등록증</dt>
									<dd>
										<div class="inp">
											<input type="file" id="compDoc" name="uploadFile" accept="application/pdf, image/*"  />
										</div>
									</dd>
									<!--언론사 회원한테만 파일첨부 창 보여주기 여기까지-->
								</dl>
								<dl class="item_info">
									<dt>회사/기관 전화</dt>
									<dd class="inp_num">
										<select id="compTel1" class="inp_txt" style="width: 85px;">
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
										<input type="text" id="compTel2" size="5" class="inp_txt" value="" maxlength="4" pattern="[0-9]*" title="숫자만 입력 하세요." required />
										<span class=" bar">-</span>
										<input type="text" id="compTel3" size="5" class="inp_txt" value="" maxlength="4" pattern="[0-9]*" title="숫자만 입력 하세요." required />
									</dd>
									<dd>
										<p class="txt_message" id="compTel_message" style="display: none;">형식이 올바르지 않은 번호입니다.</p>
									</dd>
								</dl>
								<dl class="item_info">
									<dt>회사/기관 주소</dt>
									<dd class="inp">
										<div class="inp addr">
											<input type="text" id="compZipcode" name="compZipcode" readonly required>
											<button type="button" id="findAddress">주소찾기</button>
										</div>
									</dd>
									<dd class="inp">
										<div class="inp">
											<input type="text" id="compAddress" name="compAddress" readonly required>
										</div>
									</dd>
									<dd class="inp">
										<div class="inp">
											<input type="text" id="compAddDetail" name="compAddDetail" placeholder="상세주소를 입력하세요">
										</div>
									</dd>
								</dl>
							</div>
						</c:if>
						<c:if test="${type eq '사용안함'}">
							<!--여기부턴 언론사회원-->
							<div class="box_info">
								<dl class="item_info">
									<dt>정산할 매체</dt>
									<dd>
										<div class="inp">
											<select id='meida' name='media'>
												<option>서비스 중인 매체 중에서 선택</option>
												<c:forEach var="media" items="${mediaList}">.
									<option value="${media.seq}">${media.compName}</option>
												</c:forEach>
											</select>
										</div>
									</dd>
								</dl>
								<dl class="item_info">
									<dt>매체사 로고</dt>
									<dd>
										<div class="inp">
											<input type="file" />
										</div>
									</dd>
								</dl>
							</div>
						</c:if>
					</div>
				</fieldset>
				<div class="wrap_btn">
					<button type="submit" class="btn_agree">가입하기</button>
				</div>
			</form>
		</section>
		<footer>
			<ul>
				<li>
					<a target="_blank" href="/policy.intro">이용약관</a>
				</li>
				<li class="bar"></li>
				<li>
					<a target="_blank" href="/privacy.intro">개인정보처리방침</a>
				</li>
			</ul>
			<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
		</footer>
	</div>
</body>
</html>
