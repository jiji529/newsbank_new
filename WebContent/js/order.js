// pay
$(document).ready(function() {
	/*
	 * 수정불가.
	 */
	var LGD_window_type = 'iframe';

	/*
	 * 수정불가
	 */
	function launchCrossPlatform() {
		// lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'service',
		// LGD_window_type, null, "", "");
		lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'test', LGD_window_type, null, "", "");
	}
	/*
	 * FORM 명만 수정 가능
	 */
	function getFormObject() {
		return document.getElementById("LGD_PAYINFO");
	}

	/*
	 * 인증결과 처리
	 */
	function payment_return() {
		var fDoc;

		fDoc = lgdwin.contentWindow || lgdwin.contentDocument;

		if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {

			document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
			document.getElementById("LGD_PAYINFO").target = "_self";
			document.getElementById("LGD_PAYINFO").action = "Payres.Xpay";
			document.getElementById("LGD_PAYINFO").submit();
		} else {
			alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
			closeIframe();
		}
	}

	$("#frmSubmit").on("click", function() {
		$("#frmOrder").submit();
	});

	$("#frmOrder").on("submit", function() {

		var check = true;
		check = check && validPlatform();

		if (check) {
			$.ajax({
				type : "post",
				url : "/purchase.api",
				data : ({
					orderJson : JSON.stringify($(this).serializeObject())
				}),
				
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var form = $('<form></form>');
						form.attr('id', 'LGD_PAYINFO');
						form.attr('method', 'post');
						form.appendTo($("#order_list"));
						data.data.each(function(index) {
							console.log(index + ": " + $(this).text());

						});

						// form.submit();
						launchCrossPlatform();
					}

				},
				error : function() {
					console.log(data);
				}
			});
		}
		return false;

	});

	function validPlatform() {
		var CST_PLATFORM = $("input[name=LGD_CUSTOM_USABLEPAY]:checked").val();
		if (CST_PLATFORM != null && CST_PLATFORM.length > 0) {
			return true;
		} else {
			alert('결제 방법을 선택하세요.');
			return false;
		}
	}

});
