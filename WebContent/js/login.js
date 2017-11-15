//login 로그인
$(document).ready(function() {
	
	$("#frmLogin").on("submit",function(){
		$.post("/login.api", $(this).serialize(), function(data) {
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
