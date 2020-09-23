<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	var MemberJoinForm__submitDone = false;
	function MemberJoinForm__submit(form) {
		if (MemberJoinForm__submitDone) {
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
		if (form.loginId.value.length < 4) {
			form.loginId.focus();
			alert('로그인 아이디 4자 이상 입력해주세요.');
			return;
		}
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 입력해주세요.');
			return;
		}
		if (form.loginPw.value.length < 5) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 5자 이상 입력해주세요.');
			return;
		}
		if (form.loginPwConfirm.value.length == 0) {
			form.loginPwConfirm.focus();
			alert('로그인 비밀번호 확인을 입력해주세요.');
			return;
		}
		if (form.loginPw.value != form.loginPwConfirm.value) {
			form.loginPwConfirm.focus();
			alert('로그인 비밀번호 확인이 일치하지 않습니다.');
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

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.loginPwConfirm.value = '';
		
		form.submit();
		MemberJoinForm__submitDone = true;
	}
		
	function MemberJoinForm__checkLoginIdDup(input) {
		var form = input.form;

		form.loginId.value = form.loginId.value.trim();

		if (form.loginId.value.length == 0) {
			$(form.loginId).next().empty();
			return;
		}
		
		$.get('getLoginIdDup', {
				loginId: form.loginId.value
			},
			function(data) {
				var $message = $(form.loginId).next();
				if (data.resultCode.substr(0, 2) == 'S-') {
					$message.empty().append('<div style="color:green;">' + data.msg + '</div>');
				} 
				else {
					$message.empty().append('<div style="color:red;">' + data.msg + '</div>');
				}
			}, 'json' );
	}

	function MemberJoinForm__sendEmailDup(input) {
		$('html').addClass('auth-mode-actived');
		var form = input.form;

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			$(form.email).next().empty();
			return;
		}
		
		$.get('getEmailDup', {
				email: form.email.value
			},
			function(data) {
				var $message = $(form.email).next();
				if (data.resultCode.substr(0, 2) == 'S-') {
					alert(data.msg);
				}
				else {
					alert(data.msg);
				}
			}, 'json' );
	}

	function MemberJoinForm__emailAuth(input) {
		var form = input.form;

		form.authCode.value = form.authCode.value.trim();
		form.email.value = form.email.value.trim();

		if (form.authCode.value.length == 0) {
			$(form.authCode).next().empty();
			return;
		}
		
		$.get('checkAuthCode', {
				authCode: form.authCode.value,
				email: form.email.value
			},
			function(data) {
				var $message = $(form.authCode).next();
				if (data.resultCode.substr(0, 2) == 'S-') {
					$('html').addClass('hideSendMailButton');
					$('html').removeClass('auth-mode-actived');
					alert(data.msg);
				} 
				else {
					alert(data.msg);
				}
			}, 'json' );
	}	

	MemberJoinForm__checkLoginIdDup = _.debounce(MemberJoinForm__checkLoginIdDup, 2000);
</script>
<style>
.authComplete {
	display:none;
}

.hideSendMailButton .authComplete {
	display:block;
	color:green;
}

.auth-mode-on {
	display:none;
}

.auth-mode-actived .auth-mode-on {
	display:block;
}

.hideSendMailButton .sendMailButton {
	display:none;
}

.sendMailButton > button {
	padding:6.5px;
}

.auth-mode-on > input {
	width: 100%;
	display: block;
	box-sizing: border-box;
	padding: 10px;
}

.auth-mode-on > button {
	padding:6.5px;
}
</style>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<div class="con body-box">
	<form method="POST" class="form1 form2" action="doJoin" onsubmit="MemberJoinForm__submit(this); return false;">
		<input type="hidden" name="redirectUrl" value="/usr/member/login">
		<input type="hidden" name="loginPwReal">
		<table class="table1" border="1">
			<colgroup>
				<col width="200">
			</colgroup>
			<tbody>
				<tr>
					<th>* 로그인 아이디</th>
					<td>
						<div class="form-control-box">
							<input onkeyup="MemberJoinForm__checkLoginIdDup(this);" type="text" placeholder="로그인 아이디 입력해주세요." name="loginId" maxlength="30" />
							<div class="message"></div>
						</div>
					</td>
				</tr>
				<tr>
					<th>* 로그인 비번</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="로그인 비밀번호를 입력해주세요." name="loginPw" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>* 로그인 비번 확인</th>
					<td>
						<div class="form-control-box">
							<input type="password" placeholder="로그인 비밀번호 확인을 입력해주세요." name="loginPwConfirm" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>* 이름</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="이름을 입력해주세요." name="name" maxlength="20" />
						</div>
					</td>
				</tr>
				<tr>
					<th>* 닉네임</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="닉네임을 입력해주세요." name="nickname" maxlength="20" />
						</div>
					</td>
				</tr>
				<tr>
					<th>* 휴대폰</th>
					<td>
						<div class="form-control-box">
							<input type="tel" placeholder="휴대전화번호를 입력해주세요." name="phoneNo" maxlength="12" />
						</div>
					</td>
				</tr>
				<tr>
					<th>* 이메일</th>
					<td>
						<div class="form-control-box">
							<input type="email" placeholder="이메일 입력해주세요." name="email" maxlength="50" />
							<div class="message"></div>
							<div class="sendMailButton">
								<button type="button" onclick="MemberJoinForm__sendEmailDup(this);">인증메일 보내기</button>
							</div>
							<div class="auth-mode-on">
								<input type="text" name="authCode" placeholder="인증코드" />
								<button type="button" onclick="MemberJoinForm__emailAuth(this);">인증</button>
							</div>
							<div class="authComplete">인증완료</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-box">
			<button type="submit">가입</button>
		</div>
	</form>
</div>
<%@ include file="../part/foot.jspf"%> 