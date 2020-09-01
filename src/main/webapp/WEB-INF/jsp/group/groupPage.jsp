<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${group.name} 페이지입니다." />
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
				<td>${group.name}</td>
			</tr>
			<tr>
				<th>소개글</th>
				<td>${group.body}</td>
			</tr>
			<tr>
				<th>회원수</th>
				<td>${groupSize}</td>
			</tr>	
		</tbody>
	</table>
	<a href="doJoinGroup?id=${loginedMemberId}&groupId=${group.id}" onclick="if ( confirm('정말로 그룹에 참여하시겠습니까?') == false ) return false;">[그룹 참여하기]</a>
</div>
<%@ include file="../part/foot.jspf"%> 