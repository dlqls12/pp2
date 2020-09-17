<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<div class="con body-box">
	<div class="pageTitle">
		<div>${memberNickname}님이 작성한 게시물입니다.</div>
		<div>총 게시물 수 : ${articlesSize}</div>
	</div>
	<table class="table1" border="1">
		<colgroup>
			<col width="100" />
			<col />
			<col width="150" />
			<col width="200" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>카테고리</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="code" value="deal"></c:set>
			<c:forEach items="${articleList}" var="article">
					<tr>
						<td>${article.extra.name}</td>
						<td>
							<a href="${article.getDetailLink(article.extra.name)}">${article.title}</a>
						</td>
						<td>${memberNickname}</td>
						<td>${article.regDate}</td>
						<td>${article.hit}</td>
					</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<%@ include file="../part/foot.jspf"%>