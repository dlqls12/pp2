<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	var MemberModifyInfoForm__submitDone = false;
	function MemberModifyInfoForm__submit(form) {
		if (MemberModifyInfoForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			form.name.focus();
			alert('이름을 입력해주세요.');
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			form.nickname.focus();
			alert('활동명을 입력해주세요.');
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');
			return;
		}
		form.phoneNo.value = form.phoneNo.value.trim();
		form.phoneNo.value = form.phoneNo.value.replaceAll('-', '');
		form.phoneNo.value = form.phoneNo.value.replaceAll(' ', '');
		if (form.phoneNo.value.length == 0) {
			form.phoneNo.focus();
			alert('휴대전화번호를 입력해주세요.');
			return;
		}
		if (form.phoneNo.value.length < 8) {
			form.phoneNo.focus();
			alert('휴대폰번호를 8자 이상 입력해주세요.');
			return;
		}

		form.submit();
		MemberModifyInfoForm__submitDone = true;
	}

	function MemberModifyInfo__showModifyForm(el) {
		$('html').addClass('modify-mode-actived');
	}

	function MemberModifyInfo__hideModifyForm() {
		$('html').removeClass('modify-mode-actived');
	}
</script>

<style>
.modify-mode-on {
	display:none;
}

.modify-mode-actived .modify-mode-off {
	display:none;
}

.modify-mode-actived .modify-mode-on {
	display:flex;
}
</style>
<div class="con body-box">	
	<div class="modify-mode-off">
		<table>
			<colgroup>
				<col width="100">
			</colgroup>
			<tbody>
				<tr>
					<th>이름</th>
					<td>${loginedMember.name}</td>
				</tr>
				<tr>
					<th>활동명</th>
					<td>${loginedMember.nickname}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${loginedMember.email}</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td>${loginedMember.phoneNo}</td>
				</tr>
				<tr>
					<th>회원 정보 수정</th>
					<td>
						<button type="button" onclick="MemberModifyInfo__showModifyForm(this);">회원 정보 수정</button>
						<a href="/usr/member/modifyPw">[비밀번호변경하기]</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="modify-mode-on">
		<form method="POST" action="doModifyMemberInfo" onsubmit="MemberModifyInfoForm__submit(this); return false;">
			<input type="hidden" name="redirectUrl" value="/usr/member/modifyMemberInfo">
			<input type="hidden" name="id" value="${loginedMember.id}">
			<table>
				<colgroup>
					<col width="100">
				</colgroup>
				<tbody>
					<tr>
						<th>이름</th>
						<td>
							<div class="form-control-box">
								<input type="text" value="${loginedMember.name}" name="name" maxlength="20" />
							</div>
						</td>
					</tr>
					<tr>
						<th>활동명</th>
						<td>
							<div class="form-control-box">
								<input type="text" value="${loginedMember.nickname}" name="nickname" maxlength="20" />
							</div>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<div class="form-control-box">
								<input type="email" value="${loginedMember.email}" name="email" maxlength="50" />
							</div>
						</td>
					</tr>
					<tr>
						<th>휴대폰</th>
						<td>
							<div class="form-control-box">
								<input type="tel" value="${loginedMember.phoneNo}" name="phoneNo" maxlength="12" />
							</div>
						</td>
					</tr>
					<tr>
						<th>회원 정보 수정</th>
						<td>
							<button type="submit">완료</button>
							<button type="button" onclick="MemberModifyInfo__hideModifyForm();">취소</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div>
		<h3>쪽지함</h3>
		<table class="table1" border="1">
			<thead>
				<tr>
					<th>번호</th>
					<th>날짜</th>
					<th>제목</th>
					<th>보낸사람</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${messageList}" var="message">
					<tr>
						<td>${message.id}</td>
						<td>${message.regDate}</td>
						<td>${message.title}</td>
						<td><a href="memberPage?id=${message.writerId}">[${message.extra.writer}]</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<%@ include file="../part/foot.jspf"%> 