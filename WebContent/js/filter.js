 jQuery(document).ready(function(){
  $(" ").each(function(){
   $(this).parent(".filter_list").css("width", $(this).parent(".filter_list").parent(".filter_title").width()+60);
   $(this).css("width", $(this).parent(".filter_list").parent(".filter_title").width()+60);
  });
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
  			$(".filter_list").stop().slideUp("fast");
  		}
  });;
 });
 
 
 jQuery(document).ready(function(){
  $(" ").each(function(){
   $(this).parent(".folder_item").css("width", $(this).parent(".folder_item").parent(".sort_folder").width()+60);
   $(this).css("width", $(this).parent(".folder_item").parent(".sort_folder").width()+60);
  });
  $(".sort_folder").click(function(){
   $(this).children(".folder_item").stop().slideDown("fast");
  }).mouseleave(function(){
   $(this).children(".folder_item").stop().slideUp("fast");
  });;
 });
 
 jQuery(document).ready(function(){
  $(" ").each(function(){
   $(this).parent(".navi_select").css("width", $(this).parent(".navi_select").parent(".navi_cate").width()+60);
   $(this).css("width", $(this).parent(".navi_select").parent(".navi_cate").width()+60);
  });
  $(".navi_cate").click(function(){
   $(this).children(".navi_select").stop().slideDown("fast");
  }).mouseleave(function(){
   $(this).children(".navi_select").stop().slideUp("fast");
  });;
 });