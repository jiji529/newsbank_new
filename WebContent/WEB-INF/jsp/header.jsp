<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript">
	$(document).on("keypress", "#keyword", function(e) {
		if (e.keyCode == 13) { // 엔터
			searchTop();
		}
	});
	
	$(document).on("click", "#btn_search", function(e) { // 검색 버튼
		searchTop();
	});

	function searchTop() {
		if($("#serviceMode").length > 0) {
			$("#keyword_current").val($("#keyword").val());
			search();
		}
		else {
			var keyword = $("#keyword").val();
			keyword = $.trim(keyword);
			$("#keyword_current").val(keyword);
			searchform.submit();
		}
	}
	
	// 로그인 페이지 이동시 매개변수 넘기기
	$(document).ready(function() {
		var param = "${param}".replace(/, /gi, '&').slice(0, -1).slice(1);
		$('a[href="/login"]').on("click", function(e) {
			e.preventDefault();
			var form = document.createElement('form');
			var objs;
			objs = document.createElement('input');
			objs.setAttribute('type', 'hidden');
			objs.setAttribute('name', "prevPage");
			objs.setAttribute('value', window.location.pathname);
			form.appendChild(objs);
			if (param.length > 0) {
				
				$.each(parseQuery(param), function(key, value) {
					
					objs = document.createElement('input');
					objs.setAttribute('type', 'hidden');
					objs.setAttribute('name', key);
					objs.setAttribute('value', value);
					form.appendChild(objs);
				});
			}
			
			form.setAttribute('method', 'post');
			form.setAttribute('action', $(this)[0].href);
			document.body.appendChild(form);
			form.submit();
			return false;
		});
//	query string parse
		function parseQuery(queryString) {
			var query = {};
			var pairs = (queryString[0] === '?' ? queryString.substr(1) : queryString).split('&');
			for (var i = 0; i < pairs.length; i++) {
				var pair = pairs[i].split('=');
				query[decodeURIComponent(pair[0])] = decodeURIComponent(pair[1] || '');
			}
			return query;
		}

	});
</script>
<nav class="gnb_dark">
<div class="gnb">
	<a href="/home" class="logo"></a>
	<ul class="gnb_left">
		<li>
			<a href="/photo">보도사진</a>
		</li>
		<!--li>
			<a href="javascript:void(0)">뮤지엄</a>
		</li>
		<li>
			<a href="javascript:void(0)">사진</a>
		</li-->
		<!-- <li>
			<a href="/collection">컬렉션</a>
		</li> -->
	</ul>
	<ul class="gnb_right">
		<c:choose>
			<c:when test="${empty MemberInfo}">
				<li>
					<a href="/login">로그인</a>
				</li>
				<li>
					<a href="/kind.join" target="_blank">가입하기</a>
				</li>
			</c:when>
			<c:otherwise>
				<li>
					<a href="/logout">로그아웃</a>
				</li>
				<li>
					<a href="/info.mypage">마이페이지</a>
				</li>
				<c:if test="${MemberInfo.type == 'A'}">
					<li class="go_admin">
						<a href="/cms.manage">관리자페이지</a>
					</li>
				</c:if>
			</c:otherwise>
		</c:choose>
	</ul>
</div>
<div class="gnb_srch">
	<form id="searchform" action="/photo" method="post">
		<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해주세요." />
		<input type="text" id="keyword_current" style="display: none;" />
		<a href="javascript:void(0)" id="btn_search" class="btn_search">검색</a>
	</form>
</div>
</nav>