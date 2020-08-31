<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${member.nickname}님의 페이지입니다." />
<%@ include file="../part/head.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<div class="con body-box">
	<table class="table1" border="1">
		<colgroup>
			<col width="150">
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
				<th>휴대폰</th>
				<td>${member.phoneNo}</td>
			</tr>	
		</tbody>
	</table>
	<a href="/usr/message/sendMessage?getterId=${member.id}">[쪽지보내기]</a>
</div>
<%@ include file="../part/foot.jspf"%> 