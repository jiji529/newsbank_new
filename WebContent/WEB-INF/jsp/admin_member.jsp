<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2017. 11. 22. 오후 16:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 21.   LEE GWANGHO    member.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	String IMG_SERVER_URL_PREFIX = "http://www.dev.newsbank.co.kr";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크관리자</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script> 
$(document).ready(function(){ 
$("#popup_open").click(function(){ 
$("#popup_wrap").css("display", "block"); 
$("#mask").css("display", "block"); 
}); 
}); 
</script>
<script> 
$(document).ready(function(){ 
$("#popup_open").click(function(){ 
$("#popup_wrap").css("display", "block"); 
$("#mask").css("display", "block"); 
}); 
$(".popup_close").click(function(){ 
$("#popup_wrap").css("display", "none"); 
$("#mask").css("display", "none"); 
}); 
}); 
</script>
<script>
//관리자페이지 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
$(document).ready(function() {
	$("[href]").each(function() {
		if (this.href == window.location.href) {
			$(this).parent().addClass("on");
		}
	});
});
</script>
</head>
<body>
<div class="wrap admin">
	<%@include file="header_admin.jsp" %>
	<section class="wide">
		<%@include file="sidebar.jsp" %>
		<div class="mypage">
			<div class="table_head">
				<h3>회원 현황</h3>
			</div>
			<div class="ad_sch_area">
				<table class="tb01" cellpadding="0" cellspacing="0">
					<colgroup>
					<col style="width:240px;">
					<col style="width:;">
					</colgroup>
					<tbody>
						<tr>
							<th>아이디/이름/회사명</th>
							<td><input type="text" class="inp_txt" size="50" /></td>
						</tr>
						<tr>
							<th>회원구분</th>
							<td><select name="" class="inp_txt" style="width:380px;">
									<option>전체</option>
									<option>개인</option>
									<option>법인</option>
								</select></td>
						</tr>
						<tr>
							<th>결제구분</th>
							<td><select name="" class="inp_txt" style="width:380px;">
									<option>전체</option>
									<option>온라인결제</option>
									<option>오프라인결제</option>
								</select></td>
						</tr>
						<tr>
							<th>그룹구분</th>
							<td><select name="" class="inp_txt" style="width:380px;">
									<option>전체</option>
									<option>개별</option>
									<option>그룹</option>
								</select></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_area" style="margin-top:0;"><a href="#" class="btn_input2">검색</a></div>
			</div>
			<div class="ad_result">
				<div class="ad_result_btn_area">
					<select>
						<option>20개</option>
						<option>50개</option>
						<option>100개</option>
					</select>
					<span  id="popup_open"><a href="#none">그룹묶기</a></span><a href="#">엑셀저장</a></div>
				<table cellpadding="0" cellspacing="0" class="tb04">
					<colgroup>
					<col width="30" />
					<col width="30" />
					<col width="100" />
					<col />
					<col width="80" />
					<col width="80" />
					<col/>
					<col width="130" />
					<col width="80" />
					<col width="130" />
					<col/>
					<col width="100" />
					</colgroup>
					<thead>
						<tr>
							<th><div class="tb_check">
									<input id="check_all" name="check_all" type="checkbox">
									<label for="check_all">선택</label>
								</div></th>
							<th>No. </th>
							<th>아이디</th>
							<th>회사명</th>
							<th>회원구분</th>
							<th>이름</th>
							<th>이메일</th>
							<th>연락처</th>
							<th>결제구분</th>
							<th>그룹구분</th>
							<th>계약기간</th>
							<th>가입일자</th>
						</tr>
					</thead>
					<tbody>
						<tr onclick="location.href='admin2.html'">
							<td><div class="tb_check">
									<input id="check1" name="check1" type="checkbox">
									<label for="check1">선택</label>
								</div></td>
							<td>1</td>
							<td>crk0526</td>
							<td>(주)다하미</td>
							<td>법인</td>
							<td>김정현</td>
							<td>funcion@korea.kr</td>
							<td>010-0000-0000</td>
							<td>온라인결제</td>
							<td>개별</td>
							<td>&nbsp;</td>
							<td>2017-07-01</td>
						</tr>
						<tr onclick="location.href='admin2.html'">
							<td><div class="tb_check">
									<input id="check2" name="check2" type="checkbox">
									<label for="check2">선택</label>
								</div></td>
							<td>2</td>
							<td>maywood</td>
							<td>대한민국역사박물관</td>
							<td>법인</td>
							<td>최고운</td>
							<td>kdahyuns@gmail.com</td>
							<td>010-0000-0000</td>
							<td>온라인결제</td>
							<td>그룹(maywood)</td>
							<td>2017-01-01 ~ 2017-12-31</td>
							<td>2017-07-01</td>
						</tr>
					</tbody>
				</table>
				<div id="popup_wrap">
					<div class="pop_tit">
						<h2>그룹묶기</h2>
						<p>
							<button class="popup_close">닫기</button>
						</p>
					</div>
					<div class="pop_cont">
						<ul class="group_li">
							<li>
								<input type="radio" id="radio_chk1" name="group" />
								<label for="radio_chk1"> ottffssentottffssent(아이디스무자)</label>
							</li>
							<li>
								<input type="radio" id="radio_chk2" name="group" />
								<label for="radio_chk2"> ok0526(다하미)</label>
							</li>
							<li>
								<input type="radio" id="radio_chk3" name="group" />
								<label for="radio_chk3"> ok0526(다하미)</label>
							</li>
							<li>
								<input type="radio" id="radio_chk4" name="group" />
								<label for="radio_chk4"> ok0526(다하미)</label>
							</li>
							<li>
								<input type="radio" id="radio_chk5" name="group" />
								<label for="radio_chk5"> ok0526(다하미)</label>
							</li>
						</ul>
					</div>
					<div class="pop_foot">
						<p>선택한 ID를 그룹(<span class="color">ottffssentottffssent</span>)으로 묶겠습니까?</p>
						<div class="pop_btn">
							<button onclick="location.href='#'";>확인</button>
							<button class="popup_close">취소</button>
						</div>
					</div>
				</div>
				<div id="mask"></div>
				<div class="page">
					<ul>
						<li class="first"> <a href="#">첫 페이지</a> </li>
						<li class="prev"> <a href="#">이전 페이지</a> </li>
						<li> <a href="#">1</a> </li>
						<li class="active"> <a href="#">2</a> </li>
						<li> <a href="#">3</a> </li>
						<li> <a href="#">4</a> </li>
						<li> <a href="#">5</a> </li>
						<li> <a href="#">6</a> </li>
						<li> <a href="#">7</a> </li>
						<li> <a href="#">8</a> </li>
						<li> <a href="#">9</a> </li>
						<li> <a href="#">10</a> </li>
						<li class="next"> <a href="#"> 다음 페이지 </a> </li>
						<li class="last"> <a href="#"> 마지막 페이지 </a> </li>
					</ul>
				</div>
			</div>
		</div>
	</section>
</div>
</body>
</html>