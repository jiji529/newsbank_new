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


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>NYT 뉴스뱅크-개인정보처리방침</title>
	<script src="js/nyt/jquery-1.12.4.min.js"></script>
	<link rel="stylesheet" href="css/nyt/base.css" />
	<link rel="stylesheet" href="css/nyt/sub.css" />
	<link rel="stylesheet" href="css/nyt/mypage.css" />
	<script src="js/nyt/footer.js"></script>
	<script type="text/javascript">
		// 이전 개인정보처리 방침
		function past_privacy(url) {
			if (url.length != 0)
				window.open(url, "뉴스뱅크 개인정보 처리방침");
		}
	</script>
</head>

<body>
	<div class="wrap">
		<%@include file="common/headerKR2.jsp"%>
		<section class="mypage">
			<div class="head">
				<h2>법적고지</h2>
				<p>홈페이지 이용에 있어 법적 제한에 대하여 알려드립니다.</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1 cs">
					<li><a href="/policy.intro">이용약관</a></li>
					<li class="on"><a href="/privacy.intro">개인정보처리방침</a></li>
				</ul>
			</div>
			<div class="table_head">
				<h3>개인정보 처리방침</h3>
			</div>
			<div class="policy_wrap">
				<section class="policy_top">
					<p>
						주식회사 다하미커뮤니케이션즈는(이하 ‘회사’) 회사가 제공하는 스크랩마스터 및 클리핑온, T-Paper, 뉴스뱅크,
						e-NIE, 뉴스플라자, 뉴스콕, 초판 등의 서비스를 이용하는 이용자의 개인정보를 매우 소중하게 생각하고 있으며,
						이용자 개인정보를 보호하기 위하여 최선의 노력을 다하고 있습니다.<br /> 회사는 개인정보보호법에 따라 이용자의
						개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 『개인정보 보호법』,
						『정보통신망 이용촉진 및 정보보호 등에 관한 법률』을 비롯한 모든 개인정보보호 관련 법률규정을 준수하고 있으며, 아래와
						같은 개인정보처리방침을 두고 있습니다. 회사는 개인정보처리방침을 회사 홈페이지 첫 화면에 항상 공개하고, 이를 개정하는
						경우 웹사이트 새소식(또는 개별공지)을 통하여 공지할 것입니다.<br /> 회사의 개인정보처리방침은 다음과 같은
						내용을 담고 있습니다.
					</p>
					<section class="section_go">
						<ol>
							<li><a href="#rule1">제1조 개인정보의 수집에 대한 동의 및 수집 방법</a></li>
							<li><a href="#rule2">제2조 개인정보의 수집항목 및 수집∙이용 목적</a></li>
							<li><a href="#rule3">제3조 개인정보의 제공</a></li>
							<li><a href="#rule4">제4조 개인정보의 취급위탁</a></li>
							<li><a href="#rule5">제5조 개인정보의 보유∙이용 기간, 파기 절차 및 파기 방법</a></li>
							<li><a href="#rule6">제6조 개인정보 보호업무 및 관련 고충사항 처리 부서</a></li>
							<li><a href="#rule7">제7조 개인정보 자동수집 장치에 의한 개인정보 수집</a></li>
							<li><a href="#rule8">제8조 개인정보의 열람 및 정정 등</a></li>
							<li><a href="#rule9">제9조 개인정보 수집ㆍ이용ㆍ제공에 대한 동의 철회</a></li>
							<li><a href="#rule10">제10조 개인정보보호를 위한 관리적∙기술적∙물리적 대책</a></li>
							<li><a href="#rule11">제11조 이용자 및 법정대리인의 권리와 그 행사방법</a></li>
							<li><a href="#rule12">제12조 보호정책 변경시 공지의무</a></li>
						</ol>
					</section>
				</section>
				<section class="policy_cont" id="rule1">
					<h4>제1조 (개인정보의 수집에 대한 동의 및 수집 방법)</h4>
					<ol>
						<li>회사는 회사가 운영하는 서비스 및 서비스별 인터넷 사이트를 통합하지 않고 각각 독립적으로 운영합니다.
							따라서 이용자가 서면 양식이나 전화/팩스를 통해 서비스 이용 계약을 하거나 서비스 사이트에 회원 가입을 할 때
							서비스별로 수집하는 개인정보 항목을 확인하고 이에 대해 동의하는 경우에 한해 각 서비스를 제공합니다.</li>
						<li>이용자는 회사가 회사의 개인정보처리방침에 따라 이용자의 개인정보를 수집함에 대하여 동의 여부를 표시하는
							방법으로 동의할 수 있습니다. 이용자가 동의 부분에 표시하면 해당 개인정보 수집에 대해 동의한 것으로 봅니다.</li>
						<li>‘회원’이라 함은 회사에게 개인정보를 제공하여 회원 등록을 하는 방법으로 회원 가입된 이용자를
							의미합니다.</li>
						<li>‘비회원’이라 함은 회사의 사이트 등에 회원 가입을 하지 않고, 회사가 제공하는 서비스를 이용하는 자를
							말합니다.</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule2">
					<h4>제2조 (개인정보의 수집항목 및 수집∙이용 목적)</h4>
					<ol>
						<li>회사는 이용자의 회원 가입 시 서비스 제공을 위해 필요한 최소한의 개인정보를 수집하고 있습니다. 다만,
							이용자들에게 보다 양질의 맞춤 서비스를 제공하기 위하여 이용자의 추가적인 개인정보를 선택적으로 입력 받고 있습니다.</li>
						<li>회사는 이용자의 명시적인 별도 동의 없이 기본적 인권 침해의 우려가 있는 사상 • 신념, 노동조합 •
							정당의 가입 • 탈퇴, 정치적 견해, 건강, 성생활, 과거의 병력, 종교, 출신지, 범죄기록 등 민감한 개인정보는
							수집하지 않습니다.</li>
						<li>회사가 회원가입 시 수집하는 개인정보 항목과 그 수집 • 이용의 주된 목적은 아래 표와 같습니다.
							<h5>개인정보 수집항목</h5>
							<table border="0" cellspacing="0" cellpadding="0" width="100%">
								<tr>
									<th width="113" valign="top">서비스</th>
									<th width="246" valign="top">필수 항목</th>
									<th width="246" valign="top">선택 항목</th>
								</tr>
								<tr>
									<td width="113" valign="top">다하미 홈페이지</td>
									<td width="246" valign="top">성명, 연락처, 이메일</td>
									<td width="246" valign="top">&nbsp;</td>
								</tr>
								<tr>
									<td width="113" valign="top">스크랩마스터 <br /> (개인회원)
									</td>
									<td width="246" valign="top">아이디, 비밀번호, 성명, 이메일, 전화번호,
										휴대폰, 주소, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록</td>
									<td width="246" valign="top">신용카드정보, 은행계좌정보,</td>
								</tr>
								<tr>
									<td width="113" valign="top">스크랩마스터 <br /> (법인회원)
									</td>
									<td width="246" valign="top">아이디, 비밀번호, 회사명, 사업자등록번호,
										대표자명, 회사주소, 전화번호, 담당자성명, 담당자전화번호, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP
										정보, 결제기록</td>
									<td width="246" valign="top">팩스번호, 직급, 부서, 이메일, 신용카드정보,
										은행계좌정보,</td>
								</tr>
								<tr>
									<td width="113" valign="top">클리핑온</td>
									<td width="246" valign="top">아이디, 비밀번호, 회사명, 사업자등록번호,
										대표자명, 회사주소, 전화번호, 담당자성명, 담당자전화번호, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP
										정보, 결제기록</td>
									<td width="246" valign="top">팩스번호, 직급, 부서, 이메일, 신용카드정보,
										은행계좌정보,</td>
								</tr>
								<tr>
									<td width="113" valign="top">T-Paper</td>
									<td width="246" valign="top">아이디, 비밀번호, 회사명, 사업자등록번호,
										대표자명, 회사주소, 전화번호, 담당자성명, 담당자전화번호, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP
										정보, 결제기록</td>
									<td width="246" valign="top">팩스번호, 직급, 부서, 이메일, 신용카드정보,
										은행계좌정보,</td>
								</tr>
								<tr>
									<td width="113" valign="top">뉴스뱅크(개인회원)</td>
									<td width="246" valign="top">아이디, 비밀번호, 이메일, 이름, 연락처, 접속
										로그, 쿠키, 접속 IP 정보, 결제기록</td>
									<td width="246" rowspan="3" valign="top">신용카드 정보, 은행계좌정보,
										현금영수증 관련 정보</td>
								</tr>
								<tr>
									<td width="113" valign="top">뉴스뱅크(법인회원)</td>
									<td width="246" valign="top">아이디, 비밀번호, 이메일, 이름, 연락처, 회사명,
										사업자등록번호, 사업자등록증, 접속 로그, 쿠키, 접속 IP 정보, 결제기록</td>
								</tr>
								<tr>
									<td width="113" valign="top">뉴스뱅크(언론사)</td>
									<td width="246" valign="top">아이디, 비밀번호, 이메일, 이름, 연락처, 회사명,
										사업자등록번호, 사업자등록증, 은행 및 입금 계좌 정보, 통장 사본, 세금계산서 담당자 관련 정보(이름,
										전화번호, 이메일) 접속 로그, 쿠키, 접속 IP 정보, 결제기록</td>
								</tr>
								<tr>
									<td width="113" valign="top">e-NIE (교사)</td>
									<td width="246" valign="top">아이디, 비밀번호, 이름, 이메일, 담당 학교</td>
									<td width="246" valign="top">전화번호, 휴대폰, 주소, 담당과목, 교육인원</td>
								</tr>
								<tr>
									<td width="113" valign="top">e-NIE (학생)</td>
									<td width="246" valign="top">아이디, 비밀번호, 이름, 이메일, 담당 학교</td>
									<td width="246" valign="top">전화번호, 휴대폰, 주소</td>
								</tr>
								<tr>
									<td width="113" valign="top">뉴스플라자</td>
									<td width="246" valign="top">회원사 정보 <br /> 사업자 구분, 상호명,
										사업자등록번호, 대표자명, 업태, 종목, 주소 <br /> 사용자 정보 <br /> 아이디, 비밀번호,
										이름, 휴대폰, 이메일
									</td>
									<td width="246" valign="top">2사용자 정보 <br /> 부서, 직위, 전화번호
									</td>
								</tr>
								<tr>
									<td width="113" valign="top">뉴스콕</td>
									<td width="246" valign="top">아이디, 비밀번호, 휴대폰 정보(디바이스
										고유번호(UUID), 단말기 이름, 단말기 OS 버전)</td>
									<td width="246" valign="top">&nbsp;</td>
								</tr>
								<tr>
									<td width="113" valign="top">초판 서비스<br /> (국민일보, 세계일보,
										서울경제, 한겨레, 한국일보, 이데일리, 아주경제, 아시아투데이)
									</td>
									<td width="246" valign="top">아이디, 비밀번호, 회사명, 사업자등록번호,
										회사주소, 업태/종목, 담당자성명, 부서/직위, 회사전화번호(일반전화), 팩스번호, 휴대전화번호, 이메일, 접속
										로그, 쿠키, 접속 IP 정보, 브라우저 정보, 운영체제 정보, 결제기록</td>
									<td width="246" valign="top">&nbsp;</td>
								</tr>
							</table>
							<h5>수집∙이용 목적</h5>
							<p>회사는 수집한 개인정보를 다음의 목적 이외의 용도로는 처리 • 이용하지 않으며 이용 목적이 변경될 시에는
								사전동의를 구할 예정입니다.</p>
							<ol>
								<li>홈페이지 회원가입 및 관리 회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증,
									회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 고충처리, 분쟁 조정을 위한
									기록 보존 등을 목적으로 개인정보를 처리합니다.</li>
								<li>민원사무 처리 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등을
									목적으로 개인정보를 처리합니다.</li>
								<li>재화 또는 서비스 제공 서비스 제공, 콘텐츠 제공, 본인인증, 연령인증, 요금결제·정산 등을
									목적으로 개인정보를 처리합니다.</li>
								<li>마케팅 및 광고에의 활용 신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보
									제공 및 참여기회 제공, 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로
									개인정보를 처리합니다.</li>
							</ol>
						</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule3">
					<h4>제3조 (개인정보의 제공)</h4>
					<ol>
						<li>회사는 이용자들의 사전 동의가 있거나 관련법령의 규정에 의한 경우를 제외하고는 제2조에 고지한 범위를
							넘어 이용자의 개인정보를 이용하거나 제3자에게 제공하지 않습니다.</li>
						<li>다만, 다음 각 호의 경우에는 이용자의 별도 동의 없이 제공될 수 있습니다.
							<ol>
								<li>서비스 제공에 따른 요금 정산을 위하여 필요한 경우</li>
								<li>통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 알아볼 수 없는 형태로
									가공하여 연구단체, 설문조사, 리서치 기관 등에 제공하는 경우</li>
								<li>개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 통신비밀보호법, 국세기본법,
									금융실명거래 및 비밀보장에 관한 법률, 신용정보의 이용 및 보호에 관한 법률, 전기통신기본법, 전기통신사업법,
									지방세법, 소비자보호법, 형사소송법 등 법률상 특별한 규정이 있는 경우</li>
							</ol>
						</li>
						<li>이용자는 제3자에 대한 개인정보 제공 동의를 거부할 수 있으며, 동의를 거부할 때에는 제3자 제공에
							따른 서비스 이용에 제한을 받을 수 있습니다.</li>
						<li>회사는 개인정보를 국외의 제3자에게 제공할 때에는 이용자에게 내용을 알리고 동의를 받습니다.</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule4">
					<h4>제4조 (개인정보의 취급위탁)</h4>
					<ol>
						<li>회사는 고객편의 서비스를 원활하게 제공하기 위해서 일부 업무를 전문업체에 위탁 운영하고 있습니다.</li>
						<li>회사는 개인정보 보호의 만전을 기하기 위하여 서비스 제공자의 개인정보 처리위탁관련 적법한 처리절차,
							보안지시엄수, 개인정보에 관한 비밀 유지, 업무 목적 및 범위를 벗어난 사용의 제한, 재위탁 제한 등 사고 시의
							손해배상 책임부담을 명확히 규정하고 해당 계약내용을 서면 또는 전자적으로 보관하여 이를 엄격하게 관리감독 하고
							있습니다.</li>
						<li>위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개합니다.</li>
						<li>회사에서 고객의 개인정보를 위탁하는 현황은 다음과 같습니다.
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<th width="203" valign="top">수탁자</th>
									<th width="249" valign="top">위탁 목적</th>
								</tr>
								<tr>
									<td width="203">LG유플러스</td>
									<td width="249">결제처리</td>
								</tr>
								<tr>
									<td width="203">(주)이노포스트</td>
									<td width="249"><p>SMS 발송</td>
								</tr>
							</table>
						</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule5">
					<h4>제5조 (개인정보의 보유ㆍ이용 기간, 파기 절차 및 파기방법)</h4>
					<ol>
						<li>회사는 이용자가 회사에서 제공하는 서비스를 이용하는 동안 이용자들의 개인정보를 보유하며 서비스 제공
							등의 목적을 위해 이용합니다. 전산에 등록된 이용자의 개인정보는 개인정보관리 담당자 및 책임자 또는 이들의 승인을
							얻은 자가 아니면 문서로 출력할 수 없습니다.</li>
						<li>회사는 이용자가 자신의 개인정보를 삭제하거나 회원가입 탈퇴를 요청한 경우 지체 없이 조치를 취하며,
							삭제된 정보는 기록을 복구 또는 재생할 수 없는 방법에 의하여 디스크에서 완전히 삭제하며 추후 열람이나 이용이
							불가능한 상태로 처리됩니다.</li>
						<li>회사는 개인정보의 수집목적 및 또는 제공받은 목적이 아래와 같이 파기사유가 발생한 때에 회사의 내부
							파기절차에 따라 디스크에서 정보를 삭제하고, 출력된 경우에는 분쇄기로 분쇄하는 방법으로 이용자의 개인정보를 지체 없이
							파기합니다.
							<ol>
								<li>회원가입정보의 경우 : 회원가입을 탈퇴하거나 회원에서 제명된 때</li>
								<li>대금지급정보의 경우 : 대금의 완제일 또는 채권소멸시효기간이 만료된 때</li>
								<li>설문조사, 이벤트 등의 목적을 위하여 수집한 경우 : 해당 설문조사, 이벤트가 종료한 때</li>
							</ol>
						</li>
						<li>수집목적 또는 제공받은 목적이 달성된 경우에도 전자상거래 등에서의 소비자보호에 관한 법률,
							개인정보보호법, 상법, 국세기본법 등 법령의 규정에 의하여 보존할 필요성이 있는 경우에는 다음과 같이 일정기간
							이용자의 개인정보를 보유할 수 있습니다.
							<ol>
								<li>계약 또는 청약철회 등에 관한 기록 : 5년</li>
								<li>대금결제 및 재화 등의 공급에 관한 기록 : 5년</li>
								<li>소비자 불만 또는 분쟁 처리에 관한 기록 : 3년</li>
								<li>웹사이트 방문기록 : 3개월</li>
							</ol>
						</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule6">
					<h4>제6조 (개인정보 보호업무 및 관련 고충사항 처리 부서)</h4>
					<ol>
						<li>회사는 이용자의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 개인정보보호업무 및 관련
							고충사항을 처리하는 부서가 지정되어 있습니다. 또한 개인정보 관리 책임자와 개인정보 관리 담당자를 두어 이용자의
							개인정보에 관한 문의 및 불만을 신속하게 처리해드리고 있습니다.
							<div class="box">
								<p>
									[개인정보 보호 책임자]<br /> 성명: 신태범 부사장
								</p>
								<p>
									[개인정보 보호 담당자]<br /> 성명: 최고운 선임 <br /> 소속: 기술개발연구소 <br />
									연락처: 02-593-4174, <a href="mailto:gwchoi@dahami.com">gwchoi@dahami.com</a>
									(월~금 08:00~17:00, 공휴일 제외)
								</p>
							</div>
						</li>
						<li>이용자는 자신의 개인정보에 관하여 침해의 발생 또는 그 염려로 인하여 상담이 필요한 때에는 제1항의
							회사 개인정보보호 담당부서뿐만 아니라 다음의 기관 등에 문의할 수 있습니다.
							<ol>
								<li>한국인터넷진흥원 개인정보침해신고센터 (privacy.kisa.or.kr/국번 없이 118)</li>
								<li>대검찰청 사이버범죄수사단 (<a
									href="http://www.spo.go.kr/02-3480-3571">www.spo.go.kr/02-3480-3571</a>)
								</li>
								<li>경찰청 사이버안전국 (www.ctrc.go.kr/국번 없이 182)</li>
							</ol>
						</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule7">
					<h4>제7조 (개인정보 자동수집 장치에 의한 개인정보 수집)</h4>
					<ol>
						<li>이용자 개개인에게 개인화되고 맞춤화된 서비스를 제공하기 위해서 회사는 이용자의 정보를 저장하고 수시로
							불러오는 '쿠키(cookie)'를 사용합니다. 쿠키는 웹사이트를 운영하는데 이용되는 서버가 사용자의 브라우저에게
							보내는 조그마한 데이터 꾸러미로 이용자 컴퓨터의 하드디스크에 저장됩니다.</li>
						<li>회사는 아래와 같은 목적으로 쿠키를 사용합니다.
							<ol>
								<li>로그인 유지를 위한 아이디 정보 1시간 저장</li>
								<li>이메일 인증을 위한 이메일 주소 및 이메일 인증 코드</li>
								<li>회원가입 완료 후 자동 로그인을 위한 아이디값 및 유저 구분 코드(고객/기업)와 기업명</li>
							</ol>
						</li>
						<li>이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서, 이용자는 웹브라우저에서 옵션을
							설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도
							있습니다.
							<ul>
								<li>쿠키설치 허용여부를 지정하는 방법 (INTERNET EXPLORER 6.0을 사용하고 있는 경우)
									인터넷 화면 작업표시줄의 [도구]를 클릭한 후 [인터넷 옵션] 선택하고, [개인정보 탭]을 선택한 후,
									[개인정보보호 수준]에서 쿠키허용 여부를 설정합니다.</li>
								<li>받은 쿠키를 보는 방법 (INTERNET EXPLORER 6.0을 사용하고 있는 경우) 인터넷 화면
									작업표시줄의 [도구]를 클릭한 후 [인터넷 옵션]을 선택하고, 일반 탭(기본 탭)에서 임시 인터넷 파일의
									[설정]을 선택한 후, [파일보기]를 선택합니다.</li>
							</ul>
						</li>
						<li>회사는 구글(Google)에서 제공하는 웹 분석 도구인 구글 애널리틱스를 이용하고 있으며, 이용자
							개인을 식별할 수 없도록 비식별화 처리된 정보를 이용합니다. 이용자는 구글 애널리틱스 Opt-out Browser
							Add-on 을 이용하거나, 쿠키 설정 거부를 통해 구글 애널리틱스 이용을 거부할 수 있습니다.</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule8">
					<h4>제8 조 (개인정보의 열람 및 정정 등)</h4>
					<ol>
						<li>이용자는 언제든지 회사의 웹사이트에 로그인하여 [회원정보수정]을 클릭하여 직접 열람 또는 정정하거나,
							영업사원을 비롯한 개인정보 취급위탁을 받은 자에게 요청하거나, 회사의 개인정보보호부서로 전화, 서면,
							전자우편(e-mail)로 연락하여, 열람, 정정, 삭제, 처리정지를 요구할 수 있으며, 회사는 이용자의 요구에 대하여
							지체 없이 관련 조치를 취하겠습니다.</li>
						<li>이용자가 개인정보의 오류에 대한 정정을 요청한 경우 회사는 정정을 완료하기 전까지 해당 개인정보를 이용
							또는 제공 등 처리하지 않습니다. 또한 잘못된 개인정보를 이미 처리한 경우에는 정정 처리결과가 지체없이 반영되도록
							조치하겠습니다.</li>
						<li>다음과 같은 경우에는 개인정보의 열람 및 정정 등을 제한할 수 있습니다.
							<ul>
								<li>제3자의 권익을 현저하게 해할 우려가 있는 경우</li>
								<li>해당 서비스제공자의 업무에 현저한 지장을 미칠 우려가 있는 경우</li>
								<li>법령을 위반하는 경우 등</li>
							</ul>
						</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule9">
					<h4>제9 조 (개인정보 수집 • 이용 • 제공에 대한 동의 철회)</h4>
					<ol>
						<li>이용자는 개인정보의 수집, 이용 및 제공에 대해 동의한 내용을 언제든지 철회할 수 있습니다.
							동의철회(회원탈퇴)는 회사 웹사이트에 로그인한 후 직접 동의철회(회원탈퇴)를 하거나, 영업사원을 비롯한 개인정보
							취급위탁을 받은 자에게 요청하거나, 개인정보 관리책임부서로 서면, 전화 또는 전자우편(E-mail) 등으로 연락하는
							등의 방법으로 할 수 있습니다. 회사는 이용자의 요청에 대하여 지체 없이 이용자의 회원탈퇴처리 및 개인정보의 파기 등
							필요한 조치를 하겠습니다.</li>
						<li>회사는 개인정보의 수집에 대한 동의철회(회원탈퇴)를 개인정보의 수집 방법보다 쉽게 할 수 있도록 필요한
							조치를 취하도록 노력합니다.</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule10">
					<h4>제10 조 (개인정보보호를 위한 관리적 • 기술적 • 물리적 대책)</h4>
					<ol>
						<li>회사는 개인정보의 안전한 처리를 위한 내부관리계획을 수립하고 시행하며, 교육을 실시합니다.</li>
						<li>회사는 이용자의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록
							안전성 확보를 위하여 기술적 대책을 강구하고 있습니다</li>
						<li>이용자의 개인정보는 외부 망에서 접근 및 침입이 불가능한 내부 망을 활용하여 관리되고 있으며, 파일 및
							전송데이터를 암호화하거나 파일 잠금기능(lock)을 사용하여 중요한 데이터는 별도의 보안기능을 통해 철저하게 보호되고
							있습니다.</li>
						<li>회사는 해킹 등 외부 침입에 대비하여 방화벽 및 침입탐지시스템을 이용하여 사내 네트워크 보안에 만전을
							기하고 있으며, 접근제어 시스템을 설치하여 보안을 강화하고 있습니다.</li>
						<li>개인정보처리 시스템 및 개인정보 취급자가 개인정보 처리에 이용하는 정보기기에 컴퓨터 바이러스,
							스파이웨어 등 악성 프로그램의 침투 여부를 항시 점검, 처리할 수 있도록 백신프로그램을 설치하여 개인정보가 침해되는
							것을 방지하고 있습니다.</li>
						<li>회사는 이용자의 개인정보에 대한 접근권한을 최소한의 인원으로 제한하고 개인정보의 안전성을 확보하기
							위하여 개인정보에 대한 접근 및 관리에 필요한 내부절차를 마련하고 출입통제 • 잠금장치를 하고 소속 직원으로 하여금
							이를 숙지하고 준수하도록 하고 있습니다.</li>
						<li>개인정보 관련 취급자의 업무 인수인계는 보안이 유지된 상태에서 철저하게 이뤄지고 있으며 입사 및 퇴사
							후 개인정보 사고에 대한 책임을 명확히 하고 있습니다.</li>
						<li>이용자는 회사에 제공한 개인정보에 대한 스스로의 확인 및 관리를 통하여 정확한 정보를 유지하도록 하며,
							인터넷 사이트의 이용과정에서 타인의 개인정보를 권한 없이 이용하거나 타인의 권리를 침해하는 경우에는 회사의 제재뿐만
							아니라 민 • 형사상 책임을 부담할 수 있습니다.</li>
						<li>회사는 개인정보처리자로서의 의무를 다하였음에도 불구하고, 이용자 본인의 부주의나 회사가 관리하지 않는
							영역에서의 사고 등 회사의 귀책에 기인하지 않은 손해에 대해서는 회사는 책임을 지지 않습니다. 따라서 이용자 개개인이
							본인의 개인정보를 보호하기 위해서 자신의 아이디(ID) 와 비밀번호(P/W)를 적절하게 관리하고 여기에 대한 책임을
							져야 합니다. 다만, 회사의 내부 관리자의 실수 또는 기술관리의 사고로 인해 이용자의 개인정보의 상실, 유출, 변조,
							훼손이 생긴 경우 회사는 즉각 이용자에게 사실을 알리고 적절한 대책과 보상을 강구할 것입니다.</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule11">
					<h4>제11 조 (이용자 및 법정대리인의 권리와 그 행사방법)</h4>
					<ol>
						<li>이용자 및 법정대리인은 회사에 대하여 제공한 본인 또는 법정대리인으로서 개인정보를 조회, 수정, 변경
							및 회원의 탈퇴 등과 관련한 권리를 행사할 수 있습니다.</li>
						<li>이용자 및 법정대리인은 개인정보와 관련하여 인터넷, 전화, 서면 등을 이용하여 회사에 연락을 하여
							권리를 행사할 수 있으며, 회사는 지체 없이 필요한 조치를 합니다.</li>
					</ol>
				</section>
				<section class="policy_cont" id="rule12">
					<h4>제12 조 (보호정책 변경 시 공지의무)</h4>
					<p>개인정보취급방침은 법령 • 정책 및 회사 내부 운영방침 또는 보안기술의 변경에 따라 내용이 변경될 수
						있으며, 이 때에는 변경되는 개인정보취급방침을 시행하기 최소 7일전(이용자에게 불리하게 변경된 경우는 30일 전)부터
						회사 사이트 첫 페이지에 변경 이유 및 내용 등을 공지하도록 하겠습니다.</p>
				</section>
				<section class="policy_cont" id="rule13">
					<h4>부칙</h4>
					<p>2018.08.23   이 방침은 2018년 9월 6일부터 시행됩니다.</p>
				</section>
				<section class="policy_cont" id="rule14">
					<h4>개인정보처리방침 변경사항</h4>
					<p>
						<a href="/privacy.intro">이후 개인처리정보방침(2019.08.13 ~)</a>
					</p>
				</section>
			</div>
		</section>
		<%@include file="common/footerKR.jsp"%>
	</div>
</body>
</html>