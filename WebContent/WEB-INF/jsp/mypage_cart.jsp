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
<% long currentTimeMills = System.currentTimeMillis(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script type="text/javascript">
	
	/** 찜하기 */
	$(document).on("click", ".btn_b", function() {
		var member_seq = "1002"; // 사용자 고유번호
		var uciCode = $(this).closest("tr").find(".code").text();		
		
		var param = "action=bookmark";
		
		$.ajax({
			url: "/cart.myPage?"+param,
			type: "POST",
			data: {
				"member_seq" : member_seq,
				"uciCode" : uciCode
			},
			success: function(data){ 
				alert("찜목록에 추가되었습니다.");
			}, 
			error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
		});
		
	});

	/** 개별 삭제 */
	$(document).on("click", ".btn_g", function() {
		var member_seq = "1002"; // 사용자 고유번호
		var uciCode = $(this).closest("tr").find(".code").text();
		
		var chk = confirm("정말로 삭제하시겠습니까?");
		if(chk == true) {
			cartDelete(member_seq, uciCode);
			$(this).closest("tr").remove();
		} 				
	});

	/** 다중선택 삭제 */
	$(document).on("click", ".mp_btn", function() {
		var member_seq = "1002"; // 사용자 고유번호
		var chk = confirm("정말로 삭제하시겠습니까?");
		
		if(chk == true) {
			$("#order_list input:checkbox:checked").each(function(index) {
				var uciCode = $(this).val();
				cartDelete(member_seq, uciCode);
				$(this).closest("tr").remove();
			});
		}
	});
	
	/** 전체선택 */
	$(document).on("click", "input[name='check_all']", function() {
		if($("input[name='check_all']").prop("checked")) {
			$("#order_list input:checkbox").prop("checked", true);
		}else {
			$("#order_list input:checkbox").prop("checked", false);
		}
	});
	
	/** DB 삭제함수 */
	function cartDelete(member_seq, uciCode) {
		var param = "action=delete";
		
		$.ajax({
			url: "/cart.myPage?"+param,
			type: "POST",
			data: {
				"member_seq" : member_seq,
				"uciCode" : uciCode
			},
			success: function(data){ }, 
			error:function(request,status,error){
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       	}
		});
	}
	
</script>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
<script src="js/footer.js"></script>
</head>
<body>
	<div class="wrap">
		<%@include file="header.jsp" %>
		<section class="mypage">
			<div class="head">
				<h2>마이페이지</h2>
				<p>설명어쩌고저쩌고</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1">
					<li><a href="/account.mypage">정산 관리</a></li>
					<li><a href="/cms">사진 관리</a></li>
					<li><a href="/info.mypage">회원정보 관리</a></li>
					<li><a href="/dibs.myPage">찜관리</a></li>
					<li class="on"><a href="/cart.myPage">장바구니</a></li>
					<li><a href="/buylist.mypage">구매내역</a></li>
				</ul>
			</div>
			<div class="table_head">
				<h3>장바구니</h3>
			</div>
			<section id="order_list">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tb03" style="border-top:0; margin-bottom:15px;">
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
						<td><div class="tb_check">
								<input id="check${status.index}" name="check${status.index}" type="checkbox" value="${CartDTO.uciCode}">
								<label for="check${status.index}">선택</label>
							</div></td>
						<td><div class="cart_item">
								<div class="thumb"><a href="/view.photo?uciCode=${CartDTO.uciCode}" target="_blank"><img src="/list.down.photo?uciCode=${CartDTO.uciCode}&dummy=<%= currentTimeMills%>" /></a></div>
								<div class="cart_info"> <a href="/view.photo?uciCode=${CartDTO.uciCode}" target="_blank">
									<div class="brand">${CartDTO.copyright}</div>
									<div class="code">${CartDTO.uciCode}</div>
									</a>
									<div class="option_area">
										<c:forEach items="${CartDTO.getUsageList()}" var="UsageDTO">
											<ul class="opt_li">
												<li>${UsageDTO.usage}</li>
												<li>${UsageDTO.division1}</li>
												<li>${UsageDTO.division2}</li>
												<li>${UsageDTO.division3}</li>
												<li>${UsageDTO.usageDate}</li>
											</ul>
										</c:forEach>
										<a href= "main.html" onClick="window.open('/cart.popOption?uciCode=${CartDTO.uciCode}','new','resizable=no width=420 height=600');return false">옵션 변경/추가</a></div>
								</div>
							</div></td>
						<td><fmt:formatNumber value="${CartDTO.price * 10 / 11}" type="number"/>원</td>
						<td><fmt:formatNumber value="${CartDTO.price * 10 / 11 / 10}" type="number"/>원</td>
						<td><strong class="color"><fmt:formatNumber value="${CartDTO.price}" type="number"/>원</strong></td>
						<td><div class="btn_group">
								<button type="button" class="btn_o" name="btn_buy">바로구매</button>
								<button type="button" class="btn_b" name="btn_zzim">찜 하기</button>
								<button type="button" class="btn_g" name="btn_delete">삭제</button>
							</div></td>
					</tr>
					</c:forEach>
				</table>
	<a href="#" class="mp_btn" style="float:left;">선택 삭제</a>
			<div class="calculate_info_area">총 금액<strong><fmt:formatNumber value="${total * 10 / 11}" type="number"/></strong>원<span style="margin:0 20px;">+</span> 부가세<strong><fmt:formatNumber value="${total * 10 / 11 / 10}" type="number"/></strong>원<span style="margin:0 20px;">=</span> 총 판매금액 : <strong class="color"><fmt:formatNumber value="${total}" type="number"/></strong>원</div>
			<div class="btn_area"><a href="#" class="btn_input2">결제하기</a></div>
	
	</section>
		</section>
	</div>
</body>
</html>
