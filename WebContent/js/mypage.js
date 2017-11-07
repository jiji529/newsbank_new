// mypage 현재 페이지 도매인과 같은 링크 부모객체 클래스 추가
$(document).ready(function() {
	$("[href]").each(function() {
		if (this.href == window.location.href) {
			$(this).parent().addClass("on");
		}
	});
});

// mypage 메뉴 개수에 따라 길이 조절
$(document).ready(function() {
	var len = $(".mypage .mypage_ul .mp_tab1 li").length;
	var liWidth = 100 / len;
	$(".mypage .mypage_ul .mp_tab1 li").css('width', liWidth + '%');

})

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

$(document).ready(function() {

	var phone = null;
	function validPw() {
		// password 입력을 받기 위한 정규식 6-16자리 영문, 숫자, 특수문자 조합
		var regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}/;
		var pw = $("#frmMypage #pw").val();
		var pw_check = $("#pw_check").val();
		$("#pw").removeAttr("name");
		if (pw.length > 0) {
			if (regex.test(pw)) {
				$("#pw_message").css("display", "none");
				if (pw != pw_check) {
					$("#pw_check_message").css("display", "block");
					$("#pw_check").focus();
					return false;
				} else {
					$("#pw").attr("name", "pw");
					$("#pw_check_message").css("display", "none");
					return true;
				}
			} else {
				$("#pw_message").css("display", "block");
				$("#pw").focus();
				return false;
			}
		} else {
			return true;
		}

	}
	// 비밀번호 입력 정규표현식 체크
	$("#pw").change(function() {
		return validPw();
	});

	$("#pw_check").change(function() {
		return validPw()

	});

	// 핸드폰 번호 인증 체크
	function validPhone() {
		var regex = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
		if ($("#phone2").val().length > 0 || $("#phone3").val().length > 0) {

			if ($('#frmMypage').find("[name=phone]").length > 0) {
				$('#frmMypage').find("[name=phone]").val(phone);
			} else {
				$('<input>').attr({
					type : 'hidden',
					name : 'phone',
					value : phone
				}).appendTo('#frmMypage');
			}

			if (regex.test(phone) && phone.length > 0) {
				$("#phone_message").css("display", "none");
				return true;
			} else {
				$("#phone_message").css("display", "block");
				$("#phone3").focus();
				return false;
			}
		} else {
			return true;
		}

	}

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
						$("#certify_number").parent().css("display", "none");

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

	// 회사 전화번호 체크
	function validCompTel() {
		var regex = /^0([0-9]{1,3})-?([0-9]{3,4})-?([0-9]{4})$/;
		var compTel = $("#compTel1").val() + $("#compTel2").val() + $("#compTel3").val();
		if (regex.test(compTel) && compTel.length > 0) {
			if ($('#frmMypage').find("[name=compTel]").length > 0) {
				$('#frmMypage').find("[name=compTel]").val(compTel);
			} else {
				$('<input>').attr({
					type : 'hidden',
					name : 'compTel',
					value : compTel
				}).appendTo('#frmMypage');
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
		if ($(this).val().length == 4) {
			$("#compTel3").focus();
		}
	});

	// 회사 전화번호 체크
	$("#compTel3").change(function() {
		return validCompTel();
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

	function validCompName() {
		var compName = $("#compName").val();
		if (compName.length > 0) {
			return true;
		} else {
			$("#compName").focus();
			return false;
		}
	}

	$("#btnEdit").on("click", function() {
		$("#editView").css("display", "block");
	});
	// 사업자 등록번호 체크
	$("#compNum1").on("input", function() {
		if ($(this).val().length == 3) {
			$("#compNum2").focus();
		}
	});
	$("#compNum2").on("input", function() {
		if ($(this).val().length == 2) {
			$("#compNum3").focus();
		}
	});

	// 사업자 등록번호 유효성 체크
	function validCompNum() {
		var compNum = $("#compNum1").val() + $("#compNum2").val() + $("#compNum3").val();
		if ($('#frmMypage').find("[name=compNum]").length > 0) {
			$('#frmMypage').find("[name=compNum]").val(compNum);
		} else {
			$('<input>').attr({
				type : 'hidden',
				name : 'compNum',
				value : compNum
			}).appendTo('#frmMypage');
		}
		var regex = /[(0-9)]{10}/;
		if (regex.test(compNum) && compNum.length > 0) {
			$("#compNum_message").css("display", "none");
			return true;
		} else {
			$("#compNum_message").css("display", "block");
			return false;
		}
	}

	$("#compNum1").on("change", function() {
		return validCompNum();
	});
	$("#compNum2").on("change", function() {
		return validCompNum();
	});
	$("#compNum3").on("change", function() {
		return validCompNum();
	});

	$("#btnSubmit").on("click", function() {
		var type = $("#type").val();
		var check = true;
		check = check && validPw();
		check = check && validName();
		check = check && validPhone();
		if (type != "P") {
			check = check && validCompNum();
			check = check && validCompName();
			check = check && validCompTel();
			if (type == "M") {

			}
		}
		if (check) {
			if (confirm("회원정보를 수정하시겠습니까?")) {
				$.post($("#frmMypage").attr("action"), $("#frmMypage").serialize(), function(data) {
					if (data.success) {
						alert("수정되었습니다.");
						location.reload()
					} else {
						alert(data.message);

					}
				}, "json");
				return false;
			}
		}
	});

});

// buylist.mypage
$(document).ready(function() {
	$("#tbBuyList a").each(function() {
		var a = $(this);
		a.on("click",function(){
			console.log(a);
			var form = $('<form></form>');
		     form.attr('action', '/buy.mypage');
		     form.attr('method', 'post');
		     form.appendTo(a);
		     var idx = $('<input type="hidden" value="'+a.text()+'" name="LGD_OID">');
		     form.append(idx);
		     form.submit();

		});
	});
});


//buy.mypage
$(document).ready(function() {
	/** 개별 다운로드 */
	$(".btn_group [name=btn_down]").on("click", function() {
		var uciCode = $(this).parent().parent().find("div span:first").text();
		var imgPath = $(this).parent().parent().find("a img").attr("src");
		
		var link = document.createElement("a");
	   /* link.download = uciCode;
	    link.href = imgPath;
	    link.click();*/
	});

});


