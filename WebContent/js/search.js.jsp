<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>

<%
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>

	/** 검색에서 넘어온 파라메터로 화면 초기화 */
	function initSearchParam() {
		// 리스트와 상세화면의 키워드폼 이름이 다름
		var keywordSetF = false;
		if($("#cms_keyword").length > 0) {
			$("#cms_keyword").val(view_form.keyword.value);
			$("#cms_keyword_current").val(view_form.keyword.value);
			keywordSetF = true;
		}
		if($("#cms_keywordFV").length > 0) {
			$("#cms_keywordFV").val(view_form.keyword.value);
			keywordSetF = true;
		}
		if(!keywordSetF && $("#keyword").length > 0) {
			$("#keyword").val(view_form.keyword.value);
			$("#keyword_current").val(view_form.keyword.value);
		}
		
		// 필터가 존재할때만
		if($(".filters").length > 0) {
			// 페이징값
			if(view_form.pageNo.value > 1) {
				$(".page").val(view_form.pageNo.value);
			}
			
			// 페이지볼륨
			if(view_form.pageVol.value > 1) {
				var options = $("select[name=pageVol]").find("option");
				for(var i=0; i < options.length; i++) {
					if($(options[i]).attr("value") == view_form.pageVol.value) {
						$(options[i]).attr("selected", "selected");
					}
					else {
						$(options[i]).removeAttr("selected");
					}
				}
			}
			
			setFilter(view_form.media.value, $("li.filter_media"));
			setFilter(view_form.horiVertChoice.value, $("li.filter_horizontal"));
			setFilter(view_form.size.value, $("li.filter_size"));
			setFilter(view_form.saleState.value, $("li.filter_saleState"));
			setFilter(view_form.durationReg.value, $("li.filter_durationReg"));
			setFilter(view_form.durationTake.value, $("li.filter_durationTake"));
		}
	}

	function setFilter(value, filterForm) {
		var findF = false;
		filterForm.find("li").each(function(index) {
			if($(this).attr("value") == value) {
				findF = true;
			}
		});
	
		if(findF) {
			var itemName = "";
			filterForm.find("li").each(function(index) {
				if($(this).attr("value") == value) {
					$(this).attr("selected", "selected");
					itemName = $(this).text();
				}
				else {
					$(this).removeAttr("selected");
				}
			});
			var titleStr = filterForm.find("span").text();
			var header = titleStr.substring(0, titleStr.indexOf(":")+2);
			filterForm.find("span").text(header + itemName);
		}
		else {
			if(value.charAt(0) == 'C') {
				value = value.substring(1);
				filterForm.find("li").each(function(index) {
					if($(this).hasClass("choice")) {
						$(this).attr("selected", "selected");
						$(this).attr("value", "C"+value);
					}
					else {
						$(this).removeAttr("selected");
					}
				});
				var titleStr = filterForm.find("span").text();
				var header = titleStr.substring(0, titleStr.indexOf(":")+2);
				filterForm.find("span").text(header + value);
			}
			console.log(value);
		}
	}
/*
	//날짜 입력 오늘 날짜, 입력되도록 해둠 2017.04.06 이재우
	// 익스플로러에서 비정상 동작하여 사용안함 / 오늘로 이동으로 변경함
	$(document).on('click', ".datepicker" , function(){
		var elmnt = $(this);
		$("button.ui-datepicker-current").on('click', function(){
			$(elmnt).datepicker('setDate',new Date());
			$(".ui-datepicker-close").click();
		});
	});
*/
	
	function userBookmarkList() { // 사용자가 찜한 북마크 목록
		var param = "action=list";
		$.ajax({
			type: "POST",
			url: "bookmark.api?"+param,
			dataType: "json",
			success : function(data) { 
				$(data.result).each(function(key, val) {
					var uciCode = val.uciCode;
					$("#search_list ul .over_wish").each(function(idx, value) { // 가로맞춤 보기
						var list_uci = $("#search_list ul .over_wish").eq(idx).attr("value");
						
						if(list_uci == uciCode) {
							$("#search_list ul .over_wish").eq(idx).addClass("on");
						}
					});

				});
			}
		});
	}
	
	<%-- 상황에 따른 서비스 CMS용 검색 호출 --%>
	function search() {
		searchInternal($("#serviceMode").length == 0);
	}
	
	<%-- 통합(서비스/CMS) 검색 --%>
	function searchInternal(cmsMode) {
	
		$("#searchProgress").css("display", "block");
		
		var keyword = "";
		if(cmsMode) {
			keyword = $("#cms_keyword_current").val();
		}
		else {
			keyword = $("#keyword_current").val();
		}
		
		keyword = $.trim(keyword);
		var pageNo = $("input[name=pageNo]").val();
		var transPageNo = pageNo.match(/[0-9]/g).join("");
		if(pageNo != transPageNo) {
			pageNo = transPageNo;
			$("input[name=pageNo]").val(pageNo);
		}
		var pageVol = $("select[name=pageVol]").val();
		var contentType = $(".filter_contentType .filter_list").find("[selected=selected]").attr("value");
		var media = $(".filter_media .filter_list").find("[selected=selected]").attr("value");
		var durationReg = $(".filter_durationReg .filter_list").find("[selected=selected]").attr("value");
		console.log("xx"+durationReg);
		var durationTake = $(".filter_durationTake .filter_list").find("[selected=selected]").attr("value");
		var colorMode = $(".filter_color .filter_list").find("[selected=selected]").attr("value");
		var horiVertChoice = $(".filter_horizontal .filter_list").find("[selected=selected]").attr("value");
		var portRight = $(".filter_portRight .filter_list").find("[selected=selected]").attr("value");
		var includePerson = $(".filter_incPerson .filter_list").find("[selected=selected]").attr("value");
		var group = $(".filter_group .filter_list").find("[selected=selected]").attr("value");
		var saleState = $(".filter_saleState .filter_list").find("[selected=selected]").attr("value");
		var size = $(".filter_size .filter_list").find("[selected=selected]").attr("value");

		view_form.keyword.value = keyword;
		view_form.pageNo.value = pageNo;
		view_form.pageVol.value = pageVol;
		view_form.media.value = media;
		view_form.durationReg.value = durationReg;
		view_form.durationTake.value = durationTake;
		view_form.colorMode.value = colorMode;
		view_form.horiVertChoice.value = horiVertChoice;
		view_form.saleState.value = saleState;
		view_form.size.value = size;
		
		var searchParam = {
				"keyword":keyword
				, "pageNo":pageNo
				, "pageVol":pageVol
				, "contentType":contentType
				, "media":media
				, "durationReg":durationReg
				, "durationTake":durationTake
				, "colorMode":colorMode
				, "horiVertChoice":horiVertChoice
				, "portRight":portRight
				, "includePerson":includePerson
				, "group":group
				, "saleState":saleState
				, "size":size
		};
		searchKeyword = keyword; //검색결과 없는 페이지를 만들기 위한 검색어 셋팅
		<%-- 키워드 변경 후 반영 없이 필터 등의 변경으로 인해 재검색 하면 기존 검색어를 키워드로 사용  --%>
		if(cmsMode) {
			$("#cms_keyword").val(keyword);
		}
		else {
			$("#keyword").val(keyword);
		}
		
		var html = "";
		$.ajax({
			type: "POST",
			async: true,
			dataType: "json",
			data: searchParam,
			timeout: 1000000,
			url: searchTarget,
			success : function(data) { 
				var count = data.count; // 총 갯수
				var viewCnt = data.result.length; // 현재 페이지에 보여지는 목록 갯수
				
				if(cmsMode) {
					makeCmsList(data);
				}
				else {
					makeServiceList(data);
				}
				$("#searchProgress").css("display", "none");
				
				var pageVol = parseInt($("select[name='pageVol'] option:selected").val()); // 페이지당 표현단위
		
				if(count < pageVol || viewCnt < pageVol) { 
				// 총 갯수 혹은 현재 페이지 목록갯수가 표현단위보다 작을 때, [다음 페이지] 숨김
					$(".more").hide();
				}else{
					$(".more").show();
				}	
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				$("#searchProgress").css("display", "none");
			}
		});
	}
	var searchKeyword = '';
	<%--검색 결과 생성 / 서비스 --%>
	function makeServiceList(data) {
	 	var html = "";
	 	if(data.result.length > 0){
			$(data.result).each(function(key, val) {
				html += "<li class=\"thumb\"><a href=\"javascript:void(0)\" onclick=\"go_View('" + val.uciCode + "')\"><img src=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>\"></a>";
				html += "<div class=\"info\">";
				html += "<div class=\"photo_info\">" + val.ownerName + "</div>";
				html += "<div class=\"right\">";
				html += "<a class=\"over_wish\" href=\"javascript:void(0)\" value=\"" + val.uciCode + "\">찜</a> <a class=\"over_down\" href=\"javascript:void(0)\" value=\"" + val.uciCode + "\">시안 다운로드</a> </div>";
				html += "</div>";
				html += "</li>";
			});
		}else{
			html += "<div class='no_result'>";
			html += "<p>";
			if(searchKeyword.length > 0) {
				html += "<em>"+searchKeyword+"</em>에 대한";
			}
			else {
				html += "조건에 적합한";
			}
			html += " 검색 결과가 없습니다.";
			html += "</p>";
			html += "<ul>";
			html += "<li>검색어의 단어수를 줄이거나, 보다 일반적인 단어로 검색해 보세요.</li>";
			html += "<li>두 단어 이상의 키워드로 검색하신 경우, 정확하게 띄어쓰기를 한 후 검색해 보세요.</li>";
			html += "<li>키워드에 있는 특수문자를 뺀 후에 검색해 보세요.</li>";
			html += "</ul>";
			html += "</div>";
		}
		$("#search_list ul").html(html);
		$(window).scrollTop(0);
		
		var totalCount = data.count;
		if(totalCount > 1000) 
			totalCount = totalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 천단위 콤마; 
		
		var totalPage = data.totalPage;
		if(totalPage > 1000)	
			totalPage = data.totalPage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 천단위 콤마
		
		$("div .result b").text(totalCount);
		$("div .paging span.total").html(totalPage);
		
		if(loginInfo != ""){ // 로그인 시, 찜 목록을 불러오기
			userBookmarkList();
		}
	}
	
	<%--검색 결과 생성 / CMS --%>
	function makeCmsList(data) { 
		var html = "";
		
		if(data.result.length > 0){
			$(data.result).each(function(key, val) {
				var blind = (val.saleState == <%=PhotoDTO.SALE_STATE_STOP%>) ? "blind" : "";
				var deleted = (val.saleState == <%=PhotoDTO.SALE_STATE_DEL%>) ? "deleted" : "";
				var coverClass = "";
				if(val.saleState == <%=PhotoDTO.SALE_STATE_STOP%>) {
					coverClass = "img_blind";
				}
				else if(val.saleState == <%=PhotoDTO.SALE_STATE_DEL%>) {
					coverClass = "img_del";
				}
				html += "<li class=\"thumb " + coverClass + "\"> <a href=\"#\" onclick=\"go_View('" + val.uciCode + "')\"><img src=\"<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=" + val.uciCode + "&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>\" /></a>";
				html += "<div class=\"thumb_info\">";
				if(val.saleState != <%=PhotoDTO.SALE_STATE_DEL%>) {
					html += "<input type=\"checkbox\" value=\""+ val.uciCode +"\"/>";
				}
				html += "<span>" + val.uciCode + "</span><span>" + val.copyright + "</span></div>";
				html += "<ul class=\"thumb_btn\">";
				if(deleted.length == 0) {
					html += "<li class=\"btn_down\" value=\"" + val.uciCode + "\"><a>다운로드</a></li>"
					html += "<li class=\"btn_del " + deleted + "\" value=\"" + val.uciCode + "\"><a>삭제</a></li>";
					html += "<li class=\"btn_view " + blind + "\" value=\"" + val.uciCode + "\"><a>숨김</a></li>";
				}
				else {
					html += "<li class=\"btn_down hide\"></li>"
					html += "<li class=\"" + deleted + "\" value=\"" + val.uciCode + "\"></li>";
					html += "<li class=\"btn_view hide" + blind + "\" value=\"" + val.uciCode + "\"></li>";
				}
				html += " </ul>";
			});
		}else{
			html += "<div class='no_result'>";
			html += "<p>";
			html += "<em>"+searchKeyword+"</em>에 대한 검색 결과가 없습니다.";
			html += "</p>";
			html += "<ul>";
			html += "<li>검색어의 단어수를 줄이거나, 보다 일반적인 단어로 검색해 보세요.</li>";
			html += "<li>두 단어 이상의 키워드로 검색하신 경우, 정확하게 띄어쓰기를 한 후 검색해 보세요.</li>";
			html += "<li>키워드에 있는 특수문자를 뺀 후에 검색해 보세요.</li>";
			html += "</ul>";
			html += "</div>";
		}
		$("#cms_list2 ul").html(html);
		var totalCount = data.count;
		if(totalCount > 1000) 
			totalCount = totalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 천단위 콤마; 
		var totalPage = data.totalPage;
		if(totalPage > 1000)
			totalPage = totalPage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 천단위 콤마;
		$("div .result b").html(totalCount);
		$("div .paging span.total").html(totalPage);
	}
	
	<%-- 연관사진 검색 --%>
	function relation_photo() {
		var keyword = "";
		keyword = $.trim(keyword);
		var pageNo = "1";
		var pageVol = "10";
		var contentType = $(".filter_contentType .filter_list").find("[selected=selected]").attr("value");
		var media = 0;
		var duration = "";
		var colorMode = "0";
		var horiVertChoice = "0";
		var size = "0";
		var portRight = $(".filter_portRight .filter_list").find("[selected=selected]").attr("value");
		var includePerson = $(".filter_incPerson .filter_list").find("[selected=selected]").attr("value");
		var group = $(".filter_group .filter_list").find("[selected=selected]").attr("value");

		var searchParam = {
				"uciCode":$('#uciCode').val()
				,"keyword":keyword
				, "pageNo":pageNo
				, "pageVol":pageVol
				, "contentType":contentType
				, "media":media
				, "duration":duration
				, "colorMode":colorMode
				, "horiVertChoice":horiVertChoice
				, "size":size
				, "portRight":portRight
				, "includePerson":includePerson
				, "group":group
		};
		
		$("#keyword").val($("#keyword_current").val());
		console.log(searchParam);
		var html = "";
		$.ajax({
			type: "POST",
			async: false,
			dataType: "json",
			data: searchParam,
			timeout: 1000000,
			url: "search",
			success : function(data) { console.log(data);
				$(data.result).each(function(key, val) {
					html += '<li><a href="javascript:void(0)" onclick="go_View(\'' + val.uciCode + '\')"><img src="<%= IMG_SERVER_URL_PREFIX %>/list.down.photo?uciCode=' + val.uciCode + '" /></a></li>';
				});
				$(html).appendTo(".cfix");
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}