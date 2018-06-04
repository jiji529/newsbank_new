<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script>
	$(document).ready(
			function() {
				$('.popup_close').on('click', function() {
					
					if (confirm("다음에 변경하시겠습니까?")) {
						location.reload();
						return false;
					}
				});


				$("form[name=frmLoginPop]").submit(	function() {
					var check = true;
					var new_id = $("input[name=new_id]");
					check = check && validId();
					check = check && validIdConfirm();
					if (check) {
						if (confirm(new_id.val()+" 으로 변경하시겠습니까?")) {
							$.ajax({
								url : "/member.api",
								type : "post",
								data : ({
									cmd : "U",
									id : new_id.val()
								}),
								dataType : "json",
								success : function(data) {
									if (data.success) {
										alert('변경되었습니다.');
										location.reload();
									} else {
										alert(data.message);
									}
									return false;

								}

							});
							return false;
						}
						
					}
					return false;
				});
				
				$("input[name=new_id]").change(function() {
					var new_id = $(this);
					if (validId()) {
						$.ajax({
							url : "/findMember.api",
							data : ({
								id :new_id.val()
							}),
							dataType : "json",
							success : function(data) {
								if (data.success) {
									// 사용중
									$(".msg1").css("display", "block");
									$("input[name=new_id_check]").val(0);
									new_id.focus();
								} else {
									// 미사용중
									$("input[name=new_id_check]").val(1);
									$(".msg1").css("display", "none");
								}

							}

						});
					}

				});
				$("input[name=new_id_confirm]").change(function() {
					return validIdConfirm();

				});
				
		

				// form.join 아이디 상용 유무 체크
				function validId() {
					var id = $("input[name=new_id]").val();
					var regex = /[A-Za-z0-9]{2,19}$/g;
					if (regex.test(id) && id.length > 3) {
						$(".msg2").css("display", "none");
						return true;
					} else {
						$(".msg2").css("display", "block");
						return false;
					}
				}
				// form.join 아이디 상용 유무 체크
				function validIdConfirm() {
					var new_id = $("input[name=new_id]");
					var id_confirm = $("input[name=new_id_confirm]");
					var id_same_check = $("input[name=new_id_check]");
					var regex = /[A-Za-z0-9]{2,19}$/g;
					if (regex.test(new_id.val()) && new_id.val().length > 3) {
						$(".msg2").css("display", "none");
						
						if(id_same_check.val()==1){
							if (new_id.val() != id_confirm.val()) {
								$(".msg3").css("display", "block");
								id_confirm.focus();
								return false;
							} else {
								$(".msg3").css("display", "none");
								return true;
							}
						}else{
							$(".msg1").css("display", "block");
							id_confirm.val("");
							new_id.focus();
							return false;
						}
						
						
						
						
					} else {
						$(".msg2").css("display", "block");
						return false;
					}
				}

			});
</script>
<form method="post" name="frmLoginPop">
	<div id="popup_wrap" class="pop_id">
		<div class="pop_tit">
			<h2>아이디를 변경해 주세요</h2>
		</div>
		<div class="pop_cont">
			<div class="id_cont">
				<p>
					뉴스뱅크 사이트 업데이트로 인하여 <br /> 기존에 사용하고 계시는 아이디를 더 이상 사용하실 수 없습니다. <br />
					<b>영문 대소문자, 숫자 조합 4~20자 이내</b>의 새로운 아이디를 등록해주세요. <br /> 기존 아이디에서
					사용하셨던 이력을 이관하여 드리겠습니다.
				</p>
			</div>
			<dl class="input_box">
				<dt>현재 아이디</dt>
				<dd>${id}</dd>
				<dt>새 아이디</dt>
				<dd>
					<input type="text" name="new_id" maxlength="20"
						pattern="[A-Za-z0-9]*" title="숫자와 영문만 입력 하세요." required tabindex="1" />
						<input type="hidden" name="new_id_check" value="0"  />
					<p class="txt_message msg1"  style="display: none;">이미
						사용된 아이디입니다. 다른 아이디를 입력하세요.</p>
					<p class="txt_message msg2"  style="display: none;">숫자와
						영문만 입력 하세요.</p>
				</dd>
				<dt>새 아이디 확인</dt>
				<dd>
					<input type="text" name="new_id_confirm" maxlength="20"
						pattern="[A-Za-z0-9]*" title="숫자와 영문만 입력 하세요." required tabindex="2"/>
					<p class="txt_message msg3"  style="display: none;">아이디가
						일치하지 않습니다.</p>
				</dd>
			</dl>
			<p class="id_alert">
				<b>2018년 12월 31일까지</b> 꼭 아이디를 변경해주세요.<br />이후에는 기존 아이디로 로그인 하실 수
				없습니다.
			</p>
		</div>
		<div class="pop_foot">
			<div class="pop_btn">
				<button type="submit" class="popup_change" tabindex="3">변경하기</button>
				<c:if test="${!nextChangeHide}">
					<button type="button" class="popup_close" tabindex="4">다음에 변경하기</button>
				</c:if>
			</div>
		</div>
	</div>
	<div class="mask" style="display: block;"></div>
</form>
