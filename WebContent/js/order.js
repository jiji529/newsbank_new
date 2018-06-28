// pay

/*
 * 수정불가.
 */
var LGD_window_type = 'iframe';

/*
 * 수정불가
 */
function launchCrossPlatform(platform) {
	if(platform!=null){
		platform = 'service';
	}
	// lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'service',
	// LGD_window_type, null, "", "");
	lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), platform, LGD_window_type, null, "", "");
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
		alert("사용자가 결제를 완료했습니다.");
		document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
		document.getElementById("LGD_PAYINFO").target = "_self";
		document.getElementById("LGD_PAYINFO").action = "Payres.Xpay";
		document.getElementById("LGD_PAYINFO").submit();
	} else {
		//alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		alert("사용자가 결제를 취소하였습니다.");
		closeIframe();
	}
}

$(document).ready(function() {

	$("#frmSubmit").on("click", function() {
		$("#frmOrder").submit();
	});

	$("#frmOrder").on("submit", function() {

		var check = true;
		check = check && validPlatform();

		if (check) {
			console.log(JSON.stringify($(this).serializeObject()));
			
			$.ajax({
				type : "post",
				url : "/purchase.api",
				data : ({
					orderJson : JSON.stringify($(this).serializeObject())
				}),

				dataType : "json",
				success : function(data) {
					if (data.success) {
						console.log(data.data);
						$('#LGD_PAYINFO').remove();
						var form = $('<form></form>');
						form.attr('id', 'LGD_PAYINFO');
						form.attr('method', 'post');
						form.attr('name', 'LGD_PAYINFO');
						form.attr('action', 'Payres.Xpay');
						
						form.appendTo($(".order_list"));

						$.each(data.data, function(key, value) {
							var objs;
							objs = document.createElement('input');
							objs.setAttribute('type', 'hidden');
							objs.setAttribute('name', key);
							objs.setAttribute('id', key);
							objs.setAttribute('value', value);
							form.append(objs);
						});

						// form.submit();
						launchCrossPlatform(data.data.CST_PLATFORM);
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
