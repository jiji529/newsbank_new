
function down(uciCode) {
	var groupMsg = "";
	var group_seq = $("#group_seq").val(); // 그룹회원 여부
	if(group_seq && group_seq != 0) {
//		groupMsg = "\n고객님과 같은 그룹으로 묶인 계정에서 다운로드 받은 내역이 모두 공유됩니다.";
		groupMsg = "이미지를 다운로드 하시면 이미지를 사용하지 않으시더라도 결제 취소를 하실 수 없습니다. \n이미지를 다운로드 하시겠습니까?";
	}
	
//	if(!confirm("원본 크기로 다운로드 하시겠습니까?" + groupMsg)) {
//		return;
//	}
	
	if(!confirm(groupMsg)) {
		return;
	}
	
	$("#downUciCode").val(uciCode);
	$("#downType").val("file");
	$("#downForm").attr("action", "/outline.down.photo");
	$("#downForm").submit();
//	$("#downFrame").attr("src", url);
}
