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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<link rel="stylesheet" href="css/base.css" />
	<link rel="stylesheet" href="css/sub.css" />
	<style type="text/css">
		body { width:420px; min-width:inherit}
	</style>
	<script type="text/javascript">
		usageList();
		
		// #장바구니 옵션변경 - 선택항목 개별삭제
		$(document).on("click", ".op_del", function() {
			$(this).parent("li").remove();
		});
		
		// #장바구니 옵션변경 - 선택항목 변경
		$(document).on("click", "btn_cart", function() {
			updateUsageOption();
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
						}
					});
					
					var options = usage + " / " + division1 + " / " + division2 + " / " + division3 + " / " + division4 + " / " + usageDate;
					var html = '<li><span class="op_cont">' + options + '</span><span class="op_price" value="'+price+'">'+price+'원</span><span class="op_del">x</span></li>';
					
					$(html).appendTo($(".option_result > ul"));
				}
			});
		}		
		
		// 장바구니 옵션 변경하기
		function updateUsageOption() {
			
		}
		
	</script>
</head>
<body>
	<div class="wrap_pop">
		<div class="view_rt_top">
			<h3>장바구니 옵션변경</h3>
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
				<c:forEach items="${usageOptions}" var="UsageDTO">
					<li><span class="op_cont">${UsageDTO.usage} / ${UsageDTO.division1} / ${UsageDTO.division2} / ${UsageDTO.division3} / ${UsageDTO.division4} / ${UsageDTO.usageDate} </span><span class="op_price" value="${UsageDTO.price}">${UsageDTO.price}원</span><span class="op_del">x</span></li>
				</c:forEach>
			</ul>
		</div>
		<div class="sum_sec">
			<div class="total"><span class="tit">총 금액 (수량)</span><span class="price">528,000<span class="price_txt">원(<span class="price_count">2</span>개)</span></span></div>
			<div class="btn_wrap">
				<div class="btn_cart"><a href="#">변경하기</a></div>
				<div class="btn_down"><a href="#">취소</a></div>
			</div>
			</div>
	</div>
</body>
</html>