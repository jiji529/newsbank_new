//login 로그인
$(document).ready(function() {
	
	$("#frmLogin").on("submit",function(){
		$.post("/login.api", $(this).serialize(), function(data) {
			if (data.success) {
				if(data.message){
					alert(data.message);
				}
			//	location.href = "/login";
				var frm = $('#frmPost');
				var prevPage = frm.find('[name=prevPage]').val();
				if(!prevPage)
					prevPage = "/home";
				frm.attr('action', prevPage).attr('method', 'post').submit();
				return false;
				
				
			} else {
				alert(data.message);

			}
		}, "json");
		
		return false;
	});

	
});
