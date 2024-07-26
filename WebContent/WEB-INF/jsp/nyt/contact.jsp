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
  2017. 12. 19.   	  hoydev        질문하기 등록
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
			    <script src="js/footer.js"></script>
			</head>
			
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
			                    <li><a href="/FAQ">FAQ</a></li>
			                    <li class="on"><a href="/contact">직접 문의하기</a></li>
			                </ul>
			            </div>
			            <div class="table_head">
			                <h3>직접 문의하기</h3>
			            </div>
			            <div class="call">
			                <!-- 여기 내용들은 바뀔거에요 지금 다하미홈페이지에서 끌어온내용이라 내용 바뀝니다 -->
			                <table width="100%" border="0" cellspacing="0" cellpadding="0">
			                    <tbody>
			                        <tr>
			                            <th scope="col">문의사항</th>
			                            <th scope="col">연락처</th>
			                            <th scope="col">메일</th>
			                        </tr>
			                        <tr>
			                            <td>기술지원</td>
			                            <td>02-593-4174 (414)</td>
			                            <td>helpdesk@dahami.com</td>
			                        </tr>
			                    </tbody>
			                </table>
			                <div class="call_box">
			                    <h3>개인정보 수집 및 이용동의</h3>
			                    <div class="agree_box"> <strong>[개인정보 수집 등에 대한 동의]</strong><br>
                        <br>
                        <strong>1. 개인정보 수집 항목 및 목적</strong><br>
                        다하미커뮤니케이션즈는 NYT 뉴스뱅크 관련 사항을 문의하는 고객과의 원활한 의사소통을 위한 목적으로 아래와 같은 항목을 수집합니다.<br>
                        : 이름, 이메일 주소, 연락처<br>
                        <br>
                        <strong>2. 개인정보의 보유 및 이용기간</strong><br>
                        : 수집된 개인정보는 보유 및 이용 목적이 완료된 후 즉시 파기됩니다. 또한 ‘문의하기’를 통해 삭제 요청을 하는 경우 3일 이내 파기됩니다.<br>
                        <br>
                        ※ 귀하는 이에 대한 동의를 거부할 수 있으며, 다만 동의하지 않으실 경우 문의가 불가능 할 수 있음을 알려드립니다.<br>
                        <br>
                    </div>
			                    <div class="agree_check">
			                        <p>
			                            <input type="checkbox">
			                            <label for="agree">개인정보 수집 및 이용에 동의합니다.</label>
			                        </p>
			                    </div>
			                    <h3>질문하기</h3>
			                    <dl>
			                        <dt>성명</dt>
			                        <dd>
			                            <input type="text" />
			                        </dd>
			                        <dt>연락처</dt>
			                        <dd>
			                            <input type="text" class="num" />
			                            <span>-</span>
			                            <input type="text" class="num" />
			                            <span>-</span>
			                            <input type="text" class="num" />
			                        </dd>
			                        <dt>이메일</dt>
			                        <dd>
			                            <input type="text" class="mail" />
			                            <span>@</span>
			                            <input type="text" class="mail" />
			                        </dd>
			                        <dt>제목</dt>
			                        <dd>
			                            <input type="text" style="width:950px" />
			                        </dd>
			                        <dt class="main_cont">질문내용</dt>
			                        <dd class="main_cont">
			                            <textarea></textarea>
			                        </dd>
			                    </dl>
			                    <div class="call_send"><a href="#">등록</a></div>
			                </div>
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
			    <script src="js/footer.js"></script>
			</head>
			
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
			                    <li><a href="/FAQ">FAQ</a></li>
			                    <li class="on"><a href="/contact">Contact us directly</a></li>
			                </ul>
			            </div>
			            <div class="table_head">
			                <h3>Contact us directly</h3>
			            </div>
			            <div class="call">
			                <table width="100%" border="0" cellspacing="0" cellpadding="0">
			                    <tbody>
			                        <tr>
			                            <th scope="col">Contact us</th>
			                            <th scope="col">Contacts</th>
			                            <th scope="col">Email</th>
			                        </tr>
			                        <tr>
			                            <td>Technical Supports</td>
			                            <td>02-593-4174 (414)</td>
			                            <td>helpdesk@dahami.com</td>
			                        </tr>
			                    </tbody>
			                </table>
			                <div class="call_box">
			                    <h3>Consent to Collection and Use of Personal Information</h3>
			                    <div class="agree_box"> <strong>[Consent to the collection and use of personal information]</strong><br>
			                        <br>
			                        <strong>1. Personal Information Collection : Items and Purpose</strong><br>
			                        We collect the following information to facilitate communication with customers who inquire about Dahami Communications NYT Newsbank.<br>
			                        : Name, Email, Phone Number<br>
			                        <br>
			                        <strong>2. Retention and use period of personal information</strong><br>
			                        : The collected personal information is destroyed immediately after the purpose of retention and use is completed. In addition, if you request deletion through 'Contact Us', it will be destroyed within 3 days.<br>
			                        <br>
			                        ※ You may refuse to agree to this. And if you do not agree, we will not be able to send you emails through Ask a Question.<br>
			                        <br>
			                    </div>
			                    <div class="agree_check">
			                        <p>
			                            <input type="checkbox">
			                            <label for="agree">I agree to the collection and use of personal information.</label>
			                        </p>
			                    </div>
			                    <h3>Question</h3>
			                    <dl>
			                        <dt>Name</dt>
			                        <dd>
			                            <input type="text" />
			                        </dd>
			                        <dt>Phone Number</dt>
			                        <dd>
			                            <input type="text" class="num" />
			                            <span>-</span>
			                            <input type="text" class="num" />
			                            <span>-</span>
			                            <input type="text" class="num" />
			                        </dd>
			                        <dt>Email</dt>
			                        <dd>
			                            <input type="text" class="mail" />
			                            <span>@</span>
			                            <input type="text" class="mail" />
			                        </dd>
			                        <dt>Title</dt>
			                        <dd>
			                            <input type="text" style="width:950px" />
			                        </dd>
			                        <dt class="main_cont">Question Content</dt>
			                        <dd class="main_cont">
			                            <textarea></textarea>
			                        </dd>
			                    </dl>
			                    <div class="call_send"><a href="#">Submit</a></div>
			                </div>
			            </div>
			        </section>
			        <jsp:include page="./common/footerEN.jsp"/>
			    </div>
			</body>		
		</html>	
	</c:otherwise>
</c:choose>