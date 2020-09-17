<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>
<div class="con body-box">
	<form class="form1" action="listSortByTag" onsubmit="TagSeekForm__submit(this); return false;">
		<input type="hidden" name="sortId" value="0" />
		<table class="table1" border="1">
			<colgroup>
				<col width=200 />
			</colgroup>
			<tbody>
				<tr>
					<th>검색</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="검색어를 입력해주세요." name="searchKeyword" maxlength="30" value="${param.searchTag}"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>찾기</th>
					<td>
						<button type="submit">찾기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
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
				<col />
				<col width="150"/>
				<col width="200"/>
				<col width="100"/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${noticeArticleList}" var="article">
					<tr>
						<td>${article.id}</td>
						<td><a href="${article.getDetailLink(board.code)}">${article.title}</a></td>
						<td><a href="./../member/memberPage?id=${article.memberId}">${article.extra.writer}</a></td>
						<td>${article.regDate}</td>
						<td>${article.hit}</td>
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
				<col />
				<col width="150"/>
				<col width="200"/>
				<col width="100"/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${freeArticleList}" var="article">
					<tr>
						<td>${article.id}</td>
						<td><a href="${article.getDetailLink(board.code)}">${article.title}</a></td>
						<td><a href="./../member/memberPage?id=${article.memberId}">${article.extra.writer}</a></td>
						<td>${article.regDate}</td>
						<td>${article.hit}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>