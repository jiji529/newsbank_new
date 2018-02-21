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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크-UCI 소개</title>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<link rel="stylesheet" href="css/jquery.bxslider.css" />
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery.bxslider.js"></script>
<script src="js/footer.js"></script>
<script> 
	$(document).ready(function() {
		set_bxSlider();
		function set_bxSlider() { //
			slider = $('.bxslider').bxSlider({
				pagerCustom : '#bx-controls',
				controls : false,				
				slideWidth: 860
			});
		}

	});
</script>
</head>
<body>
	<div class="wrap">
		<%@include file="header.jsp"%>
		<section class="mypage">
			<div class="head">
				<h2>서비스 소개</h2>
				<p>뉴스뱅크 서비스에 대하여 알려드립니다.</p>
			</div>
			<div class="mypage_ul" style="display:none;">
				<ul class="mp_tab1 si">
					<li>
						<a href="/newsbank.intro">뉴스뱅크 소개</a>
					</li>
					<li class="on">
						<a href="/uci.intro">UCI 소개</a>
					</li>
					<li>
						<a href="/copyright.intro">저작권 안내</a>
					</li>
				</ul>
			</div>
		</section>
		<div class="uci_info">
			<section class="uci_sec1">
				<h4>뉴스뱅크 사진의 고유ID는 UCI입니다.</h4>
				<p>
					자동차 등록번호나 상품에 부여된 바코드처럼 디지털 콘텐츠에도 고유한 식별 방법이 있습니다.
					<br />
					뉴스뱅크의 사진은 UCI 코드를 고유ID로 삼아 식별하고 있습니다.
					<br />
					UCI, 즉 Universal Content Identifier 국가디지털콘텐츠 식별체계는 식별이 가능한 디지털 콘텐츠에 유일하고 영구한 코드를 부여하고 이를 관리해주는 체계입니다.
					<br />
					국제 표준체계로도 인정받고 있는 UCI 코드를 부여 받은 디지털 콘텐츠는 인터넷 상의 수 많은 콘텐츠 중에 식별이 가능하고, 구매와 이용현황 확인은 물론 유통과정 추적도 가능합니다.
				</p>
				<div class="uci_ex">
					<h3>UCI 코드 및 메타데이터 표현 예시</h3>
					<img src="images/uci/uci_img_ex.png" alt="UCI 코드 및 메타데이터 표현 예시" />
				</div>
			</section>
			<section class="uci_sec2">
				<h4>UCI 활용 예시</h4>
				<div class="tab" id="bx-controls" class="bx-controls">
					<ul class="tabs">
						<li>
							<a data-slide-index="0" href="javascript:;" class="active">사진 ID</a>
						</li>
						<li>
							<a data-slide-index="1" href="javascript:;">검색</a>
						</li>
						<li>
							<a data-slide-index="2" href="javascript:;">개인화</a>
						</li>
						<li>
							<a data-slide-index="3" href="javascript:;">구매</a>
						</li>
					</ul>
				</div>
				<div class="uci_pc">
					<ul class="bxslider">
						<li class="uci_img1">
							<img src="images/uci/uci_img1.png" alt="사진ID" />
						</li>
						<li class="uci_img2">
							<img src="images/uci/uci_img2.png" alt="검색" />
						</li>
						<li class="uci_img3">
							<img src="images/uci/uci_img3.png" alt="개인화" />
						</li>
						<li class="uci_img4">
							<img src="images/uci/uci_img4.png" alt="구매" />
						</li>
					</ul>
				</div>
			</section>
			<section class="uci_sec3">
				<h4>다하미는 UCI 등록관리기관입니다.</h4>
				<p>
					UCI는 전자출판물, 디지털음원, 영화/방송 영상 등 다양한 분야에 적용되고 있습니다.
					<br />
					㈜다하미커뮤니케이션즈는 UCI 총괄기구인 한국저작권위원회에 의해 2016년 언론사 보도사진 분야의 UCI 등록관리기관으로 지정되었습니다.
					<br />
					등록관리기관은 디지털 콘텐츠 등록자로부터 콘텐츠에 대한 식별정보를 등록 받고, 해당 콘텐츠에 UCI를 발급하는 업무를 수행하는 기관을 말합니다.
					<br />
				</p>
				<div class="uci_list">
					<h3>등록관리기관의 역할</h3>
					<ul>
						<li>- 등록자 승인, 등록자 코드발급 등 등록자 관리</li>
						<li>- 메타데이터의 등록, 식별자 발급 및 유지 관리</li>
						<li>- 식별메타데이터의 총괄기구로의 전송</li>
						<li>- 식별자와 함께 관리되는 URL(Uniform Resource Locator) 정보의 유효성 확인</li>
						<li>- 총괄시스템과의 연계, 응용서비스 개발 및 서비스</li>
						<li>- 기타 등록관리 업무와 관련하여 수행할 필요가 있는 업무</li>
					</ul>
				</div>
				<div class="uci_img_regi">
					<img src="images/uci/uci_img_regi.png" alt="등록기관지정서" />
				</div>
			</section>
			<section class="uci_sec4">
				<h4>UCI는 디지털 콘텐츠 유통을 원활하게 합니다.</h4>
				<p>
					UCI는 디지털 콘텐츠에 유일한 코드를 부여하는 국가표준 식별체계로, 식별 범위는 국내 지역에 한정되지 않고 전 세계적입니다.
					<br />
					<br />
					디지털 콘텐츠의 생성/관리/서비스 방식이 기관 내에서 기관 간으로 변화하고 있는 요즘 환경에서는 식별체계 간 연계가 필요하고 중요합니다.
					<br />
					UCI는 기존 식별자인 ISBN, ISSN, ISAN, DOI 등을 수용할 수 있는 구조로 정의되어 호환성이 있고, URL이나 다른 연결 정보로 변환이 가능합니다.
					<br />
					<br />
					구문구조/메타데이터/운영절차/운영시스템 네 요소가 유기적으로 결합된 UCI는 자원의 유통 기반 역할을 수행하게 되며
					<br />
					유통내역 추적, 거래인증, 참조연계서비스 등 온라인과 오프라인 구분 없이 실질적인 활용분야에 다양하게 적용됩니다.
			</section>
		</div>
		<%@include file="footer.jsp"%>
	</div>
</body>
</html>