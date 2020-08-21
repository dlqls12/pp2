<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../part/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	var MemberCheckPwForm__submitDone = false;
	function MemberCheckPwForm__submit(form) {
		if (MemberCheckPwForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			form.loginPw.focus();
			alert('비밀번호를 입력해주세요.');
			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		
		form.submit();
		MemberCheckPwForm__submitDone = true;
	}
</script>
<div class="con">
	<form method="POST" action="doCheckPw" onsubmit="MemberCheckPwForm__submit(this); return false;">
		<!-- <input type="hidden" name="redirectUrl" value="/usr/member/modifyMemberInfo?uuid=#uuid"> -->
		<input type="hidden" name="redirectUrl" value="/usr/member/modifyMemberInfo">
		<input type="hidden" name="loginPwReal">
		<input type="hidden" name="id" value="${loginedMember.id}">
		<table>
			<tbody>
				<tr>
					<th>로그인 비번</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="비밀번호를 입력해주세요." name="loginPw" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>마이페이지</th>
					<td>
						<button type="submit">이동</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%> 