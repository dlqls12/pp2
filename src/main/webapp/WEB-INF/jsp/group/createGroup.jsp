<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="그룹만들기" />
<%@ include file="../part/head.jspf"%>
<script>
	var GroupCreateForm__submitDone = false;
	function GroupCreateForm__submit(form) {
		if (GroupCreateForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			form.name.focus();
			alert('그룹이름을 입력해주세요.');
			return;
		}

		form.submit();
		GroupCreateForm__submitDone = true;
	}
</script>
<div class="con body-box">
	<form method="POST" class="form1" action="doCreateGroup" onsubmit="GroupCreateForm__submit(this); return false;">
		<input type="hidden" name="redirectUrl" value="/usr/group/groupPage?id=#id">
		<input type="hidden" name="id" value="${loginedMemberId}">
		<table class="table1" border="1">
			<colgroup>
				<col width=200 />
			</colgroup>
			<tbody>
				<tr>
					<th>그룹명</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="그룹이름을 입력해주세요." name="name" maxlength="30" />
						</div>
					</td>
				</tr>
				<tr>
					<th>그룹소개</th>
					<td>
						<div class="form-control-box">
							<textarea name="body" placeholder="간단한 소개글을 입력해주세요."></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>그룹생성</th>
					<td>
						<button type="submit">만들기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>