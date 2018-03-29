// 이미지 삭제
$(document).on("click",".list_btn",function() {		
	this.closest("tr").remove();
});

// 이미지 개별 삭제
$(document).on("click","#btn_del",function() {
	var tabName = $(".tabs li").find("a.active").attr("value");
	var delCnt = parseInt($("#delCnt").val());
	var html = "";
	
	var param = {
			"tabName" : "autoAdd",
			"start" : delCnt,
			"count" : 1
		};
	
	console.log(param);
	
	$.ajax({
		type: "POST",
		dataType: "json",
		url: "/admin.popular.api",
		data: param,
		success: function(data) {
			var uciCode = data.list.uciCode;
			var ownerName = data.list.ownerName;
			var hitCount = data.list.hitCount;
			
			html += '<tr>';
			html += '<td>' + uciCode + '</td>';
			html += '<td>' + ownerName + '</td>';
			html += '<td>' + hitCount + '회</td>';
			html += '<td><a href="#" id="btn_del" class="list_btn">삭제</a></td>';
			html += '</tr>';
			
			console.log(html);
		},
		complete: function() {
			setTimeout(function() {
				 // 1초 이후에 추가하기
				$(html).appendTo("tbody");
			}, 1000);
			
			$("#delCnt").val(delCnt+1); // 삭제 카운트 증가
		}
	});
	
});

//취소
$(document).on("click", ".btn_input1", function() {
	location.reload();
});


//이미지 추가(엄선한 사진)
$(document).on("click", ".btn_add", function() {
	var keyword = $("#keyword").val(); // UCI코드
	var uciCode; // uci코드
	var ownerName; // 매체사
	var hitCount; // 조회수
	var tr_cnt = $("tbody tr").length; // 테이블 행 갯수
	var html = '';
	
	var searchParam = {"keyword" : keyword};
	var count = 0;
	
	if(keyword != "") {
		$.ajax({
			type: "POST",
			async: false,
			dataType: "json",
			data: searchParam,
			timeout: 1000000,
			url: "search",
			success : function(data) { //console.log(data); 
				count = data.count; 
				
				if(count > 0) {
					uciCode = data.result[0].uciCode; // uci코드
					ownerName = data.result[0].ownerName; // 매체사
					hitCount = data.result[0].hitCount; // 조회수	
					
					html += '<tr>';
					html += '<td>' + keyword + '</td>';
					html += '<td>' + ownerName + '</td>';
					html += '<td>' + hitCount + '회</td>';
					html += '<td><a href="#" class="list_btn" value="${photo.mediaExActive}">삭제</a></td>';
					html += '</tr>';
				}
				
			},
			complete: function() {
				if(count != 0 && tr_cnt < 7) { // 7개 미만일 때만 추가
					$(html).appendTo("tbody");	
					$("#keyword").val("");
				}else if(count == 0) {
					alert("UCI 코드를 정확히 입력해주세요.");
				}else if(tr_cnt >= 7) {
					alert("최대 7개 사진을 엄선할 수 있습니다.");	
				}
			}
		});
	}
	
});


// 저장(엄선한 사진)
$(document).on("click", "#btn_complete", function() {
	// 기존 리스트 생성
	var existList = $("#uciCodeList").val();
	existList = existList.replace("[", "");
	existList = existList.replace("]", "");
	existList = existList.split(", ");

	var editList = [];
	$("tbody tr").each(function(index){
		var uciCode = $(this).find("td:first").text();
		editList.push(uciCode);
	});
	
	var delArr = array_diff(existList, editList); // 삭제될 대상
	var insArr = array_diff(editList, existList); // 추가될 대상
	
	var param = {
		"delArr" : delArr
		, "insArr" : insArr
		, "tabName" : "selected"
	};
	console.log(param);
	
	jQuery.ajaxSettings.traditional = true; // 배열 직렬화전달
	
	$.ajax({
		type: "POST",
		dataType: "json",
		url: "/admin.popular.api",
		data: param,
		success: function(data) {
			
		},
		complete: function() {
			location.reload();
		}
	});
});


// 저장(다운로드, 찜, 상세보기)
$(document).on("click", "#btn_save", function() {
	// 기존 리스트 생성
	var existList = $("#uciCodeList").val();
	existList = existList.replace("[", "");
	existList = existList.replace("]", "");
	existList = existList.split(", ");
	
	// 편진된 리스트
	var editList = [];
	$("tbody tr").each(function(index){
		var uciCode = $(this).find("td:first").text();
		editList.push(uciCode);
	});
	
	var delArr = array_diff(existList, editList); // 삭제될 대상
	
	var tabName = $(".tabs li").find("a.active").attr("value");
	
	var param = {
		"delArr" : delArr
		, "tabName" : tabName
	};
	console.log(param);
	
	jQuery.ajaxSettings.traditional = true; // 배열 직렬화전달
	
	$.ajax({
		type: "POST",
		dataType: "json",
		url: "/admin.popular.api",
		data: param,
		success: function(data) {
			console.log(data);
		},
		complete: function() {
			location.reload();
		}
	});
	
	
});


//차집합 (a-b)
function array_diff(a, b) {
	var tmp={}, res=[];
	for(var i=0;i<a.length;i++) tmp[a[i]]=1;
	for(var i=0;i<b.length;i++) { if(tmp[b[i]]) delete tmp[b[i]]; }
	for(var k in tmp) res.push(k);
	return res;
}