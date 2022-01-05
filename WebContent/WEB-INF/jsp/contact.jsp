<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 11. 13.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 13.   	  tealight        file_name
  2017. 12. 19.   	  hoydev        질문하기 등록
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="common/head_meta.jsp"/>
<title>뉴스뱅크-직접문의하기</title>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/footer.js"></script>
<script type="text/javascript">

	$(document).on("keyup", ".num", function() { // 숫자만 입력
		this.value = this.value.replace(/[^0-9]/g,'');
	});
	
	// 이메일 보내기
	$(document).on("click", ".call_send", function() {
		var name = "";
		var phone = "";
		var email = "";
		var title = "";
		var contents = "";
		var tempPhone = "";
		var tempEmail = "";
		var chkflag = false;
		
		name = $('#commuName').val();
		phone = $('#firNum').val()+"-"+$('#midNum').val()+"-"+$('#lastNum').val();
		email = $('#firEmail').val()+"@"+$('#lastEmail').val();
		title = $('#commuTitle').val();
		contents = $('#commuContents').val();
		
		tempPhone = $('#firNum').val()+$('#midNum').val()+$('#lastNum').val();
		tempEmail = $('#firEmail').val()+$('#lastEmail').val();
		chkflag = $('#chk').prop('checked');
		
		if(chkflag  == false){
			alert("개인정보 수집에 동의 하여 주십시오");
			$('#chk').focus();
		}else if(name == ""){
			alert("성명을 기입하여 주십시오");
			$('#commuName').focus();
			return false;
		}else if(tempPhone == ""){
			alert("연락처를 기입하여 주십시오");
			$('#firNum').focus();
			return false;
		}else if(tempEmail == ""){
			alert("이메일을 기입하여 주십시오");
			$('#firEmail').focus();
			return false;
		}else if(title == ""){
			alert("제목을 기입하여 주십시오");
			$('#commuTitle').focus();
			return false;
		}else if(contents == ""){
			alert("내용을 기입하여 주십시오");
			$('#commuContents').focus();
			return false;
		}else{
			
			$.ajax({
				url : "/SendEmail",
				cache : false,
			    dataType: 'json',
			    contentType: 'application/json; charset=utf-8',
				data: {
					name: name,
					phone: phone,
					email: email,
					title: title,
					contents: contents
		        },
				success: response_jsonlst
			});
		}
	});
	
	// success성공시 성공 여부 확인 창
	function response_jsonlst(data){
		var success = data.success;
		
		if(success) {
			alert("관리자에게 문의사항이 전달 되었습니다.");
			
			$('#commuName').val("");
			$('#firNum').val("");
			$('#midNum').val("");
			$('#lastNum').val("");
			$('#firEmail').val("")
			$('#lastEmail').val("");
			$('#commuTitle').val("");
			$('#commuContents').val("");
			
			tempPhone = $('#firNum').val()+$('#midNum').val()+$('#lastNum').val();
			tempEmail = $('#firEmail').val()+$('#lastEmail').val();
		} else {
			alert("전송과정에서 오류가 발생했습니다.\n 관리자에게 문의바랍니다.");
		}
		
	}
	
</script>
</head>
<body>
<div class="wrap">
	<%@include file="header.jsp" %>
	<section class="mypage">
		<div class="head">
			<h2>이용안내</h2>
			<p>뉴스뱅크 사이트에 관하여 알려드립니다.</p>
		</div>
		<div class="mypage_ul">
			<ul class="mp_tab1 use">
				<li><a href="/price.info">구매안내</a></li>
				<li><a href="/board">공지사항</a></li>
				<li><a href="/FAQ">FAQ</a></li>
				<li class="on"><a href="/contact">직접 문의하기</a></li>
				<!-- <li><a href="sitemap.html">사이트맵</a></li> -->
			</ul>
		</div>
		<div class="table_head">
			<h3>직접 문의하기</h3>
		</div>
		<div class="call">
		<!-- 여기 내용들은 바뀔거에요 지금 다하미홈페이지에서 끌어온내용이라 내용 바뀝니다 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<th scope="col">문의사항</th>
						<th scope="col">연락처</th>
						<th scope="col">메일</th>
					</tr>
					<tr>
						<td>고객문의</td>
						<td>02-593-4174 (224)</td>
						<td>newsbank@dahami.com</td>
					</tr>
					<tr>
						<td>매체 제휴</td>
						<td>02-593-4174 (218)</td>
						<td>seoski@dahami.com</td>
					</tr>
					<tr>
						<td>기술지원</td>
						<td>02-593-4174 (414)</td>
						<td>helpdesk@dahami.com</td>
					</tr>
				</tbody>
			</table>
			<div class="call_box">
				<h3>개인정보 수집 및 이용동의</h3>
				<div class="agree_box"> <strong>[개인정보 수집 등에 대한 동의]</strong><br>
					<br>
					<strong>1. 개인정보 수집 항목 및 목적</strong><br>
					다하미커뮤니케이션즈는 뉴스뱅크 사이트 내 직접 문의하기를 통해 문의주신 내용에 대해 문의자와 원활히 의사소통 하기 위한 목적으로 아래와 같은 항목을 수집합니다.<br>
					: 성명, 연락처, 이메일 주소<br>
					<br>
					<strong>2. 개인정보의 보유 및 이용기간</strong><br>
					: 수집된 개인정보는 보유 및 이용 목적이 완료된 후 즉시 파기됩니다. 또한 ‘문의하기’를 통해 삭제 요청을 하는 경우 3일 이내 파기됩니다.<br>
					<br>
					※ 귀하는 이에 대한 동의를 거부할 수 있으며, 동의하지 않으실 경우 직접 문의하기를 통한 이메일 발송은 불가능함을 알려드립니다.<br>
					<br>
				</div>
				<div class="agree_check">
					<p>
						<input type="checkbox" id="chk">
						<label for="agree">개인정보 수집 및 이용에 동의합니다.</label>
					</p>
				</div>
				<h3>문의하기</h3>
				<dl>
					<dt>성명</dt>
					<dd>
						<input type="text" id="commuName" maxlength="10"/>
					</dd>
					<dt>연락처</dt>
					<dd>
						<input type="text" class="num" id="firNum" maxlength="3"/>
						<span>-</span>
						<input type="text" class="num" id="midNum" maxlength="4"/>
						<span>-</span>
						<input type="text" class="num" id="lastNum" maxlength="4"/>
					</dd>
					<dt>이메일</dt>
					<dd>
						<input type="text" class="mail" id="firEmail"/>
						<span>@</span>
						<input type="text" class="mail" id="lastEmail"/>
					</dd>
					<dt>제목</dt>
					<dd>
						<input type="text" style="width:950px" id="commuTitle"/>
					</dd>
					<dt class="main_cont">질문내용</dt>
					<dd class="main_cont">
						<textarea id="commuContents"></textarea>
					</dd>
				</dl>
				<div class="call_send"><a href="javascript:void(0)">등록</a></div>
			</div>
		</div>
	</section>
	<%@include file="footer.jsp"%>
</div>
</body>
</html>