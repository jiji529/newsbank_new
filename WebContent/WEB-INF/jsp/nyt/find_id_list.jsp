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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="common/head_meta.jsp"/>
<title>NYT 뉴스뱅크 아이디 찾기</title>
<link rel="stylesheet" href="css/nyt/base.css" />
<link rel="stylesheet" href="css/nyt/join.css" />
<script src="js/nyt/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="js/nyt/find.js"></script>
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
				<div class="txt_desc">고객님의 정보와 일치하는 아이디 목록입니다.</div>
			</div>
			<form id="frmFindList">
				<div class="id_box">
					<ul class="id_list">
						<c:forEach items="${listMember}" var="member">
							<li>
								<strong>
									<label>
										<input type="radio" name="id" value="${member.id}"/>
										${member.id}
									</label>
								</strong>
								<span>가입일 ${member.regDate}</span>
							</li>
						</c:forEach>
						<c:if test="${fn:length(listMember) == 0}">
						<li>
								<strong>
									일치하는 아이디가 없습니다.
								</strong>
							</li>
						</c:if>

			
					</ul>
				</div>
				<div class="wrap_btn2">
					<button type="button" class="btn_agree" id="btnLogin">로그인하기</button>
					<button type="button" class="btn_cancel" id="btnFindPw" >비밀번호 찾기</button>
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