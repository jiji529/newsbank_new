<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 10. 16. 오후 16:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 16.   hoyadev        cms
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	$(document).on("click", ".filter_list li", function() {
		var choice = $(this).text();
		$(this).attr("selected", "selected");
		$(this).siblings().removeAttr("selected");
		var filter_list = "<ul class=\"filter_list\">"+$(this).parents(".filter_list").html()+"</ul>";
		$(this).parents(".filter_title").children().remove().end().html(choice+filter_list);
		searchList();
	});
	
	function searchList() {
		$("#cms_list2 ul").empty();
		
		var count = $("select[name=limit]").val();
		var contentType = $(".filter_title:nth-of-type(2) .filter_list").find("[selected=selected]").val(); 
		var media = $(".filter_title:nth-of-type(3) .filter_list").find("[selected=selected]").val();
		var duration = $(".filter_title:nth-of-type(4) .filter_list").find("[selected=selected]").val();
		var portRight = $(".filter_title:nth-of-type(5) .filter_list").find("[selected=selected]").val();
		var includePerson = $(".filter_title:nth-of-type(6) .filter_list").find("[selected=selected]").val();
		
		var parameter = "count=" + count;
		parameter += "&contentType="+contentType+"&media="+media;
		parameter += "&duration="+duration+"&portRight="+portRight;
		parameter += "&includePerson="+includePerson;
		
		var html = "";				
		$.ajax({
			url: "/searchJson?"+parameter,		
			type: "GET",
			dataType: "json",
			success: function(data) { console.log(data);
				$(data.result).each(function(key, val) {		
					html += "<li class=\"thumb\"> <a href=\"/view.cms?uciCode="+val.uciCode+"\"><img src=\"/list.down.photo?uciCode="+val.uciCode+"\" /></a>";
					html += "<div class=\"thumb_info\"><input type=\"checkbox\" /><span>"+val.uciCode+"</span><span>"+val.copyright+"</span></div>";
					html += "<ul class=\"thumb_btn\"> <li class=\"btn_down\">다운로드</li>	<li class=\"btn_del\">삭제</li> <li class=\"btn_view\">다운로드</li> <li class=\"btn_likeness\"></li> </ul>";
				});	
				
				$(html).appendTo("#cms_list2 ul");
			}, error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
		});
	}
</script>
</head>
<body> 
<div class="wrap">
	<nav class="gnb_dark">
		<div class="gnb"><a href="#" class="logo"></a>
			<ul class="gnb_left">
				<li class=""><a href="/picture">보도사진</a></li>
				<li><a href="#">뮤지엄</a></li>
				<li><a href="#">사진</a></li>
				<li><a href="#">컬렉션</a></li>
			</ul>
			<ul class="gnb_right">
				<li><a href="/login">로그인</a></li>
				<li><a href="/kind.join" target="_blank">가입하기</a></li>
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
				<li class="on"><a href="#">사진 관리</a></li>
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
		<!-- 필터시작 -->
		<div class="filters">
			<ul>
				<li class="filter_title filter_ico">검색필터</li>
				<li class="filter_title"> 전체매체
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
				<li class="filter_title"> 검색기간
					<ul class="filter_list">
						<li>전체</li>
						<li>1일</li>
						<li>1주</li>
						<li>1달</li>
						<li>1년</li>
						<li class="choice">직접 입력
							<div class="calendar">
								<div class="cal_input">
									<input type="text" title="검색기간 시작일" />
									<a href="#" class="ico_cal">달력</a> </div>
								<div class="cal_input">
									<input type="text" title="검색기간 시작일" />
									<a href="#" class="ico_cal">달력</a> </div>
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
				<li class="filter_title"> 사진크기
					<ul class="filter_list">
						<li value="<%=request.getAttribute("SIZE_ALL")%>">모든크기</li>
						<li value="<%=request.getAttribute("SIZE_LARGE")%>">3,000 px 이상</li>
						<li value="<%=request.getAttribute("SIZE_MEDIUM")%>">1,000~3,000 px</li>
						<li value="<%=request.getAttribute("SIZE_SMALL")%>">1,000 px 이하</li>
					</ul>
				</li>
			</ul>
			<div class="filter_rt">
				<div class="result"><b class="count">123</b>개의 결과</div>
				<div class="paging"><a href="#" class="prev" title="이전페이지"></a>
					<input type="text" class="page" value="1" />
					<span>/</span><span class="total">1234</span><a href="#" class="next" title="다음페이지"></a></div>
				<div class="viewbox">
					<div class="size"><span class="grid">가로맞춤보기</span><span class="square on">사각형보기</span></div>
					<select name="limit" onchange="searchList()">
						<option value="40" selected="selected">40</option>
						<option value="80">80</option>
						<option value="120">120</option>
					</select>
				</div>
			</div>
		</div>
		<!-- 필터끝 -->
		<div class="btn_sort"><span class="task_check">
			<input type="checkbox" />
			</span>
			<ul class="button">
				<li class="sort_down">다운로드</li>
				<li class="sort_del">삭제</li>
				<li class="sort_menu">블라인드</li>
				<li class="sort_menu">초상권 해결</li>
				<li class="sort_menu">관련사진 묶기</li>
				<li class="sort_up">수동 업로드</li>
			</ul>
		</div>
		<section id="cms_list2">
			<ul>
				<c:forEach items="${picture}" var="PhotoDTO">
					<li class="thumb"> <a href="/view.cms?uciCode=${PhotoDTO.uciCode}"><img src="/list.down.photo?uciCode=${PhotoDTO.uciCode}"/></a>
					<div class="thumb_info">
						<input type="checkbox" />
						<span>${PhotoDTO.uciCode}</span><span>${PhotoDTO.copyright}</span></div>
					<ul class="thumb_btn">
						<li class="btn_down">다운로드</li>
						<li class="btn_del">삭제</li>
						<li class="btn_view">다운로드</li>
						<li class="btn_likeness"></li>
					</ul>
				</li>
				</c:forEach>
			</ul>
		</section>
	<div class="more"><a href="#">다음 페이지</a></div>
	</section>
</div>
</body>
</html>
