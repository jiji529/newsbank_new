<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뉴스뱅크</title>
<link rel="stylesheet" href="css/base.css" />

<script>
	$(document).ready(function() {
		$('.popup_change').on('click', function() {
			alert('변경되었습니다.');
		});
		$('.popup_close').on('click', function() {
			location.reload();
		});
	});
</script>
</head>
<body>
	<div id="popup_wrap" class="pop_id">
		<div class="pop_tit">
			<h2>아이디를 변경해 주세요</h2>
		</div>
		<div class="pop_cont">
			<div class="id_cont">
				<p>
					뉴스뱅크 사이트 업데이트로 인하여 <br /> 기존에 사용하고 계시는 아이디를 더 이상 사용하실 수 없습니다. <br />
					<b>영문 대소문자, 숫자 조합 4~20자 이내</b>의 새로운 아이디를 등록해주세요. <br /> 기존 아이디에서
					사용하셨던 이력을 이관하여 드리겠습니다.
				</p>
			</div>
			<dl class="input_box">
				<dt>현재 아이디</dt>
				<dd>${id}</dd>
				<dt>새 아이디</dt>
				<dd>
					<input type="text" maxlength="20" />
				</dd>
				<dt>새 아이디 확인</dt>
				<dd>
					<input type="text" maxlength="20" />
				</dd>
			</dl>
			<p class="id_alert">
				<b>2018년 5월 31일까지</b> 꼭 아이디를 변경해주세요.<br />이후에는 기존 아이디로 로그인 하실 수
				없습니다.
			</p>
		</div>
		<div class="pop_foot">
			<div class="pop_btn">
				<button class="popup_change">변경하기</button>
				<button class="popup_close">다음에 변경하기</button>
			</div>
		</div>
	</div>
	<div class="mask" style="display: block;"></div>
</body>
</html>