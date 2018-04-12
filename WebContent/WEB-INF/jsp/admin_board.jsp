<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2017. 12. 13. 오전 08:24:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 21.   LEE GWANGHO    board.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
	pageContext.setAttribute("LF", "\n"); // Enter
	pageContext.setAttribute("BR", "<br/>"); //br 태그
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css">

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>
<script src="js/filter.js"></script>

<script>
	$(document).ready(function() {
		//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
		$("[href]").each(function() {
			if (this.href == window.location.href) {
				$(this).parent().addClass("on");
			}
		});
		
		$(".popup_close").click(function() {
			$(".popup_wrap").css("display", "none");
			$("#mask").css("display", "none");
		});
	});
	
	/** 전체선택 */
	$(document).on("click", "input[name='check_all']", function() {
		if($("input[name='check_all']").prop("checked")) {
			$(".noti input:checkbox").prop("checked", true);
		}else {
			$(".noti input:checkbox").prop("checked", false);
		}
	});
	
	function popup_open(index) { 
		$(".popup_"+index).css("display", "block"); // 선택 인덱스 팝업 열기
		$("#mask").css("display", "block");
	}
	
	function board_view(seq) { // 상세 페이지 이동
		$("#seq").val(seq);
		view_form.submit();
	}
	
	function fn_delete(seq) { // 공지사항 삭제
		var tf = false;
		$.ajax({
			url: "/board.manage?action=deleteNotice",
			type: "POST",
			data: {
				"seq" : seq
			},
			async: false,	//비동기 할건지 설정사항
			success: function(data) {
				$(".tr_"+seq).remove();
				resort();
				tf = true;
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				tf = false;
			}
		});
		return tf;
	}
	
	function delete_board(seq) { // 개별삭제
		var chk = confirm("정말로 삭제하시겠습니까?");
	
		if(chk == true) {
			var tf = false;
			tf = fn_delete(seq);
			if(tf) alert("성공적으로 삭제되었습니다.");
		}
	}
	
	function multi_delete_board() { // 선택삭제
		var chk_total = $(".noti input:checkbox:checked").length;
		if(chk_total == 0) {
			alert("최소 1개 이상을 선택해주세요.");
		}else {
			var chk = confirm("정말로 삭제하시겠습니까?");
			
			if(chk == true) {
				var tf = false;
				$(".noti input:checkbox:checked").each(function(index) {
					var seq = $(this).val();
					tf = fn_delete(seq);
					if(!tf) return false;
				});
				if(tf) alert("성공적으로 삭제되었습니다.");
			}
		}
	}
	
	function insert_board() { // 신규 등록
		view_form.submit();
	}
	
	function resort() { //목록 재정렬
		$(".noti tbody tr").each(function(index) {
			$(this).find("td:eq(1)").text(index + 1);			
		});
	}
</script>

<title>뉴스뱅크</title>
</head>
<body>
	<div class="wrap admin">
		<%@include file="header_admin.jsp" %>
		
		<section class="wide">
			<%@include file="sidebar.jsp" %>
			<div class="mypage">
				<div class="table_head">
					<h3>공지사항</h3>
					<button class="fr btn_head" onclick="insert_board()">글쓰기</button>
				</div>
				<div class="btn_sort">
					<ul class="button">
						<li class="sort_del" onclick="multi_delete_board()">선택 삭제</li>
					</ul>
				</div>
				<section class="noti">
					<table cellpadding="0" cellspacing="0" class="tb04" style=" margin-bottom:10px;">
						<colgroup>
						<col width="30">
						<col width="70">
						<col>
						<col width="220">
						<col width="80">
						<col width="80">
						</colgroup>
						
						<thead>
							<tr>
								<th scope="col"> <div class="tb_check">
										<input id="check_all" name="check_all" type="checkbox">
										<label for="check_all">선택</label>
									</div>
								</th>
								<th>번호</th>
								<th>제목</th>
								<th>등록날짜</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach items="${boardList}" var="board" varStatus="status">
								<tr class="tr_${board.seq}">
									<td><div class="tb_check">
											<input id="check${status.index + 1}" name="check" type="checkbox" value="${board.seq}">
											<label for="check${status.index + 1}">선택</label>
										</div></td>
									<td>${status.index + 1}</td>
									<td><span onclick="popup_open(${status.index + 1})"><a href="#none">${board.title}</a></span></td>
									<fmt:parseDate value="${board.regDate}" var="noti_regDate" pattern="yyyy-MM-dd"/>
									<td><fmt:formatDate value="${noti_regDate}" pattern="yyyy-MM-dd"/></td>
									<%-- <td><a href="view.board.manage?seq=${board.seq}" class="list_btn">수정</a></td> --%>
									<td><a href="javascript:void(0)" onclick="board_view(${board.seq})" class="list_btn">수정</a></td>
									<td><a href="javascript:void(0)" onclick="delete_board(${board.seq})" class="list_btn">삭제</a></td>
								</tr>
							</c:forEach>							
						</tbody>
					</table>
					
					<c:forEach items="${boardList}" var="board" varStatus="status">
						<div id="popup_wrap" class="wd popup_wrap popup_${status.index + 1}">
							<div class="pop_tit">
								<h2>
									공지사항 미리보기
									<c:if test="${!empty board.fileName}">
									 (첨부파일 有)
									</c:if>
								</h2>
								<p>
									<button class="popup_close">닫기</button>
								</p>
							</div>
							<div class="pop_cont">
								<div class="pop_noti_tit"> ${board.title} </div>
								<div class="pop_noti_txt" style="overflow:scroll;">
									<c:if test="${!empty board.fileName}">
										<img src="<%=IMG_SERVER_URL_PREFIX%>/notice.down.photo?seq=${board.seq}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>"/>
									</c:if>
									${fn:replace(board.description, LF, BR)}	
								</div>
							</div>
						</div>
					</c:forEach>
					
					<div id="mask"></div>
				</section>
			</div>
		</section>
		<form class="view_form" method="post" action="/view.board.manage" name="view_form" >
			<input type="hidden" name="seq" id="seq"/>
		</form>
	</div>
</body>
</html>