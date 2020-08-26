<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 변경" />
<%@ include file="../part/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	var MemberModifyPwForm__submitDone = false;
	function MemberModifyPwForm__submit(form) {
		if (MemberModifyPwForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			form.loginPw.focus();
			alert('비밀번호를 입력해주세요.');
			return;
		}
		
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value.length == 0) {
			form.loginPwConfirm.focus();
			alert('비밀번호 확인을 입력해주세요.');
			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			alert('비밀번호가 일치하지 않습니다.');
			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.loginPwConfirm.value = '';
		
		form.submit();
		MemberModifyPwForm__submitDone = true;
	}
</script>
<div class="con body-box">
	<form method="POST" action="doModifyPw" onsubmit="MemberModifyPwForm__submit(this); return false;">
		<input type="hidden" name="redirectUrl" value="/usr/member/modifyMemberInfo">
		<input type="hidden" name="loginPwReal">
		<input type="hidden" name="id" value="${loginedMember.id}">
		<table>
			<tbody>
				<tr>
					<th>로그인 비번</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="새로운 비밀번호를 입력해주세요." name="loginPw" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>로그인 비번확인</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="새로운 비밀번호를 입력해주세요." name="loginPwConfirm" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>수정하기</th>
					<td>
						<button type="submit">완료</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%> 