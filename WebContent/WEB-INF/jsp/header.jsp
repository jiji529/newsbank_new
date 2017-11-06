<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript">
	$(document).on("keypress", "#keyword", function(e) {
		if(e.keyCode == 13) {	// 엔터
			var keyword = $("#keyword").val();
			keyword = $.trim(keyword);
			$("#keyword_current").val(keyword);
			
			if(keyword != "") {
				location.href = "/photo?keyword="+keyword;	
			}else {
				location.href = "/photo";
			}
		}
	});
</script>
<nav class="gnb_dark">
	<div class="gnb"><a href="/home" class="logo"></a>
		<ul class="gnb_left">
			<li class="on"><a href="/photo">보도사진</a></li>
			<li><a href="#">뮤지엄</a></li>
			<li><a href="#">사진</a></li>
			<li><a href="#">컬렉션</a></li>
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
			<input type="text" id="keyword" value="${keyword}" placeholder="검색어를 입력해주세요." />
			<input type="text" id="keyword_current" value="${keyword}" style="display:none;"/>
			<a href="#" class="btn_search">검색</a>
		</form>
	</div>
</nav>