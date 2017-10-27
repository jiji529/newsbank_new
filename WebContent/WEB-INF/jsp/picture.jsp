<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 9. 21. 오후 3:27:27
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 11.   hoyadev       picture
  2017. 10. 16.   hoyadev       searchList()
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script type="text/javascript">

	$(document).on("click", ".square", function() {
		$(".viewbox > .size > span.grid").removeClass("on");
		$(".viewbox > .size > span.square").addClass("on");
		$("#search_list1").css("display", "none");
		$("#search_list2").css("display", "block");
	});

	$(document).on("click", ".grid", function() {
		$(".viewbox > .size > span.square").removeClass("on");
		$(".viewbox > .size > span.grid").addClass("on");
		$("#search_list1").css("display", "block");
		$("#search_list2").css("display", "none");
	});

	$(document).on("click", ".filter_list li", function() {
		var choice = $(this).text();
		$(this).attr("selected", "selected");
		$(this).siblings().removeAttr("selected");
		var filter_list = "<ul class=\"filter_list\">" + $(this).parents(".filter_list").html() + "</ul>";
		$(this).parents(".filter_title").children().remove().end().html(choice + filter_list);

		searchList();
	});

	function searchList() {
		$("#search_list1 ul").empty();
		$("#search_list2 ul").empty();

		var count = $("select[name=limit]").val();
		var contentType = $(".filter_title:nth-of-type(2) .filter_list").find("[selected=selected]").val();
		var media = $(".filter_title:nth-of-type(3) .filter_list").find("[selected=selected]").val();
		var duration = $(".filter_title:nth-of-type(4) .filter_list").find("[selected=selected]").val();
		var colorMode = $(".filter_title:nth-of-type(5) .filter_list").find("[selected=selected]").val();
		var horiVertChoice = $(".filter_title:nth-of-type(6) .filter_list").find("[selected=selected]").val();
		var size = $(".filter_title:nth-of-type(7) .filter_list").find("[selected=selected]").val();
		var portRight = $(".filter_title:nth-of-type(8) .filter_list").find("[selected=selected]").val();
		var includePerson = $(".filter_title:nth-of-type(9) .filter_list").find("[selected=selected]").val();
		var group = $(".filter_title:nth-of-type(10) .filter_list").find("[selected=selected]").val();

		var parameter = "count=" + count;
		parameter += "&contentType=" + contentType + "&media=" + media;
		parameter += "&duration=" + duration + "&colorMode=" + colorMode;
		parameter += "&horiVertChoice=" + horiVertChoice + "&size=" + size;
		parameter += "&portRight=" + portRight + "&includePerson=" + includePerson;
		parameter += "&group=" + group;

		var html = "";
		$.ajax({
			url : "/searchJson?" + parameter,
			type : "GET",
			dataType : "json",
			success : function(data) {
				console.log(data);
				$(data.result).each(function(key, val) {
					html += "<li class=\"thumb\"><a href=\"/view.picture?uciCode=" + val.uciCode + "\"><img src=\"images/serviceImages" + val.listPath + "\"></a>";
					html += "<div class=\"info\">";
					html += "<div class=\"photo_info\">" + val.copyright + "</div>";
					html += "<div class=\"right\">";
					html += "<a class=\"over_wish\" href=\"#\">찜</a> <a class=\"over_down\" href=\"images/serviceImages"+val.originPath+"\" download>시안 다운로드</a> </div>";
					html += "</div>";
					html += "</li>";
				});

				$(html).appendTo("#search_list1 ul");
				$(html).appendTo("#search_list2 ul");
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}
</script>
</head>
<body class="fixed">
	<div class="wrap">
		<div class="fixed_layer">
			<nav class="gnb_dark">
			<div class="gnb">
				<a href="/home" class="logo"></a>
				<ul class="gnb_left">
					<li class="on">
						<a href="#">보도사진</a>
					</li>
					<li>
						<a href="#">뮤지엄</a>
					</li>
					<li>
						<a href="#">사진</a>
					</li>
					<li>
						<a href="#">컬렉션</a>
					</li>
				</ul>
				<ul class="gnb_right">
					<li>
						<a href="/login">로그인</a>
					</li>
					<li>
						<a href="/kind.join" target="_blank">가입하기</a>
					</li>
				</ul>
			</div>
			<div class="gnb_srch">
				<form id="searchform">
					<input type="text" value="검색어를 입력하세요" />
					<a href="#" class="btn_search">검색</a>
				</form>
			</div>
			</nav>
			<!-- 필터시작 -->
			<div class="filters">
				<ul>
					<li class="filter_title filter_ico">검색필터</li>
					<li class="filter_title">
						보도사진
						<ul class="filter_list">
							<li value="<%=request.getAttribute("CONTENT_TYPE_NEWS")%>">보도사진</li>
							<li value="<%=request.getAttribute("CONTENT_TYPE_MUSEUM")%>">뮤지엄</li>
							<li value="<%=request.getAttribute("CONTENT_TYPE_PERSONAL")%>">사진</li>
							<li value="<%=request.getAttribute("CONTENT_TYPE_COLLECTION")%>">컬렉션</li>
						</ul>
					</li>
					<li class="filter_title">
						전체매체
						<ul class="filter_list">
							<li>전체</li>
							<li>노컷뉴스</li>
							<li>뉴데일리</li>
							<li>뉴시스</li>
							<li>동아일보</li>
							<li>마이데일리</li>
							<li>문화일보</li>
							<li>세계일보</li>
							<li>스포츠동아</li>
							<li>스포츠조선</li>
							<li>영상미디어</li>
							<li>아시아경제</li>
							<li>이데일리</li>
							<li>전자신문</li>
							<li>조선일보</li>
							<li>텐아시아</li>
							<li>평화신문</li>
						</ul>
					</li>
					<li class="filter_title">
						검색기간
						<ul class="filter_list">
							<li>전체</li>
							<li>1일</li>
							<li>1주</li>
							<li>1달</li>
							<li>1년</li>
							<li class="choice">
								직접 입력
								<div class="calendar">
									<div class="cal_input">
										<input type="text" title="검색기간 시작일" />
										<a href="#" class="ico_cal">달력</a>
									</div>
									<div class="cal_input">
										<input type="text" title="검색기간 시작일" />
										<a href="#" class="ico_cal">달력</a>
									</div>
									<button class="btn_cal" type="button">적용</button>
								</div>
							</li>
						</ul>
					</li>
					<li class="filter_title">
						색상
						<ul class="filter_list">
							<li value="<%=request.getAttribute("COLOR_ALL")%>">전체</li>
							<li value="<%=request.getAttribute("COLOR_YES")%>">컬러</li>
							<li value="<%=request.getAttribute("COLOR_NO")%>">흑백</li>
						</ul>
					</li>
					<li class="filter_title">
						형태
						<ul class="filter_list">
							<li value="<%=request.getAttribute("HORIZONTAL_ALL")%>">전체</li>
							<li value="<%=request.getAttribute("HORIZONTAL_YES")%>">가로</li>
							<li value="<%=request.getAttribute("HORIZONTAL_NO")%>">세로</li>
						</ul>
					</li>
					<li class="filter_title">
						사이즈
						<ul class="filter_list">
							<li value="<%=request.getAttribute("SIZE_ALL")%>">모든크기</li>
							<li value="<%=request.getAttribute("SIZE_LARGE")%>">큰 사이즈</li>
							<li value="<%=request.getAttribute("SIZE_MEDIUM")%>">중간 사이즈</li>
							<li value="<%=request.getAttribute("SIZE_SMALL")%>">작은 사이즈</li>
						</ul>
					</li>
					<li class="filter_title">
						라이선스
						<ul class="filter_list">
							<li value="<%=request.getAttribute("PORTRAIT_RIGHT_ALL")%>">전체</li>
							<li value="<%=request.getAttribute("PORTRAIT_RIGHT_ACQUIRE")%>">초상권 해결</li>
							<li value="<%=request.getAttribute("PORTRAIT_RIGHT_NOT")%>">초상권 미해결</li>
						</ul>
					</li>
					<li class="filter_title">
						인물
						<ul class="filter_list">
							<li value="<%=request.getAttribute("INCLUDE_PERSON_ALL")%>">전체</li>
							<li value="<%=request.getAttribute("INCLUDE_PERSON_YES")%>">포함</li>
							<li value="<%=request.getAttribute("INCLUDE_PERSON_NO")%>">미포함</li>
						</ul>
					</li>
					<li class="filter_title">
						대표이미지
						<ul class="filter_list">
							<li value="<%=request.getAttribute("GROUP_IMAGE_ALL")%>">전체</li>
							<li value="<%=request.getAttribute("GROUP_IMAGE_REP")%>">대표만 보기</li>
						</ul>
					</li>
				</ul>
				<div class="filter_rt">
					<div class="result">
						<b class="count">123</b>
						개의 결과
					</div>
					<div class="paging">
						<a href="#" class="prev" title="이전페이지"></a>
						<input type="text" class="page" value="1" />
						<span>/</span>
						<span class="total">1234</span>
						<a href="#" class="next" title="다음페이지"></a>
					</div>
					<div class="viewbox">
						<div class="size">
							<span class="grid on">가로맞춤보기</span>
							<span class="square">사각형보기</span>
						</div>
						<select name="limit" onchange="searchList()">
							<option value="40" selected="selected">40</option>
							<option value="80">80</option>
							<option value="120">120</option>
						</select>
					</div>
				</div>
			</div>
			<!-- 필터끝 -->
		</div>
		<section id="search_list1">
		<ul>
			<c:forEach items="${picture}" var="PhotoDTO">
				<li class="thumb">
					<a href="/view.picture?uciCode=${PhotoDTO.uciCode}">
						<img src="images/serviceImages${PhotoDTO.getListPath()}">
					</a>
					<div class="info">
						<div class="photo_info">${PhotoDTO.copyright}</div>
						<div class="right">
							<a class="over_wish" href="#">찜</a>
							<a class="over_down" href="images/serviceImages${PhotoDTO.getOriginPath()}" download>시안 다운로드</a>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
		</section>
		<section id="search_list2" style="display: none;">
		<ul>
			<c:forEach items="${picture}" var="PhotoDTO">
				<li class="thumb">
					<a href="/view.picture?uciCode=${PhotoDTO.uciCode}">
						<img src="images/serviceImages${PhotoDTO.getListPath()}">
					</a>
					<div class="info">
						<div class="photo_info">${PhotoDTO.copyright}</div>
						<div class="right">
							<a class="over_wish" href="#">찜</a>
							<a class="over_down" href="images/serviceImages${PhotoDTO.getOriginPath()}" download>시안 다운로드</a>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
		</section>
		<div class="more">
			<a href="#">다음 페이지</a>
		</div>
		<footer>
		<div class="foot_wrap">
			<div class="foot_lt">
				(주)다하미커뮤니케이션즈 | 대표 박용립
				<br />
				서울시 중구 마른내로 140 5층 (쌍림동, 인쇄정보센터)
				<br />
				고객센터 02-593-4174 | 사업자등록번호 112-81-49789
				<br />
				저작권대리중개신고번호 제532호
				<br />
				통신판매업신고번호 제2016-서울중구-0501호 (사업자정보확인)
			</div>
			<div class="foot_ct">
				<dl>
					<dt>회사소개</dt>
					<dd>뉴스뱅크 소개</dd>
					<dd>UCI 소개</dd>
					<dd>공지사항</dd>
					<dd>이용약관</dd>
					<dd>개인정보처리방침</dd>
				</dl>
				<dl>
					<dt>구매안내</dt>
					<dd>저작권 안내</dd>
					<dd>FAQ</dd>
					<dd>도움말</dd>
					<dd>직접 문의하기</dd>
				</dl>
				<dl>
					<dt>사이트맵</dt>
				</dl>
			</div>
			<div class="foot_rt">
				<div id="family_site">
					<div id="select-title">주요 서비스 바로가기</div>
					<div id="select-layer" style="display: none;">
						<ul class="site-list">
							<li>
								<a href="http://scrapmaster.co.kr/" target="_blank">스크랩마스터</a>
							</li>
							<li>
								<a href="http://clippingon.co.kr/" target="_blank">클리핑온</a>
							</li>
							<li>
								<a href="http://www.t-paper.co.kr/" target="_blank">티페이퍼</a>
							</li>
							<li>
								<a href="http://forme.or.kr/" target="_blank">e-NIE</a>
							</li>
							<li>
								<a href="http://www.newsbank.co.kr/" target="_blank">뉴스뱅크</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="foot_banner">
					<ul>
						<li class="uci">
							<a>
								국가표준 디지털콘텐츠
								<br />
								식별체계 등록기관 지정
							</a>
						</li>
						<li class="cleansite">
							<a>
								클린사이트
								<br />
								한국저작권보호원
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
		</footer>
	</div>
</body>
</html>