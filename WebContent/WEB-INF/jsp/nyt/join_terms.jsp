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
    <jsp:include page="common/head_meta.jsp" />
    <title>NYT 뉴스뱅크</title>
    <link rel="stylesheet" href="css/nyt/base.css" />
    <link rel="stylesheet" href="css/nyt/join.css" />
    <script src="js/nyt/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="js/nyt/join.js"></script>
</head>

<body>
    <div class="wrap">
        <header>
            <nav class="gnb_dark">
                <div class="gnb" style="display:flex; justify-content:center; padding: 0;">
                    <a href="/" class="nyt">뉴욕타임스</a><span class="by">X</span>
                    <a href="https://www.newsbank.co.kr/" target="_blank" class="logo">뉴스뱅크</a>
                </div>
            </nav>
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
                            <p>본 약관에 대한 동의는 ㈜다하미커뮤니케이션즈(이하 ‘회사’라 한다)가 제공하는 사진 저작물(이하 ‘이미지’라 한다)을 이용하는 모든 자(이하 ‘이용자’라 한다)와의 계약 체결과 동일한 효력을 가지게 됩니다. </p>
                            <h3 id="rule1">제1조(목적) </h3>
                            <p>이 약관은 ㈜다하미커뮤니케이션즈가 NYT 뉴스뱅크(http://providers-nyt.newsbank.co.kr)사이트 등을 통해 제공하는 이미지를 이용함에 있어 이용자의 권리, 의무, 책임사항을 규정함을 목적으로 합니다.</p>
                            <h3 id="rule2">제2조(용어 정의) </h3>
                            <ol>
                                <li>‘NYT 뉴스뱅크’란 뉴욕타임스의 보도 사진을 온라인으로 게시하고 이를 판매할 수 있도록 한 영업장을 말합니다.</li>
                                <li>‘이용자’란 NYT 뉴스뱅크에 접속하여 이 약관에 따라 NYT 뉴스뱅크가 제공하는 각종 이미지를 이용하는 회원 및 비회원을 말합니다. </li>
                                <li> ‘회원’이란 NYT 뉴스뱅크가 정한 약관에 동의한 후 회원가입을 신청해 회원ID를 받은 사람을 말합니다. </li>
                            </ol>
                            <h3 id="rule3">제3조 (약관의 명시와 개정) </h3>
                            <ol>
                                <li> 회사는 합리적 사유가 발생했을 경우 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</li>
                                <li> 회사는 약관을 개정할 경우에는 적용일자 및 개정사유를 초기화면에 공지합니다.</li>
                                <li> 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 관계 법령 또는 상거래 관례에 따릅니다.</li>

                            </ol>
                            <h3 id="rule4">제4조 (회원가입과 관리) </h3>
                            <ol>
                                <li>이용자는 회사가 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로써 회원가입을 신청합니다. </li>
                                <li>회원은 필요시 탈퇴를 요청할 수 있으며, 회사는 회원의 탈퇴 요청을 받아 회원 탈퇴의 처리를 합니다. </li>
                                <li>회원은 기관, 단체, 회사명으로 가입하는 법인회원과 개인명의로 가입하는 개인회원으로 다시 각각 구분합니다. </li>
                                <li>회원은 등록사항에 변경이 있는 경우, NYT 뉴스뱅크 사이트를 통해 그 변경사항을 회사에 알려야 합니다. </li>
                                <li>회원이 다음 각 호의 사유에 해당하는 경우, 회사는 회원자격을 제한 또는 상실시킬 수 있습니다.
                                    <ul>
                                        <li>가입 신청 시에 허위 내용을 등록한 경우 </li>
                                        <li>NYT 뉴스뱅크를 부정한 목적으로 사용하여 개인 또는 단체의 명예를 훼손 하였거나 경제적 정신적 피해를 주었을 경우</li>
                                    </ul>
                                </li>
                            </ol>
                            <h3 id="rule5">제5조 (서비스의 중단) </h3>
                            <p>회사는 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다. </p>
                            <h3 id="rule6">제6조 (구매대금 결제) </h3>
                            <p>NYT 뉴스뱅크에서 구매한 이미지에 대한 대금지급방법은 다음과 같습니다. </p>
                            <ol>
                                <li>신용카드 결제 </li>
                                <li>온라인 무통장입금 </li>
                                <li>자동이체 </li>
                            </ol>
                            <h3 id="rule7">제7조(환급, 반품 및 교환)</h3>
                            <ol>
                                <li>NYT 뉴스뱅크는 복제가 가능한 이미지의 특성 상 이미 제공된 이미지에 대해 변경, 취소, 환불이 되지 않습니다. </li>
                                <li> 단, 다음 각 호의 경우는 이미 제공된 이미지일지라도 이용자의 요구에 따라 쌍방 합의를 거친 후 재배송, 환급, 반품 및 교환 조치를 합니다. 다만, 그 요구기한은 제공된 날로부터 7일 이내로 합니다
                                    <ul>
                                        <li>제공된 이미지가 주문내용과 상이하거나 NYT 뉴스뱅크가 제공한 정보와 상이할 경우</li>
                                        <li>제공된 이미지가 파손, 손상되었을 경우. 단 이용자에게 책임이 있는 사유로 훼손 또는 멸실된 경우는 제외.</li>
                                    </ul>
                                </li>
                                <li> NYT 뉴스뱅크는 대금의 결제와 동일한 방법으로 대금을 환급하며, 동일한 방법으로 환급이 불가능 할 때에는 이를 사전에 고지합니다.</li>
                            </ol>
                            <h3 id="rule8">제8조(과오금)</h3>
                            <ol>
                                <li>NYT 뉴스뱅크는 유료서비스 결제와 관련하여 NYT 뉴스뱅크의 귀책사유로 인해 과오금이 발생한 경우 이용대금의 결제와 동일한 방법으로 과오금 전액을 환불합니다. 다만, 동일한 방법으로 환불이 불가능할 때는 이를 사전에 고지합니다.</li>
                                <li>NYT 뉴스뱅크의 책임 있는 사유로 과오금이 발생한 경우 NYT 뉴스뱅크는 비용, 수수료 등의 관계없이 과오금 전액을 환급합니다. 다만, 이용자의 책임 있는 사유로 과오금이 발생한 경우, 과오금의 환급에 소요되는 비용은 합리적인 범위 내에서 이용자가 부담합니다 </li>
                                <li>NYT 뉴스뱅크는 이용자가 요구하는 과오금에 대하여 환불을 거부할 경우, 정당하게 유료서비스 요금이 부과되었음을 입증할 책임을 집니다.</li>
                                <li>NYT 뉴스뱅크는 과오금의 환불절차를 ‘콘텐츠이용자보호지침’에 따라 처리 합니다.</li>
                            </ol>
                            <h3 id="rule9">제9조 (회사의 의무) </h3>
                            <ol>
                                <li>회사는 본 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스 제공하는데 최선을 다해야 합니다. </li>
                                <li>회사는 원활한 서비스를 위해 최적의 상태로 시스템을 유지, 보수하여야 하며 장애 발생 시 즉각 대처하여 서비스에 불편이 없도록 해야 합니다. </li>
                            </ol>
                            <h3 id="rule10">제10조 (회원의 ID 및 비밀번호에 대한 의무) </h3>
                            <ol>
                                <li>ID와 비밀번호에 관한 관리책임은 회원에게 있습니다. </li>
                                <li>회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안 됩니다. </li>
                                <li>회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 즉시 회사에 통보함으로써 회사가 이에 대한 조치를 취할 수 있도록 해야 합니다. </li>
                            </ol>
                            <h3 id="rule11">제11조 (저작권 및 제반 권리) </h3>
                            <ol>
                                <li>NYT 뉴스뱅크 사이트를 통해 게시한 모든 이미지에 대한 저작권은 뉴욕타임스에게 있습니다</li>
                                <li>회사는 뉴욕타임스가 제공한 이미지의 피사체에 대한 초상권, 상표권, 특허권, 등 제반 권리를 가지고 있지 않습니다. </li>
                                <li>이용자가 회사가 제공하는 이미지를 사용할 경우 저작권, 피사체에 대한 초상권, 상표권 등 기타권리는 이용자 자신이 취득하여야 하며, 만일 이들 권리에 대한 분쟁이 발생할 경우 이용자에게 모든 책임이 있습니다. </li>
                                <li>이용자가 본 계약에 따른 의무사항을 위반할 경우 이용허락계약은 자동 종료되며, 이용자는 즉시 모든 형태의 저작물 이용을 중단해야 합니다.</li>
                            </ol>
                            <h3 id="rule12">제12조 (이미지 구매 시 사용범위와 제한사항) </h3>
                            <ol>
                                <li>이용자는 회사가 NYT 뉴스뱅크를 통해 제공한 이미지를 구입하여 출판, 전자출판, 홍보 등의 목적으로 사용할 수 있습니다. </li>
                                <li>보도사진의 사용요금은 1회 구매 시 1회인쇄, 1용도, 1매체에 한해서 적용됩니다. </li>
                                <li>보도사진의 사용기간은 일반적으로 1년으로 제한되며, 온라인 디지털 미디어에 한하여 6개월 계약 2번으로 최대 1년 사용 가능합니다. 사용기간을 연장하여 사용할 경우 지정된 추가요금을 지불하고 라이선스 기간을 연장하여야 합니다. 사용자가 라이선스의 기간을 연장하지 않은 경우 계약이 자동적으로 종료됩니다. </li>
                                <li>보도사진을 사용 허가된 이미지의 사용범위 이외의 목적으로 이미지를 사용할 수 없으며, 만일 사전 통보 없이 변칙적으로 사용한 사실이 인정되었을 경우 발생할 수 있는 법원 및 변호사 비용 및 위약금 등을 배상합니다. </li>
                                <li>이용자가 이미지를 구매한 후에는 제3자에게 판매, 대여, 배포, 양도, 전송, 복제할 수 없으며, 이미지를 불법으로 사용한 경우 저작권법에 의거하여 민ㆍ형사상의 책임을 져야 합니다. </li>
                                <li>이용자는 이 라이선스의 조건을 위반하는 방법으로 저작물에 대한 접근이나 이용을 통제하는 기술적 보호조치를 하여 저작물을 복제, 공연, 방송, 전송, 전시 또는 배포할 수 없습니다. </li>
                                <li>이미지의 사용에 있어서 외설적이거나 타인에 대한 명예훼손 등 일반 정서에 반하는 용도 및 범죄를 목적으로 한 용도로의 사용을 금지합니다.</li>
                                <li>이미지를 사용할 때 반드시 저작권자 표시(이미지 제공사 혹은 사진작가 등)를 기재하여야 합니다. </li>
                                <li>이용자는 이미지 저작물에 대해 단순한 크기조절 외에 임의로 그 형태를 변형, 합성, 왜곡, 그리고 인공지능 학습 등을 할 수 없습니다. </li>
                            </ol>
                            <h3 id="rule13">제13조 (분쟁의 해결)</h3>
                            <ol>
                                <li>회사와 이용자간에 발생한 전자거래 분쟁에 관한 소송은 서울중앙법원에 제기할 수 있습니다. </li>
                                <li>회사와 이용자간에 제기된 전자거래 소송에는 대한민국 법을 적용받습니다. </li>
                                <li>이 약관에 명시되지 않은 사항은 관계법령과 상관례에 따릅니다. </li>
                            </ol>
                            <h3 id="rule14">부칙</h3>
                            <p>제 1 조 (적용일자) </p>
                            <ol>
                                <li>이 약관은 2024년 9월 1일부터 적용됩니다.</li>
                            </ol>
                        </div>
                        <div class="wrap_check">
                            <input id="copyAgree" name="copyAgree" type="checkbox" title="저작물 이용 약관에 동의합니다." />
                            <label for="copyAgree">개인정보 처리 방침에 동의합니다.</label>
                        </div>
                    </div>
                    <div class="join_box">
                        <h5 class="box_tit">개인정보처리방침</h5>
                        <div class="box_cont">


                            <section class="policy_top">
                                <p>주식회사 [다하미커뮤니케이션즈]는(이하 ‘회사’) 회사가 제공하는 스크랩마스터 및 클리핑온, T-Paper, 뉴스뱅크, e-NIE, 뉴스플라자, 뉴스콕, 초판 등의 서비스를 이용하는 이용자의 개인정보를 매우 소중하게 생각하고 있으며 이용자 개인정보를 보호하기 위하여 최선의 노력을 다하고 있습니다. <br />
                                    회사는 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 『개인정보 보호법』, 『정보통신망 이용촉진 및 정보보호 등에 관한 법률』을 비롯한 모든 개인정보보호 관련 법률규정을 준수하고 있으며, 아래와 같은 개인정보처리방침을 두고 있습니다. <br />
                                    회사는 개인정보처리방침을 회사 홈페이지 하단에 항상 공개하고, 이를 개정하는 경우 홈페이지 내 ‘회사소식’을 통하여 공지할 것입니다.
                                </p>
                            </section>
                            <section class="policy_cont" id="rule1">
                                <h4>제1조 (개인정보의 수집에 대한 동의 및 수집 방법)</h4>
                                <ol>
                                    <li>회사는 회사가 운영하는 서비스 및 서비스별 인터넷 사이트를 통합하지 않고 각각 독립적으로 운영합니다. 따라서 이용자가 서면 양식이나 전화/팩스를 통해 서비스 이용 계약을 하거나 서비스 사이트에 회원 가입을 할 때 서비스별로 수집하는 개인정보 항목을 확인하고 이에 대해 동의하는 경우에 한해 각 서비스를 제공합니다. </li>
                                    <li>이용자는 회사가 회사의 개인정보처리방침에 따라 이용자의 개인정보를 수집함에 대하여 동의 여부를 표시하는 방법으로 동의할 수 있습니다. 이용자가 동의 부분에 표시하면 해당 개인정보 수집에 대해 동의한 것으로 봅니다.</li>
                                    <li>‘회원’이라 함은 회사에게 개인정보를 제공하여 회원 등록을 하는 방법으로 회원 가입된 이용자를 의미합니다.</li>
                                    <li>‘비회원’이라 함은 회사의 사이트 등에 회원 가입을 하지 않고, 회사가 제공하는 서비스를 이용하는 자를 말합니다.</li>
                                </ol>
                            </section>
                            <section class="policy_cont" id="rule2">
                                <h4>제2조 (개인정보의 수집항목 및 수집∙이용 목적)</h4>
                                <ol>
                                    <li>회사는 이용자의 회원 가입 시 서비스 제공을 위해 필요한 최소한의 개인정보를 수집하고 있습니다. 다만, 서비스 이용 과정이나 서비스 제공 업무 처리 과정에서 이용자들에게 보다 양질의 맞춤 서비스를 제공하기 위하여 이용자의 추가적인 개인정보를 입력 받고 있습니다.</li>
                                    <li>회사는 이용자의 명시적인 별도 동의 없이 기본적 인권 침해의 우려가 있는 사상 • 신념, 노동조합 • 정당의 가입 • 탈퇴, 정치적 견해, 건강, 성생활, 과거의 병력, 종교, 출신지, 범죄기록 등 민감한 개인정보는 수집하지 않습니다.</li>
                                    <li> 회사가 회원가입 시 수집하는 개인정보 항목과 그 수집 • 이용의 주된 목적은 아래 표와 같습니다.
                                        <h5>개인정보 수집항목</h5>
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%" class="tb03">
                                            <thead>
                                                <colgroup>
                                                    <col width="50">
                                                    <col width="">
                                                    <col width="50">
                                                    <col width="50">
                                                </colgroup>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>서비스 </td>
                                                    <td>처리하는 개인정보 항목 </td>
                                                    <td>개인정보 처리 목적 </td>
                                                    <td>보유 및 이용기간 </td>
                                                </tr>
                                                <tr>
                                                    <td>다하미<br>
                                                        홈페이지 </td>
                                                    <td>[선택] 성명, 연락처, 이메일 </td>
                                                    <td>- 문의하기: 고객 응대 및 안내 </td>
                                                    <td rowspan="17">-회원탈퇴 혹은 동의철회시까지 <br>
                                                        -관련법령에 따른 보존기간까지 <br>
                                                        -수집 및 이용 목적 달성시까지 </td>
                                                </tr>
                                                <tr>
                                                    <td>스크랩마스터<br>
                                                        홈페이지 </td>
                                                    <td>&lt;기관/기업회원&gt;<br>
                                                        [필수] 아이디, 비밀번호, 회사명, 사업자등록번호, 대표자명, 회사 주소, 회사 전화번호, 담당자 성명, 담당자 전화번호, 이메일, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록 <br>
                                                        [선택] 팩스번호, 직급, 부서 </td>
                                                    <td>- 회원가입 및 서비스 결제 <br>
                                                        - 서비스 제공 및 향상 </td>
                                                </tr>
                                                <tr>
                                                    <td>티페이퍼<br>
                                                        홈페이지 </td>
                                                    <td>[선택] 도서관명/기관명, 성명, 이메일, 전화번호 </td>
                                                    <td>- 제품 소개자료 요청/문의하기: 고객 응대 및 안내 </td>
                                                </tr>
                                                <tr>
                                                    <td>스크랩마스터3 프로그램 </td>
                                                    <td>[필수] 아이디, 비밀번호, 윈도우 디바이스 이름, Local IP Address</td>
                                                    <td rowspan="4">- 사용자 식별 및 서비스 운영 </td>
                                                </tr>
                                                <tr>
                                                    <td>스크랩마스터5 프로그램 </td>
                                                    <td>[필수] 아이디, 비밀번호, 윈도우 디바이스 이름, Local IP Address, PC 사양, 윈도우 버전, 서비스 이용 기록 </td>
                                                </tr>
                                                <tr>
                                                    <td>스크랩마스터<br>
                                                        모바일 플러스 </td>
                                                    <td>[필수]<br>
                                                        - 안드로이드: 아이디, 비밀번호, 디바이스 정보(OS버전, 단말기명)<br>
                                                        - iOS: 아이디, 비밀번호, 디바이스 정보(OS버전)<br>
                                                        [선택]<br>
                                                        공통: 이름, 부서, 직급 </td>
                                                </tr>
                                                <tr>
                                                    <td>SM+ 알림뉴스 </td>
                                                    <td>[필수]<br>
                                                        - 안드로이드: 아이디, 비밀번호, 부서, 디바이스 정보(OS버전, 단말기명)<br>
                                                        - iOS: 아이디, 비밀번호, 디바이스 정보(OS버전)<br>
                                                        [선택]<br>
                                                        - 안드로이드: 휴대전화번호 </td>
                                                </tr>
                                                <tr>
                                                    <td>클리핑온<br>
                                                    </td>
                                                    <td>[필수] 아이디, 비밀번호, 회사명, 사업자등록번호, 대표자명, 회사주소, 전화번호, 담당자성명, 담당자전화번호, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록 <br>
                                                        [선택] 팩스번호, 직급, 부서, 이메일, 신용카드정보, 은행계좌정보 </td>
                                                    <td rowspan="4">- 회원가입 및 서비스 결제 <br>
                                                        - 사용자 식별 및 서비스 운영 </td>
                                                </tr>
                                                <tr>
                                                    <td>클리핑온<br>
                                                        TV뉴스 </td>
                                                    <td>[필수] 아이디, 비밀번호, 디바이스 정보(OS버전, 단말기명), 휴대전화번호 </td>
                                                </tr>
                                                <tr>
                                                    <td>T-Paper</td>
                                                    <td>[필수] 아이디, 비밀번호, 회사명, 사업자등록번호, 대표자명, 회사주소, 전화번호, 담당자성명, 담당자전화번호, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록<br>
                                                        [선택] 팩스번호, 직급, 부서, 이메일, 신용카드정보, 은행계좌정보 </td>
                                                </tr>
                                                <tr>
                                                    <td>뉴스뱅크 </td>
                                                    <td>&lt;개인회원&gt;<br>
                                                        [필수] 아이디, 비밀번호, 이메일, 이름, 연락처, 접속 로그, 쿠키, 접속 IP 정보, 결제기록 <br>
                                                        [선택] 신용카드 정보, 은행계좌정보, 현금영수증 정보 <br>
                                                        &lt;기관/법인회원&gt;<br>
                                                        [필수] 아이디, 비밀번호, 이메일, 이름, 연락처, 회사명, 사업자등록번호, 사업자등록증, 접속 로그, 쿠키, 접속 IP 정보, 결제기록 <br>
                                                        [선택] 신용카드 정보, 은행계좌정보, 현금영수증 정보 <br>
                                                        &lt;언론사&gt;<br>
                                                        [필수] 아이디, 비밀번호, 이메일, 이름, 연락처, 회사명, 사업자등록번호, 사업자등록증, 은행 및 입금 계좌 정보, 통장 사본, 세금계산서 담당자 관련 정보(이름, 전화번호, 이메일) 접속 로그, 쿠키, 접속 IP 정보, 결제기록 <br>
                                                        [선택] 신용카드 정보, 은행계좌정보, 현금영수증 정보 </td>
                                                </tr>
                                                <tr>
                                                    <td>뉴욕타임스<br>
                                                        뉴스뱅크 </td>
                                                    <td>&lt;개인회원&gt;<br>
                                                        [필수] 아이디, 비밀번호, 이메일, 이름, 연락처, 접속 로그, 쿠키, 접속 IP 정보, 결제기록 <br>
                                                        [선택] 신용카드 정보, 은행계좌정보, 현금영수증 정보 <br>
                                                        &lt;기관/법인회원&gt;<br>
                                                        [필수] 아이디, 비밀번호, 이메일, 이름, 연락처, 회사명, 사업자등록번호, 사업자등록증, 접속 로그, 쿠키, 접속 IP 정보, 결제기록 <br>
                                                        [선택] 신용카드 정보, 은행계좌정보, 현금영수증 정보 </td>
                                                    <td>- 회원가입 및 서비스 결제 <br>
                                                        - 사용자 식별 및 서비스 운영 </td>
                                                </tr>
                                                <tr>
                                                    <td>e-NIE</td>
                                                    <td>&lt;교사&gt;<br>
                                                        [필수] 아이디, 비밀번호, 이름, 이메일, 담당 학교 <br>
                                                        [선택] 전화번호, 휴대전화번호, 주소, 담당과목, 교육인원 <br>
                                                        &lt;학생&gt;<br>
                                                        [필수] 아이디, 비밀번호, 이름, 이메일, 담당 학교 <br>
                                                        [선택] 전화번호, 휴대전화번호, 주소 </td>
                                                    <td rowspan="2">- 회원가입 및 서비스 운영 </td>
                                                </tr>
                                                <tr>
                                                    <td>뉴스플라자 </td>
                                                    <td>[필수] <br>
                                                        - 회원사 정보: 사업자 구분, 상호명, 사업자등록번호, 대표자명, 업태, 종목, 주소 <br>
                                                        - 사용자 정보: 아이디, 비밀번호, 이름, 휴대폰, 이메일 <br>
                                                        [선택]<br>
                                                        - 2 사용자 정보: 부서, 직위, 전화번호 </td>
                                                </tr>
                                                <tr>
                                                    <td>뉴스콕 </td>
                                                    <td>[필수] 아이디, 비밀번호, 휴대폰 정보(단말기명, 단말기 OS 버전)</td>
                                                    <td>- 사용자 식별 및 서비스 운영 </td>
                                                </tr>
                                                <tr>
                                                    <td>초판 서비스 <br>
                                                        (매일경제, 조선일보, 한국경제, 경향신문, 서울신문, 파이낸셜뉴스, 국민일보, 세계일보, 서울경제, 한겨레신문, 한국일보, 아시아투데이, 전자신문, 머니투데이, 이데일리, 아주경제, 대한경제)</td>
                                                    <td>[필수] 아이디, 비밀번호, 회사명, 사업자등록번호, 회사주소, 업태/종목, 담당자성명, 부서/직위, 회사전화번호(일반전화), 팩스번호, 휴대전화번호, 이메일, 접속 로그, 쿠키, 접속 IP 정보, 브라우저 정보, 운영체제 정보, 결제기록 </td>
                                                    <td>- 회원가입 및 서비스 결제 <br>
                                                        - 서비스 제공 및 향상 <br>
                                                        - 사용자 식별 및 서비스 운영 </td>
                                                </tr>
                                                <tr>
                                                    <td>종판 서비스<br>
                                                        (정보통신신문)</td>
                                                    <td>[필수] Android: 아이디, 비밀번호, 디바이스 정보(OS버전, 단말기명), 휴대전화번호, 쿠키 </td>
                                                    <td>- 회원가입 및 서비스 결제 <br>
                                                        - 서비스 제공 및 향상 <br>
                                                        - 사용자 식별 및 서비스 운영 </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <h5>수집∙이용 목적 </h5>
                                        <p>회사는 수집한 개인정보를 다음의 목적 이외의 용도로는 처리 • 이용하지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.</p>
                                        <ol>
                                            <li>홈페이지 회원가입 및 관리 회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 처리합니다.</li>
                                            <li>민원사무 처리 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등을 목적으로 개인정보를 처리합니다.</li>
                                            <li>재화 또는 서비스 제공 서비스 제공, 콘텐츠 제공, 본인인증, 연령인증, 요금결제·정산 등을 목적으로 개인정보를 처리합니다.</li>
                                            <li>마케팅 및 광고에의 활용 신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.</li>
                                        </ol>
                                    </li>
                                </ol>
                            </section>
                            <section class="policy_cont" id="rule3">
                                <h4>제3조 (개인정보의 제공)</h4>
                                <ol>
                                    <li>회사는 이용자들의 사전 동의가 있거나 관련법령의 규정에 의한 경우를 제외하고는 제2조에 고지한 범위를 넘어 이용자의 개인정보를 이용하거나 제3자에게 제공하지 않습니다. </li>
                                    <li>다만, 다음 각 호의 경우에는 이용자의 별도 동의 없이 제공될 수 있습니다.
                                        <ol>
                                            <li>서비스 제공에 따른 요금 정산을 위하여 필요한 경우 </li>
                                            <li>통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 알아볼 수 없는 형태로 가공하여 연구단체, 설문조사, 리서치 기관 등에 제공하는 경우 </li>
                                            <li>개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 통신비밀보호법, 국세기본법, 금융실명거래 및 비밀보장에 관한 법률, 신용정보의 이용 및 보호에 관한 법률, 전기통신기본법, 전기통신사업법, 지방세법, 소비자보호법, 형사소송법 등 법률상 특별한 규정이 있는 경우 </li>
                                        </ol>
                                    </li>
                                    <li>이용자는 제3자에 대한 개인정보 제공 동의를 거부할 수 있으며, 동의를 거부할 때에는 제3자 제공에 따른 서비스 이용에 제한을 받을 수 있습니다.</li>
                                    <li>회사는 개인정보를 국외의 제3자에게 제공•위탁할 때에는 이용자에게 별도로 구분하여 내용을 알리고 법적 근거를 기재하여 동의를 받습니다.</li>
                                </ol>
                            </section>
                          <section class="policy_cont" id="rule4">
                                <h4>제4조 (개인정보의 취급위탁) </h4>
                                <ol>
                                    <li> 회사는 고객편의 서비스를 원활하게 제공하기 위해서 일부 업무를 전문업체에 위탁 운영하고 있습니다.</li>
                                    <li> 회사는 개인정보 보호의 만전을 기하기 위하여 서비스 제공자의 개인정보 처리위탁관련 적법한 처리절차, 보안지시엄수, 개인정보에 관한 비밀 유지, 업무 목적 및 범위를 벗어난 사용의 제한, 재위탁 제한 등 사고 시의 손해배상 책임부담을 명확히 규정하고 해당 계약내용을 서면 또는 전자적으로 보관하여 이를 엄격하게 관리감독 하고 있습니다.</li>
                                    <li> 위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개합니다.</li>
                                    <li> 회사에서 고객의 개인정보를 위탁하는 현황은 다음과 같습니다.
                                        <table border="0" cellspacing="0" cellpadding="0" class="tb03">
                                            <tr>
                                                <th width="203" valign="top">수탁자 </th>
                                                <th width="249" valign="top">위탁 목적</th>
                                                <th width="249" valign="top">담당 부서</th>
                                            </tr>
                                            <tr>
                                                <td width="203">㈜토스페이먼츠</td>
                                                <td width="249">결제처리</td>
                                                <td width="249">마케팅관리팀</td>
                                            </tr>
                                            <tr>
                                                <td width="203">(주)이노포스트</td>
                                                <td width="249">SMS 발송</td>
                                                <td width="249">경영관리실 </td>
                                            </tr>
                                        </table>
                                    </li>
                                </ol>
                            </section>
                            <section class="policy_cont" id="rule5">
                                <h4>제5조 (개인정보의 보유ㆍ이용 기간, 파기 절차 및 파기방법)</h4>
                                <ol>
                                    <li>회사는 이용자가 회사에서 제공하는 서비스를 이용하는 동안 이용자들의 개인정보를 보유하며 서비스 제공 등의 목적을 위해 이용합니다. 전산에 등록된 이용자의 개인정보는 개인정보관리 담당자 및 책임자 또는 이들의 승인을 얻은 자가 아니면 문서로 출력할 수 없습니다.</li>
                                    <li>회사는 이용자가 자신의 개인정보를 삭제하거나 회원가입 탈퇴를 요청한 경우 지체 없이 조치를 취하며, 삭제된 정보는 기록을 복구 또는 재생할 수 없는 방법에 의하여 디스크에서 완전히 삭제하며 추후 열람이나 이용이 불가능한 상태로 처리됩니다.</li>
                                    <li>회사는 개인정보의 수집목적 및 또는 제공받은 목적이 아래와 같이 파기사유가 발생한 때에 회사의 내부 파기절차에 따라 디스크에서 정보를 삭제하고, 출력된 경우에는 분쇄기로 분쇄하는 방법으로 이용자의 개인정보를 지체 없이 파기합니다.
                                        <ol>
                                            <li>회원가입정보의 경우 : 회원가입을 탈퇴하거나 회원에서 제명된 때 </li>
                                            <li>대금지급정보의 경우 : 대금의 완제일 또는 채권소멸시효기간이 만료된 때 </li>
                                            <li>설문조사, 이벤트 등의 목적을 위하여 수집한 경우 : 해당 설문조사, 이벤트가 종료한 때 </li>
                                        </ol>
                                    </li>
                                    <li>수집목적 또는 제공받은 목적이 달성된 경우에도 전자상거래 등에서의 소비자보호에 관한 법률, 개인정보보호법, 상법, 국세기본법 등 법령의 규정에 의하여 보존할 필요성이 있는 경우에는 다음과 같이 일정기간 이용자의 개인정보를 보유할 수 있습니다.
                                        <ol>
                                            <li>계약 또는 청약철회 등에 관한 기록 : 5년 </li>
                                            <li>대금결제 및 재화 등의 공급에 관한 기록 : 5년 </li>
                                            <li>소비자 불만 또는 분쟁 처리에 관한 기록 : 3년 </li>
                                            <li>웹사이트 방문기록 : 3개월 </li>
                                        </ol>
                                    </li>
                                </ol>
                            </section>
                            <section class="policy_cont" id="rule6">
                                <h4>제6조 (개인정보 보호업무 및 관련 고충사항 처리 부서)</h4>
                                <ol>
                                    <li>회사는 이용자의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 개인정보보호업무  및 관련 고충사항을 처리하는 부서가 지정되어 있습니다. 또한 개인정보 관리 책임자와 개인정보 관리 담당자를  두어 이용자의 개인정보에 관한 문의 및 불만을 신속하게 처리해드리고 있습니다.
                                        <div class="box">
                                            <p>[개인정보 보호 최고 책임자]<br />
                                                성명: 양희범 소장 </p>
                                            <p>[개인정보 보호 담당자]<br />
                                                성명: 채세나 전임 <br />
                                                소속: 기술개발연구소 <br />
                                                연락처: 02-593-4174 <a href="mailto:help@dahami.com">help@dahami.com</a> (월~금 08:00~17:00, 공휴일 제외)</p>
                                        </div>
                                    </li>
                                    <li>이용자는 자신의 개인정보에 관하여 침해의 발생 또는 그 염려로 인하여 상담이 필요한 때에는 제1항의 회사 개인정보보호 담당부서뿐만 아니라 다음의 기관 등에 문의할 수 있습니다.
                                        <ol>
                                            <li>개인정보 분쟁조정위원회: (국번없이) 1833-6972 (www.kopico.go.kr)</li> <li>개인정보침해신고센터: (국번없이) 118 (privacy.kisa.or.kr)</li>
											<li>대검찰청: (국번없이) 02-3480-3570 (www.spo.go.kr)</li>
											<li>경찰청: (국번없이) 182 (ecrm.cyber.go.kr) </li>
                                        </ol>
								
								
「개인정보 보호법」 제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.
<br> ※ 중앙행정심판위원회 : (국번없이) 110(center.simpan.go.kr) 
                                    </li>
                                </ol>
                            </section>
                            <section class="policy_cont" id="rule7">
                              <h4>제7조 (개인정보 자동수집 장치에 의한 개인정보 수집)</h4>
                                <ol>
                                    <li>이용자에게 개인 맞춤화 서비스를 제공하기 위해서 회사는 이용자의 정보를 저장하고 수시로 불러오는 '쿠키(cookie)'를 사용합니다. 쿠키는 웹사이트를 운영하는데 이용되는 서버가 사용자의 브라우저에게 보내는 조그마한 데이터 꾸러미로 이용자 컴퓨터의 하드디스크에 저장됩니다 </li>
                                    <li>방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 보안접속 여부 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.  회사는 아래와 같은 목적으로 쿠키를 사용합니다.<br>회사는 아래와 같은 목적으로 쿠키를 사용합니다. 
                                        <ol>
                                            <li>로그인 유지를 위한 아이디 정보 1시간 저장 </li>
                                            <li>회원가입 완료 후 자동 로그인을 위한 아이디 및 유저 구분 코드(고객/기업)와 기업명 </li>
                                        </ol>
                                    </li>
                                    <li>이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서, 이용자는 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다. 쿠키 저장을 거부하는 경우 제공하는 일부 서비스 이용에 제한이 있을 수 있습니다. 
                                    </li>
                                    <li>회사는 구글(Google)에서 제공하는 웹 분석 도구인 구글 애널리틱스를 이용하고 있으며, 이용자 개인을 식별할 수 없는 비식별화 처리된 정보를 이용합니다. 이용자는 구글 애널리틱스 Opt-out Browser Add-on을 이용하거나, 쿠키 설정 거부를 통해 구글 애널리틱스 이용을 거부할 수 있습니다.</li>
                                </ol>
                            </section>
                            <section class="policy_cont" id="rule8">
                                <h4> 제8 조 (개인정보의 열람 및 정정 등)</h4>
                                <ol>
                                    <li>이용자는 언제든지 회사의 웹사이트에 로그인하여 [회원정보수정]을 클릭하여 직접 열람 또는 정정하거나, 영업사원을 비롯한 개인정보 취급위탁을 받은 자에게 요청하거나, 회사의 개인정보보호부서로 전화, 서면, 전자우편(e-mail)로 연락하여, 열람, 정정, 삭제, 처리정지를 요구할 수 있으며, 회사는 이용자의 요구에 대하여 지체 없이 관련 조치를 취하겠습니다.</li>
                                    <li>이용자가 개인정보의 오류에 대한 정정을 요청한 경우 회사는 정정을 완료하기 전까지 해당 개인정보를 이용 또는 제공 등 처리하지 않습니다. 또한 잘못된 개인정보를 이미 처리한 경우에는 정정 처리결과가 지체없이 반영되도록 조치하겠습니다.</li>
                                    <li>다음과 같은 경우에는 개인정보의 열람 및 정정 등을 제한할 수 있습니다.
                                        <ul>
                                            <li>제3자의 권익을 현저하게 해할 우려가 있는 경우 </li>
                                            <li>해당 서비스제공자의 업무에 현저한 지장을 미칠 우려가 있는 경우 </li>
                                            <li>법령을 위반하는 경우 등 </li>
                                        </ul>
                                    </li>
                                </ol>
                            </section>
                            <section class="policy_cont" id="rule9">
                                <h4> 제9 조 (개인정보 수집 • 이용 • 제공에 대한 동의 철회)</h4>
                                <ol>
                                    <li>이용자는 개인정보의 수집, 이용 및 제공에 대해 동의한 내용을 언제든지 철회할 수 있습니다. 동의철회(회원탈퇴)는 회사 웹사이트에 로그인한 후 직접 동의철회(회원탈퇴)를 하거나, 영업사원을 비롯한 개인정보 취급위탁을 받은 자에게 요청하거나, 개인정보 관리책임부서로 서면, 전화 또는 전자우편(E-mail) 등으로 연락하는 등의 방법으로 할 수 있습니다. 회사는 이용자의 요청에 대하여 지체 없이 이용자의 회원탈퇴 처리 및 개인정보의 파기 등 필요한 조치를 하겠습니다.</li>
                                    <li>회사는 개인정보의 수집에 대한 동의철회(회원탈퇴)를 개인정보의 수집 방법보다 쉽게 할 수 있도록 필요한 조치를 취하도록 노력합니다.</li>
                                </ol>
                            </section>
                            <section class="policy_cont" id="rule10">
                                <h4> 제10 조 (개인정보보호를 위한 관리적 • 기술적 • 물리적 대책)</h4>
                                <ol>
                                    <li>회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.
										<ul><li>•	관리적 조치 : 내부관리계획 수립·시행, 정기적 직원 교육</li><li>
•	기술적 조치 : 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의 암호화, 보안프로그램 설치</li><li>
•	물리적 조치 : 전산실, 자료보관실 등의 접근통제 
</li></ul></li>
                                    
                                </ol>
                            </section>
                            <section class="policy_cont" id="rule11">
                                <h4> 제11 조 (이용자 및 법정대리인의 권리와 그 행사방법)</h4>
                                <ol>
                                    <li>이용자 및 법정대리인은 회사에 대하여 제공한 본인 또는 법정대리인으로서 개인정보를 조회, 수정, 변경 및 회원의 탈퇴 등과 관련한 권리를 행사할 수 있습니다.</li>
                                    <li>이용자 및 법정대리인은 개인정보와 관련하여 인터넷, 전화, 서면, 이메일  등을 이용하여 회사에 연락을 하여 권리를 행사할 수 있으며, 회사는 지체 없이 필요한 조치를 합니다.</li>
                                </ol>
                            </section>
                            <section class="policy_cont" id="rule12">
                                <h4> 제12 조 (보호정책 변경 시 공지의무)</h4>
                                <p>개인정보취급방침은 법령•정책 및 회사 내부 운영방침 또는 보안기술의 변경에 따라 내용이 변경될 수 있으며, 이 때 변경되는 개인정보취급방침은 회사 사이트의 공지사항에 고지하도록 하겠습니다</p>
                            </section>
                            <section class="policy_cont" id="rule13">
                                <h4>부칙</h4>
								<p>공고일자: 2024년 9월 11일</p><p>시행일자: 2024년 9월 18일 </p>
                            </section>
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
                    <a target="_blank" href="/policy.intro">이용약관</a>
                </li>
                <li class="bar"></li>
                <li>
                    <a target="_blank" href="/privacy.intro">개인정보처리방침</a>
                </li>
            </ul>
            <div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
        </footer>
    </div>
</body>

</html>