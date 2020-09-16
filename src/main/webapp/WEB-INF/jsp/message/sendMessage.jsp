<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="쪽지보내기" />
<%@ include file="../part/head.jspf"%>
<script>
	var MessageWriteForm__submitDone = false;
	function MessageWriteForm__submit(form) {
		if (MessageWriteForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			form.title.focus();
			alert('제목을 입력해주세요.');
			return;
		}
		
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			form.body.focus();
			alert('내용을 입력해주세요.');
			return;
		}

		form.submit();
		MessageWriteForm__submitDone = true;
	}
</script>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<div class="con body-box">
	<form method="POST" class="form1" action="doSendMessage" onsubmit="MessageWriteForm__submit(this); return false;">
		<input type="hidden" name="redirectUrl" value="/usr/member/memberPage?id=${getterId}">
		<input type="hidden" name="writerId" value="${loginedMemberId}">
		<input type="hidden" name="getterId" value="${getterId}">
		<table class="table1" border="1">
			<tbody>
				<tr>
					<th>받는사람</th>
					<td>${member.nickname}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="제목을 입력해주세요." name="title" maxlength="100" />
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea placeholder="내용을 입력해주세요." name="body" maxlength="2000"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td>
						<button type="submit">작성</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>