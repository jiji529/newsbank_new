<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="/js/popular.js"></script>

<!-- <script type="text/javascript">
	
	// 이미지 삭제
	$(document).on("click",".list_btn",function() {		
		this.closest("tr").remove();
	});
	
	// 이미지 추가
	$(document).on("click", ".btn_add", function() {
		var keyword = $("#keyword").val(); // UCI코드
		var uciCode; // uci코드
		var ownerName; // 매체사
		var hitCount; // 조회수
		var tr_cnt = $("tbody tr").length; // 테이블 행 갯수
		var html = '';
		
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
					}else if(count == 0) {
						alert("UCI 코드를 정확히 입력해주세요.");
					}else if(tr_cnt >= 7) {
						alert("최대 7개 사진을 엄선할 수 있습니다.");	
					}
				}
			});
		}
		
	});
	// 취소
	$(document).on("click", ".btn_input1", function() {
		location.reload();
	});
	
	// 최종저장
	$(document).on("click", ".btn_input2", function() {
		// 기존 리스트 생성
		var existList = $("#uciCodeList").val();
		existList = existList.replace("[", "");
		existList = existList.replace("]", "");
		existList = existList.split(", ");
	
		var editList = [];
		$("tbody tr").each(function(index){
			var uciCode = $(this).find("td:first").text();
			editList.push(uciCode);
		});
		
		var delArr = array_diff(existList, editList); // 삭제될 대상
		var insArr = array_diff(editList, existList); // 추가될 대상
		
		var param = {
			"delArr" : delArr
			, "insArr" : insArr
			, "tabName" : "selected"
		};
		console.log(param);
		
		jQuery.ajaxSettings.traditional = true; // 배열 직렬화전달
		
		$.ajax({
			type: "POST",
			dataType: "json",
			url: "/admin.popular.api",
			data: param,
			success: function(data) {
				
			},
			complete: function() {
				location.reload();
			}
		});
	});
	
	// 차집합 (a-b)
	function array_diff(a, b) {
		var tmp={}, res=[];
		for(var i=0;i<a.length;i++) tmp[a[i]]=1;
		for(var i=0;i<b.length;i++) { if(tmp[b[i]]) delete tmp[b[i]]; }
		for(var k in tmp) res.push(k);
		return res;
	}
</script> -->

<!-- 검색추가는 엄선한 사진에만 있고 다운로드 찜 상세보기에는 없어요-->

<div class="center">
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
		<a href="#" id="btn_complete" class="btn_input2">저장</a><a href="#" class="btn_input1">취소</a>
	</div>
</div>