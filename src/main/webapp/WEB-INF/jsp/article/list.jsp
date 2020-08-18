<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 리스트" />
<%@ include file="../part/head.jspf" %>
<h1>${pageTitle}</h1>
<table>
	<colgroup>
		<col width="200" />
		<col width="200" />
		<col width="200" />
	</colgroup>
	<thead>
		<tr>
			<th>번호</th>
			<th>날짜</th>
			<th>제목</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${articles}" var="article">
			<tr>
				<td>${article.id}</td>
				<td>${article.regDate}</td>
				<td><a href="">${article.title}</a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<%@ include file="../part/foot.jspf" %>