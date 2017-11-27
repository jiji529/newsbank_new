<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script src="js/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script type="text/javascript">
	$(document).ready(function(key, val){
		relation_photo();
	});
	
	// #찜하기 버튼 on/off
	$(document).on("click", ".btn_wish", function() {
		var login_state = login_chk();
		
		if(login_state) {
			var uciCode = "${photoDTO.uciCode}";
			var bookName = "기본그룹";
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
				url: "/view.photo?"+param,
				type: "POST",
				data: {
					"photo_uciCode" : uciCode,
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
		var login_state = login_chk();
		
		if(login_state) {
			down();
		} else {
			if(confirm("회원 서비스입니다.\n로그인 하시겠습니까?")) {
				$(".gnb_right li").first().children("a").click();	
			}
		}
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
	
	usageList();
	
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
			
			if(count > 0) {
				$(".op_cont").each(function(index){
					var usageList_seq = $(".op_cont").eq(index).attr("value");
					var price = $(".op_price").eq(index).attr("value");
					
					// 선택옵션 새롭게 추가
					$.ajax({
						url: "/cart.popOption?action=insertUsage",
						type: "POST",
						data: {
							"uciCode" : uciCode,
							"usageList_seq" : usageList_seq,
							"price" : price						
						},
						success: function(data) {					
						}
					});
				});
				
				alert("장바구니에 담겼습니다.");
			}else {
				alert("최소한 1개의 구매옵션은 선택해야 합니다.");
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
					html += '<li><a href="javascript:;"><img src="<%=IMG_SERVER_URL_PREFIX%>/list.down.photo?uciCode=' + val.uciCode + '" /></a></li>';
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
		
		if(login_state) {
			var cartArry = new Array();
			var uciCode = "${photoDTO.uciCode}";
			var cart = uciCode;
			if($(".option_result ul li").length>0){
				$(".option_result ul li").each(function(index) {
					var usage_seq = $(this).children(".op_cont").attr("value");
					cart = cart + "|" + usage_seq;
				});		
				cartArry.push(cart);
				
				var param = {
					"cart" : cartArry
				};
				
				$("#cartArry").val(cartArry);
				
				view_form.submit();
			}else{
				alert("상품을 선택하세요.");
			}
			
		}else{ // 비회원
			if(confirm("회원 서비스입니다.\n로그인 하시겠습니까?")) {
				
			}	
		}
	}
	
	function down() {
		if(!confirm("원본을 다운로드 하시겠습니까?")) {
			return;
		}
		var url = "<%=IMG_SERVER_URL_PREFIX%>/service.down.photo?uciCode=${photoDTO.uciCode}&type=file";
		$("#downFrame").attr("src", url);
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
</script>
</head>
<body> 
<div class="wrap">
	<%@include file="header.jsp" %>
	<form class="view_form" method="post" action="/pay" name="view_form" >
		<input type="hidden" name="cartArry" id="cartArry" />
	</form>
	<form method="post" action="/photo" name="list_form" >
		<input type="hidden" id="seq" name="seq"/>		
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
						${photoDTO.copyright}
						<ul class="navi_select">
							<c:forEach items="${mediaList}" var="media">
								<li value="${media.seq}" onclick="media_submit(${media.seq})">${media.name}</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<h2 class="media_logo"><img src="<%=IMG_SERVER_URL_PREFIX%>/logo.down.photo?seq=${photoDTO.ownerNo}" alt="${photoDTO.ownerName}" /></h2>
			<div class="img_area"><img src="<%=IMG_SERVER_URL_PREFIX%>/view.down.photo?uciCode=${photoDTO.uciCode}"/>
			</div>
			<div class="cont_area">
				<h3 class="img_tit"><span class="uci">${photoDTO.uciCode}</span> ${photoDTO.titleKor}</h3>
				<c:if test="${bookmark.seq eq null || bookmark.seq eq ''}">
					<a href="javascript:void(0)" class="btn_wish">찜하기 X</a>	
				</c:if>
				<c:if test="${bookmark.seq ne null}">
					<a href="javascript:;" class="btn_wish on">찜하기 O</a>
				</c:if>
				<p class="img_cont">${photoDTO.descriptionKor}</p>
			</div>
			<div class="img_info_area">
				<h3 class="info_tit">사진 정보</h3>
				<dl>
					<dt>촬영일</dt>
					<dd>${photoDTO.shotDate}</dd>
					<dt>픽셀수</dt>
					<dd>${photoDTO.widthPx} X ${photoDTO.heightPx}(pixel)</dd>
					<dt>출력사이즈</dt>
					<dd>${photoDTO.widthCm} x ${photoDTO.heightCm} (cm)</dd>
					<dt>파일용량</dt>
					<dd>${photoDTO.fileSize}MB</dd>
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
		</div>
		<div class="view_rt">
			<div class="view_rt_top">
				<h3>이미지 구매하기</h3>
				<a href="javascript:;" class="price_info">가격확인</a>
			</div>
			<c:if test="${loginInfo == null || loginInfo.deferred != 'Y'}">
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
				<c:if test="${loginInfo == null || loginInfo.deferred != 'Y'}">
					<div class="total"><span class="tit">총 금액 (수량)</span><span class="price">0<span class="price_txt">원(<span class="price_count">0</span>개)</span></span></div>
					<div class="btn_wrap">
						<div class="btn_cart"><a href="javascript:insertUsageOption();">장바구니</a></div>
						<div class="btn_down" id="btnDownTentative"><a href="javascript:void(0)" value="${photoDTO.uciCode}">시안 다운로드</a></div>
						<div class="btn_buy"><a href="javascript:;" onclick="go_pay()">구매하기</a></div>
					</div>
				</c:if>
				<c:if test="${loginInfo != null && loginInfo.deferred == 'Y'}">
					<div class="btn_wrap">
						<div class="btn_buy" id="btnDown">
							<a href="javascript:;" onclick="down()">다운로드</a>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</section>
	<%@include file="footer.jsp"%>
</div>
<iframe id="downFrame" style="display:none" >
</iframe>
</body>
</html>
