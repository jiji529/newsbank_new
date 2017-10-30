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
		$(document).on("change", ".usage", function() {
			console.log("usage changed");
		});
		
		var f_selbox = new Array("상업용", "출판용");
		
		var s_selbox = new Array();
		s_selbox[0] = new Array("광고", "홍보판촉상품");
		s_selbox[1] = new Array("교육용", "기타", "언론보도용", "전시,디스플레이", "출판,간행물");
		
		var t_selbox = new Array();
		t_selbox[0] = new Array("TV광고", "극장광고", "신문광고", "옥외 및 매장내", "온라인광고");
		t_selbox[1] = new Array("기타", "보도자료", "캘린더용", "");
		
		function init(f) {
			var f_sel = f.first;
			var s_sel = f.second;
			var t_sel = f.third;
			
			f_sel.options[0] = new Option("선택", "");
			s_sel.options[0] = new Option("선택", "");
			t_sel.options[0] = new Option("선택", "");
			
			for(var i=0; i<f_selbox.length; i++) {
				f_sel.options[i+1] = new Option(f_selbox[i], f_selbox[i]);		
			}
		}
		
		function itemChange(f) {
			var f_sel = f.first;
			var s_sel = f.second;
			
			var sel = f_sel.selectedIndex;
			for(var i=sel.length; i>=0; i--) {
				s_sel.options[i] = null;
			}
			
			s_sel.options[0] = new Option("선택", "");
			
			if(sel != 0) {
				for(var i=0; i<s_selbox[sel-1].length; i++) {
					s_sel.options[i+1] = new Option(s_selbox[sel-1][i], s_selbox[sel-1][i]);
				}
			}
		}
		
		function secondChange(f) {
			var s_sel = f.second;
			var t_sel = f.third;
			
			var sel = s_sel.selectedIndex;
			for(var i=sel.length; i>=0; i--) {
				t_sel.options[i] = null;
			}
			
			t_sel.options[0] = new Option("선택", "");
			
			if(sel != 0) {
				for(var i=0; i<s_selbox[sel-1].length; i++) {
					t_sel.options[i+1] = new Option(t_selbox[sel-1][i], t_selbox[sel-1][i]);
				}
			}
		}
	</script>
</head>
<body onload="init(this.form)">
	<div class="wrap_pop">
		<div class="view_rt_top">
			<h3>장바구니 옵션변경</h3>
			</div>
		<form name="form">
			<div class="option_choice">
				<ul>
					<li><span>구분</span>
						<select id="first" onchange="itemChange(this.form);">
						</select>
					</li>
					<li><span>상세</span>
						<select id="second" onchange="secondChange(this.form);">
						</select>
					</li>
					<li><span>용도</span>
						<select id="third">
						</select>
				</li>
				</ul>
			</div>
		</form>
		<%-- <div class="option_choice">
			<ul>
				<li><span>구분</span>
					<select class="usage">
						<option>선택</option>
						<c:forEach items="${usageOption}" var="option">
							<option>${option.usage}</option>
						</c:forEach>
					</select>
				</li>
				<li><span>상세</span>
					<select>
						<option>선택선택</option>
					</select>
				</li>
				<li><span>용도</span>
					<select>
						<option>선택선택</option>
					</select>
				</li>
				<li><span>기간</span>
					<select>
						<option>선택선택</option>
					</select>
				</li>
			</ul>
		</div> --%>
		<div class="option_result">
			<ul>
				<li><span class="op_cont">상업용 / 신문광고 / 중앙지, 스포츠지, 경제지 등 / 1~9단 / 1년 이내</span><span class="op_price">440,000원</span><span class="op_del">x</span></li>
				<li><span class="op_cont">출판용 / 교육용 / 전집, 백과사전, 도감, 학술논문 발표자료 등 / 1년 이내</span><span class="op_price">88,000원</span><span class="op_del">x</span></li>
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