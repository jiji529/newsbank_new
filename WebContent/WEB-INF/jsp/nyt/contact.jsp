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
		
		<jsp:include page="../common/head_meta.jsp"/>
		
		<body>
		    <div class="wrap"><nav class="gnb_dark">
		            <div class="gnb"><a href="/" class="nyt"><svg width="200" viewBox="0 0 184 25" fill="#000" aria-hidden="true">
		                        <path d="M14.57,2.57C14.57,.55,12.65-.06,11.04,.01V.19c.96,.07,1.7,.46,1.7,1.11,0,.45-.32,1.01-1.28,1.01-.76,0-2.02-.45-3.2-.84-1.3-.45-2.54-.87-3.57-.87-2.02,0-3.55,1.5-3.55,3.36,0,1.5,1.16,2.02,1.63,2.21l.03-.07c-.3-.2-.49-.42-.49-1.06,0-.54,.39-1.26,1.43-1.26,.94,0,2.17,.42,3.8,.88,1.4,.39,2.91,.76,3.75,.87v3.28l-1.58,1.3,1.58,1.36v4.49c-.81,.46-1.75,.61-2.56,.61-1.5,0-2.88-.42-4.02-1.68l4.26-2.07V5.73l-5.2,2.32c.54-1.38,1.55-2.41,2.66-3.08l-.03-.08C3.31,5.73,.5,8.56,.5,12.06c0,4.19,3.35,7.3,7.22,7.3,4.19,0,6.65-3.28,6.61-6.75h-.08c-.61,1.33-1.63,2.59-2.78,3.25v-4.38l1.65-1.33-1.65-1.33v-3.28c1.53,0,3.11-1.01,3.11-2.96M5.8,14.13l-1.21,.61c-.74-.96-1.23-2.32-1.23-4.07,0-.72,.08-1.7,.32-2.39l2.14-.96-.03,6.8h0Zm19.47-5.76l-.81,.64-2.47-2.2-2.86,2.21V.48l-3.89,2.69c.45,.15,.99,.39,.99,1.43v11.81l-1.33,1.01,.12,.12,.67-.46,2.32,2.12,3.11-2.07-.1-.15-.79,.52-1.08-1.08v-7.12l.74-.54,1.7,1.48v6.19c0,3.92-.87,4.73-2.63,5.37v.1c2.93,.12,5.57-.87,5.57-5.89v-6.75l.88-.72-.12-.15h0Zm5.22,10.8l4.51-3.62-.12-.17-2.36,1.87-2.71-2.14v-1.33l4.68-3.3-2.36-3.67-5.2,2.86v6.8l-1.01,.79,.12,.15,.96-.76,3.5,2.54h-.01Zm-.69-5.67v-5.15l2.27,3.55-2.27,1.6ZM53.65,1.61c0-.32-.08-.59-.2-.96h-.07c-.32,.87-.67,1.33-1.68,1.33-.88,0-1.58-.54-1.95-.94,0,.03-2.96,3.42-2.96,3.42l.15,.12,.84-.96c.64,.49,1.21,1.06,2.63,1.08V13.34l-6.06-10.5c-.47-.79-1.28-1.97-2.66-1.97-1.63,0-2.86,1.4-2.66,3.77h.1c.12-.59,.47-1.33,1.18-1.33,.57,0,1.03,.54,1.3,1.03v3.38c-1.87,0-2.93,.87-2.93,2.34,0,.61,.45,1.94,1.72,2.17v-.07c-.17-.17-.34-.32-.34-.67,0-.57,.42-.88,1.18-.88,.12,0,.3,.03,.37,.05v4.38c-2.2,.03-3.89,1.23-3.89,3.31s1.7,2.88,3.47,2.78v-.07c-1.11-.12-1.68-.69-1.68-1.5,0-.88,.64-1.36,1.45-1.36s1.43,.52,1.95,1.11l2.96-3.33-.12-.12-.76,.87c-1.14-1.01-1.87-1.48-3.18-1.68V4.67l8.36,14.57h.45V4.72c1.6-.1,3.03-1.3,3.03-3.11m2.81,17.54l4.51-3.62-.12-.17-2.36,1.87-2.71-2.14v-1.33l4.68-3.3-2.36-3.67-5.2,2.86v6.8l-1.01,.79,.12,.15,.96-.76,3.5,2.54h0Zm-.69-5.67v-5.15l2.27,3.55-2.27,1.6Zm21.22-5.52l-.69,.52-1.97-1.68-2.29,2.07,.94,.88v7.72l-2.34-1.6v-6.26l.81-.57-2.41-2.24-2.24,2.07,.94,.88v7.46l-.15,.1-2.2-1.6v-6.13c0-1.43-.72-1.85-1.63-2.41-.76-.47-1.16-.91-1.16-1.63,0-.79,.69-1.11,.91-1.23-.79-.03-2.98,.76-3.03,2.76-.03,1.03,.47,1.48,.99,1.97,.52,.49,1.01,.96,1.01,1.83v6.01l-1.06,.84,.12,.12,1.01-.79,2.63,2.14,2.51-1.75,2.76,1.75,5.42-3.2v-6.95l1.21-.94-.1-.15h0Zm18.15-5.84l-1.03,.94-2.32-2.02-3.13,2.51V1.19h-.19V18.12c-.34-.05-1.06-.25-1.85-.37V3.58c0-1.03-.74-2.47-2.59-2.47s-3.01,1.56-3.01,2.91h.08c.1-.61,.52-1.16,1.13-1.16s1.18,.39,1.18,1.78v4.04c-1.75,.07-2.81,1.16-2.81,2.34,0,.67,.42,1.92,1.75,1.97v-.1c-.45-.19-.54-.42-.54-.67,0-.59,.57-.79,1.36-.79h.19v6.51c-1.5,.52-2.2,1.53-2.2,2.78,0,1.72,1.38,3.05,3.4,3.05,1.43,0,2.44-.25,3.75-.54,1.06-.22,2.21-.47,2.83-.47,.79,0,1.14,.35,1.14,.91,0,.72-.27,1.08-.69,1.21v.1c1.7-.32,2.69-1.3,2.69-2.83s-1.5-2.54-3.18-2.54c-.87,0-2.44,.27-3.72,.57-1.43,.32-2.66,.47-3.11,.47-.72,0-1.6-.32-1.6-1.28,0-.87,.72-1.56,2.49-1.56,.96,0,1.9,.15,3.08,.42,1.26,.27,2.12,.64,3.2,.64,1.5,0,2.71-.54,2.71-2.74V3.29l1.11-1.01-.12-.15h0Zm-4.24,6.78c-.27,.3-.59,.54-1.11,.54-.57,0-.87-.3-1.14-.54V3.81l.74-.59,1.5,1.28v4.41h0Zm0,2.41c-.25-.25-.57-.47-1.11-.47s-.91,.27-1.14,.47v-2.17c.22,.19,.59,.49,1.14,.49s.87-.25,1.11-.49v2.17Zm0,5.1c0,.84-.42,1.78-1.5,1.78-.17,0-.57-.03-.74-.05v-6.58c.25-.22,.57-.52,1.14-.52,.52,0,.81,.25,1.11,.52v4.86h0Zm8.78,2.74l5.03-3.13v-6.85l-3.25-2.39-5.03,2.88v6.78l-.99,.79,.1,.15,.81-.67,3.33,2.44h0Zm-.37-3.55v-7.3l2.51,1.87v7.3l-2.51-1.87Zm15.01-8.65c-.39,.27-.74,.42-1.11,.42-.39,0-.88-.25-1.14-.57,0,.03-1.87,2.02-1.87,2.02l-1.87-2.02-3.05,2.12,.1,.17,.81-.54,1.11,1.21v6.63l-1.33,1.01,.12,.12,.67-.46,2.49,2.12,3.15-2.09-.1-.15-.81,.49-1.28-1.16v-7.28c.52,.57,1.11,1.06,1.82,1.06,1.28,0,2.14-1.53,2.29-3.11m11.88,9.81l-.94,.59-5.2-7.76,.27-.37c.57,.34,1.08,.81,2.17,.81s2.47-1.14,2.59-3.23c-.27,.37-.81,.81-1.7,.81-.64,0-1.28-.42-1.67-.81l-3.55,5.22,4.71,7.17,3.42-2.27-.1-.17h0Zm-6.31,.19l-.79,.52-1.08-1.08V.48l-3.89,2.69c.45,.15,.99,.39,.99,1.43v11.81l-1.33,1.01,.12,.12,.67-.46,2.32,2.12,3.11-2.07-.1-.15h0Zm22.89-14.39c0-2.02-1.92-2.63-3.53-2.56V.19c.96,.07,1.7,.46,1.7,1.11,0,.45-.32,1.01-1.28,1.01-.76,0-2.02-.45-3.2-.84-1.3-.45-2.54-.87-3.57-.87-2.02,0-3.55,1.5-3.55,3.35,0,1.5,1.16,2.02,1.63,2.21l.03-.07c-.3-.2-.49-.42-.49-1.06,0-.54,.39-1.26,1.43-1.26,.94,0,2.17,.42,3.8,.88,1.4,.39,2.91,.76,3.75,.87v3.28l-1.58,1.3,1.58,1.36v4.49c-.81,.46-1.75,.61-2.56,.61-1.5,0-2.89-.42-4.02-1.68l4.26-2.07V5.73l-5.2,2.32c.54-1.38,1.55-2.41,2.66-3.08l-.03-.08c-3.08,.84-5.89,3.67-5.89,7.17,0,4.19,3.35,7.3,7.22,7.3,4.19,0,6.65-3.28,6.61-6.75h-.07c-.61,1.33-1.63,2.59-2.78,3.25v-4.38l1.65-1.33-1.65-1.33v-3.28c1.53,0,3.11-1.01,3.11-2.96m-8.78,11.56l-1.21,.61c-.74-.96-1.23-2.32-1.23-4.07,0-.72,.07-1.7,.32-2.39l2.14-.96-.03,6.8h0Zm11.93-12.31l-2.17,1.82,1.85,2.09,2.17-1.82-1.85-2.09Zm3.3,15.15l-.79,.52-1.08-1.08v-7.17l.91-.72-.12-.15-.76,.59-1.8-2.14-2.96,2.07,.1,.17,.74-.49,.99,1.23v6.61l-1.33,1.01,.12,.12,.67-.46,2.32,2.12,3.11-2.07-.1-.15h0Zm16.63-.1l-.74,.49-1.16-1.11v-7.03l.94-.72-.12-.15-.84,.64-2.47-2.2-2.78,2.17-2.44-2.17-2.74,2.14-1.85-2.14-2.96,2.07,.1,.17,.74-.49,1.06,1.21v6.61l-.81,.81,2.36,2,2.29-2.07-.94-.88v-7.04l.61-.45,1.7,1.48v6.16l-.79,.81,2.39,2,2.24-2.07-.94-.88v-7.04l.59-.47,1.72,1.5v6.06l-.69,.72,2.41,2.2,3.18-2.17-.1-.15h.02Zm8.6-1.5l-2.36,1.87-2.71-2.14v-1.33l4.68-3.3-2.36-3.67-5.2,2.86v6.93l3.57,2.59,4.51-3.62-.12-.17h0Zm-5.08-1.88v-5.15l2.27,3.55-2.27,1.6Zm14.12-.97l-2-1.53c1.33-1.16,1.8-2.63,1.8-3.69,0-.15-.03-.42-.05-.67h-.08c-.19,.54-.72,1.01-1.53,1.01s-1.26-.45-1.75-.99l-4.58,2.54v3.72l1.75,1.38c-1.75,1.55-2.09,2.51-2.09,3.4s.52,1.67,1.41,2.02l.07-.12c-.22-.19-.42-.32-.42-.79,0-.34,.35-.88,1.14-.88,1.01,0,1.63,.69,1.95,1.06,0-.03,4.38-2.69,4.38-2.69v-3.77h0Zm-1.03-3.05c-.69,1.23-2.21,2.44-3.11,3.13l-1.11-.94v-3.62c.45,.99,1.36,1.82,2.54,1.82,.69,0,1.14-.12,1.67-.39m-1.9,8.13c-.52-1.16-1.63-2-2.86-2-.3,0-1.21-.03-2,.46,.47-.79,1.87-2.21,3.65-3.28l1.21,1.01v3.8Z"></path>
		                    </svg></a>
		                <a href="https://www.newsbank.co.kr/" target="_blank" class="logo"></a>
		                <ul class="gnb_left">
		                    <li><a href="#">아카이브</a></li>
		                </ul>
		                <ul class="gnb_right">
		                    <li><a href="/price.info">이용안내</a></li>
		                    <li><a href="#">로그인</a></li>
		                    <li><a href="#">가입하기</a></li>
		                </ul>
		            </div>
		
		            <div class="lang">
		                <a href="javascript:void(0)">언어</a>
		                <ul>
		                    <li class="on" onclick="languageChange('KR')">KR</li>
		                    <li class="" onclick="languageChange('EN')">EN</li>
		                </ul>
		            </div>
		            <div class="gnb_srch">
		                <form id="searchform" action="/photo" method="post">
		                    <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해주세요.">
		                    <input type="text" id="keyword_current" style="display: none;">
		                    <a href="javascript:void(0)" id="btn_search" class="btn_search">검색</a>
		                </form>
		
		                <div id="searchProgress" class="progress">
		                    <div id="searchProgressImg" class="loader"></div>
		                </div>
		            </div>
		            <div id="top"><a href="#">TOP</a></div>
		        </nav>
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
		                        해당 페이지는 다하미커뮤니케이션즈 중간관리자 지원 시 문의하는 내용에 대해 문의자와의 원활한 의사소통을 위한 목적으로 아래와 같은 항목을 수집합니다.<br>
		                        : 이름, 이메일 주소, 연락처<br>
		                        <br>
		                        <strong>3. 개인정보의 보유 및 이용기간</strong><br>
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
		        
		        <footer>
		            <div class="foot_wrap">
		                <div class="foot_lt">(주)다하미커뮤니케이션즈 | 대표 박용립<br />
		                    서울시 중구 마른내로 140 5층 (쌍림동, 인쇄정보센터)<br />
		                    고객센터 02-593-4174 | 사업자등록번호 112-81-49789 <br />
		                    저작권대리중개신고번호 제532호<br />
		                    통신판매업신고번호 제2016-서울중구-0501호 (사업자정보확인)</div>
		                <div class="foot_ct">
		                    <dl>
		                        <dt>이용안내</dt>
		                        <dd><a href="/price.info">구매안내</a></dd>
		                        <dd><a href="/FAQ">FAQ</a></dd>
		                        <dd><a href="/contact">직접 문의하기</a></dd>
		                    </dl>
		                    <dl>
		                        <dt>법적고지</dt>
		                        <dd><a href="#">이용약관</a></dd>
		                        <dd><b><a href="#">개인정보처리방침</a></b></dd>
		                    </dl>
		                </div>
		                <div class="foot_rt">
		                    <div id="family_site">
		                        <div id="select-title">Family site</div>
		                        <div id="select-layer" style="display: none;">
		                            <ul class="site-list">
		                                <li><a href="http://www.dahami.com/" target="_blank">다하미커뮤니케이션즈</a></li>
		                                <li><a href="http://scrapmaster.co.kr/" target="_blank">스크랩마스터</a></li>
		                                <li><a href="http://clippingon.co.kr/" target="_blank">클리핑온</a></li>
		                                <li><a href="http://www.t-paper.co.kr/" target="_blank">티페이퍼</a></li>
		                                <li><a href="http://www.news-plaza.co.kr/" target="_blank">뉴스플라자</a></li>
		                                <li><a href="http://ndpt.dahami.com/" target="_blank">NDPT</a></li>
		                            </ul>
		                        </div>
		                    </div>
		                </div>
		            </div>
		            <div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
		        </footer>
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
		    <script src="js/footer.js"></script>
		</head>
		
		<jsp:include page="../common/head_meta.jsp"/>
		
		<body>
		    <div class="wrap"><nav class="gnb_dark">
		            <div class="gnb"><a href="/" class="nyt"><svg width="200" viewBox="0 0 184 25" fill="#000" aria-hidden="true">
		                        <path d="M14.57,2.57C14.57,.55,12.65-.06,11.04,.01V.19c.96,.07,1.7,.46,1.7,1.11,0,.45-.32,1.01-1.28,1.01-.76,0-2.02-.45-3.2-.84-1.3-.45-2.54-.87-3.57-.87-2.02,0-3.55,1.5-3.55,3.36,0,1.5,1.16,2.02,1.63,2.21l.03-.07c-.3-.2-.49-.42-.49-1.06,0-.54,.39-1.26,1.43-1.26,.94,0,2.17,.42,3.8,.88,1.4,.39,2.91,.76,3.75,.87v3.28l-1.58,1.3,1.58,1.36v4.49c-.81,.46-1.75,.61-2.56,.61-1.5,0-2.88-.42-4.02-1.68l4.26-2.07V5.73l-5.2,2.32c.54-1.38,1.55-2.41,2.66-3.08l-.03-.08C3.31,5.73,.5,8.56,.5,12.06c0,4.19,3.35,7.3,7.22,7.3,4.19,0,6.65-3.28,6.61-6.75h-.08c-.61,1.33-1.63,2.59-2.78,3.25v-4.38l1.65-1.33-1.65-1.33v-3.28c1.53,0,3.11-1.01,3.11-2.96M5.8,14.13l-1.21,.61c-.74-.96-1.23-2.32-1.23-4.07,0-.72,.08-1.7,.32-2.39l2.14-.96-.03,6.8h0Zm19.47-5.76l-.81,.64-2.47-2.2-2.86,2.21V.48l-3.89,2.69c.45,.15,.99,.39,.99,1.43v11.81l-1.33,1.01,.12,.12,.67-.46,2.32,2.12,3.11-2.07-.1-.15-.79,.52-1.08-1.08v-7.12l.74-.54,1.7,1.48v6.19c0,3.92-.87,4.73-2.63,5.37v.1c2.93,.12,5.57-.87,5.57-5.89v-6.75l.88-.72-.12-.15h0Zm5.22,10.8l4.51-3.62-.12-.17-2.36,1.87-2.71-2.14v-1.33l4.68-3.3-2.36-3.67-5.2,2.86v6.8l-1.01,.79,.12,.15,.96-.76,3.5,2.54h-.01Zm-.69-5.67v-5.15l2.27,3.55-2.27,1.6ZM53.65,1.61c0-.32-.08-.59-.2-.96h-.07c-.32,.87-.67,1.33-1.68,1.33-.88,0-1.58-.54-1.95-.94,0,.03-2.96,3.42-2.96,3.42l.15,.12,.84-.96c.64,.49,1.21,1.06,2.63,1.08V13.34l-6.06-10.5c-.47-.79-1.28-1.97-2.66-1.97-1.63,0-2.86,1.4-2.66,3.77h.1c.12-.59,.47-1.33,1.18-1.33,.57,0,1.03,.54,1.3,1.03v3.38c-1.87,0-2.93,.87-2.93,2.34,0,.61,.45,1.94,1.72,2.17v-.07c-.17-.17-.34-.32-.34-.67,0-.57,.42-.88,1.18-.88,.12,0,.3,.03,.37,.05v4.38c-2.2,.03-3.89,1.23-3.89,3.31s1.7,2.88,3.47,2.78v-.07c-1.11-.12-1.68-.69-1.68-1.5,0-.88,.64-1.36,1.45-1.36s1.43,.52,1.95,1.11l2.96-3.33-.12-.12-.76,.87c-1.14-1.01-1.87-1.48-3.18-1.68V4.67l8.36,14.57h.45V4.72c1.6-.1,3.03-1.3,3.03-3.11m2.81,17.54l4.51-3.62-.12-.17-2.36,1.87-2.71-2.14v-1.33l4.68-3.3-2.36-3.67-5.2,2.86v6.8l-1.01,.79,.12,.15,.96-.76,3.5,2.54h0Zm-.69-5.67v-5.15l2.27,3.55-2.27,1.6Zm21.22-5.52l-.69,.52-1.97-1.68-2.29,2.07,.94,.88v7.72l-2.34-1.6v-6.26l.81-.57-2.41-2.24-2.24,2.07,.94,.88v7.46l-.15,.1-2.2-1.6v-6.13c0-1.43-.72-1.85-1.63-2.41-.76-.47-1.16-.91-1.16-1.63,0-.79,.69-1.11,.91-1.23-.79-.03-2.98,.76-3.03,2.76-.03,1.03,.47,1.48,.99,1.97,.52,.49,1.01,.96,1.01,1.83v6.01l-1.06,.84,.12,.12,1.01-.79,2.63,2.14,2.51-1.75,2.76,1.75,5.42-3.2v-6.95l1.21-.94-.1-.15h0Zm18.15-5.84l-1.03,.94-2.32-2.02-3.13,2.51V1.19h-.19V18.12c-.34-.05-1.06-.25-1.85-.37V3.58c0-1.03-.74-2.47-2.59-2.47s-3.01,1.56-3.01,2.91h.08c.1-.61,.52-1.16,1.13-1.16s1.18,.39,1.18,1.78v4.04c-1.75,.07-2.81,1.16-2.81,2.34,0,.67,.42,1.92,1.75,1.97v-.1c-.45-.19-.54-.42-.54-.67,0-.59,.57-.79,1.36-.79h.19v6.51c-1.5,.52-2.2,1.53-2.2,2.78,0,1.72,1.38,3.05,3.4,3.05,1.43,0,2.44-.25,3.75-.54,1.06-.22,2.21-.47,2.83-.47,.79,0,1.14,.35,1.14,.91,0,.72-.27,1.08-.69,1.21v.1c1.7-.32,2.69-1.3,2.69-2.83s-1.5-2.54-3.18-2.54c-.87,0-2.44,.27-3.72,.57-1.43,.32-2.66,.47-3.11,.47-.72,0-1.6-.32-1.6-1.28,0-.87,.72-1.56,2.49-1.56,.96,0,1.9,.15,3.08,.42,1.26,.27,2.12,.64,3.2,.64,1.5,0,2.71-.54,2.71-2.74V3.29l1.11-1.01-.12-.15h0Zm-4.24,6.78c-.27,.3-.59,.54-1.11,.54-.57,0-.87-.3-1.14-.54V3.81l.74-.59,1.5,1.28v4.41h0Zm0,2.41c-.25-.25-.57-.47-1.11-.47s-.91,.27-1.14,.47v-2.17c.22,.19,.59,.49,1.14,.49s.87-.25,1.11-.49v2.17Zm0,5.1c0,.84-.42,1.78-1.5,1.78-.17,0-.57-.03-.74-.05v-6.58c.25-.22,.57-.52,1.14-.52,.52,0,.81,.25,1.11,.52v4.86h0Zm8.78,2.74l5.03-3.13v-6.85l-3.25-2.39-5.03,2.88v6.78l-.99,.79,.1,.15,.81-.67,3.33,2.44h0Zm-.37-3.55v-7.3l2.51,1.87v7.3l-2.51-1.87Zm15.01-8.65c-.39,.27-.74,.42-1.11,.42-.39,0-.88-.25-1.14-.57,0,.03-1.87,2.02-1.87,2.02l-1.87-2.02-3.05,2.12,.1,.17,.81-.54,1.11,1.21v6.63l-1.33,1.01,.12,.12,.67-.46,2.49,2.12,3.15-2.09-.1-.15-.81,.49-1.28-1.16v-7.28c.52,.57,1.11,1.06,1.82,1.06,1.28,0,2.14-1.53,2.29-3.11m11.88,9.81l-.94,.59-5.2-7.76,.27-.37c.57,.34,1.08,.81,2.17,.81s2.47-1.14,2.59-3.23c-.27,.37-.81,.81-1.7,.81-.64,0-1.28-.42-1.67-.81l-3.55,5.22,4.71,7.17,3.42-2.27-.1-.17h0Zm-6.31,.19l-.79,.52-1.08-1.08V.48l-3.89,2.69c.45,.15,.99,.39,.99,1.43v11.81l-1.33,1.01,.12,.12,.67-.46,2.32,2.12,3.11-2.07-.1-.15h0Zm22.89-14.39c0-2.02-1.92-2.63-3.53-2.56V.19c.96,.07,1.7,.46,1.7,1.11,0,.45-.32,1.01-1.28,1.01-.76,0-2.02-.45-3.2-.84-1.3-.45-2.54-.87-3.57-.87-2.02,0-3.55,1.5-3.55,3.35,0,1.5,1.16,2.02,1.63,2.21l.03-.07c-.3-.2-.49-.42-.49-1.06,0-.54,.39-1.26,1.43-1.26,.94,0,2.17,.42,3.8,.88,1.4,.39,2.91,.76,3.75,.87v3.28l-1.58,1.3,1.58,1.36v4.49c-.81,.46-1.75,.61-2.56,.61-1.5,0-2.89-.42-4.02-1.68l4.26-2.07V5.73l-5.2,2.32c.54-1.38,1.55-2.41,2.66-3.08l-.03-.08c-3.08,.84-5.89,3.67-5.89,7.17,0,4.19,3.35,7.3,7.22,7.3,4.19,0,6.65-3.28,6.61-6.75h-.07c-.61,1.33-1.63,2.59-2.78,3.25v-4.38l1.65-1.33-1.65-1.33v-3.28c1.53,0,3.11-1.01,3.11-2.96m-8.78,11.56l-1.21,.61c-.74-.96-1.23-2.32-1.23-4.07,0-.72,.07-1.7,.32-2.39l2.14-.96-.03,6.8h0Zm11.93-12.31l-2.17,1.82,1.85,2.09,2.17-1.82-1.85-2.09Zm3.3,15.15l-.79,.52-1.08-1.08v-7.17l.91-.72-.12-.15-.76,.59-1.8-2.14-2.96,2.07,.1,.17,.74-.49,.99,1.23v6.61l-1.33,1.01,.12,.12,.67-.46,2.32,2.12,3.11-2.07-.1-.15h0Zm16.63-.1l-.74,.49-1.16-1.11v-7.03l.94-.72-.12-.15-.84,.64-2.47-2.2-2.78,2.17-2.44-2.17-2.74,2.14-1.85-2.14-2.96,2.07,.1,.17,.74-.49,1.06,1.21v6.61l-.81,.81,2.36,2,2.29-2.07-.94-.88v-7.04l.61-.45,1.7,1.48v6.16l-.79,.81,2.39,2,2.24-2.07-.94-.88v-7.04l.59-.47,1.72,1.5v6.06l-.69,.72,2.41,2.2,3.18-2.17-.1-.15h.02Zm8.6-1.5l-2.36,1.87-2.71-2.14v-1.33l4.68-3.3-2.36-3.67-5.2,2.86v6.93l3.57,2.59,4.51-3.62-.12-.17h0Zm-5.08-1.88v-5.15l2.27,3.55-2.27,1.6Zm14.12-.97l-2-1.53c1.33-1.16,1.8-2.63,1.8-3.69,0-.15-.03-.42-.05-.67h-.08c-.19,.54-.72,1.01-1.53,1.01s-1.26-.45-1.75-.99l-4.58,2.54v3.72l1.75,1.38c-1.75,1.55-2.09,2.51-2.09,3.4s.52,1.67,1.41,2.02l.07-.12c-.22-.19-.42-.32-.42-.79,0-.34,.35-.88,1.14-.88,1.01,0,1.63,.69,1.95,1.06,0-.03,4.38-2.69,4.38-2.69v-3.77h0Zm-1.03-3.05c-.69,1.23-2.21,2.44-3.11,3.13l-1.11-.94v-3.62c.45,.99,1.36,1.82,2.54,1.82,.69,0,1.14-.12,1.67-.39m-1.9,8.13c-.52-1.16-1.63-2-2.86-2-.3,0-1.21-.03-2,.46,.47-.79,1.87-2.21,3.65-3.28l1.21,1.01v3.8Z"></path>
		                    </svg></a>
		                <a href="https://www.newsbank.co.kr/" target="_blank" class="logo"></a>
		                <ul class="gnb_left">
		                    <li><a href="#">아카이브</a></li>
		                </ul>
		                <ul class="gnb_right">
		                    <li><a href="/price.info">이용안내</a></li>
		                    <li><a href="#">로그인</a></li>
		                    <li><a href="#">가입하기</a></li>
		                </ul>
		            </div>
		
		            <div class="lang">
		                <a href="javascript:void(0)">언어</a>
		                <ul>
		                    <li class="" onclick="languageChange('KR')">KR</li>
		                    <li class="on" onclick="languageChange('EN')">EN</li>
		                </ul>
		            </div>
		            <div class="gnb_srch">
		                <form id="searchform" action="/photo" method="post">
		                    <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해주세요.">
		                    <input type="text" id="keyword_current" style="display: none;">
		                    <a href="javascript:void(0)" id="btn_search" class="btn_search">검색</a>
		                </form>
		
		                <div id="searchProgress" class="progress">
		                    <div id="searchProgressImg" class="loader"></div>
		                </div>
		            </div>
		            <div id="top"><a href="#">TOP</a></div>
		        </nav>
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
		                        해당 페이지는 다하미커뮤니케이션즈 중간관리자 지원 시 문의하는 내용에 대해 문의자와의 원활한 의사소통을 위한 목적으로 아래와 같은 항목을 수집합니다.<br>
		                        : 이름, 이메일 주소, 연락처<br>
		                        <br>
		                        <strong>3. 개인정보의 보유 및 이용기간</strong><br>
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
		        
		        <footer>
		            <div class="foot_wrap">
		                <div class="foot_lt">(주)다하미커뮤니케이션즈 | 대표 박용립<br />
		                    서울시 중구 마른내로 140 5층 (쌍림동, 인쇄정보센터)<br />
		                    고객센터 02-593-4174 | 사업자등록번호 112-81-49789 <br />
		                    저작권대리중개신고번호 제532호<br />
		                    통신판매업신고번호 제2016-서울중구-0501호 (사업자정보확인)</div>
		                <div class="foot_ct">
		                    <dl>
		                        <dt>이용안내</dt>
		                        <dd><a href="/price.info">구매안내</a></dd>
		                        <dd><a href="/FAQ">FAQ</a></dd>
		                        <dd><a href="/contact">직접 문의하기</a></dd>
		                    </dl>
		                    <dl>
		                        <dt>법적고지</dt>
		                        <dd><a href="#">이용약관</a></dd>
		                        <dd><b><a href="#">개인정보처리방침</a></b></dd>
		                    </dl>
		                </div>
		                <div class="foot_rt">
		                    <div id="family_site">
		                        <div id="select-title">Family site</div>
		                        <div id="select-layer" style="display: none;">
		                            <ul class="site-list">
		                                <li><a href="http://www.dahami.com/" target="_blank">다하미커뮤니케이션즈</a></li>
		                                <li><a href="http://scrapmaster.co.kr/" target="_blank">스크랩마스터</a></li>
		                                <li><a href="http://clippingon.co.kr/" target="_blank">클리핑온</a></li>
		                                <li><a href="http://www.t-paper.co.kr/" target="_blank">티페이퍼</a></li>
		                                <li><a href="http://www.news-plaza.co.kr/" target="_blank">뉴스플라자</a></li>
		                                <li><a href="http://ndpt.dahami.com/" target="_blank">NDPT</a></li>
		                            </ul>
		                        </div>
		                    </div>
		                </div>
		            </div>
		            <div class="foot_bt">Copyright © NewsBank. All Rights Reserved.</div>
		        </footer>
		    </div>
		</body>
		
		</html>	
	</c:otherwise>
</c:choose>