// pay
$(document).ready(function() {
	/*
	 * 수정불가.
	 */
	var LGD_window_type = 'iframe';
	
	/*
	* 수정불가
	*/
	function launchCrossPlatform(){
		//lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'service', LGD_window_type, null, "", "");
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
			document.getElementById("LGD_PAYINFO").action = "payres.jsp";
			document.getElementById("LGD_PAYINFO").submit();
		} else {
			alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
			closeIframe();
		}
	}

	$("#frmOrder").on("click", function() {
		$.ajax({
			type : "post",
			url : "/purchase.api",
			data : $(this).serialize(),
			dataType : "json",
			success : function(data) {

				var form = $('<form></form>');
				form.attr('id','LGD_PAYINFO');
				form.attr('method', 'post');
				form.appendTo(a);
				var idx = $('<input type="hidden" value="' + a.text() + '" name="LGD_OID">');
				form.append(idx);
				//form.submit();
				launchCrossPlatform();

			},
			error : function() {
				console.log(data);
			}
		});
	});

});
