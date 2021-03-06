<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="로그인" />
<%@ include file="../part/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	var MemberLoginForm__submitDone = false;
	function MemberLoginForm__submit(form) {
		if (MemberLoginForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		form.loginId.value = form.loginId.value.replaceAll('-', '');
		form.loginId.value = form.loginId.value.replaceAll('_', '');
		form.loginId.value = form.loginId.value.replaceAll(' ', '');
		if (form.loginId.value.length == 0) {
			form.loginId.focus();
			alert('로그인 아이디를 입력해주세요.');
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 입력해주세요.');
			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.loginPwConfirm.value = '';
		
		form.submit();
		MemberLoginForm__submitDone = true;
	}
</script>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<div class="con body-box">
	<form method="POST" class="form1" action="doLogin" onsubmit="MemberLoginForm__submit(this); return false;">
		<input type="hidden" name="redirectUrl" value="/usr/home/main">
		<input type="hidden" name="loginPwReal">
		<table class="table1" border="1">
			<colgroup>
				<col width=15% />
			</colgroup>
			<tbody>
				<tr>
					<th>로그인 아이디</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="로그인 아이디 입력해주세요." name="loginId" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>로그인 비밀번호</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="로그인 비밀번호를 입력해주세요." name="loginPw" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>로그인</th>
					<td>
						<button type="submit">로그인</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div><a href="/usr/member/seekLoginId">[아이디찾기]</a><a href="/usr/member/seekLoginPw">[비밀번호찾기]</a></div>
</div>
<%@ include file="../part/foot.jspf"%> 