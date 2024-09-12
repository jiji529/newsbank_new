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
			
			<script>
			    $(document).ready(function() {
			        $("#popupTap1").on('click', function() {
			            $("#popupTap1").addClass('tapOn');
			            $("#popupTap2").removeClass('tapOn');
			            $("#tblEditorial").css('display', "block");
			            $("#tblCommercial").css('display', "none");
			        });
			
			        $("#popupTap2").on('click', function() {
			            $("#popupTap2").addClass('tapOn');
			            $("#popupTap1").removeClass('tapOn');
			            $("#tblEditorial").css('display', "none");
			            $("#tblCommercial").css('display', "block");
			        });
			    });
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
			                    <li class="on"><a href="/price.info">구매안내</a></li>
			                    <li><a href="/FAQ">FAQ</a></li>
			                    <li><a href="/contact">직접 문의하기</a></li>
			                </ul>
			            </div>
			            <div class="table_head">
			                <h3>구매안내</h3>
			            </div>
			            <div class="tab1">
			                <!-- 가격테이블 Tap-->
			                <span class="tapOn" id="popupTap1"><a href="#" id="Editorial">Editorial (출판용)</a></span>
			            </div>
			            <section id="tblEditorial" style="display: ;">
			                <!-- 가격테이블 -->
			                <table class="tb01" cellpadding="0" cellspacing="0">
			                    <colgroup>
			                        <col width="160px">
			                        <col width="180px">
			                        <col width="460px">
			                        <col width="240px">
			                        <col width="200px">
			                    </colgroup>
			                    <thead>
			                        <tr>
			                            <th scope="col" colspan="2">구분</th>
			                            <th scope="col">용도</th>
			                            <th scope="col">사용기간</th>
			                            <th scope="col">가격
			                                (VAT포함)</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                        <tr id="r1">
			                            <th rowspan="5">출판, 간행물</th>
			                            <td rowspan="3">인쇄매체</td>
			                            <td>단행본, 잡지-내지</td>
			                            <td>1년 이내</td>
			                            <td>99,000</td>
			                        </tr>
			                        <tr id="r2">
			                            <td>단행본, 잡지표지</td>
			                            <td>1년 이내</td>
			                            <td>187,000</td>
			                        </tr>
			                        <tr id="r3">
			                            <td>단행본, 잡지 내지+표지
			                                (동일한 컷을 같은 매체에 이용시 기준)</td>
			                            <td>1년 이내</td>
			                            <td>242,000</td>
			                        </tr>
			                        <tr id="r4">
			                            <td>e북, 모바일등</td>
			                            <td>e-book, CD수록, 기타 전자매체</td>
			                            <td>1년 이내</td>
			                            <td>187,000</td>
			                        </tr>
			                        <tr id="r5">
			                            <td>패키지</td>
			                            <td>인쇄매체 + e-book
			                                (동일한 컷을 2개 매체에 이용시 기준)</td>
			                            <td>1년 이내</td>
			                            <td>242,000</td>
			                        </tr>
			                        <tr id="r6">
			                            <th rowspan="4">교육용</th>
			                            <td rowspan="2">인쇄매체</td>
			                            <td>전집, 백과사전, 도감, 학술논문, 발표자료 등</td>
			                            <td>1년 이내</td>
			                            <td>99,000</td>
			                        </tr>
			                        <tr id="r7">
			                            <td>교과서, 참고서, 학습지</td>
			                            <td>1년 이내</td>
			                            <td>99,000</td>
			                        </tr>
			                        <tr id="r8">
			                            <td>온라인, 모바일 등</td>
			                            <td>전자교과서, 교육용 웹사이트, CD수록 등
			                                저장매체, 발표용 슬라이드</td>
			                            <td>1년 이내</td>
			                            <td>121,000</td>
			                        </tr>
			                        <tr id="r9">
			                            <td>패키지</td>
			                            <td>인쇄매체 + 온라인, 모바일 등
			                                (동일한 컷을 2개 매체에 이용시 기준)</td>
			                            <td>1년 이내</td>
			                            <td>187,000</td>
			                        </tr>
			                        <tr id="r10">
			                            <th rowspan="5">언론 보도용</th>
			                            <td>인쇄매체</td>
			                            <td>신문-종합일간지, 경제지, 스포츠지, 무가지, 타블로이드, 학술지 등</td>
			                            <td>1년 이내</td>
			                            <td>99,000</td>
			                        </tr>
			                        <tr id="r11">
			                            <td>온라인</td>
			                            <td>인터넷뉴스 등</td>
			                            <td>1년 이내</td>
			                            <td>121,000</td>
			                        </tr>
			                        <tr id="r12">
			                            <td>방송</td>
			                            <td>지상파, 종합유선방송, 위성방송, IPTV, 인터넷방송 등</td>
			                            <td>1년 이내</td>
			                            <td>121,000</td>
			                        </tr>
			                        <tr id="r13">
			                            <td rowspan="2">패키지</td>
			                            <td>방송 + 웹사이트
			                                (동일한 컷을 2개 매체에 이용시 기준)</td>
			                            <td>1년 이내</td>
			                            <td>187,000</td>
			                        </tr>
			                        <tr id="r14">
			                            <td>인쇄매체 + 웹사이트
			                                (동일한 컷을 2개 매체에 이용시 기준)</td>
			                            <td>1년 이내</td>
			                            <td>187,000</td>
			                        </tr>			                        
			                        <tr id="r23">
			                            <th rowspan="15">기타</th>			                            
			                        </tr>			                        
			                        <tr id="r29">
			                            <td rowspan="2">인쇄매체</td>
			                            <td>사보, 뉴스레터, 기관지 등</td>
			                            <td>1년 이내</td>
			                            <td>187,000</td>
			                        </tr>
			                        <tr id="r30">
			                            <td>의정보고서, 내부게시판 등</td>
			                            <td>1년 이내</td>
			                            <td>187,000</td>
			                        </tr>
			                        <tr id="r31">
			                            <td rowspan="2">온라인</td>
			                            <td>기업 및 단체 운영의 홈페이지 또는
			                                블로그, 인트라넷 등</td>
			                            <td>1년 이내</td>
			                            <td>187,000</td>
			                        </tr>
			                        <tr id="r32">
			                            <td>웹진, 뉴스레터 온라인배포용</td>
			                            <td>1년 이내</td>
			                            <td>187,000</td>
			                        </tr>
			                        <tr id="r33">
			                            <td>방송</td>
			                            <td>보도용 이외 일반 방송 프로그램
			                                (홈쇼핑 제외)</td>
			                            <td>1년 이내</td>
			                            <td>142,000</td>
			                        </tr>			                        
			                    </tbody>
			                </table>
			            </section>			            
			            <div class="price_mess">
					이용자가 NYT 뉴스뱅크가 제공하는 이미지를 사용할 경우 저작권, 피사체에 대한 초상권, 상표권 등 기타권리는 이용자 자신이 취득하여야 합니다. 
					<a href="#" class="price_info" target="_blank">이용약관</a>
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
			
			<script>
			    $(document).ready(function() {
			        $("#popupTap1").on('click', function() {
			            $("#popupTap1").addClass('tapOn');
			            $("#popupTap2").removeClass('tapOn');
			            $("#tblEditorial").css('display', "block");
			            $("#tblCommercial").css('display', "none");
			        });
			
			        $("#popupTap2").on('click', function() {
			            $("#popupTap2").addClass('tapOn');
			            $("#popupTap1").removeClass('tapOn');
			            $("#tblEditorial").css('display', "none");
			            $("#tblCommercial").css('display', "block");
			        });
			    });
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
			                    <li class="on"><a href="/price.info">Purchase</a></li>
			                    <li><a href="/FAQ">FAQ</a></li>
			                    <li><a href="/contact">Contact us directly</a></li>
			                </ul>
			            </div>
			            <div class="table_head">
			                <h3>Purchase</h3>
			            </div>
			            <div class="tab1">
                <!-- 가격테이블 Tap-->
                <span class="tapOn" id="popupTap1">
                    <a href="javascript:;" id="Editorial">Editorial</a>
                </span>
            </div>
            <section id="tblEditorial" style="display: ;">
                <!-- 가격테이블 -->
                <table class="tb01" cellpadding="0" cellspacing="0">
                    <colgroup>
                        <col width="160px">
                        <col width="185px">
                        <col width="470px">
                        <col width="260px">
                        <col width="165px">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col" colspan="2">Classification</th>
                            <th scope="col">Purpose</th>
                            <th scope="col">Usage period</th>
                            <th scope="col">Price (incl. VAT)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="r1">
                            <th rowspan="5">Publishing, Publications</th>
                            <td rowspan="3">Print Media</td>
                            <td>Book, Magazine inlay</td>
                            <td>Within 1 year</td>
                            <td>₩ 99,000</td>
                        </tr>
                        <tr id="r2">
                            <td>Book, Magazine cover</td>
                            <td>Within 1 year</td>
                            <td>₩ 187,000</td>
                        </tr>
                        <tr id="r3">
                            <td>Book, Magazine interior and cover (based on the same cut for the same medium)</td>
                            <td>Within 1 year</td>
                            <td>₩ 242,000</td>
                        </tr>
                        <tr id="r4">
                            <td>e-Book, Mobile, etc.</td>
                            <td>e-Book, CD recordings, other electronic media</td>
                            <td>Within 1 year</td>
                            <td>₩ 187,000</td>
                        </tr>
                        <tr id="r5">
                            <td>Package</td>
                            <td>Print + e-Book (Based on the same cut for two media)
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 242,000</td>
                        </tr>
                        <tr id="r6">
                            <th rowspan="4">Education
                            </th>
                            <td rowspan="2">Print Media
                            </td>
                            <td>Complete works, Encyclopedias, Books, Articles, Presentations, etc.
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 99,000</td>
                        </tr>
                        <tr id="r7">
                            <td>Textbooks, Reference books, Study sheets
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 99,000</td>
                        </tr>
                        <tr id="r8">
                            <td>Online, Mobile
                            </td>
                            <td>e-Textbooks, Educational websites, Storage media such as CD recordings, Presentation slides, etc.
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 121,000</td>
                        </tr>
                        <tr id="r9">
                            <td>Package</td>
                            <td>Print + Online, Mobile, etc. (Based on the same cut for two media)</td>
                            <td>Within 1 year</td>
                            <td>₩ 187,000</td>
                        </tr>
                        <tr id="r10">
                            <th rowspan="5">For Press</th>
                            <td>Print</td>
                            <td>Newspapers - Daily Newspaper, Economic, Sports, Free Paper, Tabloid, Journals, etc.</td>
                            <td>Within 1 year</td>
                            <td>₩ 99,000</td>
                        </tr>
                        <tr id="r11">
                            <td>Online</td>
                            <td>Internet news, etc.</td>
                            <td>Within 1 year</td>
                            <td>₩ 121,000</td>
                        </tr>
                        <tr id="r12">
                            <td>Broadcast
                            </td>
                            <td>Terrestrial Broadcasting, General wired broadcasting, Satellite broadcasting, IPTV, Internet broadcasting, etc.
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 121,000</td>
                        </tr>
                        <tr id="r13">
                            <td rowspan="2">Package</td>
                            <td>Broadcast + Website (Based on the same cut for two media)
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 187,000</td>
                        </tr>
                        <tr id="r14">
                            <td>Print media + Website (Based on the same cut for two media)
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 187,000</td>
                        </tr>                        
                        <tr id="r23">
                            <th rowspan="15">Others
                            </th>                            
                        </tr>                        
                        <tr id="r29">
                            <td rowspan="2">Print</td>
                            <td>Company newspapers, Newsletters, Institutional newspapers, etc.
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 187,000</td>
                        </tr>
                        <tr id="r30">
                            <td>State operations reports, Internal boards, etc.
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 187,000</td>
                        </tr>
                        <tr id="r31">
                            <td rowspan="2">Online</td>
                            <td>Homepage or blog for businesses and organizations, intranet, etc.
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 187,000</td>
                        </tr>
                        <tr id="r32">
                            <td>Webzines and newsletters for online distribution
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 187,000</td>
                        </tr>
                        <tr id="r33">
                            <td>Broadcast
                            </td>
                            <td>General broadcast programs (excluding home shopping) other than for reporting purposes
                            </td>
                            <td>Within 1 year</td>
                            <td>₩ 142,000</td>
                        </tr>                        
                    </tbody>
                </table>
            </section>
            <div class="price_mess">
					If you use images provided by the NYT Newsbank, you must obtain other rights to the subjects, such as portrait rights, trademark rights, etc.
					<a href="#" class="price_info" target="_blank">Terms</a>
				</div>
			        </section>
					<jsp:include page="./common/footerEN.jsp"/>
			    </div>
			</body>		
		</html>	
	</c:otherwise>
</c:choose>