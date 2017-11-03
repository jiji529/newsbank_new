<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

	// #찜하기 버튼 on/off
	$(document).on("click", ".btn_wish", function() {
		var uciCode = "${photoDTO.uciCode}";
		var bookName = "기본그룹";
		var member_seq = 1002;
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
				"member_seq" : member_seq
			},
			success: function(data) {
				
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
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
			success: function(data) { console.log(data.result);
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
		var member_seq = 1002;
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
						"member_seq" : member_seq,
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
	}
</script>
</head>
<body> 
<div class="wrap">
	<nav class="gnb_dark">
		<div class="gnb"><a href="#" class="logo"></a>
			<ul class="gnb_left">
				<li class="on"><a href="/photo">보도사진</a></li>
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
	<section class="view">
		<div class="view_lt">
			<div class="navi"></div>
			<h2 class="media_logo"><img src="images/view/logo.gif" alt="뉴시스" /></h2>
			<div class="img_area"><img src="/view.down.photo?uciCode=${photoDTO.uciCode}" style="width:50%; height:50%"/>
				<div class="cont_area">
					<h3 class="img_tit"><span class="uci">${photoDTO.uciCode}</span> ${photoDTO.titleKor}</h3>
					<c:if test="${bookmark.seq eq null || bookmark.seq eq ''}">
						<a href="#" class="btn_wish">찜하기 X</a>	
					</c:if>
					<c:if test="${bookmark.seq ne null}">
						<a href="#" class="btn_wish on">찜하기 O</a>
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
							<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a></li>
							<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001523343_P.jpg" /></a></li>
							<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001879920_P.jpg" /></a></li>
							<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E003307027_P.jpg" /></a></li>
							<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001523343_P.jpg" /></a></li>
							<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001523343_P.jpg" /></a></li>
							<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001523343_P.jpg" /></a></li>
							<li><a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001523343_P.jpg" /></a></li>
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
			<div class="view_rt_top">
				<h3>이미지 구매하기</h3>
				<a href="#" class="price_info">가격확인</a></div>
			<div class="option_choice">
				<ul>
					<li><span>용도</span>
						<select id="usage" onchange="usageChange(this)">
						</select>
					</li>
					<li><span>옵션1</span>
						<select id="division1" onchange="division1Change(this)">
						</select>
					</li>
					<li><span>옵션2</span>
						<select id="division2" onchange="division2Change(this)">
						</select>
					</li>
					<li><span>옵션3</span>
						<select id="division3" onchange="division3Change(this)">
						</select>
					</li>
					<li style="display: none;"><span>옵션4</span>
						<select id="division4" onchange="division4Change(this)">
						</select>
					</li>
					<li><span>기간</span>
						<select id="usageDate" onchange="usageDateChange(this)">
						</select>
					</li>
				</ul>
			</div>
			<div class="option_result">
				<ul>
				</ul>
			</div>
			<div class="sum_sec">
				<div class="total"><span class="tit">총 금액 (수량)</span><span class="price">0<span class="price_txt">원(<span class="price_count">0</span>개)</span></span></div>
				<div class="btn_wrap">
					<div class="btn_cart"><a href="javascript:insertUsageOption();">장바구니</a></div>
					<div class="btn_down"><a href="#">시안 다운로드</a></div>
					<div class="btn_buy"><a href="#">구매하기</a></div>
				</div>
			</div>
		</div>
	</section>
	<footer><!--  -->
		<div class="foot_wrap">
			<div class="foot_lt">(주)다하미커뮤니케이션즈 | 대표 박용립<br />
				서울시 중구 마른내로 140 5층 (쌍림동, 인쇄정보센터)<br />
				고객센터 02-593-4174 | 사업자등록번호 112-81-49789 <br />
				저작권대리중개신고번호 제532호<br />
				통신판매업신고번호 제2016-서울중구-0501호 (사업자정보확인)</div>
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
							<li><a href="http://scrapmaster.co.kr/" target="_blank">스크랩마스터</a></li>
							<li><a href="http://clippingon.co.kr/" target="_blank">클리핑온</a></li>
							<li><a href="http://www.t-paper.co.kr/" target="_blank">티페이퍼</a></li>
							<li><a href="http://forme.or.kr/" target="_blank">e-NIE</a></li>
							<li><a href="http://www.newsbank.co.kr/" target="_blank">뉴스뱅크</a></li>
						</ul>
					</div>
				</div>
				<div class="foot_banner">
					<ul>
						<li class="uci"><a>국가표준 디지털콘텐츠<br />
							식별체계 등록기관 지정</a></li>
						<li class="cleansite"><a>클린사이트<br />
							한국저작권보호원</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
	</footer>
</div>
</body>
</html>
