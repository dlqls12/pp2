<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name} 게시판" />
<%@ include file="../part/head.jspf"%>
<div class="con body-box">
	<c:if test="${fullPage==0}">
		게시물이 존재하지 않습니다.
		<h4><a href="${board.code}-write">[글 쓰러 가기]</a></h4>
		<h4><button type="button" onclick="history.back();">돌아가기</button></h4>
	</c:if>
	<c:if test="${fullPage!=0}">
		<table class="table1" border="1">
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
					<tr>
						<td>${article.id}</td>
						<td>${article.regDate}</td>
						<td><a href="${article.getDetailLink(board.code)}">${article.title}</a></td>
						<td>
							<c:if test="${article.memberId != loginedMemberId }">
								<a href="./../member/memberPage?id=${article.memberId}">${article.extra.writer}</a>
							</c:if>
							<c:if test="${article.memberId == loginedMemberId }">
								${article.extra.writer}
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="paging-box">
			<c:forEach var="cnt" begin="1" end="${fullPage}">
				<li class="${cnt==page ? "current" : "" }">
					<a href="?page=${cnt}" class="block">${cnt}</a>
				</li>
			</c:forEach>
		</div>
		
		<form action="${board.code}-list?page=1&searchKeyword=${searchKeyword}">
				<input type="hidden" name="page" value="1" />
				<input type="text" name="searchKeyword" value="${param.searchKeyword}" />
				<button type="submit">검색</button>	
		</form>
	</c:if>
</div>
<%@ include file="../part/foot.jspf"%>