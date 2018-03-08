<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2018. 03. 07. 오후 14:24:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 21.   LEE GWANGHO    popular.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.dahami.newsbank.web.service.bean.SearchParameterBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
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
<script type="text/javascript">
	$(document).ready(function() {
		//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
		$("[href]").each(function() {
			if (this.href == window.location.href) {
				$(this).parent().addClass("on");
			}
		});		
		
	});
</script>

<title>뉴스뱅크</title>
</head>
<body>
	<div class="wrap admin">
		<%@include file="header_admin.jsp"%>
		<section class="wide"> <%@include file="sidebar.jsp"%>

			<div class="mypage">
				<div class="table_head">
					<h3>인기사진 관리</h3>
				</div>
				<div class="tab">
					<ul class="tabs">
						<li><a href="javascript:tabControl(0)" class="active">엄선한
								사진</a></li>
						<li><a href="javascript:tabControl(1)">다운로드</a></li>
						<li><a href="javascript:tabControl(2)">찜</a></li>
						<li><a href="javascript:tabControl(3)">상세보기</a></li>
					</ul>
				</div>
				<div class="popular_list">
					<!-- 검색추가는 엄선한 사진에만 있고 다운로드 찜 상세보기에는 없어요-->
					<div class="cms_search">
						이미지 추가 <input type="text" placeholder="이미지 검색">
							<button>검색</button>
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
							<tr>
								<td>I011-M004974664</td>
								<td>㈜다하미커뮤니케이션즈</td>
								<td>12340회</td>
								<td><a href="#" class="list_btn">삭제</a></td>
							</tr>
							<tr>
								<td>I011-M004948927</td>
								<td>동아일보</td>
								<td>9회</td>
								<td><a href="#" class="list_btn">삭제</a></td>
							</tr>
							<tr>
								<td>I011-M000701299</td>
								<td>동아일보</td>
								<td>8회</td>
								<td><a href="#" class="list_btn">삭제</a></td>
							</tr>
							<tr>
								<td>I011-M004638910</td>
								<td>동아일보</td>
								<td>7회</td>
								<td><a href="#" class="list_btn">삭제</a></td>
							</tr>
							<tr>
								<td>I011-M000936947</td>
								<td>동아일보</td>
								<td>6회</td>
								<td><a href="#" class="list_btn">삭제</a></td>
							</tr>
							<tr>
								<td>I011-M004405317</td>
								<td>세계일보</td>
								<td>5회</td>
								<td><a href="#" class="list_btn">삭제</a></td>
							</tr>
							<tr>
								<td>I011-M004905777</td>
								<td>뉴시스</td>
								<td>4회</td>
								<td><a href="#" class="list_btn">삭제</a></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_area">
						<a href="#" class="btn_input2">저장</a><a href="#" class="btn_input1">취소</a>
					</div>
				</div>
				<div id="photo_area">
					<img
						src="http://www.dev.newsbank.co.kr/view.down.photo?uciCode=I011-M001047566&amp;dummy=LZsxEkUOqaAHHg14cFQjxA%3D%3D"
						alt="미리보기인데 제가 구현할 수 없으니 통이미지로 넣었습니다. 이 영역에 미리보기 넣어주세요!"
						style="float: left; width: 100%;">
				</div>
			</div>

		</section>
	</div>
</body>
</html>