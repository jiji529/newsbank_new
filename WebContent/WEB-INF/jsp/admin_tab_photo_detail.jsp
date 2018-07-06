<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<script src="/js/popular.js"></script>
<script type="text/javascript">
	
</script>

<!-- 검색추가는 엄선한 사진에만 있고 다운로드 찜 상세보기에는 없어요-->
<table cellpadding="0" cellspacing="0" class="tb04" style="">
	<colgroup>
		<col width="80">
		<col width="80">
		<col width="40">
		<col width="40">
	</colgroup>
	<thead>
		<tr>
			<th>UCI 코드</th>
			<th>매체사</th>
			<th>횟수</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="photo" items="${photoList}">
			<tr>
				<td>${photo.uciCode}</td>
				<td>${photo.ownerName}</td>
				<td>${photo.hitCount}회</td>
				<td><a href="#" id="btn_del" class="list_btn" value="${photo.mediaExActive}">삭제</a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div class="btn_area">
	<a href="#" id="btn_save" class="btn_input2">저장</a><a href="#" class="btn_input1">취소</a>
</div>
