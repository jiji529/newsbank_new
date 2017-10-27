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


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<link rel="stylesheet" href="css/join.css" />
</head>
<body>
<div class="wrap">
	<header>
		<h1><a href="#" class="logo">뉴스뱅크</a></h1>
	</header>
	<section class="join">
		<ul class="navi">
			<li class="" >종류 선택</li>
			<li>약관 동의</li>
			<li class="selected">정보 입력</li>
			<li>가입 완료</li>
		</ul>
		<div class="wrap_tit">
			<h3 class="tit_join">가입 정보 입력</h3>
			<div class="txt_desc">가입 정보를 입력하세요. </div>
		</div>
		<form id="join1">
			<fieldset class="fld_comm">
				<legend class="blind">가입 정보</legend>
				<div class="wrap_info">
					<div class="box_info">
						<dl class="item_info">
							<dt> 아이디 </dt>
							<dd>
								<div class="inp">
									<input type="text" maxlength="15" placeholder="아이디">
								</div>
								<p class="txt_message" style="display:none;">이미 사용된 아이디입니다. 다른 아이디를 입력하세요.</p>
							</dd>
						</dl>
						<dl class="item_info">
							<dt> 비밀번호 </dt>
							<dd>
								<div class="inp">
									<input type="password" maxlength="16" placeholder="비밀번호 (6~16자의 영문 대소문자, 숫자, 특수문자를 조합)">
								</div>
								<p class="txt_message" style="display:none;">일반적인 단어는 추측하기 쉽습니다. 다시 만드시겠어요?</p>
							</dd>
						</dl>
						<dl class="item_info">
							<dt> 비밀번호 재확인 </dt>
							<dd>
								<div class="inp">
									<input type="password" class="inp_info" maxlength="15" placeholder="비밀번호 재확인">
								</div>
								<p class="txt_message" style="display:none;">비밀번호가 일치하지 않습니다.</p>
							</dd>
						</dl>
						<dl class="item_info">
							<dt> 이메일 </dt>
							<dd>
								<div class="inp">
									<input type="text" placeholder="이메일">
								</div>
								<p class="txt_message" style="display:none;">형식이 올바르지 않은 이메일입니다.</p>
							</dd>
						</dl>
						<dl class="item_info">
							<dt> 이름 </dt>
							<dd>
								<div class="inp">
									<input type="text" placeholder="이름">
								</div>
							</dd>
						</dl>
						<dl class="item_info">
							<dt> 휴대폰 번호 </dt>
							<dd class="btn_inp">
								<div class="inp">
									<input type="number" placeholder="휴대폰 번호">
									<button>인증</button>
								</div>
							</dd>
							<dd class="btn_inp">
								<div class="inp">
									<input type="text" placeholder="인증번호">
									<button>확인</button>
								</div>
							</dd>
						</dl>
					</div>
					<!--여기부턴 기업회원-->
					<div class="box_info">
						<dl class="item_info">
							<dt> 소속/기관명 </dt>
							<dd>
								<div class="inp">
									<input type="text"  placeholder="소속/기관명">
								</div>
							</dd>
						</dl>
						<dl class="item_info">
							<dt> 사업자등록번호 </dt>
							<dd>
								<div class="inp">
									<input type="text"  placeholder="사업자등록번호">
								</div>
							</dd>
							<!--언론사 회원한테만 파일첨부 창 보여주기-->
							<dt> 사업자등록증</dt>
							<dd>
								<div class="inp">
									<input type="file" />
								</div>
							</dd>
							<!--언론사 회원한테만 파일첨부 창 보여주기 여기까지-->
						</dl>
						<dl class="item_info">
							<dt> 회사 전화 번호 </dt>
							<dd>
								<div class="inp">
									<input type="number" placeholder="회사 전화 번호">
								</div>
							</dd>
						</dl>
					</div>
					<!--여기부턴 언론사회원-->
					<div class="box_info">
						<dl class="item_info">
							<dt> 정산할 매체 </dt>
							<dd>
								<div class="inp">
									<select>
										<option>서비스 중인 매체 중에서 선택</option>
									</select>
								</div>
							</dd>
						</dl>
						<dl class="item_info">
							<dt> 매체사 로고 </dt>
							<dd>
								<div class="inp">
									<input type="file" />
								</div>
							</dd>
						</dl>
					</div>
				</div>
			</fieldset>
			<div class="wrap_btn">
				<button type="button" class="btn_agree" onClick="top.location.href='/success.join'">가입하기</button>
			</div>
		</form>
	</section>
	<footer>
		<ul>
			<li><a href="#">뉴스뱅크 소개</a></li>
			<li class="bar"></li>
			<li><a href="#">이용약관</a></li>
			<li class="bar"></li>
			<li><a href="#">개인정보처리방침</a></li>
		</ul>
		<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
	</footer>
</div>
</body>
</html>