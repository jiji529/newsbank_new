// id.find 
$(document).ready(function() {
	
	//  아이디 상용 유무 체크
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

	function validName() {
		var name = $("#name").val();
		if (name.length > 0) {
			return true;
		} else {
			$("#name").focus();
			return false;
		}
	}

	// 핸드폰 번호 인증 체크
	function validPhone() {
		var regex = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
		if ($('#frmFindId').find("[name=phone]").length > 0) {
			$('#frmFindId').find("[name=phone]").val(phone);
		} else {
			$('<input>').attr({
				type : 'hidden',
				name : 'phone',
				value : phone
			}).appendTo('#frmFindId');
		}
		console.log($("#phone2").val().length);
		if ($("#phone2").val().length == 0) {
			$("#phone2").focus();
			return false;
		}
		if ($("#phone3").val().length == 0) {
			$("#phone3").focus();
			return false;
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
						$("#phone1").not(":selected").attr("disabled", "disabled"); // 변경불가처리
						$("#phone2").attr("readonly", true);// 변경불가처리
						$("#phone3").attr("readonly", true);// 변경불가처리
						$("#certify_number").attr("readonly", true);// 변경불가처리
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

	$("#frmFindId").on("submit", function() {
		var check = true;
		check = check && validName();
		check = check && validPhone();
		check = check && validCertify();

		if (check) {
			return true;
		}
		return false;
	});
	
	$("#frmFindPw").on("submit", function() {
		var check = true;
		check = check && validId();
		check = check && validPhone();
		check = check && validCertify();

		if (check) {
			return true;
		}
		return false;
	});
});

// list.find
$(document).ready(function() {
	$("#btnLogin").on("click", function() {
		$("#frmFindList").attr('action', '/login').attr('method', 'post').submit();
	});
	
	$("#btnFindPw").on("click", function() {
		$("#frmFindList").attr('action', '/pw.find').attr('method', 'post').submit();
	});

});
