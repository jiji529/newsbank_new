<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.dahami.newsbank.dto.PhotoDTO" %>
<%
 String IMG_SERVER_URL_PREFIX = com.dahami.newsbank.web.servlet.NewsbankServletBase.IMG_SERVER_URL_PREFIX;
%>

// ################################################################################
// 리스트에서 선택해서 취하는 액션
// ################################################################################
	/** 전체선택 */
	$(document).on("click", "input[name='check_all']", function() {
		if($("input[name='check_all']").prop("checked")) {
			$("#cms_list2 input:checkbox").prop("checked", true);
		}else {
			$("#cms_list2 input:checkbox").prop("checked", false);
		}
	});
	
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
	
	/** 선택 다운로드 */
	function mutli_download() {
		var uciCode = getCheckedList();
		if(uciCode.length == 0) {
			alert("선택된 사진이 없습니다.");
			return;
		}
		
		if(!confirm("선택파일을 압축파일로 다운로드하시겠습니까?\n삭제된 파일은 다운로드 되지 않습니다.")) {
			return;
		}
		
		var param = uciCode.join("&uciCode=");
		
		var url = "<%=IMG_SERVER_URL_PREFIX%>/zip.down.photo?&type=file&uciCode=";
		url += param;
		
		$("#downFrame").attr("src", url);
	}
	
	/** 선택 블라인드/해제 */
	function multi_blind(saleState) {
		var uciCode = getCheckedList();
		if(uciCode.length == 0) {
			alert("선택된 사진이 없습니다.");
			return;
		}
		
		var msg = "숨김";
		if(saleState == <%=PhotoDTO.SALE_STATE_OK%>) {
			msg = "숨김해제";
		}
		
		if(!confirm("선택된 사진을 "+msg+"처리 합니다. 진행합니까?\n이미 "+msg+"상태이거나 삭제된 사진은 적용되지 않습니다.")) {
			return;
		}
		
		for(var i=0; i < uciCode.length; i++) {
			changeOption(uciCode[i], "saleState", saleState);
		}
		alert("처리되었습니다");
		cms_search();
	}
	
	/** 선택 삭제 */
	function multi_delete() {
		var uciCode = getCheckedList();
		if(uciCode.length == 0) {
			alert("선택된 사진이 없습니다.");
			return;
		}
		
		if(!confirm("이미지 삭제 후 복구할 수 없습니다.\n삭제합니까?")) {
			return;
		}
		if(uciCode.length > 1) {
			if(!confirm("여러개의 이미지가 선택되었습니다. 정말 삭제하시겠습니까?")) {
				return;
			}
		}
		
		for(var i=0; i < uciCode.length; i++) {
			changeOption(uciCode[i], "saleState", <%=PhotoDTO.SALE_STATE_DEL %>);
		}
		alert("삭제되었습니다");
		cms_search();
	}
	
// ################################################################################
// 리스트 각 항목에 대한 액션
// ################################################################################
	/** 다운로드 버튼 클릭 */
	$(document).on("click", ".btn_down", function() {
		down($(this).attr("value"));
	});

	/** 블라인드/해제 버튼 클릭 */
	$(document).on("click", ".btn_view", function() {
		var uciCode = $(this).attr("value");
		var saleState;
		if($(this).hasClass("blind")) {
			$(this).removeClass("blind");
			saleState = <%=PhotoDTO.SALE_STATE_OK%>;
		}else {
			$(this).addClass("blind");
			saleState = <%=PhotoDTO.SALE_STATE_STOP%>;
		}
		changeOption(uciCode, "saleState", saleState);
	});
	
	/** 삭제버튼 클릭 */
	$(document).on("click", ".btn_del", function() {
		var uciCode = $(this).attr("value");		
		if(!confirm("이미지 삭제 후 복구할 수 없습니다.\n삭제합니까?")) {
			return;
		}
		changeOption(uciCode, "saleState", <%=PhotoDTO.SALE_STATE_DEL %>);
		alert("삭제되었습니다");
		cms_search();
	});
