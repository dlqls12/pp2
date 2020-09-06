<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name} 게시판" />
<%@ include file="../part/head.jspf"%>

<div class="con body-box">
	<c:if test="${board.id != 2}">
		<h4><a href="${board.code}-write">[글 쓰러 가기]</a></h4>
	</c:if>
	<c:if test="${board.id == 2 && loginedMemberId == 1}">
		<h4><a href="${board.code}-write">[글 쓰러 가기]</a></h4>
	</c:if>
	<c:if test="${fullPage==0}">
		게시물이 존재하지 않습니다.
		<h4><button type="button" onclick="history.back();">돌아가기</button></h4>
	</c:if>
	<c:if test="${fullPage!=0}">
		<c:if test="${board.id > 2}">
			<select onchange="location.href = '?page=1&sortId=' + this.value;">
			    <option value="none">=== select ===</option>
			    <option value="0">all</option>
			    <option value="1">sell</option>
			    <option value="2">buy</option>
			</select>
		</c:if>
		<table class="table1" border="1">
			<colgroup>
				<col width="100"/>
				<col width="200"/>
				<col />
				<col width="100"/>
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
				<c:forEach items="${articles}" var="article">
					<c:if test="${board.id == 3}">
						<c:if test="${sortId == article.sortId}">
							<tr>
								<td>${article.id}</td>
								<td>${article.regDate}</td>
								<td><a href="${article.getDetailLink(board.code)}">${article.title}</a></td>
								<td><a href="./../member/memberPage?id=${article.memberId}">${article.extra.writer}</a></td>
							</tr>
						</c:if>
					</c:if>
					<c:if test="${board.id != 3 || sortId == 0}">
						<tr>
							<td>${article.id}</td>
							<td>${article.regDate}</td>
							<td><a href="${article.getDetailLink(board.code)}">${article.title}</a></td>
							<td><a href="./../member/memberPage?id=${article.memberId}">${article.extra.writer}</a></td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<div class="paging-box">
			<c:forEach var="cnt" begin="1" end="${fullPage}">
				<li class="${cnt==page ? "current" : "" }">
					<a href="?page=${cnt}&sortId=${sortId}" class="block">${cnt}</a>
				</li>
			</c:forEach>
		</div>
		<div class="search-box">
			<form class="form2" action="${board.code}-list">
				<div class="search-box-el">
					<input type="hidden" name="page" value="1" />
					<c:if test="${board.id == 3}">
						<input type="hidden" name="sortId" value="${param.sortId}" />
					</c:if>
					<input type="text" name="searchKeyword" value="${param.searchKeyword}" />
					<button type="submit">검색</button>
				</div>
			</form>
		</div>
	</c:if>
</div>

<%@ include file="../part/foot.jspf"%>