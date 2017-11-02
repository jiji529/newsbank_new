// id.find 
$(document).ready(function() {

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
});