<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물리스트" />
<%@ include file="../part/head.jspf"%>

<div class="con body-box">
	<div class="pageTitle">
		<div>${member.nickname}님이 작성한 게시물입니다.</div>
		<div>총 게시물 수 : ${articlesSize}</div>
	</div>
	<table class="table2">
		<colgroup>
			<col width="100" />
			<col />
			<col width="200" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>카테고리</th>
				<th>제목</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="cnt" value="0" />
			<c:forEach items="${articleList}" var="article">
				<c:set var="cnt" value="${cnt+1}" />
				<c:if test="${((page-1) * 10) < cnt && cnt <= ((page-1)*10) + 10}">
					<tr>
						<td>${article.extra.name}</td>
						<td class="title">
							<c:if test="${article.sortId == 2}"><div class="buy">[삽니다]</div></c:if>
							<c:if test="${article.sortId == 1}"><div class="sell">[팝니다]</div></c:if>
							<c:if test="${article.boardId == 3 && article.sortId == 0}"><div class="dealComplete">[거래완료]</div></c:if>
							<a href="${article.getDetailLink(article.extra.name)}">${article.title}</a>
						</td>
						<td>${article.regDate}</td>
						<td>${article.hit}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<div class="paging-box">
		<c:forEach var="cnt" begin="1" end="${fullPage}">
			<li>
				<c:if test="${cnt==page}"><div class="current"><a href="?memberId=${member.id}&page=${cnt}" class="block">${cnt}</a></div></c:if>
				<c:if test="${cnt!=page}"><a href="?memberId=${member.id}&page=${cnt}" class="block">${cnt}</a></c:if>
			</li>
		</c:forEach>
	</div>
</div>

<%@ include file="../part/foot.jspf"%>