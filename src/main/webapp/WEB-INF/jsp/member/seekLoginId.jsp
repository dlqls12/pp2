<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="아이디 찾기" />
<%@ include file="../part/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<script>
	var MemberSeekLoginIdForm__submitDone = false;
	function MemberSeekLoginIdForm__submit(form) {
		if (MemberSeekLoginIdForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			form.name.focus();
			alert('이름을 입력해주세요.');
			return;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');
			return;
		}

		form.submit();
		MemberSeekLoginIdForm__submitDone = true;
	}
</script>
<div class="con body-box">
	<form method="POST" class="form1" action="doSeekLoginId" onsubmit="MemberSeekLoginIdForm__submit(this); return false;">
		<input type="hidden" name="redirectUrl" value="usr/member/login">
		<table class="table1" border="1">
			<tbody>
				<tr>
					<th>이름</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="이름을 입력해주세요." name="name" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<div class="form-control-box">
							<input type="email" placeholder="이메일을 입력해주세요." name="email" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>찾기</th>
					<td>
						<button type="submit">완료</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%> 