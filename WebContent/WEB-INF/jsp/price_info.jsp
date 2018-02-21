<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 11. 13.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 11. 13.   	  tealight        file_name
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크-구매안내</title>
<script src="js/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/footer.js"></script>
<script>
	$(document).ready(function() {
		$("#popupTap1").on('click', function() {
			$("#popupTap1").addClass('tapOn');
			$("#popupTap2").removeClass('tapOn');
			$("#tblEditorial").css('display',"block");
			$("#tblCommercial").css('display',"none");
		});
		
		$("#popupTap2").on('click', function() {
			$("#popupTap2").addClass('tapOn');
			$("#popupTap1").removeClass('tapOn');
			$("#tblEditorial").css('display',"none");
			$("#tblCommercial").css('display',"block");
		});
	});
</script>
</head>
<body>
	<div class="wrap">
		<%@include file="header.jsp"%>
		<section class="mypage">
			<div class="head">
				<h2>이용안내</h2>
				<p>뉴스뱅크 사이트에 관하여 알려드립니다.</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1 use">
					<li class="on">
						<a href="/price.info">구매안내</a>
					</li>
					<li>
						<a href="/board">공지사항</a>
					</li>
					<li>
						<a href="/FAQ">FAQ</a>
					</li>
					<li>
						<a href="/contact">직접 문의하기</a>
					</li>
				</ul>
			</div>
			<div class="table_head">
				<h3>구매안내</h3>
			</div>
			<div class="tab1">
				<!-- 가격테이블 Tap-->
				<span class="tapOn" id="popupTap1">
					<a href="javascript:;" id="Editorial">Editorial (출판용)</a>
				</span>
				<span id="popupTap2">
					<a href="javascript:;" id="Commercial">Commercial (상업용)</a>
				</span>
			</div>
			<section id="tblEditorial" style="display:;">
				<!-- 가격테이블 -->
				<table class="tb01" cellpadding="0" cellspacing="0">
					<colgroup>
						<col width="100px">
						<col width="112px">
						<col width="280px">
						<col width="80px">
						<col width="80px">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" colspan="2">구분</th>
							<th scope="col">용도</th>
							<th scope="col">사용기간</th>
							<th scope="col">가격 (VAT포함)</th>
						</tr>
					</thead>
					<tbody>
						<tr id="r1">
							<th rowspan="5">출판, 간행물</th>
							<td rowspan="3">인쇄매체</td>
							<td>단행본, 잡지-내지</td>
							<td>1년 이내</td>
							<td>88,000</td>
						</tr>
						<tr id="r2">
							<td>단행본, 잡지표지</td>
							<td>1년 이내</td>
							<td>165,000</td>
						</tr>
						<tr id="r3">
							<td>단행본, 잡지 내지+표지 (동일한 컷을 같은 매체에 이용시 기준)</td>
							<td>1년 이내</td>
							<td>220,000</td>
						</tr>
						<tr id="r4">
							<td>e북, 모바일등</td>
							<td>e-book, CD수록, 기타 전자매체</td>
							<td>1년 이내</td>
							<td>165,000</td>
						</tr>
						<tr id="r5">
							<td>패키지</td>
							<td>인쇄매체 + e-book (동일한 컷을 2개 매체에 이용시 기준)</td>
							<td>1년 이내</td>
							<td>220,000</td>
						</tr>
						<tr id="r6">
							<th rowspan="4">교육용</th>
							<td rowspan="2">인쇄매체</td>
							<td>전집, 백과사전, 도감, 학술논문, 발표자료 등</td>
							<td>1년 이내</td>
							<td>88,000</td>
						</tr>
						<tr id="r7">
							<td>교과서, 참고서, 학습지</td>
							<td>1년 이내</td>
							<td>88,000</td>
						</tr>
						<tr id="r8">
							<td>온라인, 모바일 등</td>
							<td>전자교과서, 교육용 웹사이트, CD수록 등 저장매체, 발표용 슬라이드</td>
							<td>1년 이내</td>
							<td>110,000</td>
						</tr>
						<tr id="r9">
							<td>패키지</td>
							<td>인쇄매체 + 온라인, 모바일 등 (동일한 컷을 2개 매체에 이용시 기준)</td>
							<td>1년 이내</td>
							<td>165,000</td>
						</tr>
						<tr id="r10">
							<th rowspan="5">언론 보도용</th>
							<td>인쇄매체</td>
							<td>신문-종합일간지, 경제지, 스포츠지, 무가지, 타블로이드, 학술지 등</td>
							<td>1년 이내</td>
							<td>88,000</td>
						</tr>
						<tr id="r11">
							<td>온라인</td>
							<td>인터넷뉴스 등</td>
							<td>1년 이내</td>
							<td>110,000</td>
						</tr>
						<tr id="r12">
							<td>방송</td>
							<td>지상파, 종합유선방송, 위성방송, IPTV, 인터넷방송 등</td>
							<td>1년 이내</td>
							<td>110,000</td>
						</tr>
						<tr id="r13">
							<td rowspan="2">패키지</td>
							<td>방송 + 웹사이트 (동일한 컷을 2개 매체에 이용시 기준)</td>
							<td>1년 이내</td>
							<td>165,000</td>
						</tr>
						<tr id="r14">
							<td>인쇄매체 + 웹사이트 (동일한 컷을 2개 매체에 이용시 기준)</td>
							<td>1년 이내</td>
							<td>165,000</td>
						</tr>
						<tr id="r15">
							<th rowspan="8">전시, 디스플레이</th>
							<td rowspan="4">오프라인</td>
							<td rowspan="4">전시회 (1개장소 기준) * 5년 이상 사용시 별도문의 바람</td>
							<td>3개월 미만</td>
							<td>330,000</td>
						</tr>
						<tr id="r16">
							<td>3개월 ~ 6개월 미만</td>
							<td>440,000</td>
						</tr>
						<tr id="r17">
							<td>6개월 ~ 1년 미만</td>
							<td>550,000</td>
						</tr>
						<tr id="r18">
							<td>1 년 이상</td>
							<td>1,100,000</td>
						</tr>
						<tr id="r19">
							<td rowspan="4">오프라인</td>
							<td rowspan="4">매장 및 사업장 내 디스플레이</td>
							<td>3개월 미만</td>
							<td>330,000</td>
						</tr>
						<tr id="r20">
							<td>3개월 ~ 6개월 미만</td>
							<td>440,000</td>
						</tr>
						<tr id="r21">
							<td>6개월 ~ 1년 미만</td>
							<td>550,000</td>
						</tr>
						<tr id="r22">
							<td>1년 이상</td>
							<td>1,100,000</td>
						</tr>
						<tr id="r23">
							<th rowspan="15">기타</th>
							<td rowspan="3">인쇄매체, 온라인</td>
							<td rowspan="3">카달로그, 팜플렛, 브로슈어,리플렛, 메뉴얼, 샘플북 e-카다로그, 전자브로셔</td>
							<td>5,000 ~</td>
							<td>220,000</td>
						</tr>
						<tr id="r24">
							<td>5,000 ~ 10,000부 미만</td>
							<td>330,000</td>
						</tr>
						<tr id="r25">
							<td>10,000부 이상</td>
							<td>440,000</td>
						</tr>
						<tr id="r26">
							<td rowspan="3">패키지</td>
							<td rowspan="3">카달로그 + E-카달로그, 브로슈어 + E-브로슈어, 메뉴얼 + E-메뉴얼</td>
							<td>5,000부 미만</td>
							<td>330,000</td>
						</tr>
						<tr id="r27">
							<td>5,000~10,000부 미만</td>
							<td>440,000</td>
						</tr>
						<tr id="r28">
							<td>10,000부 이상</td>
							<td>550,000</td>
						</tr>
						<tr id="r29">
							<td rowspan="2">인쇄매체</td>
							<td>사보, 뉴스레터, 기관지 등</td>
							<td>1년 이내</td>
							<td>110,000</td>
						</tr>
						<tr id="r30">
							<td>의정보고서, 내부게시판 등</td>
							<td>1년 이내</td>
							<td>110,000</td>
						</tr>
						<tr id="r31">
							<td rowspan="2">온라인</td>
							<td>기업 및 단체 운영의 홈페이지 또는 블로그, 인트라넷 등</td>
							<td>1년 이내</td>
							<td>110,000</td>
						</tr>
						<tr id="r32">
							<td>웹진, 뉴스레터 온라인배포용</td>
							<td>1년 이내</td>
							<td>165,000</td>
						</tr>
						<tr id="r33">
							<td>방송</td>
							<td>보도용 이외 일반 방송 프로그램 (홈쇼핑 제외)</td>
							<td>1년 이내</td>
							<td>120,000</td>
						</tr>
						<tr id="r34">
							<td rowspan="4">멀티미디어</td>
							<td>게임, 소프트웨어, 영상배경</td>
							<td>1년 이내</td>
							<td>220,000</td>
						</tr>
						<tr id="r35">
							<td>홍보용 슬라이드, 멀티비전</td>
							<td>1년 이내</td>
							<td>220,000</td>
						</tr>
						<tr id="r36">
							<td>모바일 기기, PDA 등 휴대 단말기 내장형</td>
							<td>1년 이내</td>
							<td>220,000</td>
						</tr>
						<tr id="r37">
							<td>키오스크, 발매기, 현금지급기, 모니터 등 고정기기 내장형</td>
							<td>1년 이내</td>
							<td>330,000</td>
						</tr>
					</tbody>
				</table>
			</section>
			<section id="tblCommercial" style="display: none;">
				<!-- 가격테이블 -->
				<table class="tb01"  cellpadding="0" cellspacing="0">
					<colgroup>
					<col width="140px">
					<col width="170px">
					<col width="430px">
					<col width="160px">
					<col width="170px">
					<col width="170px">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" colspan="2">구분</th>
							<th scope="col">용도</th>
							<th scope="col">사용조건</th>
							<th scope="col">사용기간</th>
							<th scope="col">가격
								(VAT포함)</th>
						</tr>
					</thead>
					<tbody>
						<tr id="r50">
							<th rowspan="19">광고</th>
							<td rowspan="4">신문광고</td>
							<td rowspan="3">중앙지, 스포츠지, 경제지등</td>
							<td>1단 ~ 9단</td>
							<td>1년 이내</td>
							<td>440,000</td>
						</tr>
						<tr id="r51">
							<td>10단 ~ 15단</td>
							<td>1년 이내</td>
							<td>550,000</td>
						</tr>
						<tr id="r52">
							<td>스프레드</td>
							<td>1년 이내</td>
							<td>770,000</td>
						</tr>
						<tr id="r53">
							<td>지역지, 학보사, 타블로이드, 무가지, 기타 전문지</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>330,000</td>
						</tr>
						<tr id="r54">
							<td rowspan="2">잡지광고</td>
							<td rowspan="2">정기간행물, 교양지, 전문지, 학술지, 전화번호부등</td>
							<td>내지</td>
							<td>1년 이내</td>
							<td>220,000</td>
						</tr>
						<tr id="r55">
							<td>표지</td>
							<td>1년 이내</td>
							<td>330,000</td>
						</tr>
						<tr id="r56">
							<td>TV광고</td>
							<td>CF (중앙방송, 지역방송, 케이블방송, 위성방송, 인터넷방송 등)</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>550,000</td>
						</tr>
						<tr id="r57">
							<td>극장광고</td>
							<td>극장용 광고</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>550,000</td>
						</tr>
						<tr id="r58">
							<td rowspan="2">온라인광고</td>
							<td>배너광고</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>220,000</td>
						</tr>
						<tr id="r59">
							<td>스크린 쉐이퍼, 웰페이퍼</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>165,000</td>
						</tr>
						<tr id="r60">
							<td>홈쇼핑</td>
							<td>홈쇼핑 프로그램</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>440,000</td>
						</tr>
						<tr id="r61">
							<td rowspan="8">옥외 및 매장내</td>
							<td rowspan="3">현수막, 네코와이드칼라, 버스쉘터, 스크린도어 ,전광판 등</td>
							<td>-</td>
							<td>3개월 미만</td>
							<td>440,000</td>
						</tr>
						<tr id="r62">
							<td>-</td>
							<td>3개월 ~ 6개월 미만</td>
							<td>550,000</td>
						</tr>
						<tr id="r63">
							<td>-</td>
							<td>6개월 이상</td>
							<td>660,000</td>
						</tr>
						<tr id="r64">
							<td rowspan="2">POP배너-1개 장소 기준</td>
							<td>10개 미만</td>
							<td>1년 이내</td>
							<td>330,000</td>
						</tr>
						<tr id="r65">
							<td>10개 이상</td>
							<td>1년 이내</td>
							<td>440,000</td>
						</tr>
						<tr id="r66">
							<td>간판</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>550,000</td>
						</tr>
						<tr id="r67">
							<td rowspan="2">차량광고-버스, 택시, 지하철, 기차 등</td>
							<td>내부</td>
							<td>1년 이내</td>
							<td>330,000</td>
						</tr>
						<tr id="r68">
							<td>외부</td>
							<td>1년 이내</td>
							<td>440,000</td>
						</tr>
						<tr id="r69">
							<th rowspan="13">홍보판촉 상품</th>
							<td>포스터</td>
							<td>상업용</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>550,000</td>
						</tr>
						<tr id="r70">
							<td>포스터</td>
							<td>비상업용-비고객용, 사내용, 캠페인</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>330,000</td>
						</tr>
						<tr id="r71">
							<td>보도자료</td>
							<td>신문, 온라인 배포용
								(2차이상 배포불가)</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>550,000</td>
						</tr>
						<tr id="r72">
							<td rowspan="8">캘린더용</td>
							<td rowspan="4">벽걸이용</td>
							<td>1 만부 미만</td>
							<td>1년 이내</td>
							<td>495,000</td>
						</tr>
						<tr id="r73">
							<td>1만 ~ 5만부</td>
							<td>1년 이내</td>
							<td>605,000</td>
						</tr>
						<tr id="r74">
							<td>5만 ~ 10만부</td>
							<td>1년 이내</td>
							<td>715,000</td>
						</tr>
						<tr id="r75">
							<td>10만부초과</td>
							<td>1년 이내</td>
							<td>825,000</td>
						</tr>
						<tr id="r76">
							<td rowspan="4">탁상용</td>
							<td>1만부 미만</td>
							<td>1년 이내</td>
							<td>330,000</td>
						</tr>
						<tr id="r77">
							<td>1만 ~ 5만부</td>
							<td>1년 이내</td>
							<td>385,000</td>
						</tr>
						<tr id="r78">
							<td>5만 ~ 10만부</td>
							<td>1년 이내</td>
							<td>440,000</td>
						</tr>
						<tr id="r79">
							<td>10만부 초과</td>
							<td>1년 이내</td>
							<td>550,000</td>
						</tr>
						<tr id="r80">
							<td>기타</td>
							<td>상품인쇄-음반자켓, 박스, 엽서, 초대장, 카드, 다이어리, 판촉물 등</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>330,000</td>
						</tr>
						<tr id="r81">
							<td>기타</td>
							<td>로고, 심볼, 캐릭터</td>
							<td>-</td>
							<td>1년 이내</td>
							<td>770,000</td>
						</tr>
					</tbody>
				</table>
			</section>
		</section>
		<%@include file="footer.jsp"%>
	</div>
</body>
</html>