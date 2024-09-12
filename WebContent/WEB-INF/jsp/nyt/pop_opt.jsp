<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 10. 25. 오후 03:25:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 30.   hoyadev        pop_option (cart.mypage 내부) 
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>장바구니 옵션변경/추가</title>
	<link rel="stylesheet" href="css/nyt/base.css" />
	<link rel="stylesheet" href="css/nyt/sub.css" />
	<style type="text/css">
		body { width:420px; min-width:inherit}
	</style>
	<script src="js/nyt/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		usageList();
		
		// #장바구니 옵션변경 - 선택항목 개별삭제
		$(document).on("click", ".op_del", function() {
			// 최소한 옵션은 존재해야만 함.
			var optionCnt = $(".option_result li").length;
			//console.log("optionCnt : " + optionCnt);
			
			if(optionCnt > 1) {
				$(this).parent("li").remove();
				setTotalCount();	
			}else {
				alert("최소한 1개의 옵션은 선택해야 합니다.")
			}
			
		});
		
		// #금액 천단위 콤마
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
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
		
		// #장바구니 옵션 변경하기
		function updateUsageOption() {
			var uciCode = "${uciCode}";
			var count = $(".op_cont").length;
			console.log(uciCode);
			
			if(count > 0) {
				
				// 기존의 옵션 모두 삭제
				$.ajax({
					url: "/cart.popOption?action=deleteCart",
					type: "POST",
					data: {
						"uciCode" : uciCode
					},
					success: function(data) {
						insertUsageOption(uciCode);
					}
					
				});
			}else {
				alert("최소한 1개의 구매옵션은 선택해야 합니다.");
			}
		}
		
		function insertUsageOption(uciCode) {
			// 1. 선택사진 배열 가져오기 (uciCodes)
			// 2. 사용용도, 가격 배열 가져오기 (usageList_seq, price)
			var uciCode = "${uciCode}";
			var count = $(".op_cont").length;
			var cartArray = new Array(); // 장바구니 배열
			
			$(".op_cont").each(function(index){
				var usageList_seq = $(".op_cont").eq(index).attr("value");
				var price = $(".op_price").eq(index).attr("value");
				
				var obj = new Object(); // 객체
				obj.uciCode = uciCode;
				obj.usageList_seq = usageList_seq;
				obj.price = price;
				
				cartArray.push(obj);
			});
			
			console.log(cartArray);
			
			$.ajax({
				url: "/cart.popOption?action=insertCart",
				type: "POST",
				data : ({
					cartArray : JSON.stringify(cartArray)
				}),
				success: function(data) {
					
					alert("장바구니 옵션이 변경되었습니다.");
					window.opener.document.location.href = window.opener.document.URL; // 부모창 새로고침
					window.close(); // 팝업창 닫기
				}
			});
		}
		
		// #찜관리 - 다중선택에 따른 장바구니 담기
		function insertMultiCart() {			
			var uciCodeArr = ("${uciCode}").split(","); // uciCode 배열
			var cartArray = new Array(); // 장바구니 배열
			
			var count = $(".op_cont").length;
			var cartArray = new Array(); // 장바구니 배열
			
			if(count > 0) {
				$.each(uciCodeArr, function(key, value) {
					var uciCode = value;
					
					$(".op_cont").each(function(index){ // 선택된 사용용도 리스트 갯수대로 시행
						var usageList_seq = $(".op_cont").eq(index).attr("value"); // 사용용도 고유번호
						var price = $(".op_price").eq(index).attr("value"); // 사용용도 가격
						
						var obj = new Object(); // 객체
						obj.uciCode = uciCode;
						obj.usageList_seq = usageList_seq;
						obj.price = price;
						
						cartArray.push(obj);
						console.log(obj);
					});
				});
				
				// 선택옵션 새롭게 추가
				$.ajax({
					url: "/cart.popOption?action=insertCart",
					type: "POST",
					data : ({
						cartArray : JSON.stringify(cartArray)
					}),
					success: function(data) {
						alert("장바구니에 추가되었습니다.");
						window.close();
						opener.parent.location.reload();						
					}
				});
				
			}else {
				alert("이미지 용도와 옵션, 기간을 모두 선택한 후 장바구니에 담으실 수 있습니다.");
			}
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
		}
		
	</script>
</head>
<body>
	<div class="wrap_pop">
		<div class="view_rt_top">
		<c:if test="${page eq 'dibs.myPage'}">
			<h3>장바구니 옵션선택</h3>
		</c:if>
		<c:if test="${page ne 'dibs.myPage'}">
			<h3>장바구니 옵션변경</h3>
		</c:if>
			</div>
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
				<c:set var="total" value="0"/>
				<c:if test="${page ne 'dibs.myPage'}">
					<c:forEach items="${usageOptions}" var="UsageDTO">
						<li><span class="op_cont" value="${UsageDTO.usageList_seq}">${UsageDTO.usage} / ${UsageDTO.division1} / ${UsageDTO.division2} / ${UsageDTO.division3} / ${UsageDTO.division4} / ${UsageDTO.usageDate} </span><span class="op_price" value="${UsageDTO.price}"><fmt:formatNumber value="${UsageDTO.price}" type="number"/>원</span><span class="op_del">x</span></li>
						<c:set var="total" value="${total + UsageDTO.price}"></c:set>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		<div class="sum_sec">
			<div class="total"><span class="tit">총 금액 (수량)</span><span class="price"><fmt:formatNumber value="${total}" type="number"/><span class="price_txt">원(<span class="price_count"><c:out value="${fn:length(usageOptions)}"/></span>개)</span></span></div>
			<div class="btn_wrap">
				<c:if test="${page eq 'dibs.myPage'}">
					<div class="btn_cart" onclick="insertMultiCart()"><a href="javascript:void(0)">장바구니 담기</a></div>
				</c:if>
				<c:if test="${page ne 'dibs.myPage'}">
					<div class="btn_cart" onclick="updateUsageOption()"><a href="javascript:void(0)">변경하기</a></div>
				</c:if>
				<div class="btn_down"><a href="javascript:void(0)" onclick="javascript:self.close()">취소</a></div>
			</div>
		</div>
	</div>
</body>
</html>