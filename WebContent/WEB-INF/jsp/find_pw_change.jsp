<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 11. 3.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 3.   	  tealight        file_name
---------------------------------------------------------------------------%>
<%@page import="com.dahami.newsbank.web.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	MemberDTO memberDTO = (MemberDTO) request.getAttribute("memberDTO");
System.out.println(memberDTO);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크 비밀번호 찾기</title>
<link rel="stylesheet" href="css/join.css" />
<script src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="js/find.js"></script>
</head>
<body>
	<div class="wrap">
		<header>
			<h1>
				<a href="/home" class="logo">뉴스뱅크</a>
			</h1>
		</header>
		<section class="join">
			<div class="wrap_tit">
				<h3 class="tit_join">비밀번호 찾기</h3>
				<div class="txt_desc">새 비밀번호를 입력해주세요.</div>
			</div>
			<form id="frmChangePw" method="post">
				<fieldset class="fld_comm">
					<legend class="blind">비밀번호 찾기</legend>
					<div class="wrap_info">
						<div class="box_info">
							<div class="id_area">
								뉴스뱅크 아이디:
								<font class="color">${findMemberDTO.getId()}</font>
							</div>
							<dl class="item_info">
								<dt>새 비밀번호</dt>
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
						</div>
					</div>
				</fieldset>
				<div class="wrap_btn2">
					<button type="submit" class="btn_agree">확인</button>
				</div>
			</form>
		</section>
		<footer>
			<ul>
				<li>
					<a href="/policy.intro">이용약관</a>
				</li>
				<li class="bar"></li>
				<li>
					<a href="/privacy.intro">개인정보처리방침</a>
				</li>
			</ul>
			<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
		</footer>
	</div>
</body>
</html>