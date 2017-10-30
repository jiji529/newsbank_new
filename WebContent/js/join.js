// kink.join 회원종류에 따른 약관동의 페이지 이동
$(document).ready(
		function() {
			$('.join_choice a').click(
					function() {
						$(this).parent().attr('action', '/terms.join').attr(
								'method', 'post').submit();

					});

		})

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
})

// form.join 아이디 상용 유무 체크
$(document).ready(function() {

	$("#id").change(function() {
		$.ajax({
			url : "/checkId",
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

		})
	});
})

// form.join 패스워드 체크
$(document).ready(function() {
	// password 입력을 받기 위한 정규식 6-16자리 영문, 숫자, 특수문자 조합
	function regPasswordType(data) {
		var regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}/;
		return regex.test(data);
	}
	// 비밀번호 입력 정규표현식 체크
	$("#pw").change(function() {
		var pw = $("#pw").val();
		if (!regPasswordType(pw)) {
			$("#pw_message").css("display", "block");
			$("#pw").focus();
			return;
		} else {
			$("#pw_message").css("display", "none");
		}
	});

	// 비밀번호 입력 재확인 체크
	$("#pw_check").change(function() {
		var pw = $("#pw").val();
		var pw_check = $("#pw_check").val();

		if (pw != pw_check) {
			$("#pw_check_message").css("display", "block");
			$("#pw_check").focus();
			return;
		} else {
			$("#pw_check_message").css("display", "none");
		}

	});

});

// form.join 이메일 체크
$(document)
		.ready(
				function() {
					function regEmailType(data) {
						var regex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
						return regex.test(data);
					}
					$("#email").change(function() {
						if (!regEmailType($("#email").val())) {
							$("#email_message").css("display", "block");
							$("#email").focus();
							return;
						} else {
							$("#email_message").css("display", "none");
						}
					});
				});
// form.join 핸드폰 체크
$(document).ready(function() {
	function regPhoneType(data) {
		var regex = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		return regex.test(data);
	}
	function validPhone(){
		if (!regPhoneType($("#phone").val())) {
			$("#phone_message").css("display", "block");
			$("#phone").focus();
			return false;
		} else {
			$("#phone_message").css("display", "none");
			return true;
		}
	}
	$("#phone").change(function() {
		return validPhone();
	});

	$("#phone_certify").on("click", function() {
		if(validPhone()){
			if (confirm("인증번호를 요청하시겠습니까?")) {
				$.ajax({
					type : "post",
					url : "/SendSMS",
					data : ({
						tel : $("#phone").val()
					}),
					dataType : "json",
					success : function(data) {
						console.log(data);
						if(data.success){
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
	
	
	function validCertify(){
		if (!$("#certify_number").val()) {
			$("#certify_message").css("display", "block");
			$("#certify_number").focus();
			return false;
		} else {
			$("#certify_message").css("display", "none");
			return true;
		}
	}
	$("#certify_submit").on("click", function() {
		if(validCertify()){
			$.ajax({
				type : "post",
				url : "/SendSMS",
				data : ({
					token : $("#certify_number").val()
				}),
				dataType : "json",
				success : function(data) {
					console.log(data);
					if(data.success){
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

});

// form.join 로그인 최종 체크
$(document).ready(function() {
	$("#frmJoin").submit(function() {

		return;
	});

});
