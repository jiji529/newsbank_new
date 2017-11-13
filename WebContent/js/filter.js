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
  });
  
 });
