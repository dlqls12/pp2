<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="쪽지 상세보기" />
<%@ include file="../part/head.jspf"%>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<div class="con body-box">
	<table border="1" class="table1">
		<colgroup>
			<col width="100" />
		</colgroup>
		<tbody>
			<tr>
				<th>번호</th>
				<td>${message.id}</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${message.regDate}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${message.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><pre>${message.body}</pre></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<a href="/usr/member/memberPage?id=${message.writerId}">${message.extra.writer}</a>
				</td>
			</tr>
		</tbody>
	</table>
	<div>
		<a href="/usr/message/sendMessage?getterId=${message.writerId}">[답장]</a>
		<a href="/usr/message/deleteMessage?id=${message.id}" onclick="if ( confirm('정말로 삭제하시겠습니까?') == false ) return false;">[삭제]</a>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>