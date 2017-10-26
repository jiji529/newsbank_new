<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : Choi, Seong Hyeon
  @date     : 2017. 10. 23. 오전 08:20:00
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 23.   tealight        login
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String id = "";
	if (request.getAttribute("id") != null) {
		id = (String) request.getAttribute("id");
	}
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크 로그인</title>
<link rel="stylesheet" href="css/join.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>
	<div class="wrap">
		<header>
			<h1>
				<a href="/home" class="logo">뉴스뱅크</a>
			</h1>
		</header>
		<section class="join">
			<form method="post" id="frmLogin" name="frmLogin">
				<fieldset class="login_form">
					<legend class="blind">로그인</legend>
					<div class="inp_login">
						<label for="id" class="lbl" style="display: block;">아이디</label>
						<input type="text" id="id" name="id" placeholder="아이디" value="<%=id%>" maxlength="20" pattern="[A-Za-z0-9]*" title="숫자와 영문만 입력 하세요." required />
					</div>
					<div class="inp_login">
						<label for="pw" class="lbl" style="display: block;">비밀번호</label>
						<input type="password" id="pw" name="pw" placeholder="비밀번호" value="" maxlength="20" required />
					</div>
					<%
						// 아이디, 비밀번호가 틀릴경우 화면에 메시지 표시
						// LoginPro.jsp에서 로그인 처리 결과에 따른 메시지를 보낸다.
						Object msg = request.getAttribute("msg");
						System.out.println(request.getAttribute("msg"));

						if (msg != null && msg.equals("0")) {
							out.println("<div class='error'>");
							out.println("<p >아이디 또는 비밀번호를 다시 확인하세요.</p>");
							out.println("</div>");
						}
					%>
					<input type="submit" title="로그인" alt="로그인" value="로그인" class="btn_login" onclick="">
					<div class="login_check">
						<input type="checkbox" id="login_chk" name="login_chk" <%if (id.length() > 1)
				out.println("checked");%> />
						<label for="login_chk" id="label_login_chk" class="sp">아이디 저장</label>
					</div>
				</fieldset>
			</form>
			<div class="find_info">
				<a target="_blank" href="find_id.html">아이디 찾기</a>
				<span class="bar">|</span>
				<a target="_blank" href="find_pw.html">비밀번호 찾기</a>
				<span class="bar">|</span>
				<a target="_blank" href="join1.html">회원가입</a>
			</div>
		</section>
		<footer>
			<ul>
				<li>
					<a href="#">뉴스뱅크 소개</a>
				</li>
				<li class="bar"></li>
				<li>
					<a href="#">이용약관</a>
				</li>
				<li class="bar"></li>
				<li>
					<a href="#">개인정보처리방침</a>
				</li>
			</ul>
			<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
		</footer>
	</div>
</body>
</html>
