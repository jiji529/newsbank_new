<%---------------------------------------------------------------------------
  Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE,GWANGHO
  @date     : 2018. 4. 13. 오전 09:18:02
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2018. 4. 13.     
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	function excel() { // form, iframe을 이용한 엑셀저장
		var url = "excel.admin.search";
		getSearchOptions();
		$("#excelDownForm").attr("action", url);
		$("#excelDownForm").submit();
	}
	
	// 검색필터 전달
	function getSearchOptions() {
		var keyword = $("#cms_keyword").val();
		var media = $(".filter_media .filter_list").find("[selected=selected]").attr("value"); // 매체
		var durationReg = $(".filter_durationReg .filter_list").find("[selected=selected]").attr("value"); // 업로드일
		var durationTake = $(".filter_durationTake .filter_list").find("[selected=selected]").attr("value"); // 촬영일
		var horiVertChoice = $(".filter_horizontal .filter_list").find("[selected=selected]").attr("value"); // 가로/세로
		var size = $(".filter_size .filter_list").find("[selected=selected]").attr("value"); // 사진크기
		var service = $(".filter_service .filter_list").find("[selected=selected]").attr("value"); // 서비스
		
		excelDownForm.keyword.value = keyword;
		excelDownForm.media.value = media;
		excelDownForm.durationReg.value = durationReg;
		excelDownForm.durationTake.value = durationTake;
		excelDownForm.horiVertChoice.value = horiVertChoice;
		excelDownForm.size.value = size;
		excelDownForm.service.value = service;
		
	}
</script>

<!-- Excel 저장 form -->
<form id="excelDownForm" name="excelDownForm" method="post"  target="excelDownFrame">
	<input type="hidden" name="keyword" />
	<input type="hidden" name="media" />
	<input type="hidden" name="durationReg" />
	<input type="hidden" name="durationTake" />
	<input type="hidden" name="horiVertChoice" />
	<input type="hidden" name="size" />
	<input type="hidden" name="service" />
</form>
<iframe id="excelDownFrame" name="excelDownFrame" style="display:none"></iframe>