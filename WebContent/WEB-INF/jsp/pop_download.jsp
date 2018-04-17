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
	
	<link rel="stylesheet" href="css/base.css" />
	<link rel="stylesheet" href="css/sub.css" />
	<style type="text/css">
		body { width:420px; min-width:inherit}
	</style>
	<script src="js/jquery-1.12.4.min.js"></script>
	<script>
		$(document).ready(function() {
			userOfusageList();
		});
		
		// #사용자 선택옵션 불러오기
		function userOfusageList() {
			var result = new Array();
			var html = "<option value=''>선택</option>";
			
			$.ajax({
				url: "/UsageJSON",
				type: "GET",
				dataType: "json",
				success: function(data) { console.log(data);
					$.each(data.result, function(key, val) {
						
						if($.inArray(val.usage, result) == -1) {
							result.push(val.usage);
							html += "<option value='" + val.price + "' seq='" + val.usageList_seq + "'>"+val.usage+"</option>";
						}							
						
					});
					$(html).appendTo("#usage");
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
		
		// #금액 천단위 콤마
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		// #선택옵션 변경(용도)
		function usageChange(choice) {
			var usageList_seq = $("#usage option:selected").attr('seq');
			var price = $("#usage option:selected").val();
			var usage = $("#usage option:selected").text();
			var id = $(choice).attr("id");
			
			if(price != '') {
				var html = '<li><span class="op_cont" value="' + usageList_seq + '">' + usage + '</span><span class="op_price" value="'+price+'">'+numberWithCommas(price)+'원</span><span class="op_del">x</span></li>';
				
				$(html).appendTo($(".option_result > ul"));
				setTotalCount();	
			}			
		}
		
		// #선택 옵션변경 - 선택항목 개별삭제
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
		
		function login_chk() { // 로그인 여부 체크
			var login_state = false;
			if("${loginInfo}" != ""){ // 로그인 시
				login_state = true;
			}
			return login_state;
		}
		
		// #구매 페이지 이동
		function go_pay() {
			
			var jsonArray = new Array();
			var uciCode_array = ($("#uciCode_arr").val()).split(",");
			
			for(var i=0; i<uciCode_array.length; i++) {
				var jsonObject = new Object(); // 선택항목 객체
				var usageArray = new Array(); // 사용용도 객체
				
				$(".option_result ul li").each(function(index) {
					var usage_seq = $(this).children(".op_cont").attr("value");
					usageArray.push(usage_seq);// 사용용도
					
					jsonObject.uciCode = uciCode_array[i];				 
					jsonObject.usage = usageArray;
				});
				jsonArray.push(jsonObject);
			}
			
			var resultObject = new Object(); // 최종 JSON Object
			resultObject.order = jsonArray;
			
			$("#orderJson").val(JSON.stringify(resultObject));
			pay_form.submit();
		}
	</script>
</head>
<body>
	<form class="pay_form" method="post" action="/pay" name="pay_form" >
		<input type="hidden" name="orderJson" id="orderJson" />
		<!-- <input type="hidden" name="uciCode_array" id="uciCode_array" />
		<input type="hidden" name="usage_array" id="usage_array" /> -->
		
		<!-- <input type="hidden" name="cartArry" id="cartArry" /> -->
	</form>
	<div class="wrap_pop">
		<div class="view_rt_top">
			<h3>구매 옵션변경</h3>
		</div>
		<div class="option_choice">
			<ul>
				<li><span>용도</span>
					<select id="usage" onchange="usageChange(this)">
					</select>
				</li>
			</ul>
		</div>
		<div class="option_result">
			<ul>
				
			</ul>
		</div>
		<div class="sum_sec">
			<div class="total"><span class="tit">총 금액 (수량)</span><span class="price"></span></span></div>
			<div class="btn_wrap">
				<input type="hidden" id="uciCode_arr" value="${uciCode_arr}"/>
				<div class="btn_cart" onclick="javascript:void(0)"><a href="javascript:go_pay()">구매하기</a></div>
				<div class="btn_down"><a href="javascript:void(0)" onclick="javascript:self.close()">취소</a></div>
			</div>
		</div>
	</div>
</body>
</html>