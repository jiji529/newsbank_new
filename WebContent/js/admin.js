
$(document).ready(function() {
	// 회원가입 양식 제출
	$("#frmJoin").on("submit", function() {
		// process form
		var check = true;
		var cmd = $("input[name=cmd]").val();
		var message = "";
		
		if(cmd == "C") {
			message = "회원 추가하시겠습니까?";
			check = check && validId();
			check = check && validPw();
			check = check && validName();
			
		}else if(cmd == "U") {
			if($("#frmJoin").find("[name=pw]").val().length > 0) {
				check = check && validPw();
				console.log("비밀번호 수정");
			}
			message = "회원정보를 수정하시겠습니까?";
		}
		
		check = check && validEmail();		
		check = check && validPhone();
		// check = check && validCertify(); (인증번호 체크는 관리자 페이지에서 필요 없음.)
		if ($(this).find("[name=type]").val() != "P") {
			check = check && validCompAddr();
			check = check && validCompName();
			check = check && validCompNum();
			check = check && validCompTel();
			check = check && validCompExtTel();
			//check = check && validCompDoc();
			check = check && validUploadFile();

			if ($(this).find("[name=type]").val() == "M") {
				console.log("언론사 회원");
			}
		}
		

		if($("input[name=deferred]").val() == 1) { 		// 결제 구분 (오프라인 결제)
			
		}else if($("input[name=deferred]").val() == 2) { 		// 결제 구분 (오프라인 별도 요금)
			
		}
		
		if (check) {
			if (confirm(message)) {
				//joinAccess();
				validUploadFile()

				return false;
			}
		}

		return false;
	});
	
	//form.join 아이디 상용 유무 체크
	function validId() {
		var id = $("#id").val();
		var regex = /[A-Za-z0-9]{2,19}$/g;
		if (regex.test(id) && id.length > 0) {
			$("#id_message2").css("display", "none");
			return true;
		} else {
			$("#id_message2").css("display", "block");
			return false;
		}
	}
	
	// ID 사용유무 체크
	$("#id").change(function() {
		if (validId()) {
			$.ajax({
				url : "/findMember.api",
				data : ({
					id : $("#id").val()
				}),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						// 사용중
						$("#id_message").css("display", "block");
						$("#id").focus();
					} else {
						// 미사용중
						$("#id_message").css("display", "none");
					}

				}

			});
		}

	});
	
	// form.join 패스워드 체크
	function validPw() {
		// password 입력을 받기 위한 정규식 6-16자리 영문, 숫자, 특수문자 조합
		var regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}/;
		var pw = $("#pw").val();
		var pw_check = $("#pw_check").val();
		if (regex.test(pw) && pw.length > 0) {
			$("#pw_message").css("display", "none");
			if (pw != pw_check) {
				$("#pw_check_message").css("display", "block");
				$("#pw_check").focus();
				return false;
			} else {
				$("#pw_check_message").css("display", "none");
				return true;
			}
		} else {
			$("#pw_message").css("display", "block");
			$("#pw").focus();
			return false;
		}
	}
	
	// 비밀번호 입력 정규표현식 체크
	$("#pw").change(function() {
		return validPw();
	});
	
	// 비밀번호 입력 재확인 체크
	$("#pw_check").change(function() {
		return validPw()
	});
	
	// 이메일 체크
	function validEmail() {
		var regex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var email = $("#email").val();
		if (regex.test(email) && email.length > 0) { // 정규식과 값이 존재하는지 여부 확인
			$("#email_message").css("display", "none");
			return true;
		} else {
			$("#email_message").css("display", "block");
			$("#email").focus();
			return false;
		}

	}
	$("#email").change(function() {
		return validEmail();
	});
	
	// 이름 체크
	function validName() {
		var name = $("#name").val();
		
		if (name.length > 0) {
			return true;
		} else {
			$("#name").focus();
			return false;
		}
	}
	$("#name").change(function() {
		return validName();
	});
	
	// 핸드폰 번호 인증 체크
	function validPhone() {
		var regex = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
		// name=phone의 존재여부를 확인하여 없으면 별도로 태그를 추가
		if($('#frmJoin').find("[name=phone]").length>0){
			$('#frmJoin').find("[name=phone]").val(phone);
		}else{
			$('<input>').attr({
				type : 'hidden',
				name : 'phone',
				value : phone
			}).appendTo('#frmJoin');
		}
		
		
		if (regex.test(phone) && phone.length > 0) { // 숫자 정규식과 값의 존재여부 확인
			$("#phone_message").css("display", "none");
			return true;
		} else {
			$("#phone_message").css("display", "block");
			$("#phone3").focus();
			return false;
		}

	}
	
	// 핸드폰 번호 인증 체크
	$("#phone3").change(function() {
		return validPhone();
	});
	
	// 사업자등록증번호 첨부파일 확인(언론사 회원만 해당)
	function validUploadFile(){
		var uploadFile = $('input[name=uploadFile]');
		if(uploadFile.length>0){
			var tmpFile = $('input[name=uploadFile]')[0].files[0];
			var sizeLimit = 1024 * 1024 * 15;
			if (tmpFile.size > sizeLimit) {
				alert("파일 용량이 15MB를 초과했습니다");
				$(this).val("");
				return;
			}
			
			if (validFileType(tmpFile)) {
				var formData = new FormData();
				//첫번째 파일태그
				formData.append("uploadFile", tmpFile);

				$.ajax({
					url : '/doc.upload',
					data : formData,
					dataType : "json",
					processData : false,
					contentType : false,
					type : 'POST',
					success : function(data) {
						console.log(data);
						if (data.success) {
							
							if($('#frmJoin').find("[name=compDocPath]").length>0){
								$('#frmJoin').find("[name=compDocPath]").val(data.file);
							}else{
								$('<input>').attr({
									type : 'hidden',
									name : 'compDocPath',
									value : data.file
								}).appendTo('#frmJoin');
							}
							
							joinAccess();
						} else {
							alert(data.message);
						}
					},
					error : function(data) {
						console.log("Error: " + data.statusText);
						alert("잘못된 접근입니다.");
					},

				});

			} else {
				alert("파일 형식이 올바르지 않습니다.");
				uploadFile.val("");
			}

		}else{
			joinAccess();
		}
		
	}
	
	// 세금계산서 담당자 연락처 체크
	function validTaxPhone() {
		var regex = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var taxPhone = $("#taxPhone1").val() + $("#taxPhone2").val() + $("#taxPhone3").val();
		// name=phone의 존재여부를 확인하여 없으면 별도로 태그를 추가
		if($('#frmJoin').find("[name=taxPhone]").length>0){
			$('#frmJoin').find("[name=taxPhone]").val(phone);
		}else{
			$('<input>').attr({
				type : 'hidden',
				name : 'taxPhone',
				value : taxPhone
			}).appendTo('#frmJoin');
		}
		
		
		if (regex.test(taxPhone) && taxPhone.length > 0) { // 숫자 정규식과 값의 존재여부 확인
			//$("#phone_message").css("display", "none");
			return true;
		} else {
			//$("#phone_message").css("display", "block");
			$("#taxPhone3").focus();
			return false;
		}

	}
	
	// 핸드폰 번호 인증 체크
	$("#taxPhone3").change(function() {
		return validTaxPhone();
	});
	
	// 회원가입 최종완료
	function joinAccess() {
		var cmd = $("input[name=cmd]").val();
		var message = (cmd == "C") ? "정상적으로 추가되었습니다." : "정상적으로 수정되었습니다.";
		$.post("/admin.member.api", $("#frmJoin").serialize(), function(data) {
			if (data.success) {
				alert(message);
				location.href = "/member.manage";
			} else {
				alert(data.message);

			}
		}, "json");
		return false;
	}
	
	// 회사/기관 주소 입력
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를
				// 참고하여 분기 한다.
				var fullAddr = ''; // 최종 주소 변수
				var extraAddr = ''; // 조합형 주소 변수

				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가
					// 도로명
					// 주소를
					// 선택했을
					// 경우
					fullAddr = data.roadAddress;

				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					fullAddr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다.
					if (data.bname !== '') {
						extraAddr += data.bname;
					}
					// 건물명이 있을 경우 추가한다.
					if (data.buildingName !== '') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를
					// 만든다.
					fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('compZipcode').value = data.zonecode; // 5자리
				// 새우편번호
				// 사용
				document.getElementById('compAddress').value = fullAddr;

				// 커서를 상세주소 필드로 이동한다.
				document.getElementById('compAddDetail').focus();
			}
		}).open();
	}

	$("#findAddress").on("click", function() {
		execDaumPostcode();
	});
	
	// 회사/기관 상세주소 입력 여부
	function validCompAddr() {
		var compAddress = $("#compAddress").val();
		if (compAddress.length > 0) {
			return true;
		} else {
			$("#compAddDetail").focus();
			return false;
		}
	}
	
	// 회사/기관명 입력 여부
	function validCompName() {
		var compName = $("#compName").val();
		if (compName.length > 0) {
			return true;
		} else {
			$("#compName").focus();
			return false;
		}
	}
	
	//사업자 등록번호 유효성 체크
	function validCompNum() {
		var compNum = $("#compNum1").val()+$("#compNum2").val()+$("#compNum3").val();
		if($('#frmJoin').find("[name=compNum]").length>0){
			$('#frmJoin').find("[name=compNum]").val(compNum);
		}else{
			$('<input>').attr({
				type : 'hidden',
				name : 'compNum',
				value : compNum
			}).appendTo('#frmJoin');
		}
		var regex = /[(0-9)]{10}/;
		if (regex.test(compNum) && compNum.length > 0){
			$("#compNum_message").css("display", "none");
			return true;
		}else{
			$("#compNum_message").css("display", "block");
			return false;
		}
	}
	
	
	// 사업자 등록번호  체크
	$("#compNum1").on("input", function() {
		if($(this).val().length==3){
			$("#compNum2").focus();
		}
	});
	$("#compNum2").on("input", function() {
		if($(this).val().length==2){
			$("#compNum3").focus();
		}
	});
	$("#compNum1").on("change", function() {
		return validCompNum();
	});
	$("#compNum2").on("change", function() {
		return validCompNum();
	});
	$("#compNum3").on("change", function() {
		return validCompNum();
	});
	
	// 회사 전화번호 체크
	function validCompTel() {
		var telRegex = /^0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]?)-?([0-9]{3,4})-?([0-9]{4})$/; // 일반전화
		var phoneRegex = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/; // 휴대전화

		var compTel = $("#compTel1").val() + $("#compTel2").val() + $("#compTel3").val();
		if ((telRegex.test(compTel) || phoneRegex.test(compTel)) && compTel.length > 0) {
			if($('#frmJoin').find("[name=compTel]").length>0){
				$('#frmJoin').find("[name=compTel]").val(compTel);
				
			}else{
				$('<input>').attr({
					type : 'hidden',
					name : 'compTel',
					value : compTel
				}).appendTo('#frmJoin');
			}
			$("#compTel_message").css("display", "none");
			return true;
		} else {
			$("#compTel_message").css("display", "block");
			$("#compTel3").focus();
			return false;
		}

	}
	$("#compTel2").on("input", function() {
		if($(this).val().length==4){
			$("#compTel3").focus();
		}
	});
	
	// 회사 전화번호 체크
	$("#compTel3").change(function() {
		return validCompTel();
	});
	
	// 회사 내선번호 체크
	function validCompExtTel() {
		var regex = /[(0-9)]{3}/;
		var compExtTel = $("#compExtTel").val();
		
		if(regex.test(compExtTel) && compExtTel.length > 0 ) {
			$("#compExtTel_message").css("display", "none");
			return true;
		}else {
			$("#compExtTel_message").css("display", "block");
			return false;
		}
	}
	
	$("#compExtTel").change(function() {
		return validCompExtTel();
	});
	
	var fileTypes = [ 'image/jpeg', 'image/pjpeg', 'image/png', 'application/pdf'

		]
	
	//확장자 검사
	function validFileType(file) {
		for (var i = 0; i < fileTypes.length; i++) {
			if (file.type === fileTypes[i]) {
				return true;
			}
		}

		return false;
	}
	
	
	//파일 다운로드 체크
	$('input[name=compDoc]').bind('change', function() {
		var tmpFile = $(this)[0].files[0];
		var sizeLimit = 1024 * 1024 * 15;
		if (tmpFile.size > sizeLimit) {
			alert("파일 용량이 15MB를 초과했습니다");
			$(this).val("");
			return;
		}

		if (!validFileType(tmpFile))  {
			alert("파일 형식이 올바르지 않습니다.");
			$(this).val("");
			return;
		}

	});
	
	
	// 사업자 등록증 사본
	function validCompDoc() {
		var compDoc = $("#compDoc").val();
		if (compDoc.length > 0) {
			return true;
		} else {
			alert("사업자 등록증 사본을 등록해주세요.");
			return false;
		}
	}
	
	$(document).on("click", ".file_add", function() {
		var usageHtml = '<p><input type="text" class="inp_txt" name="usage" size="43" placeholder="교과서, 전단지, 뭐 기타등등 여기 직접 입력하는 칸">';
		usageHtml += '<b class=" bar" style="margin-left:50px;">사진단가 (VAT 포함)</b>';
		usageHtml += '<input type="text" name="price" class="inp_txt" size="10" value="">';
		usageHtml += '<span class=" bar">원</span>';
		usageHtml += ' <a class="file_del">용도 삭제</a></p>';		
		$(usageHtml).appendTo(".photoUsage td");
		
		var count = $(".photoUsage td p").length; 
	});

	$(document).on("click", ".file_del", function() {
		$(this).parent("p").remove();
	});
	
});



function setDatepicker() {
	$( ".datepicker" ).datepicker({
     changeMonth: true, 
     dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
     dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
     monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
     monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
     showButtonPanel: true, 
     currentText: '오늘 날짜', 
     closeText: '닫기', 
     dateFormat: "yymmdd"
  });
}