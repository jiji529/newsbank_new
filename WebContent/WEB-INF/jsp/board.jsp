<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 11. 07. 오후 04:02:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 25.   hoyadev        board
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script type="text/javascript">
	//공지사항 클릭시 반응
	function evt(newwin){
		var objid=document.getElementById(newwin);
		
		//class='on'
		if(objid.style.display=="block")
		{
		  objid.style.display="none";
		  $("#faq dt").removeClass();
		}
		else{
		  $('#faq dd').css('display','none');
		  $("#faq dt").removeClass();
		  objid.style.display="block";
		  //$("#dt"+newwin).addClass("on");
		  $(newwin).addClass("on");
		}
	}

</script>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/footer.js"></script>
</head>
<body>
	<div class="wrap">
		<nav class="gnb_dark">
			<div class="gnb"><a href="#" class="logo"></a>
				<ul class="gnb_left">
					<li class=""><a href="#">보도사진</a></li>
					<li><a href="#">뮤지엄</a></li>
					<li><a href="#">사진</a></li>
					<li><a href="#">컬렉션</a></li>
				</ul>
				<ul class="gnb_right">
					<li><a href="#">로그인</a></li>
					<li><a href="#">가입하기</a></li>
				</ul>
			</div>
			<div class="gnb_srch">
				<form id="searchform">
					<input type="text" value="검색어를 입력하세요" />
					<a href="#" class="btn_search">검색</a>
				</form>
			</div>
		</nav>
		<section class="mypage">
			<div class="head">
				<h2>이용안내</h2>
				<p>뉴스뱅크 사이트에 관하여 알려드립니다.</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1 use">
					<li><a href="#">구매안내</a></li>
					<li class="on"><a href="noti.html">공지사항</a></li>
					<li><a href="faq.html">FAQ</a></li>
					<li><a href="call.html">직접 문의하기</a></li>
					<li><a href="sitemap.html">사이트맵</a></li>
				</ul>
			</div>
			<div class="table_head">
				<h3>공지사항</h3>
				<div class="cms_search">공지사항 검색
					<input type="text" />
					<button>검색</button>
				</div>
			</div>
			<div class="faq">
				<dl>
					<dt class="on"><a onClick="evt('0')"><span class="faq_tit noti">개인정보처리방침이 개정되었습니다.</span><span class="faq_date">2017.09.29</span><span class="faq_ico"></span></a></dt>
					<dd id="0" style="display: block;">
						<p>안녕하세요. 뉴스뱅크를 이용해 주시는 고객님께 감사드립니다.<br />
							'개인정보처리방침' 내용이 변경되어 2017년 10월 10일자로 새롭게 시행되기에 안내 드립니다. 변경된 내용 확인하시어 서비스 이용에 불편함이 없으시길 바랍니다.<br />
							앞으로도 보다 나은 서비스 제공을 위해 노력하겠습니다. 감사합니다.<br />
							<br />
							※ 주요 개정 사항: 회사 개인정보처리방침에 따라 전면 개정<br />
							상세 내용은 아래와 같습니다.<br />
							<br />
							- 아래 -<br />
							1.개인정보의 처리 목적 <br />
							회사는 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적 이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.<br />
							1)홈페이지 회원가입 및 관리 회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 처리합니다.<br />
							2)민원사무 처리 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등을 목적으로 개인정보를 처리합니다.<br />
							3)재화 또는 서비스 제공 서비스 제공, 콘텐츠 제공, 본인인증, 연령인증, 요금결제·정산 등을 목적으로 개인정보를 처리합니다.<br />
							4)마케팅 및 광고에의 활용 신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.<br />
							<br />
							2.개인정보 파일 현황 <br />
							1)개인정보 파일명: 개인정보처리방침(뉴스뱅크) <br />
							-개인정보 항목: 로그인ID, 비밀번호, 이메일, 이름, 휴대전화번호, 회사명, 회사전화번호, 회사 대표자명, 회사 주소, 신용카드정보, 은행계좌정보, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록<br />
							-수집방법: 홈페이지, 서면양식, 전화/팩스 <br />
							-보유근거: 관련법령에 따름<br />
							-보유기간: 5 년 <br />
							-관련법령: <br />
							?소비자의 불만 또는 분쟁처리에 관한 기록 3 년<br />
							?대금결제 및 재화 등의 공급에 관한 기록 5년<br />
							<br />
							3.개인정보의 처리 및 보유 기간 <br />
							원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.<br />
							<br />
							4.개인정보의 제3 자 제공에 관한 사항 <br />
							회사는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다. <br />
							-이용자들이 사전에 동의한 경우<br />
							-법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우<br />
							<br />
							5.개인정보처리 위탁 <br />
							회사는 회원의 동의 없이 회원 정보를 외부 업체에 위탁하지 않습니다. 향후 그러한 필요가 생길 경우, 위탁 대상자와 위탁 업무 내용에 대해 통지하고 필요한 경우 사전 동의를 받겠습니다.<br />
							<br />
							6.이용자 및 법정대리인의 권리와 그 행사방법 <br />
							이용자 및 법정 대리인은 언제든지 등록되어 있는 자신 혹은 당해 위탁자의 개인정보를 조회하거나 수정할 수 있습니다. 이용자 혹은 위탁자의 개인정보 조회 및 수정을 위해서는 “마이페이지 &gt; 계정관리”를 클릭하여 직접 열람 및 정정이 가능합니다. 가입해지(회원탈퇴)를 위해서는 서비스 담당자에게 이메일로 회원 아이디와 이름, 연락처를 적어 보내주시면 확인 즉시 처리해드리겠습니다. 또는 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체없이 조치하겠습니다. 귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 이용자 혹은 법정 대리인의 요청에 의해 해지 또는 삭제된 개인정보는 “개인정보의 보유 및 이용기간”에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다. <br />
							<br />
							7.처리하는 개인정보의 항목 작성<br />
							회사는 다음의 개인정보 항목을 처리하고 있습니다. <br />
							&lt;홈페이지 회원가입 및 관리&gt; <br />
							-필수항목: 로그인 ID, 비밀번호, 이메일, 이름, 휴대전화번호, <br />
							-선택항목: 회사명, 사업자등록번호, 담당자 이름, 담당자 연락처<br />
							&lt;홈페이지 결제&gt;<br />
							-필수항목: 로그인ID, 이름, 이메일, 휴대전화번호, 회사명, 회사전화번호, 신용카드정보, 은행계좌정보, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록<br />
							&lt;오프라인 결제&gt;<br />
							-필수항목: 회사명, 대표자명, 사업자등록번호, 주소, 사업자등록증, 담당자 이름, 담당자 연락처, 담당자 이메일<br />
							<br />
							8.개인정보의 파기 <br />
							회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다. <br />
							-파기절차: 이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고는 다른 목적으로 이용되지 않습니다. <br />
							-파기기한: 이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다. <br />
							-파기방법: 전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다. 종이에 출력된 개인정보는 분쇄기로 분쇄하여 파기합니다. <br />
							<br />
							9.개인정보의 안전성 확보 조치 <br />
							회사는 개인정보보호법 제 29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다. <br />
							1)개인정보 취급 직원의 최소화 및 교육: 개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다. <br />
							2)개인정보의 암호화: 이용자의 개인정보(비밀번호)는 암호화 되어 저장 및 관리되고 있어 본인만이 알 수 있으며, 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다. <br />
							3)개인정보에 대한 접근 제한: 개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여, 변경, 말소를 통하여 개인정보에 대한 접근통제를 위한 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.<br />
							<br />
							10.개인정보 보호책임자 <br />
							회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다. <br />
							&lt;개인정보 보호책임자 신태범 소장&gt;<br />
							- 개인정보 보호 담당부서: 기술개발연구소<br />
							- 담당자: 최고운<br />
							- 연락처: 02-593-4174, gwchoi@dahami.com<br />
							서비스를 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 회사는 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.<br />
							<br />
							11.개인정보 처리방침 변경 <br />
							이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.<br />
							<br />
							-끝-</p>
					</dd>
					<dt><a onClick="evt('2')"><span class="faq_tit noti"> 경향신문 보도사진 신규 추가 안내</span><span class="faq_date">2017.09.29</span><span class="faq_ico"></span></a></dt>
					<dd id="2">
						<p></p>
					</dd>
					<dt><a onClick="evt('3')"><span class="faq_tit noti"> 뉴스뱅크 홈페이지 개편 안내</span><span class="faq_date">2017.09.29</span><span class="faq_ico"></span></a></dt>
					<dd id="3">
						<p></p>
					</dd>
					<dt><a onClick="evt('4')"><span class="faq_tit noti"> 신용카드 구매 시 세금계산서 발행 관련 안내</span><span class="faq_date">2017.09.29</span><span class="faq_ico"></span></a></dt>
					<dd id="4">
						<p></p>
					</dd>
					<dt><a onClick="evt('5')"><span class="faq_tit noti">세금계산서 발행 관련 안내</span><span class="faq_date">2017.09.29</span><span class="faq_ico"></span></a></dt>
					<dd id="5">
						<p></p>
					</dd>
				</dl>
				<!-- 나중에 쓸수도 있어요 지금 어차피 faq 11개라 그냥 가려놔도 될거같아요
				<div class="paging">
					<ul>
						<li class="first"> <a href="#">첫 페이지</a> </li>
						<li class="prev"> <a href="#">이전 페이지</a> </li>
						<li> <a href="#">1</a> </li>
						<li class="active"> <a href="#">2</a> </li>
						<li> <a href="#">3</a> </li>
						<li> <a href="#">4</a> </li>
						<li> <a href="#">5</a> </li>
						<li> <a href="#">6</a> </li>
						<li> <a href="#">7</a> </li>
						<li> <a href="#">8</a> </li>
						<li> <a href="#">9</a> </li>
						<li> <a href="#">10</a> </li>
						<li class="next"> <a href="#"> 다음 페이지 </a> </li>
						<li class="last"> <a href="#"> 마지막 페이지 </a> </li>
					</ul>
				</div> -->
			</div>
		</section>
	</div>
</body>
</html>
