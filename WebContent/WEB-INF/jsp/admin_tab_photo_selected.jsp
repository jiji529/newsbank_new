<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript">
	
	// 이미지 삭제
	$(document).on("click",".list_btn",function() {		
		/* var delete_exhArray = $("#delete_exhArray").val(); // 삭제할 대상
		var seq = $(this).attr("value"); // photo_exhibition seq 값
		
		if(delete_exhArray.length == 0){
			delete_exhArray = seq;
		}else {
			delete_exhArray += "," + seq;	
		}
		$("#delete_exhArray").val(delete_exhArray);
		console.log($("#delete_exhArray").val()); */
		
		this.closest("tr").remove();
		
	});
	
	// 이미지 추가
	$(document).on("click", ".btn_add", function() {
		var keyword = $("#keyword").val(); // UCI코드
		var uciCode; // uci코드
		var ownerName; // 매체사
		var hitCount; // 조회수
		var tr_cnt = $("tbody tr").length; // 테이블 행 갯수
		//var insert_exhArray = $("#insert_exhArray").val(); // 추가할 대상
		var html = '';
		
		// ajax로 입력한 uciCode가 존재하는 여부 확인
		// 있으면 해당 매체사와 조회수를 가져와서 추가
		// 단, 현재 엄선한 사진의 갯수가 7개 미만일 경우만 추가하기
		// max = 7  이상일 경우는 최대 엄선할 수 있는 갯수가 7개를 알려주기.
		
		var searchParam = {"keyword" : keyword};
		var count = 0;
		
		if(keyword != "") {
			$.ajax({
				type: "POST",
				async: false,
				dataType: "json",
				data: searchParam,
				timeout: 1000000,
				url: "search",
				success : function(data) { //console.log(data); 
					count = data.count; 
					
					if(count > 0) {
						uciCode = data.result[0].uciCode; // uci코드
						ownerName = data.result[0].ownerName; // 매체사
						hitCount = data.result[0].hitCount; // 조회수	
						
						html += '<tr>';
						html += '<td>' + keyword + '</td>';
						html += '<td>' + ownerName + '</td>';
						html += '<td>' + hitCount + '회</td>';
						html += '<td><a href="#" class="list_btn" value="${photo.mediaExActive}">삭제</a></td>';
						html += '</tr>';
					}
					
				},
				complete: function() {
					if(count != 0 && tr_cnt < 7) { // 7개 미만일 때만 추가
						$(html).appendTo("tbody");	
						$("#keyword").val("");

						/* if(insert_exhArray.length == 0){
							insert_exhArray = uciCode;
						}else {
							insert_exhArray += "," + uciCode;	
						}
						$("#insert_exhArray").val(insert_exhArray);
						console.log($("#insert_exhArray").val()); */
						
					}else if(count == 0) {
						alert("UCI 코드를 정확히 입력해주세요.");
					}else if(tr_cnt >= 7) {
						alert("최대 7개 사진을 엄선할 수 있습니다.");	
					}
				}
			});
		}
		
	});
	
	// 최종저장
	$(document).on("click", ".btn_input2", function() {
		// 저장 시 기존의 DB 배열 값
		// 편집 Complete 배열 값 
		// delArr = DB[] - Complete[] : 삭제할 DB
		// insArr = Complete[] - DB[] : 추가할 DB
		
	});
</script>

<!-- 검색추가는 엄선한 사진에만 있고 다운로드 찜 상세보기에는 없어요-->

<div class="cms_search">
	이미지 추가 <input type="text" id="keyword" placeholder="UCI코드 입력">
	<button class="btn_add">추가</button>
</div>

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
				<td><a href="#" class="list_btn" value="${photo.mediaExActive}">삭제</a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div class="btn_area">
	<!-- <input type="hidden" id="delete_exhArray" /> 삭제할  seq
	<input type="hidden" id="insert_exhArray" /> 추가할 uciCode -->
	<p>${dbPhotoList}</p>
	<a href="#" class="btn_input2">저장</a><a href="#" class="btn_input1">취소</a>
</div>
