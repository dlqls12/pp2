<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="파티찾기" />
<%@ include file="../part/head.jspf"%>
<script>
	var PartySeekForm__submitDone = false;
	function PartySeekForm__submit(form) {
		if (PartySeekForm__submitDone) {
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
		PartySeekForm__submitDone = true;
	}
</script>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<div class="con body-box">
	<form class="form1" action="?searchKeyword=${searchKeyword}" onsubmit="PartySeekForm__submit(this); return false;">
		<table class="table1">
			<colgroup>
				<col width=10% />
				<col />
				<col width=10%/>
			</colgroup>
			<tbody>
				<tr>
					<td style="text-align:center; font-weight:bold;">파티명</td>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="검색어를 입력해주세요." name="searchKeyword" maxlength="30" value="${param.searchKeyword}"/>
						</div>
					</td>
					<td style="text-align:center;">
						<button class="button2" type="submit"><img src="/resource/img/search.png" alt="search" /></button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	
	<h4>검색 결과</h4>
	<c:if test="${partyCount == 0}">
		결과를 찾을 수 없습니다.
	</c:if>
	<c:if test="${partyCount != 0}">
		<c:if test="${partyCount == null}">
			검색어를 입력해보세요.
		</c:if>
		<c:if test="${partyCount != null}">
			<table class="table2">
				<colgroup>
					<col width="15%"/>
					<col />
					<col width="15%"/>
					<col width="15%"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th> 
						<th>파티명</th>
						<th>생성날짜</th>
						<th>회원수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${partyList}" var="party">
						<tr>
							<td>${party.id}</td>
							<td><a href="partyPage?id=${party.id}">${party.name}</a></td>
							<td>${party.regDate}</td>
							<td>${party.memberCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</c:if>
</div>
<%@ include file="../part/foot.jspf"%>