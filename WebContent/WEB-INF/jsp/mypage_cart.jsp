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
  2017. 10. 25.   hoyadev        cart.mypage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>뉴스뱅크</title>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
<script src="js/mypage.js"></script>
<script type="text/javascript">
	
	/** 찜하기 */
	$(document).on("click", ".btn_b", function() {
		var uciCode = $(this).closest("tr").find(".code").text();		
		var param = "action=insertBookmark";
		
		$.ajax({			
			url: "/bookmark.api?"+param,
			type: "POST",
			data: {
				"uciCode" : uciCode
			},
			success: function(data){  console.log(data);
				var result = data.result;
				var success = data.success;
				var message = data.message;
				
				console.log(result + " / " + success + " / " + message);
				
				if(success) {
					alert("찜목록에 추가되었습니다.");	
				} else {
					alert(message);
				}
				
			}, 
			error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
		});
		
	});

	/** 개별 삭제 */
	$(document).on("click", ".btn_g", function() {
		var uciCode = $(this).closest("tr").find(".code").text();
		
		var chk = confirm("정말로 삭제하시겠습니까?");
		if(chk == true) {
			cartDelete(uciCode);
			$(this).closest("tr").remove();
		} 			
		recalculate();
	});

	/** 다중선택 삭제 */
	$(document).on("click", ".mp_btn", function() {
		var chkCount = $(".order_list input:checkbox:checked").length;
		
		if(chkCount == 0) {
			alert("최소 1개 이상을 선택해주세요.");
		} else {
			var chk = confirm("정말로 삭제하시겠습니까?");
			
			if(chk == true) {
				$(".order_list input:checkbox:checked").each(function(index) {
					var uciCode = $(this).val();
					cartDelete(uciCode);
					$(this).closest("tr").remove();
				});
				recalculate();
			}
		}
	});
	
	
	/** DB 삭제함수 */
	function cartDelete(uciCode) {
		$.ajax({
			url: "/cart.popOption",
			type: "POST",
			data: {
				"action" : "deleteCart",
				"uciCode" : uciCode
			},
			success: function(data){ }, 
			error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
		});
	}
	
	// #다중선택 결제 함수
	function multi_pay() {
		var jsonArray = new Array();
		var checkCnt = $(".order_list input:checkbox:checked").length; // 체크박스 선택 갯수
		
		if(checkCnt > 0) {
			$(".order_list input:checkbox:checked:not(#check_all)").each(function(index) {
				var uciCode = $(this).val();			
				var jsonObject = new Object(); // 장바구니 객체
				var usageArray = new Array(); // 사용용도 객체
				
				 $(this).closest("td").next().find(".opt_li").each(function(index) {
					 var usage_seq = $(this).attr("value");
					 usageArray.push(usage_seq);// 사용용도
					 
					 jsonObject.uciCode = uciCode;				 
					 jsonObject.usage = usageArray;
				 });
				
				 jsonArray.push(jsonObject);
			});
			
			var resultObject = new Object(); // 최종 JSON Object
			resultObject.order = jsonArray;
			
			$("#orderJson").val(JSON.stringify(resultObject));
			cart_form.submit();
			
		}else {
			alert("결제할 항목을 선택해주세요");
		}
	}
	
	
	/** 바로 구매 */
	$(document).on("click", ".btn_o", function() {
		
		var jsonArray = new Array();
		var uciCode = $(this).closest("tr").find(".code").text();
		
		var jsonObject = new Object(); // 결제대상 객체
		var usageArray = new Array(); // 사용용도 객체
		
		$(this).closest("tr").find(".opt_li").each(function(index) {
			 var usage_seq = $(this).attr("value");
			 usageArray.push(usage_seq);// 사용용도
			 
			 jsonObject.uciCode = uciCode;				 
			 jsonObject.usage = usageArray;
		 });
		
		jsonArray.push(jsonObject);
		
		var resultObject = new Object(); // 최종 JSON Object
		resultObject.order = jsonArray;
		
		$("#orderJson").val(JSON.stringify(resultObject));
		cart_form.submit();
		
	});
	
	// #총 금액 재계산
	function recalculate() {
		var totalPrice = 0; // 총 금액
		var totalSurtax = 0; // 부가세
		var totalSell = 0; // 총 판매금액
		
		$(".order_list input:checkbox:checked:not(#check_all)").each(function(index) {
			// 판매가
			 $(this).closest("tr").find("td:eq(2)").each(function(index) {
				 var price = $(this).text();
				 price = price.replace(/[^0-9]/g, "");
				 totalPrice += parseInt(price);
			 });
			
			// 판매가
			 $(this).closest("tr").find("td:eq(3)").each(function(index) {
				 var surtax = $(this).text();
				 surtax = surtax.replace(/[^0-9]/g, "");
				 totalSurtax += parseInt(surtax);
			 });
			
			// 판매가
			 $(this).closest("tr").find("td:eq(4)").each(function(index) {
				 var sell = $(this).text();
				 sell = sell.replace(/[^0-9]/g, "");
				 totalSell += parseInt(sell);
			 });
			
		});
		
		var html = '총 금액<strong>' + comma(totalPrice) + '</strong>원';
		html += '<span style="margin:0 20px;">+</span> ';
		html += '부가세<strong>' + comma(totalSurtax) + '</strong>원';
		html += '<span style="margin:0 20px;">=</span> ';
		html += '총 판매금액 : <strong class="color">' + comma(totalSell) + '</strong>원';
		
		if(totalSell > 0) {
			$(".calculate_info_area").html(html);
			$(".calculate_info_area").show();
		}else {
			$(".calculate_info_area").hide();
		}
	}
	
	// 장바구니 선택에 따른 금액 자동합산
	$(document).on("change", ".tb_check", function() {
		recalculate();
	});
	
</script>
</head>
<body>
	<div class="wrap">
		<%@include file="header.jsp" %>
		<form class="cart_form" method="post" action="/pay" name="cart_form" >
			<input type="hidden" name="orderJson" id="orderJson" />
		</form>
		<section class="mypage">
			<div class="head">
				<h2>마이페이지</h2>
				<p>설명어쩌고저쩌고</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1">
					<c:if test="${MemberInfo.type eq 'M' && MemberInfo.admission eq 'Y'}">
						<li>
							<a href="/accountlist.mypage">정산 관리</a>
						</li>
						<li>
							<a href="/cms">사진 관리</a>
						</li>
					</c:if>
					
					<c:if test="${MemberInfo.type eq 'Q' && MemberInfo.admission eq 'Y'}">
						<li>
							<a href="/cms">사진 관리</a>
						</li>
					</c:if>
					
					<c:if test="${MemberInfo.type eq 'W' && MemberInfo.admission eq 'Y'}">
						<li>
							<a href="/accountlist.mypage">정산 관리</a>
						</li>
					</c:if>
					
					<li>
						<a href="/info.mypage">회원정보 관리</a>
					</li>
					<li>
						<a href="/dibs.myPage">찜관리</a>
					</li>
					<li class="on">
						<a href="/cart.myPage">장바구니</a>
					</li>
					<li>
						<a href="/buylist.mypage">구매내역</a>
					</li>
				</ul>
			</div>
			<div class="table_head">
				<h3>장바구니</h3>
			</div>
			<section class="order_list">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tb03 cart_table" style="border-top:0; margin-bottom:15px;">
					<colgroup>
					<col width="40">
					<col>
					<col width="110">
					<col width="100">
					<col width="110">
					<col width="160">
					</colgroup>
					<tr>
						<th scope="col"> <div class="tb_check">
								<input id="check_all" name="check_all" type="checkbox">
								<label for="check_all">선택</label>
							</div>
						</th>
						<th scope="col">상품정보</th>
						<th scope="col">판매가</th>
						<th scope="col">부가세</th>
						<th scope="col">구매금액</th>
						<th scope="col">선택</th>
					</tr>
					<c:set var="total" value="0"/>
					<c:forEach items="${cartList}" var="CartDTO" varStatus="status">
					<c:set var="total" value="${total + CartDTO.price}"></c:set>
						<tr>
						<td>
							<c:if test="${CartDTO.photoDTO.withdraw eq 0 && CartDTO.photoDTO.admission eq 'Y' && CartDTO.photoDTO.activate eq 1 && CartDTO.photoDTO.saleState eq 1}">
								<div class="tb_check">
									<input id="check${status.index}" name="check${status.index}" type="checkbox" value="${CartDTO.uciCode}">
									<label for="check${status.index}">선택</label>
								</div>
							</c:if>
						</td>
						<td><div class="cart_item">
								<%-- <c:choose>
									<c:when test="${CartDTO.photoDTO.withdraw eq 0 && CartDTO.photoDTO.admission eq 'Y' && CartDTO.photoDTO.activate eq 1}">
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose> --%>
								
								<div class="thumb">
									<c:choose>
										<c:when test="${CartDTO.photoDTO.withdraw eq 0 && CartDTO.photoDTO.admission eq 'Y' && CartDTO.photoDTO.activate eq 1 && CartDTO.photoDTO.saleState eq 1}">
											<a href="/view.photo?uciCode=${CartDTO.uciCode}" target="_blank"><img src="<%=IMG_SERVER_URL_PREFIX %>/list.down.photo?uciCode=${CartDTO.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" /></a>
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0);" onclick="stopSaleMessage()"><img src="<%=IMG_SERVER_URL_PREFIX %>/list.down.photo?uciCode=${CartDTO.uciCode}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" /></a>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="cart_info">
									<c:choose>
										<c:when test="${CartDTO.photoDTO.withdraw eq 0 && CartDTO.photoDTO.admission eq 'Y' && CartDTO.photoDTO.activate eq 1 && CartDTO.photoDTO.saleState eq 1}">
											<a href="/view.photo?uciCode=${CartDTO.uciCode}" target="_blank">
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0);" onclick="stopSaleMessage()">
										</c:otherwise>
									</c:choose> 
										<div class="brand">${CartDTO.copyright}</div>
										<div class="code">${CartDTO.uciCode}</div>
										</a>
									<div class="option_area">
										<c:forEach items="${CartDTO.getUsageList()}" var="UsageDTO">
											<ul class="opt_li" value="${UsageDTO.usageList_seq}">
												<li>${UsageDTO.usage}</li>
												<li>${UsageDTO.division1}</li>
												<li>${UsageDTO.division2}</li>
												<li>${UsageDTO.division3}</li>
												<li>${UsageDTO.usageDate}</li>
											</ul>
										</c:forEach>
										<c:if test="${CartDTO.photoDTO.withdraw eq 0 && CartDTO.photoDTO.admission eq 'Y' && CartDTO.photoDTO.activate eq 1 && CartDTO.photoDTO.saleState eq 1}">
											<a href= "main.html" onClick="window.open('/cart.popOption?uciCode=${CartDTO.uciCode}','new','toolbar=no, resizable=no, width=420, height=600, directories=no, status=no, scrollbars=no');return false">옵션 변경/추가</a>
										</c:if>										
									</div>
								</div>
							</div></td>
						<td><fmt:formatNumber value="${CartDTO.price * 10 / 11}" type="number"/>원</td>
						<td><fmt:formatNumber value="${CartDTO.price * 10 / 11 / 10}" type="number"/>원</td>
						<td><strong class="color"><fmt:formatNumber value="${CartDTO.price}" type="number"/>원</strong></td>
						<td><div class="btn_group">
								<!-- 매체사 권한에 따른 구매, 찜하기 기능 동작 -->
								<c:if test="${CartDTO.photoDTO.withdraw eq 0 && CartDTO.photoDTO.admission eq 'Y' && CartDTO.photoDTO.activate eq 1 && CartDTO.photoDTO.saleState eq 1}">
									<button type="button" class="btn_o" name="btn_buy">바로구매</button>
									<button type="button" class="btn_b" name="btn_zzim">찜 하기</button>
								</c:if>
								<button type="button" class="btn_g" name="btn_delete">삭제</button>
							</div></td>
					</tr>
					</c:forEach>
				</table>
			<a href="javascript:;" class="mp_btn" style="float:left;">선택 삭제</a>
			<div class="calculate_info_area" style="display:none;"></div>
			<%-- <div class="calculate_info_area">총 금액<strong><fmt:formatNumber value="${total * 10 / 11}" type="number"/></strong>원<span style="margin:0 20px;">+</span> 부가세<strong><fmt:formatNumber value="${total * 10 / 11 / 10}" type="number"/></strong>원<span style="margin:0 20px;">=</span> 총 판매금액 : <strong class="color"><fmt:formatNumber value="${total}" type="number"/></strong>원</div> --%>
			<div class="btn_area"><a href="javascript:;" class="btn_input2" onclick="multi_pay()">결제하기</a></div>
	
	</section>
		</section>
		<%@include file="footer.jsp"%>
	</div>
</body>
</html>
