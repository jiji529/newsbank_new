<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : LEE. GWANG HO
  @date     : 2017. 12. 22. 오전 10:32:20
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 12. 22.   LEE GWANGHO    view.member.manage
---------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dahami.newsbank.web.service.bean.SearchParameterBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>뉴스뱅크관리자</title>

<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui-1.12.1.min.js"></script>

<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/sub.css" />
<link rel="stylesheet" href="css/mypage.css" />
<link rel="stylesheet" href="css/jquery-ui-1.12.1.min.css" />
<script src="js/footer.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- <script src="js/mypage.js"></script> -->
<script src="js/admin.js?v=20180405"></script>
<script type="text/javascript">

	$(document).ready(function() {
		$(".lnb [href]").each(function() {
			var lng_path = (this.pathname).substr(1, (this.pathname).length);
			var location_path = (window.location.pathname).substr(1, (window.location.pathname).length);
			
			if (location_path.match(lng_path)) {
				$(this).parent().addClass("on");
			} 
		});
		
		var deferred = ${MemberDTO.deferred};
		var memberType = "${MemberDTO.type}"; 
		
		if(deferred == 0) {
			$(".offline_area").hide();
		}else if(deferred == 2) {
			$(".photoUsage").show();
		}
		
		if(memberType == "P") { // 개인 회원
			$(".corp_area").hide();
			//$(".corp_area").children().find("input").attr("disabled", true);
		}
		
		setDatepicker();
	});
	
	function deferred_choice() {
		var deferred = parseInt($("select[name=deferred]").val());
		
		switch(deferred) {
			case 0:
				// 온라인
				$(".offline_area").hide();
				$(".photoUsage").hide();
				break;
				
			case 1:
				// 오프라인
				$(".offline_area").show();
				$(".photoUsage").hide();
				break;
				
			case 2:
				// 오프라인 별도가격
				$(".offline_area").show();
				$(".photoUsage").show();
				break;
		}
	}	
	
	// 회원구분 선택
	$(document).on("change", ".mtype", function() {
		 var type = $(this).val();
		 var tName = $(".mtype option:selected").text();
		 
		 switch(type) {
			case 'P': // 개인
				$(".media_only").hide();
				$(".corp_area").hide();
				break;
				
			case 'C': // 법인
				$("#tName").text(tName);
				$(".media_only").hide();
				$(".corp_area").show();
				break;
				
			case 'M': // 언론사
				$("#tName").text(tName);
				$(".media_only").show();
				$(".corp_area").show();
				break;
		}
	});
	
	// 회원정보 수정
	function member_update() {
		$('#frmJoin').submit(); // 회원 정보 수정
	}
	
	// 회원탈퇴
	function drop_out() {
		if(confirm("정말로 탈퇴하시겠습니까?")) {
			var seq = ${MemberDTO.seq};
			
			$.ajax({
				type: "POST",
				url: "/admin.member.api",
				data : ({
					cmd : 'D',
					seq : seq
				}),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						alert("탈퇴 완료");
						location.href = "/member.manage";
					} else {
						alert("회원 탈퇴 과정에서 오류발생");						
					}

				}
			});
		}
		
	}
</script>
</head>
<body>
<div class="wrap admin">
	<%@include file="header_admin.jsp" %>
	<section class="wide">
		<%@include file="sidebar.jsp" %>
		<div class="mypage">
			<div class="table_head">
				<h3>회원 현황</h3>
			</div>
			<h4>기본 정보</h4>
			<form id="frmJoin" action="/admin.member.api" name="frmJoin" method="post">
				<table class="tb01" cellpadding="0" cellspacing="0">
					<colgroup>
					<col style="width:240px;">
					<col style="width:;">
					</colgroup>
					<tbody>
						<tr>
							<th>아이디 </th>
							<td>${MemberDTO.id}</td>
						</tr>
						<tr>
							<th> 비밀번호 변경 </th>
							<td>
								<input type="password" id="pw" name="pw" class="inp_txt" size="40">
								<p class="txt_message" id="pw_message" style="display: none;">영대소문자, 숫자, 특수기호를 모두 사용해주세요.</p>
							</td>
						</tr>
						<tr>
							<th>비밀번호 재확인</th>
							<td>
								<input type="password" id="pw_check" name="pw_check" class="inp_txt" size="40">
								<p class="txt_message" id="pw_check_message" style="display: none;">비밀번호가 일치하지 않습니다.</p>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>${MemberDTO.name}</td>
						</tr>
						<tr>
							<th>휴대전화번호</th>
							<td class="phone"><select id="phone1" name="" class="inp_txt" style="width:70px;">
									<option value="010" <c:if test="${phone1 eq '010'}">selected</c:if>>010</option>
									<option value="011" <c:if test="${phone1 eq '011'}">selected</c:if>>011</option>
									<option value="016" <c:if test="${phone1 eq '016'}">selected</c:if>>016</option>
									<option value="017" <c:if test="${phone1 eq '017'}">selected</c:if>>017</option>
									<option value="018" <c:if test="${phone1 eq '018'}">selected</c:if>>018</option>
									<option value="019" <c:if test="${phone1 eq '019'}">selected</c:if>>019</option>
								</select>
								<span class="bar">-</span>
								<input type="text" id="phone2" size="5"  class="inp_txt" value="${phone2}" maxlength="4">
								<span class=" bar">-</span>
								<input type="text" id="phone3" size="5"  class="inp_txt" value="${phone3}" maxlength="4" /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input id="email" name="email" type="text" class="inp_txt" size="50" value="${MemberDTO.email}" /></td>
						</tr>
						<tr>
							<th>회원구분</th>
							<td>
								<select name="type" class="inp_txt mtype" style="width: 120px;" >
									<option value="P" <c:if test="${MemberDTO.type eq 'P'}">selected</c:if>>개인</option>
									<option value="C" <c:if test="${MemberDTO.type eq 'C'}">selected</c:if>>법인</option>
									<option value="M" <c:if test="${MemberDTO.type eq 'M'}">selected</c:if>>언론사</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				<!--여기부터 법인-->
				<%-- <c:if test="${MemberDTO.type eq 'C' || MemberDTO.type eq 'M'}"> --%>
				<div class="corp_area">
					<h4> <span id="tName"> </span> 회원 추가 정보</h4>
					<table class="tb01" cellpadding="0" cellspacing="0">
						<colgroup>
						<col style="width:240px;">
						<col style="width:;">
						</colgroup>
						<tbody>
							
								<tr>
									<th>회사/기관명</th>
									<td><input type="text" id="compName" name="compName" class="inp_txt" size="60" value="${MemberDTO.compName}" /></td>
								</tr>
								<tr>
									<th>사업자등록번호</th>
									<td>
										<input type="text" id="compNum1" name="compNum1"  size="3"  class="inp_txt" value="${compNum1}" maxlength="3">
										<span class=" bar">-</span>
										<input type="text" id="compNum2" name="compNum2" size="2"  class="inp_txt" value="${compNum2}" maxlength="2">
										<span class=" bar">-</span>
										<input type="text" id="compNum3" name="compNum3" size="5"  class="inp_txt" value="${compNum3}" maxlength="6" />
										
										<div class="upload-btn-wrapper">
											<a href="#" class="btn_input1">사업자등록증 업로드</a>
											<input type="file" name="doc" accept="application/pdf, image/*" required />
										</div>
										<c:if test="${!empty MemberDTO.compDocPath}">
											<a class="btn_input1" target="_blank" href="/doc.down.photo?seq=${MemberDTO.seq}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" class="btn_input1">사업자등록증 다운로드</a>
										</c:if>
										<p class="txt_message" id="compNum_message" style="display: none;">형식이 올바르지 않은 번호입니다.</p>
									</td>
								</tr>
								<tr>
									<th>회사/기관 전화</th>
									<td>
										<select id="compTel1" name="compTel1" class="inp_txt" style="width:70px;">											
											<option value="02" <c:if test="${compTel1 eq '02'}">selected</c:if>>02</option>
											<option value="031" <c:if test="${compTel1 eq '031'}">selected</c:if>>031</option>
											<option value="032" <c:if test="${compTel1 eq '032'}">selected</c:if>>032</option>
											<option value="033" <c:if test="${compTel1 eq '033'}">selected</c:if>>033</option>
											<option value="041" <c:if test="${compTel1 eq '041'}">selected</c:if>>041</option>
											<option value="042" <c:if test="${compTel1 eq '042'}">selected</c:if>>042</option>
											<option value="043" <c:if test="${compTel1 eq '043'}">selected</c:if>>043</option>
											<option value="044" <c:if test="${compTel1 eq '044'}">selected</c:if>>044</option>
											<option value="051" <c:if test="${compTel1 eq '051'}">selected</c:if>>051</option>
											<option value="052" <c:if test="${compTel1 eq '052'}">selected</c:if>>052</option>
											<option value="053" <c:if test="${compTel1 eq '053'}">selected</c:if>>053</option>
											<option value="054" <c:if test="${compTel1 eq '054'}">selected</c:if>>054</option>
											<option value="055" <c:if test="${compTel1 eq '055'}">selected</c:if>>055</option>
											<option value="061" <c:if test="${compTel1 eq '061'}">selected</c:if>>061</option>
											<option value="062" <c:if test="${compTel1 eq '062'}">selected</c:if>>062</option>
											<option value="063" <c:if test="${compTel1 eq '063'}">selected</c:if>>063</option>
											<option value="064" <c:if test="${compTel1 eq '064'}">selected</c:if>>064</option>
											<option value="070" <c:if test="${compTel1 eq '070'}">selected</c:if>>070</option>
											<option value="080" <c:if test="${compTel1 eq '080'}">selected</c:if>>080</option>
											<option value="010" <c:if test="${compTel1 eq '010'}">selected</c:if>>010</option>
											<option value="011" <c:if test="${compTel1 eq '011'}">selected</c:if>>011</option>
											<option value="016" <c:if test="${compTel1 eq '016'}">selected</c:if>>016</option>
											<option value="017" <c:if test="${compTel1 eq '017'}">selected</c:if>>017</option>
											<option value="018" <c:if test="${compTel1 eq '018'}">selected</c:if>>018</option>
											<option value="019" <c:if test="${compTel1 eq '019'}">selected</c:if>>019</option>
										</select>
										<span class=" bar">-</span>
										<input type="text" id="compTel2" name="compTel2" size="5"  class="inp_txt" value="${compTel2}" maxlength="4">
										<span class=" bar">-</span>
										<input type="text" id="compTel3" name="compTel3" size="5"  class="inp_txt" value="${compTel3}" maxlength="4">
										<span class=" bar2">내선</span>
										<input type="text" id="compExtTel" name="compExtTel" size="5"  class="inp_txt" value="${compExtTel}" maxlength="4" />
										
										<p class="txt_message" id="compTel_message" style="display: none;">형식이 올바르지 않은 번호입니다.</p><br/>
										<p class="txt_message" id="compExtTel_message" style="display: none;">형식이 올바르지 않은 내선번호입니다.</p>
									</td>
										
								</tr>
								<tr>
									<th>회사/기관 주소</th>
									<td>
										<div class="my_addr">
											<input type="text" id="compZipcode" name="compZipcode" class="inp_txt" value="${MemberDTO.compZipcode}" size="6" />
											<a href="#" id="findAddress" class="btn_input1">수정</a></div>
										<div class="my_addr">
											<input type="text" id="compAddress" name="compAddress" class="inp_txt" value="${MemberDTO.compAddress}" size="50" />
											<input type="text" id="compAddDetail" name="compAddDetail" class="inp_txt" value="${MemberDTO.compAddDetail}" size="50" />
										</div>
									</td>
								</tr>
								<tr>
									<th>결제구분</th>
									<td>
										<select name="deferred" class="inp_txt" style="width:180px;" onchange="deferred_choice()">
											<option value="0" <c:if test="${MemberDTO.deferred eq '0'}">selected</c:if>>온라인결제</option>
											<option value="1" <c:if test="${MemberDTO.deferred eq '1'}">selected</c:if>>오프라인결제</option>
											<option value="2" <c:if test="${MemberDTO.deferred eq '2'}">selected</c:if>>오프라인 별도가격</option>
										</select>
									</td>
								</tr>
								<!-- 법인, 언론사 둘다 오프라인 결제 시에만 노출  -->
								<%-- <c:if test="${MemberDTO.deferred eq '2'}"> --%>
								<tr class="offline_area">
									<th>계약 기간</th>
									
									<fmt:parseDate value="${MemberDTO.contractStart}" var="contractStart" pattern="yyyy-MM-dd"/>
									<fmt:parseDate value="${MemberDTO.contractEnd}" var="contractEnd" pattern="yyyy-MM-dd"/>
									
									<td>
										<input type="text" name="contractStart" class="inp_txt datepicker" size="12" value="<fmt:formatDate value="${contractStart}" pattern="yyyy-MM-dd"/>" maxlength="10"/>
										<span class=" bar">~</span>
										<input type="text" name="contractEnd" class="inp_txt datepicker" size="12" value="<fmt:formatDate value="${contractEnd}" pattern="yyyy-MM-dd"/>" maxlength="10"/>
										
										<div class="upload-btn-wrapper">
											<a href="#" class="btn_input1">계약서 업로드</a>
											<input type="file" name="contract" accept="application/pdf, image/*" required />
										</div>
										<c:if test="${!empty MemberDTO.contractPath}">
											<a class="btn_input1" target="_blank" href="/contract.down.photo?seq=${MemberDTO.seq}&dummy=<%=com.dahami.common.util.RandomStringGenerator.next()%>" class="btn_input1">계약서 다운로드</a>
										</c:if>
									</td>
								</tr>
								<tr class="offline_area photoUsage" style="display: none;">
									<th>사진 용도</th>
									<td>
										<c:if test="${usageList != null}" >
											<c:forEach var="usageList" items="${usageList}" >
												<p>
													<input type="hidden" name="usageList_seq" value="${usageList.usageList_seq}"/>
													<input type="text" class="inp_txt" name="usage" size="43" value="${usageList.usage}" placeholder="교과서, 전단지, 뭐 기타등등 여기 직접 입력하는 칸" />
													<b class=" bar" style="margin-left:50px;">사진단가 (VAT 포함)</b>
													<input type="text" class="inp_txt" name="price" size="10" value="${usageList.price}"/>
													<span class=" bar">원</span> <a class="file_add">용도 추가</a> <a class="file_del">용도 삭제</a>
												</p>
											</c:forEach>
										</c:if>
										<c:if test="${usageList == null}" >
											<p>
												<input type="hidden" name="usageList_seq" value="" />
												<input type="text" class="inp_txt" name="usage" size="43" placeholder="교과서, 전단지, 뭐 기타등등 여기 직접 입력하는 칸" />
												<b class=" bar" style="margin-left:50px;">사진단가 (VAT 포함)</b>
												<input type="text" class="inp_txt" name="price" size="10" />
												<span class=" bar">원</span> <a class="file_add">용도 추가</a> <a class="file_del">용도 삭제</a>
											</p>
										</c:if>
									</td>									
								</tr>
								<tr class="offline_area">
									<th>세금계산서 담당자</th>
									<td><input type="text" name="taxName" class="inp_txt" size="43" value="${MemberDTO.taxName}" /></td>
								</tr>
								<tr class="offline_area">
									<th>세금계산서 담당자 전화번호</th>
									<td><select name="" class="inp_txt" name="taxPhone1" id="taxPhone1" style="width:70px;">
											<option value="02" <c:if test="${taxPhone1 eq '02'}">selected</c:if>>02</option>
											<option value="031" <c:if test="${taxPhone1 eq '031'}">selected</c:if>>031</option>
											<option value="032" <c:if test="${taxPhone1 eq '032'}">selected</c:if>>032</option>
											<option value="033" <c:if test="${taxPhone1 eq '033'}">selected</c:if>>033</option>
											<option value="041" <c:if test="${taxPhone1 eq '041'}">selected</c:if>>041</option>
											<option value="042" <c:if test="${taxPhone1 eq '042'}">selected</c:if>>042</option>
											<option value="043" <c:if test="${taxPhone1 eq '043'}">selected</c:if>>043</option>
											<option value="044" <c:if test="${taxPhone1 eq '044'}">selected</c:if>>044</option>
											<option value="051" <c:if test="${taxPhone1 eq '051'}">selected</c:if>>051</option>
											<option value="052" <c:if test="${taxPhone1 eq '052'}">selected</c:if>>052</option>
											<option value="053" <c:if test="${taxPhone1 eq '053'}">selected</c:if>>053</option>
											<option value="054" <c:if test="${taxPhone1 eq '054'}">selected</c:if>>054</option>
											<option value="055" <c:if test="${taxPhone1 eq '055'}">selected</c:if>>055</option>
											<option value="061" <c:if test="${taxPhone1 eq '061'}">selected</c:if>>061</option>
											<option value="062" <c:if test="${taxPhone1 eq '062'}">selected</c:if>>062</option>
											<option value="063" <c:if test="${taxPhone1 eq '063'}">selected</c:if>>063</option>
											<option value="064" <c:if test="${taxPhone1 eq '064'}">selected</c:if>>064</option>
											<option value="070" <c:if test="${taxPhone1 eq '070'}">selected</c:if>>070</option>
											<option value="080" <c:if test="${taxPhone1 eq '080'}">selected</c:if>>080</option>
											<option value="010" <c:if test="${taxPhone1 eq '010'}">selected</c:if>>010</option>
											<option value="011" <c:if test="${taxPhone1 eq '011'}">selected</c:if>>011</option>
											<option value="016" <c:if test="${taxPhone1 eq '016'}">selected</c:if>>016</option>
											<option value="017" <c:if test="${taxPhone1 eq '017'}">selected</c:if>>017</option>
											<option value="018" <c:if test="${taxPhone1 eq '018'}">selected</c:if>>018</option>
											<option value="019" <c:if test="${taxPhone1 eq '019'}">selected</c:if>>019</option>
										</select>
										<span class=" bar">-</span>
										<input type="text" name="taxPhone2" id="taxPhone2" size="5" value="${taxPhone2}" class="inp_txt" maxlength="4">
										<span class=" bar">-</span>
										<input type="text" name="taxPhone3" id="taxPhone3" size="5" value="${taxPhone3}" class="inp_txt" maxlength="4">
										<span class=" bar2">내선</span>
										<input type="text" name="taxExtTell" id="taxExtTell" size="5" value="${taxExtTell}"  class="inp_txt" maxlength="4" /></td>
								</tr>
								<tr class="offline_area">
									<th>세금계산서 담당자 이메일</th>
									<td><input type="text" name="taxEmail" class="inp_txt" size="50" value="${MemberDTO.taxEmail}" /></td>
								</tr>
								<!-- 여기부터 언론사만 노출 -->
								<c:if test="${MemberDTO.type eq 'M'}">
								<tr class="media_only">
									<th>정산 매체</th>
									<td><select name="admission" class="inp_txt" style="width:180px;">
											<option value="Y" <c:if test="${MemberDTO.admission eq 'Y'}">selected</c:if>>승인</option>
											<option value="N" <c:if test="${MemberDTO.admission eq 'N'}">selected</c:if>>비승인</option>
										</select><a href="#" class="btn_input1">정산정보 보기</a></td>
								</tr>
								</c:if>
							<%-- </c:if> --%>
						</tbody>
					</table>
				</div>
				<%-- </c:if> --%>
				<div class="btn_area">
					<a href="javascript:;" id="btnSubmit" class="btn_input2" onclick="member_update()">회원정보 수정</a>
					<a href="/member.manage" class="btn_input1">취소</a>
					<c:if test="${MemberDTO.withdraw == 0}">
						<a href="javascript:;" class="btn_input3 fr" onclick="drop_out()">탈퇴</a>
					</c:if>
				</div>
				<input type="hidden" name="cmd" value="U" />
				<input type="hidden" name="seq" value="${MemberDTO.seq}" />
				<input type="hidden" id="type" name="type" value="${MemberDTO.type}" />
			</form>
		</div>
	</section>
</div>
</body>
</html>
