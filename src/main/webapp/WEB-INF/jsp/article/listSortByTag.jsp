<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="거래 게시판" />
<%@ include file="../part/head.jspf"%>

<div class="con body-box">
	<select onchange="location.href = '?sortId=' + this.value + '&searchTag=${searchTag}';">
		<option value="none">=== select ===</option>
		<option value="0">all</option>
		<option value="1">sell</option>
		<option value="2">buy</option>
	</select>
	<table class="table1" border="1">
		<colgroup>
			<col width="100" />
			<col width="200" />
			<col />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>제목</th>
				<th>작성자</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="code" value="deal"></c:set>
			<c:forEach items="${articleList}" var="article">
				<c:if test="${sortId == 0 || article.sortId == sortId}">
					<tr>
						<td>${article.id}</td>
						<td>${article.regDate}</td>
						<td><a href="deal-detail?id=${article.id}&page=1">${article.title}</a></td>
						<td>${article.extra.writer}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>

<%@ include file="../part/foot.jspf"%>