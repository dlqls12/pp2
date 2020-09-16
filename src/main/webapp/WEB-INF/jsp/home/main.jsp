<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>
<div class="con body-box">
	<div class="party-menu">
		<section class="party-menu-item"><a href="./../party/createParty">[파티 만들기]</a></section>
		<section class="party-menu-item"><a href="./../party/seekParty">[파티 찾기]</a></section>
		<section class="party-menu-item"><a href="./../article/seekTag">[게시물 태그 검색]</a></section>
	</div>
	<div class="main-notice">
		<a href="/usr/article/notice-list?page=1&sortId=0">&lt공지사항&gt</a>
		<table class="table1" border="1">
			<colgroup>
				<col width="100"/>
				<col width="200"/>
				<col />
				<col width="200"/>
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
				<c:forEach items="${noticeArticleList}" var="article">
					<tr>
						<td>${article.id}</td>
						<td>${article.regDate}</td>
						<td><a href="${article.getDetailLink(board.code)}">${article.title}</a></td>
						<td><a href="./../member/memberPage?id=${article.memberId}">${article.extra.writer}</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="main-free">
		<a href="/usr/article/free-list?page=1&sortId=0">&lt자유게시판&gt</a>
		<table class="table1" border="1">
			<colgroup>
				<col width="100"/>
				<col width="200"/>
				<col />
				<col width="200"/>
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
				<c:forEach items="${freeArticleList}" var="article">
					<tr>
						<td>${article.id}</td>
						<td>${article.regDate}</td>
						<td><a href="${article.getDetailLink(board.code)}">${article.title}</a></td>
						<td><a href="./../member/memberPage?id=${article.memberId}">${article.extra.writer}</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>