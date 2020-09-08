<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 태그검색" />
<%@ include file="../part/head.jspf"%>
<script>
	var TagSeekForm__submitDone = false;
	function TagSeekForm__submit(form) {
		if (TagSeekForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		form.searchKeyword.value = form.searchKeyword.value.trim();
		if (form.searchKeyword.value.length == 0) {
			form.searchKeyword.focus();
			alert('검색어를 입력해주세요.');
			return;
		}

		form.submit();
		TagSeekForm__submitDone = true;
	}
</script>
<div class="con body-box">
	<form class="form1" action="listSortByTag" onsubmit="TagSeekForm__submit(this); return false;">
		<table class="table1" border="1">
			<input type="hidden" name="sortId" value="0" />
			<colgroup>
				<col width=200 />
			</colgroup>
			<tbody>
				<tr>
					<th>태그</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="검색어를 입력해주세요." name="searchTag" maxlength="30" value="${param.searchTag}"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>찾기</th>
					<td>
						<button type="submit">찾기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>