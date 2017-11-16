 jQuery(document).ready(function(){
  $(" ").each(function(){
   $(this).parent(".filter_list").css("width", $(this).parent(".filter_list").parent(".filter_title").width()+60);
   $(this).css("width", $(this).parent(".filter_list").parent(".filter_title").width()+60);
  });
  $(".filter_title").click(function(){
   $(this).children(".filter_list").stop().slideDown("fast");
  }).mouseleave(function(){
	  if(!$(this).closest(".filter_title").hasClass("filter_duration")) {
 		  // 기간 (직접선택)을 제외한 나머지 검색옵션만 slide up 이벤트 적용
 		  $(".filter_duration .filter_list").stop().slideUp("fast");
 		  $(this).children(".filter_list").stop().slideUp("fast");
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