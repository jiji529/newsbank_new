 jQuery(document).ready(function(){
//  var calOpenF = false;
  $(".filter_title")
  	.click(function(){
  		// 이웃들 다 닫아주고 자기 열기
  		$(this).siblings().each(function() {
  			$(this).children(".filter_list").stop().slideUp("fast");
  		});
  		$(this).children(".filter_list").stop().slideDown("fast");
  	})
  	.mouseleave(function(){
  		// 날짜 피커가 없으면 지움
  		if($(".ui-datepicker").css("display") == "none") {
  		  $(".filter_duration .filter_list").stop().slideUp("fast");
 		  $(this).children(".filter_list").stop().slideUp("fast");
 		  $(".ui-datepicker-close").trigger("click"); 
  		}else {
  			// 일반적으로 영역을 벗어나면 사라짐
//  		$(".filter_list").stop().slideUp("fast");
  		}
  });;
 });
 
 
 jQuery(document).ready(function(){
  $(".sort_folder").click(function(){
   $(this).children(".folder_item").stop().slideDown("fast");
  }).mouseleave(function(){
   $(this).children(".folder_item").stop().slideUp("fast");
  });;
 });
 
 jQuery(document).ready(function(){
  $(".navi_cate").click(function(){
   $(this).children(".navi_select").stop().slideDown("fast");
  }).mouseleave(function(){
   $(this).children(".navi_select").stop().slideUp("fast");
  });;
 });