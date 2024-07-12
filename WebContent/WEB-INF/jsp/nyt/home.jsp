<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 9. 21. 오후 3:27:27
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 10.   tealight       home
  2017. 11. 09.   hoyadev        인기사진, 보도사진 수정 
---------------------------------------------------------------------------%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>
<c:choose>
	<c:when test="${cookie.language.value eq 'KR'}">
		<!DOCTYPE html>
		<html lang="ko">		
			<head>
			    <meta charset="UTF-8">
			    <title>NYT 뉴스뱅크</title>
			    <link rel="stylesheet" href="css/nyt/reset.css" />
			    <link rel="stylesheet" href="css/nyt/base.css" />
			    <link rel="stylesheet" href="css/nyt/main.css" />
			    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
			</head>
			
			<jsp:include page="./common/head_meta.jsp"/>
			<body>
			    <div class="wrap">			    	
					<jsp:include page="./common/headerKR.jsp"/>		    
			        <div class="main">
			            <section class="top">
			                <div class="overlay"></div>
			                <div class="main_bg"></div>
			                <div class="main_tit">
			                    <h2>NYT NewsBank (NewYorkTimes NewsBank)</h2>
			                    <p>미국의 대표일간지 뉴욕타임스의 사진을 뉴스뱅크에서도 만나볼 수 있습니다.</p>
			                    <div class="search main_search">
			                        <form class="search_form">
			                            <div class="search_area">
			                                <input type="text" class="search_bar" placeholder="검색어를 입력해주세요." />
			                                <a href="#" class="btn_search">검색</a>
			                            </div>
			                        </form>
			                    </div>
			                </div>
			            </section>
			            <section class="popular">
			                <div class="center">
			                    <h2>최신 사진</h2>
			                    <p>오늘자 뉴욕타임스 사진을 소개합니다.</p>
			                    <div class="photo_cont">
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex7.webp" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex8.webp" /></a></div>
			                        <div class="img_list gridsp"><a href="#"><img src="images/nyt/main/ex2.jpg" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex10.jpg" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex1.jpg" /></a></div>
			                    </div>
			                </div>
			            </section>
			            <section class="photo">
			                <div class="center">
			                    <h2>뉴욕타임스 뉴스뱅크가 엄선한 사진</h2>
			                    <p>뉴욕타임스의 저명한 사진작가들이 전세계 곳곳을 누비며 생생한 현장을 담고 있습니다.</p>
			                    <div class="photo_cont">
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex0.webp" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex4.webp" /></a></div>
			                        <div class="img_list gridsp"><a href="#"><img src="images/nyt/main/ex3.jpg" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex5.webp" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex6.webp" /></a></div>
			                    </div>
			                </div>
			            </section>
			            <!--엄선한사진-->
			            <section class="service">
			                <div class="center">
			                    <div class="serv_txt">
			                        <h2>뉴욕타임스 뉴스뱅크 서비스 소개</h2>
	                        <p>다하미의 뉴욕타임스 뉴스뱅크는 국내 최초 뉴욕타임스 보도사진 아카이브입니다.<br>
	                            전세계의 가장 빠르고 현장감 있는 뉴욕타임스의 보도사진을<br>
	                            뉴욕타임스 뉴스뱅크에서 만나 볼 수 있습니다.</p>
			                    </div>
			                </div>
			            </section>
			
			        </div>
			        <jsp:include page="./common/footerKR.jsp"/>	
			        <div id="top"><a href="#">TOP</a></div>		        
			    </div>
			</body>		
		</html>
	</c:when>
	<c:otherwise>
		<!DOCTYPE html>
		<html lang="en">		
			<head>
			    <meta charset="UTF-8">
			    <title>NYT NewsBank</title>
			    <link rel="stylesheet" href="css/nyt/reset.css" />
			    <link rel="stylesheet" href="css/nyt/base.css" />
			    <link rel="stylesheet" href="css/nyt/main.css" />
			    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
			</head>
			
			<jsp:include page="./common/head_meta.jsp"/>
			<body>
			    <div class="wrap">		        			    	
					<jsp:include page="./common/headerEN.jsp"/>			    	
			        <div class="main">
			            <section class="top">
			                <div class="overlay"></div>
			                <div class="main_bg"></div>
			                <div class="main_tit">
			                    <h2>NYT NewsBank (NewYorkTimes NewsBank)</h2>
	                    <p>Photos from The New York Times, the leading newspaper in the US, can also be found in the NewsBank.</p>
	                    <div class="search main_search">
	                        <form class="search_form">
	                            <div class="search_area">
	                                <input type="text" class="search_bar" placeholder="Please enter a keyword." />
	                                <a href="#" class="btn_search">Search</a>
	                            </div>
	                        </form>
	                    </div>
			                </div>
			            </section>
			            <section class="popular">
			                <div class="center">
			                    <h2>Latest Photos</h2>
	                    <p> Here are today's photos from The New York Times.</p>
			                    <div class="photo_cont">
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex7.webp" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex8.webp" /></a></div>
			                        <div class="img_list gridsp"><a href="#"><img src="images/nyt/main/ex2.jpg" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex10.jpg" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex1.jpg" /></a></div>
			                    </div>
			                </div>
			            </section>
			            <section class="photo">
			                <div class="center">
			                    <h2>Curated photos from the NYT NewsBank</h2>
	                    <p>Renowned photographers from NYT have traveled around the world to capture vivid scenes.</p>
			                    <div class="photo_cont">
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex0.webp" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex4.webp" /></a></div>
			                        <div class="img_list gridsp"><a href="#"><img src="images/nyt/main/ex3.jpg" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex5.webp" /></a></div>
			                        <div class="img_list"><a href="#"><img src="images/nyt/main/ex6.webp" /></a></div>
			                    </div>
			                </div>
			            </section>
			            <!--엄선한사진-->
			            <section class="service">
			                <div class="center">
			                    <div class="serv_txt">
			                        <h2>About NYT NewsBank Service</h2>
	                        <p>Dahami's NYT NewsBank is the first archive of New York Times press photos in Korea.<br>Discover the world's fastest, and most dynamic news photos from New York Times in the NYT NewsBank.</p>
			                    </div>
			                </div>
			            </section>
			
			        </div>
					<jsp:include page="./common/footerEN.jsp"/>	
					<div id="top"><a href="#">TOP</a></div>		        
			    </div>
			</body>		
		</html>
	</c:otherwise>
</c:choose>