<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;

PhotoDTO photoDto = (PhotoDTO)request.getAttribute("photoDTO");
boolean contentBlidF = false;
// 사진보기에서는 정상 판매상태여야함
if(photoDto == null
	|| photoDto.getSaleState() != PhotoDTO.SALE_STATE_OK) {
		contentBlidF = true;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>뉴스뱅크</title>
<script src="js/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script type="text/javascript">
	$(document).ready(function(key, val){
		relation_photo();
		usageList();
		// 오류 신고하기 팝업
		$("#popup_open").click(function(){ 
			var login_stats = login_chk();
			if(login_stats){
				$("#popup_wrap").css("display", "block"); 
				$(".mask").css("display", "block");
			}else{ // 비회원
				if(confirm("회원 서비스입니다.\n로그인 하시겠습니까?")) {
					$(".gnb_right li").first().children("a").click();	
				}	
			}
		}); 
		
		// 신고하기 팝업 닫기
		$(".popup_close").click(function(){
			$("#popup_wrap").css("display", "none"); 
// 			$(".mask").css("display", "none"); 
		}); 
	});
	
	// #찜하기 버튼 on/off
	$(document).on("click", ".btn_wish", function() {
		var login_state = login_chk();
		
		if(login_state) {
			var uciCode = "${photoDTO.uciCode}";
			var bookName = "기본폴더";
			var state = $(".btn_wish").hasClass("on");
			
			if(state) {
				// 찜 해제
				$(".btn_wish").removeClass("on");
				var param = "action=deleteBookmark";
			}else {
				// 찜 하기
				$(".btn_wish").addClass("on");
				var param = "action=insertBookmark";
			}
			
			$.ajax({
				url: "/bookmark.api?"+param,
				type: "POST",
				data: {
					"uciCode" : uciCode,
					"bookName" : bookName,
				},
				success: function(data) {
					
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		} else {
			if(confirm("회원 서비스입니다.\n로그인 하시겠습니까?")) {
				$(".gnb_right li").first().children("a").click();	
			}
		}
	});
	
	$(document).on("click", ".btn_down", function() {
		downOutline("${photoDTO.uciCode}");
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
	
	// #금액 천단위 콤마
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	// #장바구니 옵션변경 - 선택항목 개별삭제
	$(document).on("click", ".op_del", function() {
		$(this).parent("li").remove();
		setTotalCount();
	});
	
	// #선택옵션 용도옵션 불러오기
	function usageList() {
		var result = new Array();
		var html = "<option>선택</option>";
		
		$.ajax({
			url: "/UsageJSON",
			type: "GET",
			dataType: "json",
			success: function(data) {
				$.each(data.result, function(key, val) {
					
					if($.inArray(val.usage, result) == -1) {
						result.push(val.usage);
						html += "<option>"+val.usage+"</option>";
					}							
					
				});
				$(html).appendTo("#usage");
			}
		});
	}
	
	// #선택옵션 변경(용도)
	function usageChange(choice) {
		var value = $(choice).val();
		var id = $(choice).attr("id");
		var nextId = $("#"+id).parent("li").next().children("select").attr("id");
		var result = new Array();
		var html = "<option>선택</option>";
		$("#"+id).parent("li").nextAll().children("select").empty();
		
		$("#division4").parent("li").css("display", "none");
		$("#division1").empty();
		
		$.ajax({
			url: "/UsageJSON",
			type: "GET",
			dataType: "json",
			success: function(data) {
				$.each(data.result, function(key, val) {
					
					if(val.usage == value) {
						if($.inArray(val.division1, result) == -1) {
							result.push(val.division1);
							html += "<option>"+val.division1+"</option>";
						}
					}
					
				});
				$(html).appendTo("#division1");
			}
		});
	}
	
	// #선택옵션 변경(옵션1)
	function division1Change(choice) {
		var value = $(choice).val();
		var id = $(choice).attr("id");
		var usage = $("#usage").val();
		var nextId = $("#"+id).parent("li").next().children("select").attr("id");
		var result = new Array();
		var html = "<option>선택</option>";
		$("#"+id).parent("li").nextAll().children("select").empty();
		
		$("#division4").parent("li").css("display", "none");
		$("#division2").empty();
		
		$.ajax({
			url: "/UsageJSON",
			type: "GET",
			dataType: "json",
			success: function(data) {
				$.each(data.result, function(key, val) {
					
					if(val.usage == usage && val.division1 == value) {
						if($.inArray(val.division2, result) == -1) {
							result.push(val.division2);
							html += "<option>"+val.division2+"</option>";
						}
					}
				});
				$(html).appendTo("#division2");
			}
		});
	}
	
	// #선택옵션 변경(옵션2)
	function division2Change(choice) {
		var value = $(choice).val();
		var id = $(choice).attr("id");
		var usage = $("#usage").val();
		var division1 = $("#division1").val(); 
		var nextId = $("#"+id).parent("li").next().children("select").attr("id");
		var result = new Array();
		var html = "<option>선택</option>";
		$("#"+id).parent("li").nextAll().children("select").empty();
		
		$("#division4").parent("li").css("display", "none");
		$("#division3").empty();
		
		$.ajax({
			url: "/UsageJSON",
			type: "GET",
			dataType: "json",
			success: function(data) {
				$.each(data.result, function(key, val) {
					
					if(val.usage == usage && val.division1 == division1 && val.division2 == value ) {
						if($.inArray(val.division3, result) == -1) {
							result.push(val.division3);
							html += "<option>"+val.division3+"</option>";
						}
					}
				});
				$(html).appendTo("#division3");
			}
		});
	}
	
	// #선택옵션 변경(옵션3)
	function division3Change(choice) {
		var value = $(choice).val();
		var id = $(choice).attr("id");
		var usage = $("#usage").val();
		var division1 = $("#division1").val();
		var division2 = $("#division2").val();
		var nextId = $("#"+id).parent("li").next().children("select").attr("id");
		var result = new Array();
		var addOptions = new Array();
		var html = "<option>선택</option>";
		var addHtml = "<option>선택</option>";
	
		$("#"+id).parent("li").nextAll().children("select").empty();
		
		$("#usageDate").empty();
		$("#division4").empty();
		addOptions = [];
		
		$.ajax({
			url: "/UsageJSON",
			type: "GET",
			dataType: "json",
			success: function(data) {
				$.each(data.result, function(key, val) {
					
					if(val.usage == usage && val.division1 == division1 && val.division2 == division2 && val.division3 == value) {
						if($.inArray(val.usageDate, result) == -1) {
							result.push(val.usageDate);
							html += "<option>"+val.usageDate+"</option>";
						}
						
						if(val.division4 != "") {
							if($.inArray(val.division4, addOptions) == -1) {
								addHtml += "<option>"+val.division4+"</option>";
								addOptions.push(val.division4);	
							}
						}	
					}
				});
				
				if(addOptions.length > 0) {
					$("#division4").parent("li").css("display", "block");
					$(addHtml).appendTo("#division4");
				}else {
					$("#division4").parent("li").css("display", "none");
				}
				$(html).appendTo("#usageDate");
			}
		});
	}
	
	// #선택옵션 변경(옵션4)
	function division4Change(choice) {
		var value = $(choice).val();
		var id = $(choice).attr("id");
		var nextId = $("#"+id).parent("li").next().children("select").attr("id");
		var result = new Array();
		var html = "<option>선택</option>";
		$("#"+id).parent("li").nextAll().children("select").empty();
		
		$("#usageDate").empty();
		
		$.ajax({
			url: "/UsageJSON",
			type: "GET",
			dataType: "json",
			success: function(data) {
				$.each(data.result, function(key, val) {
					
					if(val.division4 == value) {
						if($.inArray(val.usageDate, result) == -1) {
							result.push(val.usageDate);
							html += "<option>"+val.usageDate+"</option>";
						}
					}
				});
				$(html).appendTo("#usageDate");
			}
		});
	}
	
	// #선택옵션 변경(기간)
	function usageDateChange(choice) {
		var value = $(choice).val();
		var usage = $("#usage").val();
		var usageList_seq;
		var division1 = $("#division1").val();
		var division2 = $("#division2").val();
		var division3 = $("#division3").val(); 
		var division4 = $("#division4").val(); if(!division4) division4 = "";
		var usageDate = $("#usageDate").val();
		var price;
		
		$.ajax({
			url: "/UsageJSON",
			type: "GET",
			dataType: "json",
			success: function(data) { 
				$.each(data.result, function(key, val) {
					if(val.usage == usage && val.division1 == division1 && val.division2 == division2 && val.division3 == division3 && val.division4 == division4 && val.usageDate == value) {							
						price = val.price;
						usageList_seq = val.usageList_seq;
					}
				});
				
				if(division4 != "") {
					var options = usage + " / " + division1 + " / " + division2 + " / " + division3 + " / " + division4 + " / " + usageDate;	
				}else {
					var options = usage + " / " + division1 + " / " + division2 + " / " + division3 + " / " + usageDate;
				}
				
				var html = '<li><span class="op_cont" value="'+usageList_seq+'">' + options + '</span><span class="op_price" value="'+price+'">'+numberWithCommas(price)+'원</span><span class="op_del">x</span></li>';
				
				$(html).appendTo($(".option_result > ul"));
				setTotalCount();
			}
		});
	}	
	
	// #옵션 추가/삭제에 따른 총 금액(수량) 후처리
	function setTotalCount() {
		var total = 0;
		var count = $(".op_cont").length; // 총 갯수
		
		$(".op_cont").each(function(index){
			var price = $(".op_price").eq(index).attr("value");
			total += Number(price);				
		});
		var priceTxt = numberWithCommas(total) + '<span class="price_txt">원(<span class="price_count">'+count+'</span>개)</span>';
		
		$(".price").html(priceTxt);
		//$(".price_count").text(count);
	}
	
	// #장바구니에 추가하기
	function insertUsageOption() {
		var login_state = login_chk();
		
		if(login_state) { // 로그인 체크
			var uciCode = "${photoDTO.uciCode}";
			var count = $(".op_cont").length;
			var cartArray = new Array(); // 장바구니 배열
			
			if(count > 0) {
				
				$(".op_cont").each(function(index){
					var usageList_seq = $(".op_cont").eq(index).attr("value");
					var price = $(".op_price").eq(index).attr("value");
					
					var obj = new Object(); // 객체
					obj.uciCode = uciCode;
					obj.usageList_seq = usageList_seq;
					obj.price = price;
					
					cartArray.push(obj);
				});
				
				$.ajax({
					url: "/cart.popOption?action=insertCart",
					type: "POST",
					data : ({
						cartArray : JSON.stringify(cartArray)
					}),
					success: function(data) {
						
						alert("장바구니에 담겼습니다.");
					}
				});
				
			}else {
				//alert("최소한 1개의 구매옵션은 선택해야 합니다.");
				alert("이미지 용도와 옵션, 기간을 모두 선택한 후 장바구니에 담으실 수 있습니다.");
			}
			
		} else { //비회원
			if(confirm("회원 서비스입니다.\n로그인 하시겠습니까?")) {
				$(".gnb_right li").first().children("a").click();	
			}
		}
		
	}
	
	// #연관사진
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
				"uciCode":"${photoDTO.uciCode}"
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
		
		var html = "";
		$.ajax({
			type: "POST",
			async: false,
			dataType: "json",
			data: searchParam,
			timeout: 1000000,
			url: "search",
			success : function(data) {
				$(data.result).each(function(key, val) {
					html += '<li><a href="javascript:;" onclick="go_photoView(\'' + val.uciCode + '\')"><img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '" /></a></li>';
				});
				$(html).appendTo(".cfix");
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}
	
	// #구매 페이지 이동
	function go_pay() {
		var login_state = login_chk();
		var jsonArray = new Array();
		
		if(login_state) {
			
			if($(".option_result ul li").length>0) {
				
				var jsonObject = new Object(); // 결제대상 객체
				var usageArray = new Array(); // 사용용도 객체
				
				var uciCode = "${photoDTO.uciCode}";
				
				$(".option_result ul li").each(function(index) {
					var usage_seq = $(this).children(".op_cont").attr("value");
					usageArray.push(usage_seq);// 사용용도
					
					jsonObject.uciCode = uciCode;				 
					jsonObject.usage = usageArray;
				});					
				jsonArray.push(jsonObject);
				
				var resultObject = new Object(); // 최종 JSON Object
				resultObject.order = jsonArray;
				
				$("#orderJson").val(JSON.stringify(resultObject));
			
				pay_form.submit();
			}else{
				alert("상품을 선택하세요.");
			}
			
		}else{ // 비회원
			if(confirm("회원 서비스입니다.\n로그인 하시겠습니까?")) {
				$(".gnb_right li").first().children("a").click();	
			}	
		}
	}		
	
	function media_submit(media_seq) {
		$("#seq").val(media_seq);
		list_form.submit();
	}
	
	function login_chk() { // 로그인 여부 체크
		var login_state = false;
		if("${loginInfo}" != ""){ // 로그인 시
			login_state = true;
		}
		return login_state;
	}
	
	function go_photoView(uciCode) {
		$("#uciCode").val(uciCode);
		view_form.submit();
	}
	
 	function declaration(){	//오류 신고하기
		var reason = $('#popup_wrap textarea').val();
		
		if(reason.trim() == ''){
			alert("사유를 입력해주세요.");
			return false;
		}else{	//엔터를 무지막지하게 쳤을 경우
			reason.replace(/\\n/g,'');
			if(reason.trim() == ''){
				alert("사유를 입력해주세요.");
				return false;
			}
		}
		$('#userErrorReportForm textarea[name=errorReportTextArea]').val(reason);
		
		var mailingCheck = $('#popup_wrap :input[type=checkbox]').prop('checked');
		if(mailingCheck){
			$('#userErrorReportForm :input[name=mailing]').val('1');
		}
		var msg='정말로 신고를 하시겠습니까?';
		if(confirm(msg)){
			$.ajax({
				type:'post',
				url:'/register.report.error',
				data:$('#userErrorReportForm').serialize(),
				async: false,
				success:function(data){
					if(data < 0){
						alert('오류신고 도중 문제가 발생했습니다.');
					}else{
						alert('성공적으로 오류신고가 완료되었습니다.');
						$('.popup_close').click();	//팝업창 닫기
					}
				},
				error:function(request,error){
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);		
				}
				
			})
 		}
	}
	
</script>
</head>
<body> 
<div class="wrap">
	<%@include file="header.jsp" %>
	<form class="pay_form" method="post" action="/pay" name="pay_form" >
		<input type="hidden" name="orderJson" id="orderJson" />
		<!-- <input type="hidden" name="cartArry" id="cartArry" /> -->
	</form>
	<form method="post" action="/photo" name="list_form" >
		<input type="hidden" id="seq" name="seq"/>		
	</form>
	<form class="view_form" method="post" action="/view.photo" name="view_form" >
		<input type="hidden" name="uciCode" id="uciCode"/>
	</form>
	<section class="view">
		<div class="view_lt">
			<div class="navi">
				<a href="/home" title="뉴스뱅크 홈" class="home">뉴스뱅크 홈</a>
				<div class="navi_wrap">
					<a href="/photo">보도사진</a><span class="ico_depth"></span>
				</div>
				<div class="navi_wrap">
					<span class="ico_depth"></span>
					<div class="navi_cate">
						${photoDTO.ownerName}
						<ul class="navi_select">
							<c:forEach items="${mediaList}" var="media">
								<li value="${media.seq}" onclick="media_submit(${media.seq})">${media.compName}</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<h2 class="media_logo">
				<img src="<%=IMG_SERVER_URL_PREFIX%>/logo.down.photo?seq=${photoDTO.ownerNo}" alt="${photoDTO.ownerName}" />
				<div class="btn_edit"> <span id="popup_open"><a href="javascript:void(0)">오류 신고하기</a></span></div>
			</h2>
			<div class="img_area"><img src="<%=IMG_SERVER_URL_PREFIX%>/view.down.photo?uciCode=${photoDTO.uciCode}"/>
			</div>
			<div class="cont_area">
				<h3 class="img_tit"><span class="uci">${photoDTO.uciCode}</span> 
<%
if(!contentBlidF) {
%>
				${photoDTO.titleKor}
<%
}
%>
				</h3>
<%
if(!contentBlidF) {
%>
				<c:if test="${bookmark.seq eq null || bookmark.seq eq ''}">
					<a href="javascript:void(0)" class="btn_wish">찜하기 X</a>	
				</c:if>
				<c:if test="${bookmark.seq ne null}">
					<a href="javascript:;" class="btn_wish on">찜하기 O</a>
				</c:if>
				<p class="img_cont">${photoDTO.descriptionKor}</p>
<%
}
%>
			</div>
<%
if(!contentBlidF) {
%>
			<div class="img_info_area">
				<h3 class="info_tit">사진 정보</h3>
				<dl>
					<dt>업로드일</dt>
					<dd><fmt:formatDate value="${photoDTO.regDate}" pattern="yyyy년 MM월 dd일  HH시 mm분 ss초"/></dd>
					<dt>촬영일</dt>
					<dd><fmt:formatDate value="${photoDTO.shotDate}" pattern="yyyy년 MM월 dd일  HH시 mm분 ss초"/></dd>
					<dt>픽셀수</dt>
					<dd>${photoDTO.widthPx} X ${photoDTO.heightPx}(pixel)</dd>
					<dt>출력사이즈</dt>
					<dd>${photoDTO.getWidthCmStr()} x ${photoDTO.getHeightCmStr()} (cm)</dd>
					<dt>파일용량</dt>
					<dd>${photoDTO.getFileSizeMBStr()}MB</dd>
					<dt>파일포맷</dt>
					<dd>JPEG</dd>
					<dt>해상도</dt>
					<dd>${photoDTO.dpi}dpi</dd>
					<dt>저작권자</dt>
					<dd>${photoDTO.copyright}</dd>
				</dl>
			</div>
			<div class="img_info_area">
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
					</ul>
					<div class="btn_conn">
						<button class="in_prev">이전</button>
						<button class="in_next">다음</button>
					</div>
				</div>
			</div>
<%
}
%>
		</div>
<%
if(!contentBlidF) {
%>
		<div class="view_rt">
			<!-- 제약사항 안내 (뉴시스 회원만) -->
			<c:if test="${photoDTO.ownerName eq '뉴시스'}">
				<div class="restriction">
	 				<div class="view_rt_top">
	 					<h3>제약사항 안내</h3>
	 				</div>
	 				<div class="restriction_cont">TV, 인터넷뉴스, 신문 등 <b class="color">언론 보도용으로는 판매가 불가</b>합니다. <br />
	 					언론 보도 목적으로 사용해야 하는 경우는 <br />
	 					<a href="https://www.newsbank.co.kr/contact" target="_blank">뉴스뱅크 고객센터</a>로 문의해주시기 바랍니다.</div>
	 			</div>
			</c:if>
			
 			
			<div class="view_rt_top">
				<h3>이미지 구매하기</h3>
				<a href="/price.info" class="price_info" target="_blank">가격확인</a>
			</div>
			<c:if test="${loginInfo == null || loginInfo.deferred == 0}">
				<div class="option_choice">
					<ul>
						<li><span>용도</span> <select id="usage"
							onchange="usageChange(this)">
						</select></li>
						<li><span>옵션1</span> <select id="division1"
							onchange="division1Change(this)">
						</select></li>
						<li><span>옵션2</span> <select id="division2"
							onchange="division2Change(this)">
						</select></li>
						<li><span>옵션3</span> <select id="division3"
							onchange="division3Change(this)">
						</select></li>
						<li style="display: none;"><span>옵션4</span> <select
							id="division4" onchange="division4Change(this)">
						</select></li>
						<li><span>기간</span> <select id="usageDate"
							onchange="usageDateChange(this)">
						</select></li>
					</ul>
				</div>
				<div class="option_result">
					<ul>
					</ul>
				</div>
			</c:if>
			<div class="sum_sec">
				<c:if test="${loginInfo == null || loginInfo.deferred == 0}">
					<div class="total"><span class="tit">총 금액 (수량)</span><span class="price">0<span class="price_txt">원(<span class="price_count">0</span>개)</span></span></div>
					<div class="btn_wrap">
						<div class="btn_cart"><a href="javascript:insertUsageOption();">장바구니</a></div>
						<div class="btn_down" id="btnDownTentative"><a href="javascript:void(0)" value="${photoDTO.uciCode}">시안 다운로드</a></div>
						<div class="btn_buy"><a href="javascript:;" onclick="go_pay()">구매하기</a></div>
					</div>
				</c:if>
				<c:if test="${loginInfo != null && loginInfo.deferred != 0}">
					<div class="btn_wrap">
						<div class="btn_buy" id="btnDown">
							<a href="javascript:;" onclick="downDiferred('${photoDTO.uciCode}')">다운로드</a>
						</div>
					</div>
				</c:if>
			</div>
		</div>
<%
}
%>

<%
if(!contentBlidF) {
%>
		
		<div id="popup_wrap" class="pop_group wd">
			<div class="pop_tit">
				<h2>오류 신고하기</h2>
				<p>
					<button class="popup_close">닫기</button>
				</p>
			</div>
			<div class="pop_cont">
				<div class="error_form">
					<p>사진과 사진의 상세 정보에서 잘못된 점을 발견하신 경우, 아래 칸에 기재하여 신고해 주세요.<br />
						최대한 신속하게 수정하여 정상적으로 서비스될 수 있도록 하겠습니다. </p>
					<textarea rows="16"></textarea>
					<div class="agree_check">
							<input type="checkbox">
							<label for="chk">신고 내역 및 처리 결과를 회원가입한 이메일로 받고 싶습니다. </label>
					</div>
				</div>
			</div>
			<div class="pop_foot">
				<div class="pop_btn">
					<button onclick="declaration();">신고하기</button>
					<button class="popup_close">닫기</button>
				</div>
			</div>
		</div>
		
		<form id="userErrorReportForm" >
			<textarea name="errorReportTextArea" style="display:none;"></textarea>
			<input type="hidden" name="uciCode" value="${photoDTO.uciCode}"/>
			<input type="hidden" name="mailing" value="0"/>
		</form>		
<%
}
%>
	</section>
<%@include file="footer.jsp"%>
</div>
<%@include file="down_frame.jsp" %>
</body>
</html>
