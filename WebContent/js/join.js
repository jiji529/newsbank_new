// kink.join 회원종류에 따른 약관동의 페이지 이동
$(document).ready(function() {

	$('.join_choice a').click(function() {
		$(this).parent().attr('action', '/terms.join').attr('method', 'post').submit();

	});
});
// terms.join 약관 동의 체크 및 페이지 이동
$(document).ready(function() {

	$("#frmJoinTerms").submit(function() {
		if ($("#copyAgree").is(":checked") == false) {
			alert($("#copyAgree").attr("title"));
			return false;
		}

		if ($("#policyAgree").is(":checked") == false) {
			alert($("#policyAgree").attr("title"));
			return false;
		}

		$(this).attr('action', '/form.join').attr('method', 'post').submit();
		return false;
	});
});

// form.join 우편번호
$(document).ready(function() {
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
});

// form.join
$(document).ready(function() {
	var phone = null;

	// form.join 아이디 상용 유무 체크
	function validId() {
		var id = $("#id").val();
		var regex = /[A-Za-z0-9]{2,19}$/g;
		if (regex.test(id) && id.length > 3) {
			$("#id_message2").css("display", "none");
			return true;
		} else {
			$("#id_message2").css("display", "block");
			return false;
		}
	}

	$("#id").change(function() {
		if (validId()) {
			$.ajax({
				url : "/findMember.api",
				data : ({
					id : $("#id").val()
				}),
				dataType : "json",
				success : function(data) { console.log(data);
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

	/*
	 * function validPwCheck() { var pw = $("#pw").val(); var pw_check =
	 * $("#pw_check").val();
	 * 
	 * if (pw != pw_check) { $("#pw_check_message").css("display", "block");
	 * $("#pw_check").focus(); return false; } else {
	 * $("#pw_check_message").css("display", "none"); return true; } }
	 */
	// 비밀번호 입력 재확인 체크
	$("#pw_check").change(function() {
		return validPw()

	});

	// form.join 이메일 체크
	/*
	 * function regEmailType(data) { var regex =
	 * /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	 * return regex.test(data); }
	 */
	function validEmail() {
		var regex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var email = $("#email").val();
		if (regex.test(email) && email.length > 0) {
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

	// form.join 핸드폰 체크

	/*
	 * function regPhoneType(data) { var regex =
	 * /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/; return
	 * regex.test(data); }
	 */
	// 핸드폰 번호 인증 체크
	function validPhone() {
		var regex = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
		if($('#frmJoin').find("[name=phone]").length>0){
			$('#frmJoin').find("[name=phone]").val(phone);
		}else{
			$('<input>').attr({
				type : 'hidden',
				name : 'phone',
				value : phone
			}).appendTo('#frmJoin');
		}
		
		
		if (regex.test(phone) && phone.length > 0) {
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
	// 인증번호 요청 버튼
	$("#phone_certify").on("click", function() {
		if (validPhone()) {
			if (confirm("인증번호를 요청하시겠습니까?")) {
				phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
				$.ajax({
					type : "post",
					url : "/SendSMS",
					data : ({
						tel : phone
					}),
					dataType : "json",
					success : function(data) {
						if (data.message) {
							alert(data.message);
						}
						// alert(data);
					},
					error : function() {
						console.log(data);
					}
				});
			}
		}

	});
	// 인증번호 체크
	function validCertify() {
		if (!$("#certify_number").val()) {
			$("#certify_message").css("display", "block");
			$("#certify_number").focus();
			return false;
		} else {
			$("#certify_message").css("display", "none");
			return true;
		}
	}
	// 인증완료 버튼
	$("#certify_submit").on("click", function() {
		if (validCertify()) {
			$.ajax({
				type : "post",
				url : "/SendSMS",
				data : ({
					tel : phone,
					token : $("#certify_number").val()
				}),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						$("#phone1").not(":selected").attr("disabled", "disabled"); //변경불가처리
						$("#phone2").attr("readonly", true);//변경불가처리
						$("#phone3").attr("readonly", true);//변경불가처리
						$("#certify_number").attr("readonly", true);//변경불가처리
						$("#phone_certify").css("display", "none");
						$("#certify_number").parent().parent().css("display", "none");
					
						alert(data.message);
					} else {
						alert(data.message);
					}
					// alert(data);
				},
				error : function() {
					console.log(data);
				}
			});
		}

	});
	
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
		
		if(compTel.length > 0 && (telRegex.test(compTel) || phoneRegex.test(compTel)) ) {
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
		
		
		function validCompDoc() {
			var compDoc = $("#compDoc").val();
			if (compDoc.length > 0) {
				return true;
			} else {
				alert("사업자 등록증 사본을 등록해주세요.");
				return false;
			}
		}
	
	
	
	function validCompAddr() {
		var compAddress = $("#compAddress").val();
		if (compAddress.length > 0) {
			return true;
		} else {
			$("#compAddDetail").focus();
			return false;
		}
	}
	
	

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
	
	
	function joinAccess() {
		$.post("/member.api", $("#frmJoin").serialize(), function(data) {
			if (data.success) {
				alert("정상적으로 회원 가입되었습니다.");
				location.href = "/success.join";
			} else {
				alert(data.message);

			}
		}, "json");
		return false;
	}

	$("#frmJoin").on("submit", function() {
		// process form
		var check = true;
		check = check && validId();
		check = check && validPw();
		check = check && validEmail();
		check = check && validName();
		check = check && validPhone();
		check = check && validCertify();
		if ($(this).find("[name=type]").val() != "P") {
			check = check && validCompAddr();
			check = check && validCompName();
			check = check && validCompNum();
			check = check && validCompTel();
			check = check && validCompDoc();
			//check = check && validUploadFile();

			if ($(this).find("[name=type]").val() == "M") {

			}
		}
		if (check) {
			if (confirm("회원 가입하시겠습니까?")) {
				//joinAccess();
				validUploadFile()

				return false;
			}
		}

		return false;
	});

	// form.join 로그인 최종 체크

});



//login 로그인
$(document).ready(function() {
	
	$("#frmLogin").on("submit",function(){
		$.post("/check.login", $(this).serialize(), function(data) {
			console.log(data);
			if (data.success) {
				location.href = "/login";
			} else {
				alert(data.message);

			}
		}, "json");
		
		return false;
	});

	
});
