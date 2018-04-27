//login 로그인
$(document).ready(function() {
	
	$("#frmLogin").on("submit",function(){
		var form = $(this);
		$.post("/check.login", form.serialize(), function(data) {
			if (data.success) {
				if(data.message){
					alert(data.message);
				}
				var id = form.find('#id').val();
				if(id.length<4){
					layer_popup();
				}else{
					login_move();
				}
				
				return false;
			} else {
				alert(data.message);
			}
		}, "json");
		
		return false;
	});

	function layer_popup(){
		
		if($('#login_popup').size()==0){
			var warp = $('<div>').attr({
				id : 'login_popup',
			}).appendTo('body');
		}

		$('#login_popup').load('idchange.login',function( response, status){
			if(response==''){
				login_move();
			}
		});
	}

	function login_move(){
		var frm = $('#frmPost');
		var prevPage = frm.find('[name=prevPage]').val();
		if(!prevPage)
			prevPage = "/home";
		frm.attr('action', prevPage).attr('method', 'post').submit();
	}


	
});


