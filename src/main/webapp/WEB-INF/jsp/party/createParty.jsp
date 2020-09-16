<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="파티 생성하기" />
<%@ include file="../part/head.jspf"%>
<script>
	var PartyCreateForm__submitDone = false;
	function PartyCreateForm__submit(form) {
		if (PartyCreateForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			form.name.focus();
			alert('파티이름을 입력해주세요.');
			return;
		}

		form.code.value = form.code.value.trim();
		if (form.code.value.length == 0) {
			form.code.focus();
			alert('파티코드를 입력해주세요.');
			return;
		}

		form.submit();
		PartyCreateForm__submitDone = true;
	}
</script>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<div class="con body-box">
	<form method="POST" class="form1" action="doCreateParty" onsubmit="PartyCreateForm__submit(this); return false;">
		<input type="hidden" name="redirectUrl" value="/usr/party/partyPage?id=#id">
		<input type="hidden" name="id" value="${loginedMemberId}">
		<table class="table1" border="1">
			<colgroup>
				<col width=200 />
			</colgroup>
			<tbody>
				<tr>
					<th>파티명</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="파티이름을 입력해주세요." name="name" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>파티소개</th>
					<td>
						<div class="form-control-box">
							<textarea name="body" placeholder="간단한 소개글을 입력해주세요."></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>파티코드</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="파티코드를 입력해주세요." name="code" maxlength="20" />
						</div>
					</td>
				</tr>
				<tr>
					<th>파티생성</th>
					<td>
						<button type="submit" onclick="if ( confirm('정말 해당 내용으로 파티를 생성하시겠습니까?') == false ) return false;">만들기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>