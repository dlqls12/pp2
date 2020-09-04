<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${party.name} 페이지입니다." />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<div class="con body-box">
	<table class="table1" border="1">
		<colgroup>
			<col width="150">
		</colgroup>
		<tbody>
			<tr>
				<th>그룹명</th>
				<td>${party.name}</td>
			</tr>
			<tr>
				<th>소개글</th>
				<td>${party.body}</td>
			</tr>
			<tr>
				<th>회원수</th>
				<td>${party.memberCount}</td>
			</tr>	
		</tbody>
	</table>
	<c:if test="${loginedMember.partyId != party.id }">
		<a href="doJoinParty?id=${loginedMemberId}&partyId=${party.id}" onclick="if ( confirm('정말로 ${party.name}그룹에 참여하시겠습니까?') == false ) return false;">[그룹 참여하기]</a>
	</c:if>
	<c:if test="${loginedMember.partyId == party.id }">
		<c:if test="${party.memberCount == 1}">
			<a href="doSignOutParty?id=${loginedMemberId}&partyId=${party.id}" onclick="if ( confirm('회원수가 0이 되어 해당 그룹은 자동으로 삭제됩니다. 정말 탈퇴하시겠습니까?') == false ) return false;">[그룹 탈퇴하기]</a>
		</c:if>
		<c:if test="${party.memberCount > 1}">
			<a href="doSignOutParty?id=${loginedMemberId}&partyId=${party.id}" onclick="if ( confirm('정말로 ${party.name}그룹에서 나가시겠습니까?') == false ) return false;">[그룹 탈퇴하기]</a>
		</c:if>
	</c:if>
</div>
<%@ include file="../part/foot.jspf"%> 