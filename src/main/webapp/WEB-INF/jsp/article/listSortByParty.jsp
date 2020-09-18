<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<div class="con body-box">
	<div class="pageTitle">
		<div>${party.name} 게시물입니다.</div>
		<div>총 게시물 수 : ${articlesSize}</div>
	</div>
	<table class="table2">
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
						<td>
							<c:if test="${article.boardId == 1}">free</c:if>
							<c:if test="${article.boardId == 2}">notice</c:if>
							<c:if test="${article.boardId == 3}">deal</c:if>
						</td>
						<td class="title">
							<c:if test="${article.sortId == 2}"><div class="buy">[삽니다]</div></c:if>
							<c:if test="${article.sortId == 1}"><div class="sell">[팝니다]</div></c:if>
							<c:if test="${article.boardId == 3 && article.sortId == 0}"><div class="dealComplete">[거래완료]</div></c:if>
							<a href="${article.getDetailLink(article.extra.name)}">${article.title}</a>
						</td>
						<td>
							<a href="./../member/memberPage?id=${article.memberId}">
								<c:forEach items="${memberList}" var="member">
									<c:if test="${member.id == article.memberId}">
										${member.nickname}
									</c:if>
								</c:forEach>
							</a>
						</td>
						<td>${article.regDate}</td>
						<td>${article.hit}</td>
					</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<%@ include file="../part/foot.jspf"%>