
function downOrg(uciCode) {
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
	$("#downType").val("file");
	$("#downForm").attr("action", "/"+outline+".down.photo");
	$("#downForm").submit();
}