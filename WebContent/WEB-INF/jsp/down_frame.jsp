<%---------------------------------------------------------------------------
  Copyright ⓒ 2018 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2018. 4. 4. 오후 12:18:02
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2018. 4. 4.     
---------------------------------------------------------------------------%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function downBuy(uciCode) {
	if(!confirm("이미지를 다운로드 하시면 이미지를 사용하지 않으시더라도\n결제 취소를 하실 수 없습니다.\n\n이미지를 다운로드 하시겠습니까?")) {
		return;
	}
	downInternal(uciCode);
}

function downOutline(uciCode) {
	if(login_chk()) {
		if(!confirm("시안 이미지를 다운로드 하시겠습니까?")) {
			return;
		}
		downInternal(uciCode, "outline");
	} else {
		if(confirm("회원 서비스입니다.\n로그인 하시겠습니까?")) {
			$(".gnb_right li").first().children("a").click();	
		}
	}
}

function downDiferred(uciCode) {
	if(!confirm("고객님과 같은 그룹으로 묶인 계정에서 다운로드 받은 \n내역이 모두 공유됩니다.\n\n이미지를 다운로드 하시겠습니까?")) {
		return;
	}
	
	downInternal(uciCode);
}

function downInternal(uciCode, outline) { 
	if(outline == null) {
		outline = "service";
	} 
	$("#downUciCode").val(uciCode);
// 	$("#downType").val("file");
	$("#downForm").attr("action", "/"+outline+".down.photo");
	$("#downForm").submit();
}

/** 제호(로고) 다운로드 */
function downLogo(seq) {
	if(!confirm("제호(로고)를 다운로드 하시겠습니까?")) {
		return;
	}
	
	downOtherInternal(seq, "logo");
}

/** 사진을 제외한 그 밖의 다운로드(등록증, 제호, 계약서..) */
function downOtherInternal(seq, outline) {
	$("#seq").val(seq);
	$("#downForm").attr("action", "/"+outline+".down.photo");
	$("#downForm").submit();
}

/** 선택 다운로드 */
function mutli_download() {
	var uciCode = getCheckedList();
	if(uciCode.length == 0) {
		alert("선택된 사진이 없습니다.");
		return;
	}
	
	var msg = "선택하신 이미지를 압축파일로 다운로드하시겠습니까?";
	if($("#cms_keyword").length == 0) {
		msg += "\n\n판매 중지된 이미지는 다운로드 되지 않습니다.";
	}
	if(!confirm(msg)) {
		return;
	}

	$("#downUciCode").val(uciCode.join("$$"));
	$("#downForm").attr("action", "/zip.down.photo");
	$("#downForm").submit();
}

/** 선택된 사진 리스트 읽기 */
function getCheckedList() {
	var uciCode = new Array();
	
	var container = null;
	if($("#wish_list2").length > 0) {
		container = $("#wish_list2");
	}
	else if($("#cms_list2").length > 0) {
		container = $("#cms_list2");
	}
	
	container.find("input:checkbox:checked").each(function(index) {
		uciCode.push($(this).val());
	});
	return uciCode;
}
</script>
<form id="downForm" method="post"  target="downFrame">
	<input type="hidden" id="downUciCode" name="uciCode" />
	<input type="hidden" id="downType" name="type" value="file" />
	<input type="hidden" name="dummy" value="<%=com.dahami.common.util.RandomStringGenerator.next()%>" />
	<input type="hidden" id="group_seq" name="group_seq" value="${memberInfo.group_seq}" />
	<input type="hidden" id="seq" name="seq" />
</form>
<iframe id="downFrame" name="downFrame" style="display:none"></iframe>