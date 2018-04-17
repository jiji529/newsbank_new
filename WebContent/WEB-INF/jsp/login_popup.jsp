<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script>
	$(document).ready(
			function() {
				$('.popup_close').on('click', function() {
					location.reload();
				});

				$('.popup_change').on('click', function() {
					alert('변경되었습니다.');
				});

				$("form[name=frmLoginPop]").submit(	function() {
					var check = true;
					check = check && validId('new_id');
					check = check && validId('new_id_confirm');
					return false;
				});
				
				$("input[name=new_id]").change(function() {
					var new_id = $(this);
					if (validId('new_id')) {
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
									new_id.focus();
								} else {
									// 미사용중
									$(".msg1").css("display", "none");
								}

							}

						});
					}

				});
				
				$("input[name=new_id_confirm]").change(function() {
					return validId('new_id_confirm');

				});
				

				// form.join 아이디 상용 유무 체크
				function validId() {
					var id = $("input[name=new_id]").val();
					var id_confirm = $("input[name=new_id_confirm]").val();
					var regex = /[A-Za-z0-9]{2,19}$/g;
					if (regex.test(id) && id.length > 3) {
						$(".msg1").css("display", "block");
						if (id != id_confirm) {
							$(".msg3").css("display", "block");
							$("input[name=new_id_confirm]").focus();
							return false;
						} else {
							$(".msg3").css("display", "none");
							return true;
						}
						return true;
					} else {
						$(".msg2").css("display", "none");
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
						pattern="[A-Za-z0-9]*" title="숫자와 영문만 입력 하세요." required />
					<p class="txt_message msg1" id="id_message" style="display: none;">이미
						사용된 아이디입니다. 다른 아이디를 입력하세요.</p>
					<p class="txt_message msg2" id="id_message2" style="display: none;">숫자와
						영문만 입력 하세요.</p>
				</dd>
				<dt>새 아이디 확인</dt>
				<dd>
					<input type="text" name="new_id_confirm" maxlength="20"
						pattern="[A-Za-z0-9]*" title="숫자와 영문만 입력 하세요." required />
					<p class="txt_message msg3" id="pw_check_message" style="display: none;">아이디가
						일치하지 않습니다.</p>
				</dd>
			</dl>
			<p class="id_alert">
				<b>2018년 5월 31일까지</b> 꼭 아이디를 변경해주세요.<br />이후에는 기존 아이디로 로그인 하실 수
				없습니다.
			</p>
		</div>
		<div class="pop_foot">
			<div class="pop_btn">
				<button type="submit" class="popup_change">변경하기</button>
				<button class="popup_close">다음에 변경하기</button>
			</div>
		</div>
	</div>
	<div class="mask" style="display: block;"></div>
</form>
