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
  2017. 11. 21.   LEE GWANGHO    view.board.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css">

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>
<script src="js/filter.js"></script>
<!-- <script src="js/mypage.js"></script> -->
<script>
	
	$(document).ready(function() {
		
		// side bar 메뉴 class on 
		$(".lnb [href]").each(function() {
			var lng_path = (this.pathname).substr(1, (this.pathname).length);
			var location_path = (window.location.pathname).substr(1, (window.location.pathname).length);
			
			if (location_path.match(lng_path)) {
				$(this).parent().addClass("on");
			} 
		});
		
		//첨부파일 업로드
		$(function() {

			var fileTypes = [ 'image/jpeg', 'image/pjpeg', 'image/png', 'application/pdf'

			]
			//확장자 검사
			function validFileType(file) {
				for (var i = 0; i < fileTypes.length; i++) {
					if (file.type === fileTypes[i]) {
						return true;
					}
				}

				return false;
			}
			
			$('input[type=file]').bind('change', function() {
				var page = (location.pathname).split(".")[1]; 
				var seq = $("input[name='seq']").val();
				var uType = $(this).attr("name"); 
				var tmpFile = $(this)[0].files[0]; 
				var sizeLimit = 1024 * 1024 * 15;
				if (tmpFile.size > sizeLimit) {
					alert("파일 용량이 15MB를 초과했습니다");
					$(this).val("");
					return;
				}
				// 일단 이미지 파일만 확인하도록 했다.
				var fileType = $(this).val();
				var type = ['JPG','PNG','GIF'];
				if(type.indexOf(fileType.substring((fileType.lastIndexOf(".")+1)).toUpperCase()) == -1){
					$(this).val("");
					return alert("알맞지 않은 파일 형식입니다!");
				}
				
				if (validFileType(tmpFile)) {
					var formData = new FormData();
					//첫번째 파일태그
					formData.append("uploadFile", tmpFile);
					formData.append("page", page); // 접근페이지: 회원현황(member), 정산매체사(media), 공지사항(board)

					$.ajax({
						url : '/'+uType+'.upload?seq='+seq,
						data : formData,
						dataType : "json",
						processData : false,
						contentType : false,
						type : 'POST',
						success : function(data) {
							console.log(data);
							if (data.success) {
								alert(data.message);
								$("input[name='seq']").val(data.notice_seq);
							} else {
								alert(data.message);
							}
							//location.reload();
						},
						error : function(data) {
							console.log("Error: " + data.statusText);
							alert("잘못된 접근입니다.");
						},

					});

				} else {
					alert("파일 형식이 올바르지 않습니다.");
					$(this).val("");
				}

			});

		});
		
		var description = $("textarea[name='desc']").val();
		$("textarea[name='desc']").val(removeHTMLTag(description));
	});
	
	function register() { // 공지사항 등록
		var seq = $("input[name='seq']").val();
		var title = $("input[name='tit']").val();
		var description = $("textarea[name='desc']").val();
		//description = description.replace(/(?:\r\n|\r|\n)/g, '<br />'); // 줄바꿈 태그 추가
		var param = "";
		if(seq == "") {
			param = "action=insertNotice";
		} else {
			param = "action=updateNotice";
		}
		
		if(title.trim() == ""){
			alert("제목을 입력해주세요.");
			return;
		}
		
		if(description.trim() == ''){
			alert("내용을 입력해주세요.");
			return;
		}else{	//엔터를 무지막지하게 쳤을 경우
			description.replace(/\\n/g,'');
			if(description.trim() == ''){
				alert("내용을 입력해주세요.");
				return;
			}
		}
		
		if(title != ""){
			$.ajax({
				url: "/view.board.manage?" + param,
				type: "POST",
				data: {
					"seq" : seq,
					"title" : title,
					"description" : description
				},
				success: function(data) {					
					window.location.href = "/board.manage";
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
			
		} else {
// 			alert("제목을 입력해주세요.");
		}
		
	}

	function update() { // 공지사항 수정
		var seq = $("input[name='seq']").val();
		var title = $("input[name='tit']").val();
		var description = $("textarea[name='desc']").val();
		//description = description.replace(/(?:\r\n|\r|\n)/g, '<br />'); // 줄바꿈 태그 추가
		var file = $("input[name='file']").val();
		var fileName;
		
		if(file){
			file = file.split("\\");
			fileName = file[file.length-1];
		}
		if(title == ""){
			alert("제목을 입력해주세요.");
			return;
		}
		
		if(description == ''){
			alert("내용을 입력해주세요.");
			return;
		}else{	//엔터를 무지막지하게 쳤을 경우
			description.replace(/\\n/g,'');
			if(description.trim() == ''){
				alert("내용을 입력해주세요.");
				return;
			}
		}
		
		if(title != ""){
			$.ajax({
				url: "/view.board.manage?action=updateNotice",
				type: "POST",
				data: {
					"seq" : seq,
					"title" : title,
					"description" : description,
					"fileName" : fileName
				},
				success: function(data) {
					window.location.href = "/board.manage";
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		} else {
// 			alert("제목을 입력해주세요.");
		}
		
		
	}
	function removeHTMLTag(text){
		text = text.replace(/<br\/>/ig, "\n"); 
		text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
		return text;
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
					<c:if test="${boardDTO.seq eq null}">
						<h3>공지사항 등록</h3>
					</c:if>
					<c:if test="${boardDTO.seq ne null}">
						<h3>공지사항 수정</h3>
					</c:if>
				</div>
				<section class="noti">
					<table cellpadding="0" cellspacing="0" class="tb01" style=" margin-bottom:10px;">
						<colgroup>
						<col width="100">
						<col>
						</colgroup>
						<tbody>
							<input type="hidden" name="seq" value="${boardDTO.seq}" />
							<tr>
								<th>제목</th>
								<td><input type="text" name="tit" class="inp_txt" size="100" value="${boardDTO.title}"/></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea name="desc" class="inp_txt" rows="20"> ${fn:replace(boardDTO.description, LF, BR)}</textarea></td>
							</tr>
							<tr>
								<th>파일 첨부</th>
								<td><input type="file" name="notice" accept="image/*"  required/></td>
								<c:if test="${!empty boardDTO.fileName}">
									<td><a href="/notice.down.photo?seq=${boardDTO.seq}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" class="btn_input1">다운로드</a></td>	
								</c:if>
							</tr>
						</tbody>
					</table>
					<div class="btn_area">
						<c:if test="${boardDTO.seq eq null}">
							<a href="javascript:void(0)" onclick="register()" class="btn_input2">등록</a>
						</c:if>
						<c:if test="${boardDTO.seq ne null}">
							<a href="javascript:void(0)" onclick="update()" class="btn_input2">수정</a>
						</c:if>
						
						<a href="/board.manage" class="btn_input1">취소</a>
					</div>
			</section>
			</div>
		</section>
	</div>
</body>
</html>