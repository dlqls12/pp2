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
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<div class="con body-box">	
	<div class="modify-mode-off">
		<table class="table3" border="1">
			<colgroup>
				<col width="15%">
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
				<c:if test="${partyName != null}">
					<tr>
						<th>파티</th>
						<td><a href="./../party/partyPage?id=${loginedMember.partyId}">${partyName}</a></td>
					</tr>
				</c:if>
				<tr>
					<th>회원 정보 수정</th>
					<td>
						<button type="button" onclick="MemberModifyInfo__showModifyForm(this);">회원 정보 수정</button>
						<a href="/usr/member/modifyPw?uuid=${uuid}">[비밀번호변경하기]</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="modify-mode-on">
		<form method="POST" class="form1" action="doModifyMemberInfo" onsubmit="MemberModifyInfoForm__submit(this); return false;">
			<input type="hidden" name="redirectUrl" value="/usr/member/modifyMemberInfo?page=1&uuid=${uuid}">
			<input type="hidden" name="id" value="${loginedMember.id}">
			<table class="table1" border="1">
				<colgroup>
					<col width="15%">
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
	<div><a href="../article/listSortByMember?memberId=${loginedMemberId}&page=1">내가 쓴 글 보기</a></div>
	<div>
		<h3>쪽지함</h3>
		<c:if test="${fullPage == 0}">
			<div>쪽지가 없습니다. ㅠㅠ</div>
		</c:if>
		<c:if test="${fullPage != 0}">
			<table class="table2 reply-list" border="1">
				<colgroup>
					<col width="15%" />
					<col />
					<col width="15%" />
					<col width="15%" />
					<col width="15%" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${messageList}" var="message">
						<tr>
							<td>${message.id}</td>
							<td>
								<c:if test="${message.readStatus == false}"><div class="noRead">[안읽음]</div></c:if>
								<a href="./../message/detailMessage?id=${message.id}&uuid=${uuid}">${message.title}</a>
							</td>
							<td><a href="memberPage?id=${message.writerId}">${message.extra.writer}</a></td>
							<td>${message.regDate}</td>
							<td>
								<a href="./../message/deleteMessage?id=${message.id}" onclick="if ( confirm('정말로 삭제하시겠습니까?') == false ) return false;">삭제</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="paging-box2">
				<c:forEach var="cnt" begin="1" end="${fullPage}">
					<li class="${cnt == page ? "current" : "" }">
						<a href="?page=${cnt}&uuid=${uuid}" class="block">${cnt}</a>
					</li>
				</c:forEach>
			</div>
		</c:if>
	</div>
</div>
<%@ include file="../part/foot.jspf"%> 