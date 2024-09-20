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
<%
	String device = (String) request.getAttribute("device");
%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
	
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
			var uciCode_arr = ($("#uciCode_arr").val()).split(",");
			// I011-M, I011-F 으로 시작하는 항목이 있는지 확인, mypage_download.jsp 에서 섞인상태로 구매가 안되도록 사전 막는 처리가 있음
			const hasM = uciCode_arr.some(item => item.startsWith("I011-M"));
			const hasF = uciCode_arr.some(item => item.startsWith("I011-F"));
			var reqUrl;
			if(hasM) {
				reqUrl = "/UsageJSON";				
			} else if(hasF) {
				reqUrl = "/Foreign.UsageJSON";
			}
			
			var result = new Array();
			var html = "<option value=''>선택</option>";
			
			$.ajax({
				url: reqUrl,
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
			// 모바일 웹 환경에서 결제가 안됨에 따라, 안내창 띄우기 위해 처리한 부분
			var device = document.getElementById("device").value;
			if(device=='mobile' || device=='tablet') {
				alert("모바일웹 환경에서는 결제 진행이 불가합니다.\nPC로 결제를 진행해주세요.");
				return false;
			}
			
			var jsonArray = new Array();
			var uciCode_array = ($("#uciCode_arr").val()).split(",");
			var count = $(".op_cont").length;
			
			if(count > 0) {
				for(var i=0; i<uciCode_array.length; i++) {
					
					$(".option_result ul li").each(function(index) {
						var usage_seq = $(this).children(".op_cont").attr("value");
						var price = $(this).children(".op_price").attr("value");
						
						var jsonObject = new Object(); // 선택항목 객체
						jsonObject.uciCode = uciCode_array[i];	
						jsonObject.usage = usage_seq;
						jsonObject.price = price;
						
						jsonArray.push(jsonObject);
					});
				}
				
				var resultObject = new Object(); // 최종 JSON Object
				resultObject.order = jsonArray;
				resultObject.LGD_CUSTOM_USABLEPAY = "SC9999";
				
				$("#orderJson").val(JSON.stringify(resultObject));
				
				// 선택옵션 구매하기
				$.ajax({
					type : "post",
					url : "/purchase.api",
					data : ({
						orderJson : JSON.stringify(resultObject)
					}),

					dataType : "json",
					success : function(data) { console.log(data);
						var success = data.success;
						
						if(success) {
							alert("구매 완료");
							self.close();
							window.opener.location.href = location.origin + "/postBuylist.mypage"; // 부모창 구매내역으로 이동
						}
					},
					error : function() {
						console.log(data);
					}
				});
			}else {
				alert("구매 용도를 선택해야만 구매하실 수 있습니다.");
			}
		}				
		
	</script>
</head>
<body>
	<div class="wrap_pop">
		<div class="view_rt_top">
			<h3>구매 용도선택</h3>
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
				<input type="hidden" id="device" name="device" value="<%=device  %>" />
				<input type="hidden" id="uciCode_arr" value="${uciCode_arr}"/>
				<div class="btn_cart" onclick="javascript:void(0)"><a href="javascript:go_pay()">구매하기</a></div>
				<div class="btn_down"><a href="javascript:void(0)" onclick="javascript:self.close()">취소</a></div>
			</div>
		</div>
	</div>
</body>
</html>