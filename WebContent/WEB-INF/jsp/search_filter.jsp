<%---------------------------------------------------------------------------
  Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2018. 4. 6. 오후 3:41:22
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2018. 4. 6.     
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String headerSplitChar = "<br>";
	try {
		if((boolean)request.getAttribute("serviceMode")) {
			headerSplitChar = " : ";
		}
	}catch(Exception e){}
%>

<script>
$(document).ready(function() {
	setDatepicker();
});

function setDatepicker() {
	$( ".datepicker" ).datepicker({
     changeMonth: true, 
     changeYear: true,
     dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
     dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
     monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
     monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
     showButtonPanel: true, 
     currentText: '오늘로 이동', 
     closeText: '닫기', 
     dateFormat: "yymmdd"
  });
}

$(document).on("click", ".ico_cal", function() { // 달력 아이콘 클릭에 따른 datepicker 활성화
	$(this).parent().find("input").focus();
});

$(document).on("click", ".filter_list li", function() { // 검색 옵션 선택
	var choice = $(this).text();
	$(this).siblings().removeAttr("selected");
	$(this).attr("selected", "selected");
	
	if(!$(this).hasClass("choice")){ // 직접 선택을 제외한 나머지는 slide up 이벤트 적용
		var filter_list = "<ul class=\"filter_list\">" + $(this).parents(".filter_list").html() + "</ul>";
		var titleTag = $(this).parents(".filter_title").find("span"); 
		var titleStr = titleTag.html();
		titleStr = titleStr.substring(0, titleStr.indexOf("<%=headerSplitChar%>")) + "<%=headerSplitChar%> " + choice;
		titleTag.html(titleStr);
		
		$(this).closest(".filter_list").stop().slideUp("fast");		
		// 필터 바꾸면 페이지 번호 초기화
		$("input[name=pageNo]").val("1");
		search();
	}
});

$(document).on("click", ".btn_cal", function() {
	// 기간 : 직접선택
	var startDate = $(this).parent().find("input[name=startDate]").val();
	var endDate = $(this).parent().find("input[name=endDate]").val();
	
	if(startDate != "" && endDate != "") {
		var choice = startDate + "~" + endDate;
		
		var titleTag = $(this).parents(".filter_title").find("span");
		var titleStr = titleTag.html();
		titleStr = titleStr.substring(0, titleStr.indexOf("<%=headerSplitChar%>")) + "<%=headerSplitChar%> " + choice;
		titleTag.html(titleStr);
		
		var choiceTag = $(this).parents(".choice");
		$(this).parents(".filter_title").find("li").each(function() {
			if(this == choiceTag[0]) {
				$(this).attr("selected", "selected");
			}
			else {
				$(this).removeAttr("selected");
			}
		});
		choiceTag.attr("value", "C" + choice);
		console.log(choice);
		
		$(this).closest(".filter_list").stop().slideUp("fast");
		// 필터 바꾸면 페이지 번호 초기화
		$("input[name=pageNo]").val("1");
		search();	
		
	} else {
		alert("시작날짜, 마지막날짜를 정확히 기입해주세요.");
	}
	
});
</script>
<%--사용자 검색 화면 확인을 위한 폼값 / 상단 검색어 연동(search / searchTop) --%>
<c:if test="${serviceMode eq true}">
	<input type="hidden" id="serviceMode" />
	<div class="filters">
</c:if>
<c:if test="${serviceMode ne true}">
	<div class="filters sml">
</c:if>
		<ul>
			<li class="filter_title filter_ico">검색필터</li>
			<li class="filter_title filter_media">
				<span>
					<font>매체</font><%=headerSplitChar%>
					
					<c:choose>
						<c:when test="${seq ne null && !empty seq}">
							${compName}
						</c:when>
						<c:otherwise>
							전체
						</c:otherwise>
					</c:choose>
				</span>
				
				<ul class="filter_list">
					<c:choose>
						<c:when test="${seq ne null && !empty seq}">
							<li value="0">전체</li>
							<c:forEach items="${mediaList}" var="media">
								<c:if test="${seq eq media.seq}">
									<li value="${media.seq }" selected="selected">${media.compName }</li>
								</c:if>
								<c:if test="${seq ne media.seq}">
									<li value="${media.seq }">${media.compName }</li>
								</c:if>
							</c:forEach>
						</c:when>
						
						<c:otherwise>
							<li value="0" selected="selected">전체</li>
							<c:forEach items="${mediaList}" var="media">
								<li value="${media.seq }">${media.compName }</li>								
							</c:forEach>
						</c:otherwise>
					</c:choose>
					
					<%-- <li value="0" selected="selected">전체</li>
					<c:forEach items="${mediaList}" var="media">
						<li value="${media.seq }">${media.name }</li>								
					</c:forEach> --%>
				</ul>
			</li>
			<li class="filter_title filter_durationReg">
				<span><font>업로드일</font><%=headerSplitChar%>전체</span>
				<ul class="filter_list">
					<li value="1" selected="selected">전체</li>
					<li value="1d">1일</li>
					<li value="1w">1주</li>
					<li value="1m">1달</li>
					<li value="1y">1년</li>
					<li class="choice">직접 입력
						<div class="calendar">
							<div class="cal_input">
								<input type="text" class="datepicker" name="startDate" title="업로드 시작일" />
								<a href="javascript:void(0)" class="ico_cal">달력</a> </div>
							<div class="cal_input">
								<input type="text" class="datepicker" name="endDate" title="업로드 마지막일" />
								<a href="javascript:void(0)" class="ico_cal">달력</a> </div>
							<button class="btn_cal" type="button">적용</button>
						</div>
					</li>
				</ul>
			</li>
			<li class="filter_title filter_durationTake">
				<span><font>촬영일(이미지생성일)</font><%=headerSplitChar%>전체</span>
				<ul class="filter_list">
					<li value="1" selected="selected">전체</li>
					<li value="1d">1일</li>
					<li value="1w">1주</li>
					<li value="1m">1달</li>
					<li value="1y">1년</li>
					<li class="choice">직접 입력
						<div class="calendar">
							<div class="cal_input">
								<input type="text" class="datepicker" name="startDate" title="촬영 시작일" />
								<a href="javascript:void(0)" class="ico_cal">달력</a> </div>
							<div class="cal_input">
								<input type="text" class="datepicker" name="endDate" title="촬영 마지막일" />
								<a href="javascript:void(0)" class="ico_cal">달력</a> </div>
							<button class="btn_cal" type="button">적용</button>
						</div>
					</li>
				</ul>
			</li>
			<%-- 1차 제외
			<li class="filter_title filter_color">
				색상
				<ul class="filter_list">
					<li value="<%=SearchParameterBean.COLOR_ALL%>" selected="selected">전체</li>
					<li value="<%=SearchParameterBean.COLOR_YES%>">컬러</li>
					<li value="<%=SearchParameterBean.COLOR_NO%>">흑백</li>
				</ul>
			</li> --%>
			<li class="filter_title filter_horizontal">
				<span><font>가로/세로</font><%=headerSplitChar%>전체</span>
				<ul class="filter_list">
					<li value="<%=SearchParameterBean.HORIZONTAL_ALL%>" selected="selected">전체</li>
					<li value="<%=SearchParameterBean.HORIZONTAL_YES%>">가로</li>
					<li value="<%=SearchParameterBean.HORIZONTAL_NO%>">세로</li>
				</ul>
			</li>
			<li class="filter_title filter_size">
				<span><font>사진크기</font><%=headerSplitChar%>전체</span>
				<ul class="filter_list">
					<li value="<%=SearchParameterBean.SIZE_ALL%>" selected="selected">전체</li>
					<li value="<%=SearchParameterBean.SIZE_LARGE%>">3,000 px 이상</li>
					<li value="<%=SearchParameterBean.SIZE_MEDIUM%>">1,000~3,000 px</li>
					<li value="<%=SearchParameterBean.SIZE_SMALL%>">1,000 px 이하</li>
				</ul>
			</li>
<c:if test="${serviceMode eq null || serviceMode ne true}">
			<li class="filter_title filter_saleState">
				<span><font>서비스 상태</font><%=headerSplitChar%>정상+숨김</span>
				<ul class="filter_list">
					<li value="<%=SearchParameterBean.SALE_STATE_OK_BLIND%>" selected="selected">정상+숨김</li>
					<li value="<%=SearchParameterBean.SALE_STATE_OK%>">정상</li>
					<li value="<%=SearchParameterBean.SALE_STATE_BLIND%>">숨김</li>
					<li value="<%=SearchParameterBean.SALE_STATE_DEL%>">삭제</li>
					<li value="<%=SearchParameterBean.SALE_STATE_BLIND_DEL%>">숨김 + 삭제</li>
					<li value="<%=SearchParameterBean.SALE_STATE_ALL%>">전체</li>
				</ul>
			</li>
</c:if>
		</ul>
		<div class="filter_rt">
			<div class="result"><b class="count">0</b>개의 결과</div>
			<div class="paging">
				<a href="javascript:void(0)" class="prev" title="이전페이지"></a>
				<input type="text" name="pageNo" class="page" value="1" onkeydown="return checkNumber(event);" onblur="searchPage()"/>
				<span>/</span>
				<span class="total">0</span>
				<a href="javascript:void(0)" class="next" title="다음페이지"></a>
			</div>
			<div class="viewbox">
				<div class="size">
<c:if test="${serviceMode eq true}">
					<span class="grid on">가로맞춤보기</span>
					<span class="square">사각형보기</span>
</c:if>
				</div>
				<select name="pageVol" onchange="goPage(1)">
					<option value="40" selected="selected">40</option>
					<option value="80">80</option>
					<option value="120">120</option>
				</select>
			</div>
		</div>
	</div>