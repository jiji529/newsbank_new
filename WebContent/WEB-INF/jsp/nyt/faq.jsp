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
<c:choose>
	<c:when test="${cookie.language.value eq 'KR'}">
		<!DOCTYPE html>
		<html lang="ko">		
			<head>
			    <meta charset="UTF-8">
			    <title>NYT 뉴스뱅크</title>
			    <link rel="stylesheet" href="css/nyt/reset.css" />
			    <link rel="stylesheet" href="css/nyt/base.css" />
			    <link rel="stylesheet" href="css/nyt/mypage.css" />
			    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
			</head>
			
		    <script type="text/javascript">
		        //FAQ 클릭시 반응
		        function evt(newwin) {
		            var objid = document.getElementById(newwin);
		            var param = "action=hit";
		            //class='on'
		            if (objid.style.display == "block") {
		                objid.style.display = "none";
		                $(".faq dl dt").removeClass();
		            } else {
		                $('.faq dd').css('display', 'none');
		                $(".faq dl dt").removeClass();
		                objid.style.display = "block";
		                $("#dt" + newwin).addClass("on");
		            }
		        }
		    </script>			
			
			<jsp:include page="./common/head_meta.jsp"/>
			<body>
			    <div class="wrap">
			    <jsp:include page="./common/headerKR2.jsp"/>
			        <section class="mypage">
			            <div class="head">
			                <h2>이용안내</h2>
			                <p>뉴스뱅크 사이트에 관하여 알려드립니다.</p>
			            </div>
			            <div class="mypage_ul">
			                <ul class="mp_tab1 use">
			                    <li><a href="/price.info">구매안내</a></li>
			                    <li class="on"><a href="/FAQ">FAQ</a></li>
			                    <li><a href="/contact">직접 문의하기</a></li>
			                </ul>
			            </div>
			            <div class="table_head">
			                <h3>FAQ</h3>
			                <div class="cms_search">FAQ 검색
			                    <input type="text" />
			                    <button>검색</button>
			                </div>
			            </div>
			            <div class="faq">
			                <dl>
			                    <dt id="dt1" class=""><a onclick="evt('1')"><span class="faq_tit">뉴스뱅크에 사진 콘텐츠를 제공하고 싶습니다.</span><span class="faq_ico"></span></a></dt>
			                    <dd id="1" style="display: none;">
			                        <p>
			                            희소성이 있는 사진, 잘 찍은 사진을 다수 보유하고 계시다면 이를 뉴스뱅크에 제공하실 수 있습니다.<br>
			                            뉴스뱅크는 저작권 대리중개를 통해 사진 저작물을 판매를 통해 발생한 수익을 다시 저작권자에게 돌려드립니다.<br>
			                            뉴스뱅크 상담전화(02-593-4174)로 연락을 주시면 자세히 안내해드립니다.
			                        </p>
			                    </dd>
			                    <dt id="dt2" class=""><a onclick="evt('2')"><span class="faq_tit">세금계산서는 어떻게 받나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="2" style="display: none;">
			                        <p>
			                            실시간계좌이체/가상계좌를 이용하여 결제하신 콘텐츠의 세금계산서 발행을 원하시면 아래의 내용을 편하신 방법(메일, 팩스)으로 보내주신 후 연락바랍니다.<br>
			                            세금계산서 발행일자는 구입날짜로 작성되어 발행됩니다.<br>
			                            <br>
			                            * 뉴스뱅크 세금계산서 담당자<br>
			                            - 당담자명 : 강소라<br>
			                            - 전화 : 02-593-4174(내선번호 224)<br>
			                            - 팩스 : 02-593-4175<br>
			                            - 이메일 : srfliegen29@dahami.com<br>
			
			                            * 세금계산서 요청 시의 기재하실 내용<br>
			                            - 뉴스뱅크이미지 회원 아이디<br>
			                            - 이미지 구입날짜 및 결제금액<br>
			                            - 성함과 연락처<br>
			                            - 세금계산서 받을 이메일주소<br>
			                        </p>
			                    </dd>
			                    <dt id="dt3" class=""><a onclick="evt('3')"><span class="faq_tit"> 전화로 상담을 하고 싶습니다.</span><span class="faq_ico"></span></a></dt>
			                    <dd id="3" style="display: none;">
			                        <p>
			                            뉴스뱅크의 고객상담 전화번호는 02-593-4174(내선번호 224)입니다.<br>
			                            고객상담 업무시간은 평일(월~금) 오전 9시부터 오후 6시까지 입니다. <br>
			                            (점심시간 12:00~ 13:00) 휴일(토, 일, 공휴일)에는 업무를 진행하지 않습니다.<br>
			                            따라서 휴일에 발생한 고객 상담업무는 익영업일에 정상처리 됩니다.<br>
			                        </p>
			                    </dd>
			                    <dt id="dt4" class=""><a onclick="evt('4')"><span class="faq_tit">가상계좌로 했습니다. 입금확인은 언제 되나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="4" style="display: none;">
			                        <p>
			                            가상계좌를 사용할 경우 실시간으로 입금확인이 되는 결제시스템을 사용하고 있습니다.<br>
			                            콘텐츠를 장바구니에 담으신 후 가결제 시 안내해 드리는 입금계좌(가상계좌)로 24시간 이내로<br>
			                            입금을 하시면 자동으로 입금이 확인되어 콘텐츠를 다운로드 받으실 수 있습니다.<br>
			
			                            가상계좌 발급 신청 후 24시간이 지나면 다시 한번 가상계좌 결제를 재신청 하셔야 합니다.<br>
			                            만약 24시간 이내에 입금을 시도했는데도 입금이 안되거나 입금 후 다운로드가 안될 경우 02-593-4174으로 연락을 주시기 바랍니다.<br>
			                        </p>
			                    </dd>
			                    <dt id="dt5" class="on"><a onclick="evt('5')"><span class="faq_tit">콘텐츠 사용을 위한 결제방법은 어떤 것이 있나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="5" style="display: block;">
			                        <p>
			                            뉴스뱅크의 콘텐츠 결제방법은 세 가지가 있습니다.<br>
			                            <br>
			                            - 신용카드 : 신용카드를 이용한 실시간 결제입니다.<br>
			                            - 실시간 계좌이체 : 결제 시 인터넷 서비스를 통해 실시간으로 계좌이체 하는 방법입니다.<br>
			                            - 가상계좌 : 결제 시 안내드리는 계좌번호로 24시간 이내로 입금하시는 방법입니다.<br>
			                        </p>
			                    </dd>
			                    <dt id="dt6" class=""><a onclick="evt('6')"><span class="faq_tit">결제한 콘텐츠는 어디에서 다운로드 받나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="6" style="display: none;">
			                        <p>
			                            사이트 오른쪽 상단 ‘마이페이지’의 ‘구매내역’ 페이지에서 다운로드 가능합니다. <br>
			                            다운로드는 결제 후 24시간 동안 가능하며, 24시간이 지나면 다운로드가 불가능합니다.<br>
			                        </p>
			                    </dd>
			                    <dt id="dt7" class=""><a onclick="evt('7')"><span class="faq_tit">회원으로 가입해야만 사진을 다운로드할 수 있나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="7" style="display: none;">
			                        <p>
			                            회원가입을 하셔야만 뉴스뱅크에 수록된 사진 콘텐츠 등을 원본의 상태로 다운로드하실 수 있습니다.
			                        </p>
			                    </dd>
			                    <dt id="dt8" class=""><a onclick="evt('8')"><span class="faq_tit">아이디와 패스워드를 변경하고 싶습니다.</span><span class="faq_ico"></span></a></dt>
			                    <dd id="8" style="display: none;">
			                        <p>
			                            회원가입 시 고객님께서 지정하신 아이디는 가입 이후 변경이 불가능합니다.<br>
			                            비밀번호는 로그인 후 사이트 오른쪽 상단 '마이페이지'의 '회원정보 관리' 페이지에서 변경하실 수 있습니다.<br>
			                        </p>
			                    </dd>
			                    <dt id="dt9" class=""><a onclick="evt('9')"><span class="faq_tit">아이디와 패스워드를 분실했을 경우는 어떻게 하나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="9" style="display: none;">
			                        <p>
			                            아이디와 패스워드를 잊어버렸을 경우, 사이트 오른쪽 상단에 있는 "로그인" 페이지에서 아이디/비밀번호 찾기를 이용하시면 됩니다.
			                        </p>
			                    </dd>
			                    <dt id="dt10" class=""><a onclick="evt('10')"><span class="faq_tit">회원탈퇴는 어떻게 하나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="10" style="display: none;">
			                        <p>
			                            회원 탈퇴를 원하는 회원은 뉴스뱅크 담당자 이메일(srfliegen29@dahami.com)로 아래의 내용을 적어 보내주시기 바랍니다.<br>
			                            1.뉴스뱅크이미지 회원 아이디<br>
			                            2.회원 이름<br>
			                            3.연락처<br>
			                        </p>
			                    </dd>
			                    <dt id="dt11" class=""><a onclick="evt('11')"><span class="faq_tit">회원가입은 어떻게 하나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="11" style="display: none;">
			                        <p>
			                            웹사이트에서 무료로 회원 가입 가능합니다.<br>
			                            사이트 오른쪽 상단에 있는 "회원가입" 버튼을 클릭하고 개인정보를 입력해 주시면 뉴스뱅크의 회원이 됩니다.<br>
			                        </p>
			                    </dd>
			                </dl>
			            </div>
			        </section>
			        <jsp:include page="./common/footerKR.jsp"/>
			    </div>
			</body>		
		</html>	
	</c:when>
	<c:otherwise>
		<!DOCTYPE html>
		<html lang="en">
			<head>
			    <meta charset="UTF-8">
			    <title>NYT Newsbank</title>
			    <link rel="stylesheet" href="css/nyt/reset.css" />
			    <link rel="stylesheet" href="css/nyt/base.css" />
			    <link rel="stylesheet" href="css/nyt/mypage.css" />
			    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
			</head>

		    <script type="text/javascript">
		        //FAQ 클릭시 반응
		        function evt(newwin) {
		            var objid = document.getElementById(newwin);
		            var param = "action=hit";
		            //class='on'
		            if (objid.style.display == "block") {
		                objid.style.display = "none";
		                $(".faq dl dt").removeClass();
		            } else {
		                $('.faq dd').css('display', 'none');
		                $(".faq dl dt").removeClass();
		                objid.style.display = "block";
		                $("#dt" + newwin).addClass("on");
		            }
		        }
		    </script>			
			
			<jsp:include page="./common/head_meta.jsp"/>
			<body>
			    <div class="wrap">
					<jsp:include page="./common/headerEN2.jsp"/>			    
			        <section class="mypage">
			            <div class="head">
			                <h2>User Guide</h2>
			            </div>
			            <div class="mypage_ul">
			                <ul class="mp_tab1 use">
			                    <li><a href="/price.info">Purchase</a></li>
			                    <li class="on"><a href="/FAQ">FAQ</a></li>
			                    <li><a href="/contact">Contact us directly</a></li>
			                </ul>
			            </div>
			            <div class="table_head">
			                <h3>FAQ</h3>
			                <div class="cms_search">Search FAQs
			                    <input type="text" />
			                    <button>Search</button>
			                </div>
			            </div>
			            <div class="faq">
			                <dl>
			                    <dt id="dt1" class=""><a onclick="evt('1')"><span class="faq_tit">I'd like to contribute photo contents to Newsbank.
			                            </span><span class="faq_ico"></span></a></dt>
			                    <dd id="1" style="display: none;">
			                        <p>
			                            If you have a lot of rare or well-taken photos, you can contribute them to Newsbank.<br>
			                            Newsbank sells photographic works through a copyright agency, and returns the revenue generated back to the copyright holder.<br>
			                            Please contact the our Help desk(02-593-4174) and we'll be happy to help you further.
			
			                        </p>
			                    </dd>
			                    <dt id="dt2" class=""><a onclick="evt('2')"><span class="faq_tit">How do I get my tax bill?
			                            </span><span class="faq_ico"></span></a></dt>
			                    <dd id="2" style="display: none;">
			                        <p>
			                            If you would like to issue a tax invoice for the content you paid for using real-time bank transfer or virtual account, please send the following information to us via your preferred method (email, fax) and contact us.<br>
			                            The invoice date is created from the date of purchase.<br>
			                            Tax Invoice Representative<br>
			                            Contact Point : Sora Kang<br>
			                            Phone: 02-593-4174 (ext. 224)<br>
			                            Fax: 02-593-4174<br>
			                            E-Mail : srfliegen29@dahami.com<br>
			                            What to include in your tax invoice<br>
			                            Personal ID of Newsbank<br>
			                            Purchase date and payment<br>
			                            Your name and contact detail<br>
			                            Email address to receive tax invoice
			
			                        </p>
			                    </dd>
			                    <dt id="dt3" class="on"><a onclick="evt('3')"><span class="faq_tit">I'd like to contact by phone.
			                            </span><span class="faq_ico"></span></a></dt>
			                    <dd id="3" style="display: block;">
			                        <p>
			                            Newsbank's customer support number is 02-593-4174 (ext. 224).<br>
			                            The business hours are 9:00 a.m. to 6:00 p.m. on weekdays (Monday through Friday).<br>
			                            We do not work during lunch breaks (12:00~13:00) and holidays (Saturdays, Sundays, and public holidays).<br>
			                            Therefore, customer support issues that occur on holidays will be resolved on the next business day.
			
			                        </p>
			                    </dd>
			                    <dt id="dt4" class=""><a onclick="evt('4')"><span class="faq_tit">I paid with a virtual account, when will my payment be confirmed?
			                            </span><span class="faq_ico"></span></a></dt>
			                    <dd id="4" style="display: none;">
			                        <p>
			                            We use a payment system that verifies your virtual account in real time.<br>
			                            Once you've added the content to your cart, please make a deposit to the virtual account you'll be provided with at checkout within 24 hours. The deposit will be automatically confirmed and you'll be able to download the content.<br>
			                            If 24 hours have passed since you applied for a virtual account, you will need to apply for virtual account payment again.<br>
			                            If you are unable to make a deposit within 24 hours, or if you are unable to download the content after making a deposit, please contact us at 02-593-4174.
			
			                        </p>
			                    </dd>
			                    <dt id="dt5" class=""><a onclick="evt('5')"><span class="faq_tit">What are the different ways to pay for content?
			                            </span><span class="faq_ico"></span></a></dt>
			                    <dd id="5" style="display: none;">
			                        <p>
			                            There are three ways to pay for content in Newsbank<br>
			                            Credit card: This is a real-time payment using a credit card.<br>
			                            Real-time bank transfer: This is a method of real-time bank transfer through internet service at the time of payment.<br>
			                            Virtual account: Deposit money to the account number provided at the time of payment within 24 hours.
			
			                        </p>
			                    </dd>
			                    <dt id="dt6" class=""><a onclick="evt('6')"><span class="faq_tit">Where can I download the content I paid for?
			                            </span><span class="faq_ico"></span></a></dt>
			                    <dd id="6" style="display: none;">
			                        <p>
			                            You can download the images from the 'Purchase History' page in the top right corner of the site under 'My Page'.<br>
			                            Downloads are available for 24 hours only after payment.
			
			                        </p>
			                    </dd>
			                    <dt id="dt7" class=""><a onclick="evt('7')"><span class="faq_tit">Do I need to be a member to download photos?
			                            </span><span class="faq_ico"></span></a></dt>
			                    <dd id="7" style="display: none;">
			                        <p>You must be a registered member to download photo content from the Newsbank in its original form.
			
			                        </p>
			                    </dd>
			                    <dt id="dt8" class=""><a onclick="evt('8')"><span class="faq_tit">I want to change my ID and password.
			                            </span><span class="faq_ico"></span></a></dt>
			                    <dd id="8" style="display: none;">
			                        <p>
			                            The ID you assigned cannot be changed after signing up.<br>
			                            You can change your password after logging in to "My Account".
			
			                        </p>
			                    </dd>
			                    <dt id="dt9" class=""><a onclick="evt('9')"><span class="faq_tit">What if I forgot my ID and password?
			                            </span><span class="faq_ico"></span></a></dt>
			                    <dd id="9" style="display: none;">
			                        <p>
			                            If you have forgotten your ID and password, you can use ID /password finder on the “Login” page in the top right corner of the site.
			
			                        </p>
			                    </dd>
			                    <dt id="dt10" class=""><a onclick="evt('10')"><span class="faq_tit">How can I cancel my membership?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="10" style="display: none;">
			                        <p>
			                            If you wish to cancel your membership, please send an email to your Newsbank representative at srfliegen29@dahami.com with the following information<br>
			                            1. Member ID<br>
			                            2. Member Name<br>
			                            3. Contact Information
			
			                        </p>
			                    </dd>
			                    <dt id="dt11" class=""><a onclick="evt('11')"><span class="faq_tit">How can I sign up?
			                            </span><span class="faq_ico"></span></a></dt>
			                    <dd id="11" style="display: none;">
			                        <p>
			                            You can sign up for free on our website.<br>
			                            Simply click the “Sign Up” button, fill in your personal information and you will become a member of Newsbank.
			
			                        </p>
			                    </dd>
			                </dl>
			            </div>
			        </section>
			        <jsp:include page="./common/footerEN.jsp"/>
			    </div>
			</body>		
		</html>	
	</c:otherwise>
</c:choose>