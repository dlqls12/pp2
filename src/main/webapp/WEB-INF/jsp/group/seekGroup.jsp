<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="그룹찾기" />
<%@ include file="../part/head.jspf"%>
<script>
	var GroupSeekForm__submitDone = false;
	function GroupSeekForm__submit(form) {
		if (GroupSeekForm__submitDone) {
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
		GroupSeekForm__submitDone = true;
	}
</script>
<div class="con body-box">
	<form class="form1" action="?searchKeyword=${searchKeyword}" onsubmit="GroupSeekForm__submit(this); return false;">
		<table class="table1" border="1">
			<colgroup>
				<col width=200 />
			</colgroup>
			<tbody>
				<tr>
					<th>그룹명</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="검색어를 입력해주세요." name="searchKeyword" maxlength="30" />
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
	
	<h4>검색 결과</h4>
	<c:if test="${groupCount == 0}">
		결과를 찾을 수 없습니다.
	</c:if>
	<c:if test="${groupCount != 0}">
		<c:if test="${groupCount == null}">
			검색어를 입력해보세요.
		</c:if>
		<c:if test="${groupCount != null}">
			<table class="table1" border="1">
				<colgroup>
					<col width="100"/>
					<col width="200"/>
					<col />
					<col />
					<col width="100"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th> 
						<th>생성날짜</th>
						<th>그룹명</th>
						<th>코드</th>
						<th>회원수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${groupList}" var="group">
						<tr>
							<td>${group.id}</td>
							<td>${group.regDate}</td>
							<td><a href="groupPage?id=${group.id}">${group.name}</a></td>
							<td>${group.code}</td>
							<td>${group.memberCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</c:if>
</div>
<%@ include file="../part/foot.jspf"%>