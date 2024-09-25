<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 11. 1.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 1.   	  tealight        file_name
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="common/head_meta.jsp"/>
<title>NYT 뉴스뱅크 아이디 찾기</title>
<link rel="stylesheet" href="css/nyt/base.css" />
<link rel="stylesheet" href="css/nyt/join.css" />
<script src="js/nyt/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="js/nyt/find.js?v=20180226"></script>
</head>
<body>
<div class="wrap">
	<header>
		<nav class="gnb_dark">
			<div class="gnb" style="display:flex; justify-content:center; padding: 0;">
				<a href="/" class="nyt">뉴욕타임스</a><span class="by">X</span>
		   		<a href="https://www.newsbank.co.kr/" target="_blank" class="logo">뉴스뱅크</a>
		   	</div>
	   	</nav>
	</header>
	<section class="join">
		<div class="wrap_tit">
			<h3 class="tit_join">아이디 찾기</h3>
			<div class="txt_desc"> 가입한 아이디를 휴대전화 번호로 찾을 수 있습니다.<br />
									번호가 기억이 나지 않거나 궁금하신 사항이 있다면, 고객센터(02-593-4174)로 문의해 주세요.</div>
		</div>
		<form id="frmFindId" action="/list.find" method="post" >
			<fieldset class="fld_comm">
				<legend class="blind">아이디 찾기</legend>
				<div class="wrap_info">
					<div class="box_info">
						<dl class="item_info">
							<dt> 이름 </dt>
							<dd>
								<div class="inp">
									<input type="text" id="name" name="name" maxlength="40" placeholder="이름" required>
								</div>
							</dd>
						</dl>
						<dl class="item_info">
							<dt> 휴대폰 번호 </dt>
							<dd class="inp_num">
									<select id="phone1" class="inp_txt" style="width:85px;">
										<option value="010" selected="selected">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select>
									<span class=" bar">-</span> 
									<input type="text" id="phone2" size="5"  class="inp_txt"  maxlength="4" required/>
									<span class=" bar">-</span>
									<input type="text" id="phone3" size="5"  class="inp_txt"  maxlength="4" required />
									<input type="hidden" id="access" value="find_id"/>  
									<a href="javascript:;" class="btn_input1" id="phone_certify" >인증</a> 
							</dd>
							<dd class="btn_inp">
								<div class="inp">
									<input type="text" id="certify_number" name="CertiNum" placeholder="인증번호" required>
									<button type="button" id="certify_submit">확인</button>
								</div>
								<p class="txt_message" id="phone_message" style="display: none;">형식이 올바르지 않은 휴대폰 번호입니다.</p>
										<p class="txt_message" id="certify_message" style="display: none;">인증번호를 다시 확인해주세요.</p>
							</dd>
						</dl>
					</div>
				</div>
			</fieldset>
			<div class="wrap_btn2">
				<button type="submit" class="btn_agree"  id="btnSubmit">다음</button>
			</div>
			<p class="find_link">비밀번호를 찾으시나요? <a href="/pw.find">비밀번호 찾기</a></p>
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