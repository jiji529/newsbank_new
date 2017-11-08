<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : file_name
  @author   : CHOI, SEONG HYEON
  @date     : 2017. 10. 19.
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 19.   	  tealight        file_name
---------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<link rel="stylesheet" href="css/join.css" />
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script type="text/javascript" src="js/join.js"></script> 
</head>

<body>
	<div class="wrap">
		<header>
		<a href="/home" class="logo">
				<h1>뉴스뱅크</h1>
			</a>
		</header>
		<section class="join">
		<ul class="navi">
			<li class="">종류 선택</li>
			<li class="selected">약관 동의</li>
			<li>정보 입력</li>
			<li>가입 완료</li>
		</ul>
		<div class="wrap_tit">
			<h3 class="tit_join">가입 약관 동의</h3>
			<div class="txt_desc">
				저작물 이용 약관 및 개인정보 처리방침에
				<b>동의</b>
				해 주세요.
			</div>
		</div>
		<form id="frmJoinTerms" name="frmJoinTerms">
		<input type="hidden" name="type" value="${type }" />
			<fieldset>
				<legend class="blind">저작물 이용 약관 및 개인정보 처리방침에 대한 동의</legend>
				<div class="join_box">
					<h5 class="box_tit">저작물 이용약관</h5>
					<div class="box_cont">
						<p>
							본 약관에 대한 동의는 ㈜다하미커뮤니케이션즈(이하 ‘회사’라 한다)가 제공하는 사진 저작물(이하 ‘이미지’라 한다)을 이용하는 모든 자(이하 ‘이용자’라 한다)와의 계약 체결과 동일한 효력을 가지게 됩니다.
							<br />
						</p>
						<p>제1조(목적)</p>
						<p>
							이 약관은 (주)다하미커뮤니케이션즈가 뉴스뱅크(http://www.newsbank.co.kr)사이트 등을 통해 제공하는 이미지를 이용함에 있어 이용자의 권리, 의무, 책임사항을 규정함을 목적으로 합니다.
							<br />
						</p>
						<p>제2조(용어 정의)</p>
						<p>
							1. ‘뉴스뱅크’란 사진, 그래픽, 일러스트레이션 등 이미지 콘텐츠를 온라인으로 게시하고 이를 판매할 수 있도록 한 영업장을 말합니다.
							<br />
							2. ‘이용자’란 뉴스뱅크에 접속하여 이 약관에 따라 뉴스뱅크가 제공하는 각종 이미지를 이용하는 회원 및 비회원을 말합니다.
							<br />
							3. ‘회원’이란 뉴스뱅크가 정한 약관에 동의한 후 회원가입을 신청해 회원ID를 받은 사람을 말합니다.
							<br />
							4. ‘영리목적 이용’이란 상업적 이익이나 금전적인 대가를 주된 목적으로 저작물을 이용하는 것은 물론 영리 목적 행위에 간접적으로 저작물을 이용하는 것을 지칭합니다. 또한 저작물을 이용해 편집저작물을 작성하거나 데이터베이스로 제작해 이를 영리목적에 직접적 또는 간접적으로 이용하는 경우도 영리목적 이용에 해당됩니다.
							<br />
							5. ‘2차적 저작’이란 뉴스뱅크가 제공하는 저작물을 변형, 각색, 번역, 영상제작 등의 방법으로 제2의 창작물을 만드는 행위를 말합니다.(예: 사진으로 슬라이드 쇼를 만들거나 영상제작에 활용하는 것 등입니다.)
							<br />
						</p>
						<p>제3조 (약관의 명시와 개정)</p>
						<p>
							1. 회사는 합리적 사유가 발생했을 경우 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
							<br />
							2. 회사는 약관을 개정할 경우에는 적용일자 및 개정사유를 초기화면에 공지합니다.
							<br />
							3. 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 관계 법령 또는 상거래 관례에 따릅니다.
							<br />
						</p>
						<p>제4조 (회원가입과 관리)</p>
						<p>
							1. 이용자는 회사가 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로써 회원가입을 신청합니다.
							<br />
							2. 회원은 필요시 탈퇴를 요청할 수 있으며, 회사는 회원의 탈퇴 요청을 받아 회원 탈퇴의 처리를 합니다.
							<br />
							3. 회원은 뉴스뱅크 사이트의 각종 이미지를 이용하거나 구매하는 ‘일반회원’과 각종 이미지를 판매하는 ‘판매회원’으로 구분하며, 일반회원은 기관, 단체, 회사명으로 가입하는 법인회원과 개인명의로 가입하는 개인회원으로 다시 각각 구분합니다.
							<br />
							4. 회원은 등록사항에 변경이 있는 경우, 뉴스뱅크 사이트를 통해 그 변경사항을 회사에 알려야 합니다.
							<br />
							5. 회원이 다음 각 호의 사유에 해당하는 경우, 회사는 회원자격을 제한 또는 상실시킬 수 있습니다.
							<br />
							1) 가입 신청 시에 허위 내용을 등록한 경우
							<br />
							2) 뉴스뱅크를 부정한 목적으로 사용하여 개인 또는 단체의 명예를 훼손 하였거나 경제적 정신적 피해를 주었을 경우
							<br />
						</p>
						<p>제5조 (서비스의 중단)</p>
						<p>
							회사는 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.
							<br />
						</p>
						<p>제6조 (구매대금 결제)</p>
						<p>
							뉴스뱅크에서 구매한 이미지에 대한 대금지급방법은 다음과 같습니다.
							<br />
							① 신용카드 결제
							<br />
							② 온라인 무통장입금
							<br />
							③ 자동이체
							<br />
						</p>
						<p>제7조 (회사의 의무)</p>
						<p>
							1. 회사는 본 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스 제공하는데 최선을 다해야 합니다.
							<br />
							2. 회사는 원활한 서비스를 위해 최적의 상태로 시스템을 유지, 보수하여야 하며 장애 발생 시 즉각 대처하여 서비스에 불편이 없도록 해야 합니다.
							<br />
						</p>
						<p>제8조 (회원의 ID 및 비밀번호에 대한 의무)</p>
						<p>
							1. ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.
							<br />
							2. 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안 됩니다.
							<br />
							3. 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 즉시 회사에 통보함으로써 회사가 이에 대한 조치를 취할 수 있도록 해야 합니다.
							<br />
						</p>
						<p>제9조 (저작권 및 제반 권리)</p>
						<p>
							1. 회사는 뉴스뱅크 사이트를 통해 게시한 모든 이미지에 대한 저작권은 본 서비스의 판매회원으로 가입한 해당 이미지의 제공법인 또는 개인에게 있습니다.
							<br />
							2. 회사는 판매회원이 제공한 이미지의 피사체에 대한 초상권, 상표권, 특허권, 등 제반 권리를 가지고 있지 않습니다.
							<br />
							3. 이용자가 회사가 제공하는 이미지를 사용할 경우 저작권, 피사체에 대한 초상권, 상표권 등 기타권리는 이용자 자신이 취득하여야 하며, 만일 이들 권리에 대한 분쟁이 발생할 경우 이용자에게 모든 책임이 있습니다.
							<br />
							4. 이용자가 본 계약에 따른 의무사항을 위반할 경우 이용허락계약은 자동 종료되며, 이용자는 즉시 모든 형태의 저작물 이용을 중단해야 합니다.
							<br />
						</p>
						<p>제10조 (이미지 구매 시 사용범위와 제한사항)</p>
						<p>
							1. 이용자는 회사가 뉴스뱅크를 통해 제공한 이미지를 구입하여 광고, 출판, 전자출판, 판촉, 홍보 등의 목적으로 사용할 수 있습니다.
							<br />
							2. 언론사 보도사진의 사용요금은 1회 구매 시 1용도, 1매체, 1광고주에 한해서 적용됩니다.
							<br />
							3. 언론사 보도사진의 사용기간은 일반적으로 1년으로 제한되며, 사용기간을 연장하여 사용할 경우 지정된 추가요금을 지불하고 라이선스 기간을 연장하여야 합니다. 사용자가 라이선스의 기간을 연장하지 않은 경우 계약이 자동적으로 종료됩니다.
							<br />
							4. 언론사 보도사진을 사용 허가된 이미지의 사용범위 이외의 목적으로 이미지를 사용하고자 할 경우 회사에 사전 통보하여 규정된 추가요금을 지불하고 사용하여야 합니다. 만일 사전 통보 없이 변칙적으로 사용한 사실이 인정되었을 경우 회사는 이에 대한 추징금을 부과할 수 있습니다.
							<br />
							5. 상업사진은 1회 구매 시 사용용도와 사용기간에 제한이 없습니다.
							<br />
							5. 이용자가 이미지를 구매한 후에는 제3자에게 판매, 대여, 배포, 양도, 전송, 복제할 수 없으며, 이미지를 불법으로 사용한 경우 저작권법에 의거하여 민ㆍ형사상의 책임을 져야 합니다.
							<br />
							6. 이용자는 이 라이선스의 조건을 위반하는 방법으로 저작물에 대한 접근이나 이용을 통제하는 기술적 보호조치를 하여 저작물을 복제, 공연, 방송, 전송, 전시 또는 배포할 수 없습니다.
							<br />
							7. 이미지의 사용에 있어서 외설적이거나 타인에 대한 명예손 등 일반 정서에 반하는 용도 및 범죄를 목적으로 한 용도로의 사용을 금지합니다.
							<br />
							8. 이미지를 사용할 때 반드시 저작권자 표시(이미지 제공사 혹은 사진작가)를 기재하여야 합니다.
							<br />
							9. 이용자는 이미지 저작물에 대해 단순한 크기조절 외에 임의로 그 형태를 변형, 합성, 왜곡할 수 없습니다.
							<br />
						</p>
						<p>제11조 (분쟁의 해결)</p>
						<p>
							1. 회사와 이용자간에 발생한 전자거래 분쟁에 관한 소송은 서울중앙법원에 제기할 수 있습니다.
							<br />
							2. 회사와 이용자간에 제기된 전자거래 소송에는 대한민국 법을 적용받습니다.
							<br />
							3. 이 약관에 명시되지 않은 사항은 관계법령과 상관례에 따릅니다.
						</p>
						<p>&nbsp;</p>
						<p>부칙</p>
						<p>제 1 조 (적용일자)</p>
						<p>
							1. 이 약관은 2016년 3월 1일부터 적용됩니다.
							<br />
							2. 2007년 2월 1일부터 시행되던 종전의 약관은 본 약관으로 대체합니다.
						</p>
					</div>
					<div class="wrap_check">
						<input id="copyAgree" name="copyAgree" type="checkbox" title="저작물 이용 약관에 동의합니다." />
						<label for="copyAgree">개인정보 처리 방침에 동의합니다.</label>
					</div>
				</div>
				<div class="join_box">
					<h5 class="box_tit">개인정보처리방침</h5>
					<div class="box_cont">
						<p>뉴스뱅크 개인정보 취급방침</p>
						<p>(주)다하미커뮤니케이션즈(이하 '회사')는 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다. 회사는 개인정보처리방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.</p>
						<p>○ 본 방침은 2017년 10월 10일부터 시행됩니다.</p>
						<p>
							1. 개인정보의 처리 목적
							<br />
							회사는 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적 이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.
							<br />
							1) 홈페이지 회원가입 및 관리 회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 처리합니다.
							<br />
							2) 민원사무 처리 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등을 목적으로 개인정보를 처리합니다.
							<br />
							3) 재화 또는 서비스 제공 서비스 제공, 콘텐츠 제공, 본인인증, 연령인증, 요금결제·정산 등을 목적으로 개인정보를 처리합니다.
							<br />
							4) 마케팅 및 광고에의 활용 신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.
						</p>
						<p>
							2. 개인정보 파일 현황
							<br />
							1) 개인정보 파일명: 개인정보처리방침(뉴스뱅크)
							<br />
							- 개인정보 항목: 로그인ID, 비밀번호, 이메일, 이름, 휴대전화번호, 회사명, 회사전화번호, 회사 대표자명, 회사 주소, 신용카드정보, 은행계좌정보, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록
							<br />
							- 수집방법: 홈페이지, 서면양식, 전화/팩스
							<br />
							- 보유근거: 관련법령에 따름
							<br />
							- 보유기간: 5 년
							<br />
							- 관련법령:
							<br />
							? 소비자의 불만 또는 분쟁처리에 관한 기록 3 년
							<br />
							? 대금결제 및 재화 등의 공급에 관한 기록 5년
						</p>
						<p>
							3. 개인정보의 처리 및 보유 기간
							<br />
							원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.
						</p>
						<p>
							4. 개인정보의 제3 자 제공에 관한 사항
							<br />
							회사는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.
							<br />
							- 이용자들이 사전에 동의한 경우
							<br />
							- 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우
						</p>
						<p>
							5. 개인정보처리 위탁
							<br />
							회사는 회원의 동의 없이 회원 정보를 외부 업체에 위탁하지 않습니다. 서비스 제공을 위하여 필요한 업무 중 일부를 아래 업체에 위탁하고 있으며, 위탁받은 업체는 정보통신망법에 따라 개인정보를 안전하게 처리하도록 필요한 사항을 규정/시행하고 있습니다.
							<br />
							- 제공목적: 결제처리
							<br />
							- 제공받는 자: LG유플러스
							<br />
							- 제공정보: 결제정보, 접속 IP 정보
							<br />
							- 보유 및 이용기간: 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. (단, 다른 법령에 특별한 규정이 있을 경우 관련 법령에 따라 보관)
						</p>
						<p>
							6. 개인정보 자동 수집 장치의 설치·운영 및 거부에 관한 사항
							<br />
							이용자 개개인에게 개인화되고 맞춤화된 서비스를 제공하기 위해서 회사는 이용자의 정보를 저장하고 수시로 불러오는 '쿠키(cookie)'를 사용합니다. 쿠키는 웹사이트를 운영하는데 이용되는 서버가 사용자의 브라우저에게 보내는 조그마한 데이터 꾸러미로 이용자 컴퓨터의 하드디스크에 저장됩니다.
							<br />
							1) 쿠키의 사용 목적
							<br />
							로그인 편의를 위한 아이디 정보 1주일 저장, 이메일 인증을 위한 이메일 주소 및 이메일 인증 코드, 팝업 오늘 하루동안 이창을 열지않음 체크값 당일 하루 저장
							<br />
							2) 쿠키 설정 거부 방법
							<br />
							이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서, 이용자는 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다.
							<br />
							* 설정방법 예(인터넷 익스플로러의 경우)
							<br />
							: 웹 브라우저 상단의 도구 &gt; 인터넷 옵션 &gt; 개인정보 (단, 쿠키 설치를 거부하였을 경우 로그인이 필요한 일부 서비스의 이용이 어려울 수 있습니다.)
						</p>
						<p>
							7. 이용자 권리와 그 행사방법
							<br />
							이용자는 언제든지 등록되어 있는 자신 혹은 당해 위탁자의 개인정보를 조회하거나 수정할 수 있습니다. 이용자의 개인정보 조회 및 수정을 위해서는 “마이페이지 &gt; 계정관리”를 클릭하여 직접 열람 및 정정이 가능합니다. 가입해지(회원탈퇴)를 위해서는 서비스 담당자에게 이메일로 회원 아이디와 이름, 연락처를 적어 보내주시면 확인 즉시 처리해드리겠습니다. 또는 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체없이 조치하겠습니다. 귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 이용자의 요청에 의해 해지 또는 삭제된 개인정보는 “개인정보의 보유 및 이용기간”에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.
						</p>
						<p>
							8. 처리하는 개인정보의 항목 작성
							<br />
							회사는 다음의 개인정보 항목을 처리하고 있습니다.
							<br />
							&lt;홈페이지 회원가입 및 관리&gt;
							<br />
							- 필수항목: 로그인 ID, 비밀번호, 이메일, 이름, 휴대전화번호,
							<br />
							- 선택항목: 회사명, 사업자등록번호, 담당자 이름, 담당자 연락처
							<br />
							&lt;홈페이지 결제&gt;
							<br />
							- 필수항목: 로그인ID, 이름, 이메일, 휴대전화번호, 회사명, 회사전화번호, 신용카드정보, 은행계좌정보, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록
							<br />
							&lt;오프라인 결제&gt;
							<br />
							- 필수항목: 회사명, 대표자명, 사업자등록번호, 주소, 사업자등록증, 담당자 이름, 담당자 연락처, 담당자 이메일
						</p>
						<p>
							9. 개인정보의 파기
							<br />
							회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.
							<br />
							- 파기절차: 이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고는 다른 목적으로 이용되지 않습니다.
							<br />
							- 파기기한: 이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.
							<br />
							- 파기방법: 전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다. 종이에 출력된 개인정보는 분쇄기로 분쇄하여 파기합니다.
						</p>
						<p>
							10. 개인정보의 안전성 확보 조치
							<br />
							회사는 개인정보보호법 제 29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.
							<br />
							1) 개인정보 취급 직원의 최소화 및 교육: 개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.
							<br />
							2) 개인정보의 암호화: 이용자의 개인정보(비밀번호)는 암호화 되어 저장 및 관리되고 있어 본인만이 알 수 있으며, 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.
							<br />
							3) 개인정보에 대한 접근 제한: 개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여, 변경, 말소를 통하여 개인정보에 대한 접근통제를 위한 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.
						</p>
						<p>
							11. 개인정보 보호책임자
							<br />
							회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
							<br />
							&lt;개인정보 보호책임자 신태범 부사장&gt;
						</p>
						<p>
							- 개인정보 보호 담당부서: 기술개발연구소
							<br />
							- 담당자: 최고운
							<br />
							- 연락처: 02-593-4174, gwchoi@dahami.com
							<br />
							서비스를 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 회사는 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.
						</p>
						<p>
							12. 개인정보 처리방침 변경
							<br />
							이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.
						</p>
					</div>
					<div class="wrap_check">
						<input id="policyAgree" name="policyAgree" type="checkbox" title="개인정보 처리 방침에 동의합니다." />
						<label for="policyAgree" class="chk">개인정보 처리 방침에 동의합니다.</label>
					</div>
				</div>
				<div class="wrap_btn">
					<button type="button" class="btn_cancel" onClick="top.location.href='/home'">비동의</button>
					<button type="submit" class="btn_agree">동의하기</button>
				</div>
			</fieldset>
		</form>
		</section>
		<footer>
		<ul>
			<li>
				<a href="#">뉴스뱅크 소개</a>
			</li>
			<li class="bar"></li>
			<li>
				<a href="#">이용약관</a>
			</li>
			<li class="bar"></li>
			<li>
				<a href="#">개인정보처리방침</a>
			</li>
		</ul>
		<div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
		</footer>
	</div>
</body>
</html>
