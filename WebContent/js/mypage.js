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

	// 핸드폰 번호 인증 체크
	function validTaxPhone() {
		var regex = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var phone = $("#taxPhone1").val() + $("#taxPhone2").val() + $("#taxPhone3").val();
		if ($("#taxPhone2").val().length > 0 || $("#taxPhone3").val().length > 0) {

			if ($('#frmMypage').find("[name=taxPhone]").length > 0) {
				$('#frmMypage').find("[name=taxPhone]").val(phone);
			} else {
				$('<input>').attr({
					type : 'hidden',
					name : 'taxPhone',
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
		$("#btnCancel").css("display", "block");
	});
	$("#btnCancel").on("click", function() {
		$("#editView").css("display", "none");
		$("#btnCancel").css("display", "none");
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
		$('#frmMypage').submit(); // 수정 버튼 클릭
	});

	$('#frmMypage').on('submit', function() {
		var type = $("#type").val();
		var check = true;
		console.log("pw size : " + $('#frmMypage').find('[name=pw]').size());
		if ($('#frmMypage').find('[name=pw]').size() > 0) {
			check = check && validPw();
		}
		if ($('#frmMypage').find('[name=name]').size() > 0) {
			check = check && validName();
		}
		if ($('#phone3').size() > 0) {
			check = check && validPhone();
		}
		if ($('#frmMypage').find('[name=compNum]').size() > 0) {
			check = check && validCompNum();
		}
		if ($('#frmMypage').find('[name=compName]').size() > 0) {
			check = check && validCompName();
		}
		if ($('#compTel3').size() > 0) {
			check = check && validCompTel();
		}
		if ($('#taxPhone3').size() > 0) {
			check = check && validTaxPhone();
		}
		

		if (check) {
			var message = "";
			
			if($("input:checkbox[name='check']").is(":checked")) { 
				// 정산매체 여러개를 일괄적용
				var mediaCodes = $.map($("#media option"), function(e) { if(e.value) return e.value; });
				mediaCodes.join(",");
				console.log(mediaCodes);
				$("#mediaCodes").val(mediaCodes);
				message = "모든 정산매체를 일괄 수정하시겠습니까?";
			} else {
				// 단일 적용
				message = "회원정보를 수정하시겠습니까?";
			}
			
			
			if (confirm(message)) {
				$.post($("#frmMypage").attr("action"), $("#frmMypage").serialize(), function(data) {
					if (data.success) {
						alert("수정되었습니다.");
						// location.reload()
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
		a.on("click", function() {
			console.log(a);
			var form = $('<form></form>');
			form.attr('action', '/buy.mypage');
			form.attr('method', 'post');
			form.appendTo(a);
			var idx = $('<input type="hidden" value="' + a.text() + '" name="LGD_OID">');
			form.append(idx);
			form.submit();

		});
	});

});

// account.mypage
$(document).ready(function() {
	/** 날짜 선택 */
	if ($("#contractStart, #contractEnd").length > 0) {
		$.datepicker.setDefaults({
			dateFormat : 'yy-mm-dd',
			prevText : '이전 달',
			nextText : '다음 달',
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true,
			yearSuffix : '년'
		});

		$("#contractStart, #contractEnd").datepicker();
	}

	$("#contractAuto").on('change', function() {
		if ($(this).is(":checked")) {
			$('input[name=contractAuto]').val('Y');
		} else {
			$('input[name=contractAuto]').val('N');
		}
	});

	$("#media").change(function() {
		if ($("#media").val().length > 0) {
			$.ajax({
				url : "/member.api",
				type : "post",
				data : ({
					cmd : "R",
					media_code : $("#media").val()
				}),
				dataType : "json",
				success : function(data) {
					if (data.success) {

						var result = data.data;
						console.log(result);
						$('input[name=compBankName]').val(result.compBankName); // 입금계좌 직접입력 방식으로 디자인 변경 (2018.02.21)
						$('input[name=compBankAcc]').val(result.compBankAcc);
						$('input[name=contractStart]').val(result.contractStart);
						$('input[name=contractEnd]').val(result.contractEnd);
						$('input[name=contractAuto]').val(result.contractAuto);
						if (result.contractAuto == 'Y') {
							$("#contractAuto").prop('checked', true);
						} else {
							$("#contractAuto").prop('checked', false);
						}

						$('input[name=preRate]').val(result.preRate);
						$('input[name=postRate]').val(result.postRate);
						$('input[name=taxName]').val(result.taxName);
						if (result.taxPhone != null) {
							
							if(result.taxPhone.length == 9) {
								$('#taxPhone1').val(result.taxPhone.substr(0, 2));
								$('#taxPhone2').val(result.taxPhone.substr(2, 3));
								$('#taxPhone3').val(result.taxPhone.substr(6, 4));
								
							} else if (result.taxPhone.length == 10) {
								$('#taxPhone1').val(result.taxPhone.substr(0, 3));
								$('#taxPhone2').val(result.taxPhone.substr(3, 3));
								$('#taxPhone3').val(result.taxPhone.substr(6, 4));
								
							} else {
								$('#taxPhone1').val(result.taxPhone.substr(0, 3));
								$('#taxPhone2').val(result.taxPhone.substr(3, 4));
								$('#taxPhone3').val(result.taxPhone.substr(7, 4));
							}
						} else {
							$('#taxPhone1').val("010");
							$('#taxPhone2').val("");
							$('#taxPhone3').val("");
						}

						$('input[name=taxName]').val(result.taxName);
						$('input[name=taxEmail]').val(result.taxEmail);
					} else {
						alert(data.message);
					}

				}

			});
		}

	});

});

// 검색옵션 월별 선택 함수
function change_customDay() {
	var year = $('#customYear').val();
	var date = new Date();
	
	if($('#customDay').val() == "all") {
		var thisYear = date.getFullYear();
		var endDate = "";
		
		if(year == thisYear) {
			// (선택년도 == 올해년도) -> 금일 날짜를 마지막 날로 설정
			endDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, date.getMonth(), date.getDate()));
		}else {
			// 아니면 선택년도의 마지막 날짜로 설정
			var lastDay = (new Date(year, 12, 0)).getDate();
			endDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, 11, lastDay));
		}
		
		var startDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, 0, 1));
		
	} else {
		var mon = $('#customDay').val() - 1;
		var lastDay = (new Date(year, mon + 1, 0)).getDate();
		
		var startDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, mon, 1));
		var endDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, mon, lastDay));
	}
	
	$("#contractStart").val(startDate);
	$("#contractEnd").val(endDate);
}

// 기간선택 (년도에 따른 월별검색 옵션 불러오기)
function year_of_month_option() {
	var date = new Date();
	var thisYear = date.getFullYear(); // 금년
	var thisMonth = date.getMonth()+1; // 금월
	var lastMonth; // 마지막 월
	var year = $('#customYear').val(); // 선택년도
	var option = '<option value="all" selected="selected">전체(월)</option>';
	
	$("#customDay option").remove();
	
	if(thisYear == year) { 
		// 선택년도 == 올해년도 이면 금월까지
		lastMonth = thisMonth;
	}else {
		// 과거년도는 12월까지
		lastMonth = 12;
	}
	
	for(var m=1; m<=lastMonth; m++) {
		option += '<option value="' + m + '">' + m +'월</option>';
	}
	
	$(option).appendTo("#customDay");
}

// accountlist.mypage
$(document).ready(function() {

	$('#customYear').on('change', function() {
		$('#customDayOption a.btn').removeClass('on'); // 날짜 초기화
		$('#customDay').val('all');
		year_of_month_option(); // 월별 옵션
		change_customDay(); // 월별 선택
	});
	
	$('#customDay').on('change', function() {
		change_customDay();
	});
	
	$('#customDayOption a.btn').on('click', function(i) {
		var year = $(this).attr('value').substring(0,4);
		var mon = $(this).attr('value').substring(4,6) - 1;
		var lastDay = (new Date(year, mon + 1, 0)).getDate();
		
		var startDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, mon, 1));
		var endDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, mon, lastDay));

		$("#contractStart").val(startDate);
		$("#contractEnd").val(endDate);
		$('#customDayOption a.btn').removeClass('on'); // 날짜 초기화
		$(this).addClass('on');

	});
	
	/*
	 * 원본
	$('#customDay a.btn').on('click', function(i) {
		var year = $('#customYear').val();
		var mon = $(this).parent().index();
		var lastDay = (new Date($('#customYear').val(), mon + 1, 0)).getDate();
		var startDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, mon, 1));
		var endDate = $.datepicker.formatDate("yy-mm-dd", new Date(year, mon, lastDay));

		$("#contractStart").val(startDate);
		$("#contractEnd").val(endDate)
		$('#customDay a.btn').removeClass('on'); // 날짜 초기화
		$(this).addClass('on');

	});
	*/

	$('#btnaccountSearch').on('click', function() {
		$("#frmAccountList").submit();

	});

	if ($(".tb_total_account").length > 0) {
		var now = new Date();
		$.ajax({
			url : "/account.api",
			type : "post",
			data : ({
				cmd : 'total',
				start_date : now.getFullYear() + "0101",
				end_date : now.getFullYear() + "1231"
			}),
			dataType : "json",
			success : function(data) {
				var offline_list = new Array();
				var online_list = new Array();
				if (data.success) {
					var onlieTotalPay = 0;
					var offlieTotalPay = 0;
					$.each(data.data, function(key, value) {
						if (value.TYPE == "offline") {
							$('.tb_total_account tbody tr:eq(1) td:eq(' + value.M + ')').text(value.totalPrice.toLocaleString());
							onlieTotalPay += value.totalPrice;
						} else {
							$('.tb_total_account tbody tr:eq(0) td:eq(' + value.M + ')').text(value.totalPrice.toLocaleString());
							offlieTotalPay += value.totalPrice;
						}

					});
					$('.tb_total_account tbody tr:eq(0) td:eq(13)').text(onlieTotalPay.toLocaleString());
					$('.tb_total_account tbody tr:eq(1) td:eq(13)').text(offlieTotalPay.toLocaleString());
					$('.calculate_info_area span:eq(1)').text(data.data.length);
					$('.calculate_info_area span:eq(3)').text((onlieTotalPay+offlieTotalPay).toLocaleString())
					
					$('.tb_total_account tfoot td:not(:eq(0))').each(function(i) {
						var onPay = $('.tb_total_account tbody tr:eq(0) td:not(:eq(0)):eq(' + i + ')').text().trim().replace(/,/gi, "");
						var offPay = $('.tb_total_account tbody tr:eq(1) td:not(:eq(0)):eq(' + i + ')').text().trim().replace(/,/gi, "");

						if (!Number.isInteger(Number.parseInt(onPay)))
							onPay = 0;
						if (!Number.isInteger(Number.parseInt(offPay)))
							offPay = 0;
						var totalPay = Number.parseInt(onPay) + Number.parseInt(offPay);
						if (totalPay > 0) {
							$(this).text(totalPay.toLocaleString());
						}

					});

				}
			}
		});
	}

	$("#frmAccountList").on("submit", function() {
		console.log("frmAccountList 호출");
		var startDate = $("#contractStart").val(); // 시작일
		if (startDate == null || startDate.length == 0) {
			alert("선택한 시작 날짜가 없습니다.");
			return false;
		}
		var endDate = $("#contractEnd").val(); // 종료일
		if (endDate == null || endDate.length == 0) {
			alert("선택한 시작 날짜가 없습니다.");
			return false;
		}
		var media_code = new Array(); // 선택 매체 코드
		$("input[name=media_code]").each(function() {
			if ($(this).is(":checked")) {
				media_code.push($(this).val());
			}
		});
		if (media_code.length == 0) {
			alert("선택된 매체가 없습니다.");
			return false;
		}
		var name = $("input[name=keyword]").val(); // 아이디/이름/회사명
		var pay = $("select[name=payType]").val(); // 결제구분
		$.ajax({
			url : "/account.api",
			type : "post",
			data : $(this).serialize(),
			dataType : "json",
			success : function(data) {
				console.log(data);
				// $('.account_list').empty();
				if (data.success) {
					var totalPay = 0;
					var totalCount = data.data.length;
					var tb_online_account = "";
					var tb_offline_account = "";

					var tb_online_total_ba = 0;
					var tb_online_total_at = 0;
					var tb_online_total_cv = 0;
					var tb_online_total_bt = 0;
					var tb_online_total_tsc = 0;
					var tb_online_total_sa = 0;
					var tb_online_total_vos = 0;
					var tb_online_total_atos = 0;
					var tb_online_total_dc = 0;

					var tb_offline_total_ba = 0;
					var tb_offline_total_at = 0;
					var tb_offline_total_cv = 0;
					var tb_offline_total_tsc = 0;
					var tb_offline_total_sa = 0;
					var tb_offline_total_vos = 0;
					var tb_offline_total_atos = 0;
					var tb_offline_total_dc = 0;

					$.each(data.data, function(key, value) {
						totalPay += value.price;

						var billing_amount = value.price; // 결제금액
						var added_tax = Math.round(billing_amount * 0.1); // 과세부가세
						var customs_value = Math.round(billing_amount * 0.9); // 과세금액
						var billing_tax = 0; // 빌링수수료

						var rate = value.preRate;
						var PAYTYPE = "";
						switch (value.LGD_PAYTYPE) {
						case "SC0010":
							PAYTYPE = "카드결제";
							billing_tax = billing_amount * 0.00363;
							break;
						case "SC0040":
							PAYTYPE = "무통장입금";
							billing_tax = 440;
							break;
						case "SC0030":
							PAYTYPE = "계좌이체";
							billing_tax = billing_amount * 0.0022;
							break;
						case "000000":
							PAYTYPE = "세금계산서";
							rate = value.postRate;
							break;
						}
						billing_tax = Math.round(billing_tax);
						rate = 1 - rate / 100;
						var total_sales_account = billing_amount - billing_tax; // 총매출액
						var sales_account = Math.round(total_sales_account * rate);// 회원사
						// 매출액
						var value_of_supply = Math.round(sales_account * 0.9); // 공급가액
						var added_tax_of_supply = Math.round(sales_account * 0.1); // 공급부가액
						var dahami_account = total_sales_account - sales_account;

						if (value.LGD_PAYTYPE == "000000") {
							tb_offline_account += "<tr>";
							tb_offline_account += "<td>" + value.LGD_PAYDATE.substr(0, 4) + '-' + value.LGD_PAYDATE.substr(4, 2) + '-' + value.LGD_PAYDATE.substr(6, 2) + "</td>";
							tb_offline_account += "<td>" + value.LGD_BUYER + "</td>";
							tb_offline_account += "<td>" + value.photo_uciCode + "</td>";
							tb_offline_account += "<td>" + value.usage + "</td>";
							tb_offline_account += "<td>" + value.copyright + "</td>";
							tb_offline_account += "<td>무통장입금</td>";
							tb_offline_account += "<td>" + PAYTYPE.toLocaleString() + "</td>";
							tb_offline_account += "<td>" + customs_value.toLocaleString() + "</td>";
							tb_offline_account += "<td>" + added_tax.toLocaleString() + "</td>";
							tb_offline_account += "<td>" + billing_amount.toLocaleString() + "</td>";
							tb_offline_account += "<td>" + total_sales_account.toLocaleString() + "</td>";
							tb_offline_account += "<td>" + sales_account.toLocaleString() + "</td>";
							tb_offline_account += "<td>" + value_of_supply.toLocaleString() + "</td>";
							tb_offline_account += "<td>" + added_tax_of_supply.toLocaleString() + "</td>";
							tb_offline_account += "<td>" + dahami_account.toLocaleString() + "</td>";
							tb_offline_account += "</tr>";
							tb_offline_total_ba += billing_amount;
							tb_offline_total_at += added_tax;
							tb_offline_total_cv += customs_value;
							tb_offline_total_tsc += total_sales_account;
							tb_offline_total_sa += sales_account;
							tb_offline_total_vos += value_of_supply;
							tb_offline_total_atos += added_tax_of_supply;
							tb_offline_total_dc += dahami_account;

						} else {
							tb_online_account += "<tr>";
							tb_online_account += "<td>" + value.LGD_PAYDATE.substr(0, 4) + '-' + value.LGD_PAYDATE.substr(4, 2) + '-' + value.LGD_PAYDATE.substr(6, 2) + "</td>";
							tb_online_account += "<td>" + value.LGD_BUYER + "</td>";
							tb_online_account += "<td>" + value.photo_uciCode + "</td>";
							tb_online_account += "<td>" + value.usage + "</td>";
							tb_online_account += "<td>" + value.copyright + "</td>";
							tb_online_account += "<td>" + PAYTYPE.toLocaleString() + "</td>";
							tb_online_account += "<td>" + customs_value.toLocaleString() + "</td>";
							tb_online_account += "<td>" + added_tax.toLocaleString() + "</td>";
							tb_online_account += "<td>" + billing_amount.toLocaleString() + "</td>";
							tb_online_account += "<td>" + billing_tax.toLocaleString() + "</td>";
							tb_online_account += "<td>" + total_sales_account.toLocaleString() + "</td>";
							tb_online_account += "<td>" + sales_account.toLocaleString() + "</td>";
							tb_online_account += "<td>" + value_of_supply.toLocaleString() + "</td>";
							tb_online_account += "<td>" + added_tax_of_supply.toLocaleString() + "</td>";
							tb_online_account += "<td>" + dahami_account.toLocaleString() + "</td>";
							tb_online_account += "</tr>";
							tb_online_total_ba += billing_amount;
							tb_online_total_at += added_tax;
							tb_online_total_cv += customs_value;
							tb_online_total_bt += billing_tax;
							tb_online_total_tsc += total_sales_account;
							tb_online_total_sa += sales_account;
							tb_online_total_vos += value_of_supply;
							tb_online_total_atos += added_tax_of_supply;
							tb_online_total_dc += dahami_account;

						}

					});
					$(".tb_offline_account table tbody").empty();
					$(".tb_online_account table tbody").empty();
					$(".tb_offline_account table tbody").append(tb_offline_account);
					$(".tb_online_account table tbody").append(tb_online_account);

					var calculate_info_area = "기간 : " + startDate + " ~ " + endDate;
					calculate_info_area += "<span style=\"margin: 0 20px;\">l</span>";
					calculate_info_area += "건수 :<span class=\"color\"> " + totalCount + "</span> 건";
					calculate_info_area += "<span style=\"margin: 0 20px;\">l</span>";
					calculate_info_area += "총 판매금액 :<span class=\"color\"> " + totalPay.toLocaleString() + "</span> 원";
					$('.calculate_info_area').html(calculate_info_area);

					var total_online_area = "<tr>";
					total_online_area += "<td colspan=\"6\">온라인 매출액 합계</td>";
					total_online_area += "<td>" + tb_online_total_cv.toLocaleString() + "</td>";
					total_online_area += "<td>" + tb_online_total_at.toLocaleString() + "</td>";
					total_online_area += "<td>" + tb_online_total_ba.toLocaleString() + "</td>";
					total_online_area += "<td>" + tb_online_total_bt.toLocaleString() + "</td>";
					total_online_area += "<td>" + tb_online_total_tsc.toLocaleString() + "</td>";
					total_online_area += "<td>" + tb_online_total_sa.toLocaleString() + "</td>";
					total_online_area += "<td>" + tb_online_total_vos.toLocaleString() + "</td>";
					total_online_area += "<td>" + tb_online_total_atos.toLocaleString() + "</td>";
					total_online_area += "<td>" + tb_online_total_dc.toLocaleString() + "</td>";
					total_online_area += "</tr>";
					$('.tb_online_account tfoot ').empty();
					$('.tb_online_account tfoot ').html(total_online_area);
					var total_offline_area = "<tr>";
					total_offline_area += "<td colspan=\"7\">오프라인 매출액 합계</td>";
					total_offline_area += "<td>" + tb_offline_total_cv.toLocaleString() + "</td>";
					total_offline_area += "<td>" + tb_offline_total_at.toLocaleString() + "</td>";
					total_offline_area += "<td>" + tb_offline_total_ba.toLocaleString() + "</td>";
					total_offline_area += "<td>" + tb_offline_total_tsc.toLocaleString() + "</td>";
					total_offline_area += "<td>" + tb_offline_total_sa.toLocaleString() + "</td>";
					total_offline_area += "<td>" + tb_offline_total_vos.toLocaleString() + "</td>";
					total_offline_area += "<td>" + tb_offline_total_atos.toLocaleString() + "</td>";
					total_offline_area += "<td>" + tb_offline_total_dc.toLocaleString() + "</td>";
					total_offline_area += "</tr>";
					$('.tb_offline_account tfoot ').empty();
					$('.tb_offline_account tfoot ').html(total_offline_area);

					var rs_vos = tb_online_total_vos + tb_offline_total_vos;
					var rs_atos = tb_online_total_atos + tb_offline_total_atos;
					console.log(rs_vos, rs_atos)
					var rs_total = rs_vos + rs_atos;
					var tb_result_account = "<tbody>";
					tb_result_account += "<tr>";
					tb_result_account += "<td>공금가액</td>";
					tb_result_account += "<td>" + rs_vos.toLocaleString() + "</td>";
					tb_result_account += "</tr>";
					tb_result_account += "<tr>";
					tb_result_account += "<td>부가세</td>";
					tb_result_account += "<td>" + rs_atos.toLocaleString() + "</td>";
					tb_result_account += "</tr>";
					tb_result_account += "</tbody>";
					tb_result_account += "<tfoot>";
					tb_result_account += "<tr>";
					tb_result_account += "<td>합계 (부가세 포함)</td>";
					tb_result_account += "<td>" + rs_total.toLocaleString() + "</td>";
					tb_result_account += "</tr>";
					tb_result_account += "</tfoot>";
					$(".tb_result_account table").empty();
					$(".tb_result_account table").html(tb_result_account);

					$(".tb_total_account").css('display', 'none');
					$(".tb_online_account").css('display', 'block');
					$(".tb_offline_account").css('display', 'block');
					$(".tb_result_account").css('display', 'block');
				}
			}
		});

		return false;
	});

});



//등록증 업로드
$(function() {

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
	
	$('input[type=file]').bind('change', function() {
		
		var uType = $(this).attr("name");	
		console.log(uType);
		var tmpFile = $(this)[0].files[0];
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
				url : '/'+uType+'.upload',
				data : formData,
				dataType : "json",
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					console.log(data);
					if (data.success) {
						alert(data.message);
					} else {
						alert(data.message);
					}
					location.reload();
				},
				error : function(data) {
					console.log("Error: " + data.statusText);
					alert("잘못된 접근입니다.");
				},

			});

		} else {
			alert("파일 형식이 올바르지 않습니다.");
			$(this).val("");
		}

	});

});

// 다운로드 내역, 구매내역 (년도별 선택 옵션)
function select_year(year, url) {
	$("#year").val(year);
	$("#dateForm").attr("action", url);
	$("#dateForm").submit();
	
	
	
	console.log($("#dateForm").length);
	console.log("year : " + year + " / url : " + url);
}

// 현재날짜 (년월일시분초)
function getDateTime() {
	var now = new Date();
	var year = now.getFullYear();
	var month = addZeros(now.getMonth() + 1, 2);
	var day = addZeros(now.getDate(), 2);
	var hour = addZeros(now.getHours(), 2);
	var min = addZeros(now.getMinutes(), 2);
	var second = addZeros(now.getSeconds(), 2);
	
	var result = year + "" + month + "" + day + "_" + hour + "" + min + "" + second;
	
	return result;
}

//자릿수 맞춰주기
function addZeros(num, digit) { 
	  var zero = '';
	  num = num.toString();
	  if (num.length < digit) {
	    for (i = 0; i < digit - num.length; i++) {
	      zero += '0';
	    }
	  }
	  return zero + num;
}

// 천단위 ,(콤마) 넣어주기
function comma(num){
	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


$(document).ready(function() {
	var payAllCancelForm = $('form[name=payAllCancel]');
	payAllCancelForm.find('a.precautions_btn').on("click", function() {
		if(!confirm("정말로 결제를 취소하시겠습니까?")) {
			return;
		}
		var today = getDateTime().substr(0, 8); // 금일날짜
		var paydate = payAllCancelForm.find('input[name=LGD_PAYDATE]').val().substr(0, 8); // 결제일자
		var gap = today - paydate; // 소요기간
		
		if(gap <= 7 && totalDownCount == 0) { // 7일 이내
			
			var param = {
				"LGD_OID" : LGD_OID,
				"cmd" : "C"
			};
				
			$.ajax({
				type: "POST",
				dataType: "json",
				data: param,
				url: "/payment.api",
				success: function(data) {
					console.log(data);
				}, complete: function() {
					alert("결제 취소 완료");
					location.replace("/buylist.mypage");
				}
			});
		}else {
			alert("다운로드 받은 내역이 있을 시, 환불이 불가능합니다.\n (환불가능기간은 결제일로부터 7일 이내입니다.)")
		}
		
	});
});

// 결제취소
function cancelPay(LGD_OID, paymentManage_seq, LGD_PAYDATE, totalDownCount) {
	/*
	 * 취소가능 조건
	 * 1. 결제일로부터 7일 이내.
	 * 2. 이미지 다운로드 이력이 없어야 됨.
	 */
	
	if(!confirm("정말로 결제를 취소하시겠습니까?")) {
		return;
	}
	var today = getDateTime().substr(0, 8); // 금일날짜
	var paydate = LGD_PAYDATE.substr(0, 8); // 결제일자
	var gap = today - paydate; // 소요기간
	
	if(gap <= 7 && totalDownCount == 0) { // 7일 이내
		
		var param = {
			"paymentManage_seq" : paymentManage_seq,
			"LGD_OID" : LGD_OID,
			"cmd" : "C"
		};
			
		$.ajax({
			type: "POST",
			dataType: "json",
			data: param,
			url: "/payment.api",
			success: function(data) {
				console.log(data);
			}, complete: function() {
				alert("결제 취소 완료");
				location.replace("/buylist.mypage");
			}
		});
	}else {
		alert("다운로드 받은 내역이 있을 시, 환불이 불가능합니다.\n (환불가능기간은 결제일로부터 7일 이내입니다.)")
	}
}
