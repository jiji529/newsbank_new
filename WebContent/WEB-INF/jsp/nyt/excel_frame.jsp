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
		alert("엑셀저장이 진행됩니다.");
		var url = "excel." + searchTarget;
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
		var saleState = $(".filter_saleState .filter_list").find("[selected=selected]").attr("value"); // 판매상태
		
		excelDownForm.keyword.value = keyword;
		excelDownForm.media.value = media;
		excelDownForm.durationReg.value = durationReg;
		excelDownForm.durationTake.value = durationTake;
		excelDownForm.horiVertChoice.value = horiVertChoice;
		excelDownForm.size.value = size;
		excelDownForm.saleState.value = saleState;
		
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
	<input type="hidden" name="saleState" />
</form>
<iframe id="excelDownFrame" name="excelDownFrame" style="display:none"></iframe>