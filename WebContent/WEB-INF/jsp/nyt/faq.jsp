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
			                    <dt class="on"><a onClick="evt('0')"><span class="faq_tit">뉴스뱅크에 사진 콘텐츠를 제공하고 싶습니다.</span><span class="faq_ico"></span></a></dt>
			                    <dd id="0" style="display: block;">
			                        <p>희소성이 있는 사진, 잘 찍은 사진을 다수 보유하고 계시다면 이를 뉴스뱅크에 제공하실 수 있습니다.<br />
			                            뉴스뱅크는 저작권 대리중개를 통해 사진 저작물을 판매를 통해 발생한 수익을 다시 저작권자에게 돌려드립니다.<br />
			                            뉴스뱅크 상담전화(02-593-4174)로 연락을 주시면 자세히 안내해드립니다.</p>
			                    </dd>
			                    <dt><a onClick="evt('2')"><span class="faq_tit">세금계산서는 어떻게 받나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="2">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('3')"><span class="faq_tit"> 전화로 상담을 하고 싶습니다.</span><span class="faq_ico"></span></a></dt>
			                    <dd id="3">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('4')"><span class="faq_tit">가상계좌로 했습니다. 입금확인은 언제 되나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="4">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('5')"><span class="faq_tit">콘텐츠 사용을 위한 결제방법은 어떤 것이 있나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="5">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('6')"><span class="faq_tit">결제한 콘텐츠는 어디에서 다운로드 받나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="6">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('7')"><span class="faq_tit">회원으로 가입해야만 사진을 다운로드할 수 있나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="7">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('8')"><span class="faq_tit">아이디와 패스워드를 변경하고 싶습니다.</span><span class="faq_ico"></span></a></dt>
			                    <dd id="8">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('9')"><span class="faq_tit">아이디와 패스워드를 분실했을 경우는 어떻게 하나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="9">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('10')"><span class="faq_tit">회원탈퇴는 어떻게 하나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="10">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('11')"><span class="faq_tit">회원가입은 어떻게 하나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="11">
			                        <p></p>
			                    </dd>
			                </dl>
			                <!-- 나중에 쓸수도 있어요 지금 어차피 faq 11개라 그냥 가려놔도 될거같아요
						<div class="pagination">
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
			    <title>NYT 뉴스뱅크</title>
			    <link rel="stylesheet" href="css/nyt/reset.css" />
			    <link rel="stylesheet" href="css/nyt/base.css" />
			    <link rel="stylesheet" href="css/nyt/mypage.css" />
			    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
			</head>
			
			<jsp:include page="./common/head_meta.jsp"/>
			<body>
			    <div class="wrap">
					<jsp:include page="./common/headerEN2.jsp"/>			    
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
			                    <dt class="on"><a onClick="evt('0')"><span class="faq_tit">뉴스뱅크에 사진 콘텐츠를 제공하고 싶습니다.</span><span class="faq_ico"></span></a></dt>
			                    <dd id="0" style="display: block;">
			                        <p>희소성이 있는 사진, 잘 찍은 사진을 다수 보유하고 계시다면 이를 뉴스뱅크에 제공하실 수 있습니다.<br />
			                            뉴스뱅크는 저작권 대리중개를 통해 사진 저작물을 판매를 통해 발생한 수익을 다시 저작권자에게 돌려드립니다.<br />
			                            뉴스뱅크 상담전화(02-593-4174)로 연락을 주시면 자세히 안내해드립니다.</p>
			                    </dd>
			                    <dt><a onClick="evt('2')"><span class="faq_tit">세금계산서는 어떻게 받나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="2">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('3')"><span class="faq_tit"> 전화로 상담을 하고 싶습니다.</span><span class="faq_ico"></span></a></dt>
			                    <dd id="3">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('4')"><span class="faq_tit">가상계좌로 했습니다. 입금확인은 언제 되나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="4">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('5')"><span class="faq_tit">콘텐츠 사용을 위한 결제방법은 어떤 것이 있나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="5">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('6')"><span class="faq_tit">결제한 콘텐츠는 어디에서 다운로드 받나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="6">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('7')"><span class="faq_tit">회원으로 가입해야만 사진을 다운로드할 수 있나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="7">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('8')"><span class="faq_tit">아이디와 패스워드를 변경하고 싶습니다.</span><span class="faq_ico"></span></a></dt>
			                    <dd id="8">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('9')"><span class="faq_tit">아이디와 패스워드를 분실했을 경우는 어떻게 하나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="9">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('10')"><span class="faq_tit">회원탈퇴는 어떻게 하나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="10">
			                        <p></p>
			                    </dd>
			                    <dt><a onClick="evt('11')"><span class="faq_tit">회원가입은 어떻게 하나요?</span><span class="faq_ico"></span></a></dt>
			                    <dd id="11">
			                        <p></p>
			                    </dd>
			                </dl>
			                <!-- 나중에 쓸수도 있어요 지금 어차피 faq 11개라 그냥 가려놔도 될거같아요
						<div class="pagination">
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
			        <jsp:include page="./common/footerEN.jsp"/>
			    </div>
			</body>		
		</html>	
	</c:otherwise>
</c:choose>