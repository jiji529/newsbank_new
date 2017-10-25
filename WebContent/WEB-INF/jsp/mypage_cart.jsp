<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE.GWANGHO
  @date     : 2017. 10. 25. 오후 03:25:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 10. 25.   hoyadev        cart.mypage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크</title>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<script src="js/filter.js"></script>
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
				<h2>마이페이지</h2>
				<p>설명어쩌고저쩌고</p>
			</div>
			<div class="mypage_ul">
				<ul class="mp_tab1">
					<li><a href="#">정산 관리</a></li>
					<li><a href="#">사진 관리</a></li>
					<li><a href="#">회원정보 관리</a></li>
					<li><a href="#">찜관리</a></li>
					<li class="on"><a href="#">장바구니</a></li>
					<li><a href="#">구매내역</a></li>
				</ul>
			</div>
			<div class="table_head">
				<h3>장바구니</h3>
			</div>
			<div class="btn_sort"><span class="task_check">
				<input type="checkbox" />
				</span>
				<ul class="button">
					<li class="sort_down">장바구니</li>
					<li class="sort_del">삭제</li>
					<li class="sort_menu">폴더이동</li>
				</ul>
			</div>
			<section id="wish_list2">
				<ul>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/A0/2009/04/30/E003307027_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/A0/2009/04/30/E003307027_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/A0/2009/04/30/E003307027_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/A0/2009/04/30/E003307027_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/2007/07/27/E001523343_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"><a href="#"><img src="http://www.newsbank.co.kr/datafolder/01/1987/06/09/E001879920_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
					<li class="thumb"> <a href="#"><img src="http://www.newsbank.co.kr/datafolder/21/2007/05/22/E001151870_P.jpg" /></a>
						<div class="thumb_info">
							<input type="checkbox" />
							<span>A1242015030205790237</span><span>뉴시스</span></div>
						<ul class="thumb_btn">
							<li class="btn_down">다운로드</li>
							<li class="btn_del">삭제</li>
						</ul>
					</li>
				</ul>
			</section>
			<div class="more"><a href="#">다음 페이지</a></div>
		</section>
	</div>
</body>
</html>
