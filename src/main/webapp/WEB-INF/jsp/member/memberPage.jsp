<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${member.nickname}님의 페이지입니다." />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<div class="con body-box">
	<table class="table1" border="1">
		<colgroup>
			<col width="15%">
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
				<th>그룹</th>
				<td><a href="./../party/partyPage?id=${member.partyId}">${party.name}</a></td>
			</tr>
		</tbody>
	</table>
	<a href="/usr/article/listSortByMember?memberId=${member.id}&page=1">[${member.nickname}님이 작성한 글 보러가기]</a>
	<c:if test="${loginedMemberId != member.id}">
		<a href="/usr/message/sendMessage?getterId=${member.id}">[쪽지보내기]</a>
	</c:if>
</div>
<%@ include file="../part/foot.jspf"%> 