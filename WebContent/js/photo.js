
function down(uciCode) {
	if(!confirm("원본 크기로 다운로드 하시겠습니까?")) {
		return;
	}
	
	var group_seq = $("#group_seq").val(); // 그룹회원 여부
	
	if(group_seq && group_seq != 0) {
		alert("고객님과 같은 그룹으로 묶인 계정에서 다운로드 받은 내역이 모두 공유됩니다.");
	}
	
	$("#downUciCode").val(uciCode);
	$("#downType").val("file");
	$("#downForm").attr("action", "/outline.down.photo");
	$("#downForm").submit();
//	$("#downFrame").attr("src", url);
}
