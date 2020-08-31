<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${member.nickname}님의 페이지입니다." />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	function MessageWrite__showWriteForm(el) {
		$('html').addClass('write-mode-actived');
	}

	function MessageWrite__hideWriteForm() {
		$('html').removeClass('write-mode-actived');
	}
	
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

<style>
.write-mode-on {
	display:none;
}

.write-mode-actived .write-mode-off {
	display:none;
}

.write-mode-actived .write-mode-on {
	display:inline-block;
}
</style>
<div class="con body-box">	
	<div>
		<table>
			<colgroup>
				<col width="100">
			</colgroup>
			<tbody>
				<tr>
					<th>닉네임</th>
					<td>${member.nickname}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${member.email}</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td>${member.phoneNo}</td>
				</tr>
				<tr class="write-mode-off">
					<th>쪽지보내기</th>
					<td>
						<button type="button" onclick="MessageWrite__showWriteForm(this);">메세지</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="write-mode-on">
		<h3>쪽지보내기</h3>
		<form method="POST" action="./../message/doSendMessage" class="form1" onsubmit="MessageWriteForm__submit(this); return false;">
			<input type="hidden" name="redirectUrl" value="/usr/member/memberPage?id=${member.id}" />
			<input type="hidden" name="writerId" value="${loginedMemberId}" />
			<input type="hidden" name="getterId" value="${member.id}" />
			<table class="table1" border="1">
				<tbody>
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
								<textarea class="reply-textarea" placeholder="내용을 입력해주세요." name="body" maxlength="2000"></textarea>
							</div>
						</td>
					</tr>
					<tr>
						<th>작성</th>
						<td>
							<button type="submit">작성</button>
							<button type="button" onclick="MessageWrite__hideWriteForm();">취소</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</div>
<%@ include file="../part/foot.jspf"%> 