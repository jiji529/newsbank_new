var IMG_SERVER_URL_PREFIX = "http://www.dev.newsbank.co.kr";

// 이미지 삭제(엄선한 사진)
$(document).on("click","#btn_rm",function() {
	$(this).closest("tr").remove();
	set_unitegallery(); // 새로고침
});

// 이미지 개별 삭제(다운로드, 찜, 상세보기)
$(document).on("click","#btn_del",function() {
	var tabName = $(".tabs li").find("a.active").attr("value");
	var delCnt = parseInt($("#delCnt").val());
	var tabName = $(".tabs li").find("a.active").attr("value");
	var html = "";
	
	var param = {
			"cmd" : "D"
			, "start" : delCnt
			, "count" : 1
			, "tabName" : tabName
		};
	
	//console.log(param);
	$(this).closest("tr").remove();
	
	$.ajax({
		type: "POST",
		dataType: "json",
		url: "/admin.popular.api",
		data: param,
		success: function(data) { console.log(data);
			var uciCode = data.list.uciCode;
			var ownerName = data.list.ownerName;
			var downCount = data.list.downCount;
			
			html += '<tr>';
			html += '<td>' + uciCode + '</td>';
			html += '<td>' + ownerName + '</td>';
			html += '<td>' + downCount + '회</td>';
			html += '<td><a href="#" id="btn_del" class="list_btn">삭제</a></td>';
			html += '</tr>';
		},
		complete: function() {
			setTimeout(function() {
				 // 1초 이후에 추가하기
				$(html).appendTo("tbody");
				
				set_unitegallery(); // 새로고침
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
					set_unitegallery(); // 새로고침					
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
		, "cmd" : "U"
	};
	//console.log(param);
	
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
	//console.log("기존 리스트 : " + existList);
	
	// 편진된 리스트
	var editList = [];
	$("tbody tr").each(function(index){
		var uciCode = $(this).find("td:first").text();
		editList.push(uciCode);
	});
	//console.log("편집 리스트 : " + editList);
	
	var delArr = array_diff(existList, editList); // 삭제될 대상
	//console.log("삭제 리스트 : " + delArr);
	
	var tabName = $(".tabs li").find("a.active").attr("value");
	
	var param = {
		"delArr" : delArr
		, "tabName" : tabName
		, "cmd" : "U"
	};
	//console.log(param);
	
	jQuery.ajaxSettings.traditional = true; // 배열 직렬화전달
	
	$.ajax({
		type: "POST",
		dataType: "json",
		url: "/admin.popular.api",
		data: param,
		success: function(data) {
			//console.log(data);
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

function set_unitegallery(){ // 새로고침
	var photo_area = "";
	
	$("tbody tr").each(function(index){
		var uciCode = $(this).find("td:first").text();
		
		photo_area += "<a href='javascript:go_photoView(" + uciCode + ")' onclick='go_photoView(" + uciCode + ")'>";
		photo_area += '<img alt="image_' + index + '" src="' + IMG_SERVER_URL_PREFIX + '/view.down.photo?uciCode=' + uciCode + '&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>">';
		photo_area += '</a>';
	});
	
	//console.log(photo_area);
	
	$("#photo_area").empty();
	$(photo_area).appendTo("#photo_area");
	
	var unite_option = { 
		gallery_theme: "tiles",			
		gallery_width:"1218px", // 전체 가로길이
		
		tiles_type: "justified", 
		tile_enable_shadow:true,
		tile_shadow_color:"#8B8B8B",
		tile_enable_icons:false, // 아이콘 숨김
		tile_as_link:true, // 링크처리
		tile_link_newpage: false, // 링크 새 페이지로 이동
		
		tiles_justified_row_height: 200,
		tiles_justified_space_between: 10,
		tiles_set_initial_height: true,	
		tiles_enable_transition: true,
	};
	
	$("#photo_area").unitegallery(unite_option);
	
}