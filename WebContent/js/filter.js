 jQuery(document).ready(function(){
  $(" ").each(function(){
   $(this).parent(".filter_list").css("width", $(this).parent(".filter_list").parent(".filter_title").width()+60);
   $(this).css("width", $(this).parent(".filter_list").parent(".filter_title").width()+60);
  });
  $(".filter_title").click(function(){
   $(this).children(".filter_list").stop().slideDown("fast");
  }).mouseleave(function(){
   $(this).children(".filter_list").stop().slideUp("fast");
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
