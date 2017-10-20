<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 10. 17. 오전 10:48:12
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 17.   hoyadev        view.cms
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script type="text/javascript">
	$(document).ready(function(key, val){
		var saleState = ${photoDTO.saleState};
		var portraitRightState = ${photoDTO.portraitRightState};
		console.log("saleState : "+saleState + " / portraitRightState : "+portraitRightState);
	});
	
	$(document).on("click", ".tag_remove", function() {
		$(this).parent().remove();
	});
	
	$(document).on("click", ".add_tag > button", function() {
		var tagName = $(this).prev().val();		
		var html = "<li class=\"tag_auto\"><span class=\"tag_remove\">×</span>"+tagName+"</li>";
		$(html).appendTo(".tag_list");
		$(this).prev().val("");
	});
	
	$(document).on("click", ".btn_edit", function() {
		var title = $(".img_tit").last().text();
		var content = $(".img_cont").text();		
		
		if($(".btn_edit").hasClass("complete")) {
			console.log("수정완료 버튼 ");	
		}else {
			console.log("수정 버튼 ");
			$(".btn_edit").text("수정 완료");		
			$(".btn_edit").addClass("complete");
			$(".img_tit").last().replaceWith("<textarea class=\"img_tit\" style=\"width:100%; font-size:14px; line-height:22px; color:#666;\">"+title+"</textarea>");
			$(".img_cont").replaceWith("<textarea class=\"img_cont\" style=\"height:300px; width:100%; font-size:14px; line-height:22px; color:#666;\">"+content+"</textarea>");	
		}
		
		
	});
	
	$(document).on("click", ".complete", function() {
		console.log("complete click");
		// DB에 기사 제목, 내용을 수정 기능 필요
		var titleKor = $(".img_tit").last().text();
		var descriptionKor = $(".img_cont").text();
		var uciCode = "${photoDTO.uciCode}";
		console.log("제목 : "+titleKor + " / 내용 : "+descriptionKor);
		
		$(".btn_edit").text("수정");		
		$(".btn_edit").removeClass("complete");
		$(".img_tit").last().replaceWith("<h3 class=\"img_tit\">"+titleKor+"</h3>");
		$(".img_cont").replaceWith("<p class=\"img_cont\">"+descriptionKor+"</p>");
		
		$.ajax({
			type: "POST",
			url: "/view.cms",
			data: {
				"uciCode" : uciCode,
				"titleKor" : titleKor,
				"descriptionKor" : descriptionKor
			},
			success: function(data){
				
			}, error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
			
		});
	});
	
	$(document).on("click", ".in_prev", function() {
	    var slide_width = $(".cfix").width();
	    var li_width = $(".cfix li:nth-child(1)").width();
	    var view_count = slide_width / li_width;
	    var slide_count = $(".cfix li").size();
	    
	    $(".cfix").animate({
	    	left: + li_width 
	    }, 200, function() {
	    	$(".cfix li:last-child").prependTo(".cfix");
	    	$(".cfix").css("left", "");
	    });
	});
	
	$(document).on("click", ".in_next", function() {
		var slide_width = $(".cfix").width();
	    var li_width = $(".cfix li:nth-child(1)").width();
	    var view_count = slide_width / li_width;
	    var slide_count = $(".cfix li").size();	    
	    
	    $('.cfix').animate({
            left: - li_width
        }, 200, function () {
            $('.cfix li:first-child').appendTo('.cfix');
            $('.cfix').css('left', '');
        });
	});
</script>
</head>
<body> 
<div class="wrap">
	<nav class="gnb_dark">
		<div class="gnb"><a href="/home" class="logo"></a>
			<ul class="gnb_left">
				<li class=""><a href="/picture">보도사진</a></li>
				<li><a href="#">뮤지엄</a></li>
				<li><a href="#">사진</a></li>
				<li><a href="#">컬렉션</a></li>
			</ul>
			<ul class="gnb_right">
				<li><a href="#">로그인</a></li>
				<li><a href="#">가입하기</a></li>
			</ul>
		</div>
		<div class="gnb_srch">
			<form id="searchform">
				<input type="text" value="검색어를 입력하세요" />
				<a href="#" class="btn_search">검색</a>
			</form>
		</div>
	</nav>
	<section class="mypage">
		<div class="head">
			<h2>마이페이지</h2>
			<p>설명어쩌고저쩌고</p>
		</div>
		<div class="mypage_ul">
			<ul class="mp_tab1">
				<li><a href="#">정산 관리</a></li>
				<li class="on"><a href="/cms">사진 관리</a></li>
				<li><a href="#">회원정보 관리</a></li>
				<li><a href="#">찜관리</a></li>
				<li><a href="#">장바구니</a></li>
				<li><a href="#">구매내역</a></li>
			</ul>
		</div>
		<div class="table_head">
			<h3>사진 관리</h3>
			<div class="cms_search">이미지 검색
				<input type="text" />
				<button>검색</button>
			</div>
		</div>
		<section class="view">
			<div class="view_lt">
				<h2 class="media_logo"><img src="images/view/logo.gif" alt="뉴시스" /></h2>
				<div class="img_area"><img src="images/n2/${photoDTO.compCode}.jpg"/>
					<div class="cont_area">
						<h3 class="img_tit"><span class="uci">[${photoDTO.uciCode}]</span>ns696100264</h3>
						<h3 class="img_tit">${photoDTO.titleKor}</h3>
						<a class="btn_edit">수정</a>
						<p class="img_cont">
							${photoDTO.descriptionKor} <br />
						</p>
					</div>
					<div class="img_info_area area1">
						<h3 class="info_tit">사진 정보</h3>
						<dl>
							<dt>촬영일</dt>
							<dd>${photoDTO.shotDate}</dd>
							<dt>픽셀수</dt>
							<dd>${photoDTO.widthPx} X ${photoDTO.heightPx}(pixel)</dd>
							<dt>출력사이즈</dt>
							<dd>${photoDTO.widthCm} x ${photoDTO.heightCm} (cm)</dd>
							<dt>파일용량</dt>
							<dd>${photoDTO.fileSizeMB}MB</dd>
							<dt>파일포멧</dt>
							<dd>JPEG</dd>
							<dt>해상도</dt>
							<dd>${photoDTO.dpi}dpi</dd>
							<dt>저작권자</dt>
							<dd>${photoDTO.copyright}</dd>
						</dl>
					</div>
					<div class="img_info_area area2">
						<h3 class="info_tit">EXIF (Exchangeable Image File Format)</h3>
						<c:set var="split_exif" value="${fn:split(photoDTO.exif, '|')}" />
						
						<dl>
							<c:forEach items="${split_exif}" var="split_exif">
								<c:set var="name" value="${fn:substringBefore(split_exif, ':')}" />
								<c:set var="value" value="${fn:substringAfter(split_exif, ':')}" />
								<dt>${name}</dt>
								<dd>${value}</dd>
							</c:forEach>
						</dl>
					</div>
					<div class="img_info_area">
						<h3 class="info_tit">연관 사진</h3>
						<div class="conn">
							<ul class="cfix">
								<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a></li>
								<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a></li>
								<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a></li>
								<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a></li>
								<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151871_P.jpg" /></a></li>
								<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151871_P.jpg" /></a></li>
								<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151871_P.jpg" /></a></li>
								<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151871_P.jpg" /></a></li>
								<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151872_P.jpg" /></a></li>
								<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151872_P.jpg" /></a></li>
							</ul>
							<div class="btn_conn">
								<button class="in_prev">이전</button>
								<button class="in_next">다음</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="view_rt">
				<div class="cms_rt">
					<h3 class="info_tit">통계</h3>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="cms_table1">
						<tr>
							<th scope="col">구분</th>
							<th scope="col">전체 횟수</th>
						</tr>
						<tr>
							<th scope="row">찜</th>
							<td><b>250</b>회</td>
						</tr>
						<tr>
							<th scope="row">다운로드</th>
							<td><b>15</b>회</td>
						</tr>
						<tr>
							<th scope="row">상세보기</th>
							<td><b>${photoDTO.hitCount}</b>회</td>
						</tr>
						<tr>
							<th scope="row">결제</th>
							<td><b>15</b>회</td>
						</tr>
						<tr>
							<th scope="row">뮤지엄</th>
							<td><b>20</b>회</td>
						</tr>
						<tr>
							<th scope="row">컬렉션</th>
							<td><b>22</b>회</td>
						</tr>
					</table>
				</div>
				<div class="cms_rt">
					<h3 class="info_tit">옵션</h3>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="cms_table2">
						<tr>
							<th scope="row">게티 노출 / 타 서비스 노출</th>
							<td><label>
									<input type="radio" name="serv" />
									ON</label>
								<label>
									<input type="radio" name="serv"/>
									OFF</label></td>
						</tr>
						<tr>
							<th scope="row">블라인드</th>
							<td><label>
									<input type="radio" name="blind" />
									ON</label>
								<label>
									<input type="radio" name="blind"/>
									OFF</label></td>
						</tr>
						<tr>
							<th scope="row">초상권 해결</th>
							<td><label>
									<input type="radio" name="likeness" />
									ON</label>
								<label>
									<input type="radio" name="likeness"/>
									OFF</label></td>
						</tr>
					</table>
				</div>
				<div class="cms_rt">
					<h3 class="info_tit">태그 달기</h3>
					<div class="add_tag">
						<input type="text" />
						<button>추가</button>
					</div>
					<ul class="tag_list">
						<!-- <li class="tag_auto"><span class="tag_remove">×</span>장원준</li>
						<li class="tag_self"><span class="tag_remove">×</span>승리투수</li> -->
						
						<c:forEach items="${photoTagList}" var="tag">
							<li class="tag_self"><span class="tag_remove">×</span>${tag.tag_tagName}</li>
							
							<%-- <c:set value="${tag.tagType}" var="tagType"/>
							<li>${tagType }</li>
							<c:if test="${tagType == 0}" var="result">
								<li class="tag_auto"><span class="tag_remove">×</span>${tag.tag_tagName}</li>
							</c:if>
							
							<c:if test="${tagType == 1}" var="result">
								<li class="tag_self"><span class="tag_remove">×</span>${tag.tag_tagName}</li>
							</c:if> --%>
							
						</c:forEach>
					</ul>
				</div>
			</div>
		</section>
	</section>
</div>
</body>
</html>
