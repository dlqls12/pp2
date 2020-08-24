<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 상세보기" />
<%@ include file="../part/head.jspf"%>
<div class="con">
	<ul>
		<li>게시판번호:${article.boardId}</li>
		<li>번호:${article.id}</li>
		<li>날짜:${article.regDate}</li>
		<li>제목:${article.title}</li>
		<li>내용:${article.body}</li>
		<li>작성자:${article.extra.writer}</li>
	</ul>
	<div>
		<a href="${article.getModifyLink(board.code)}">[수정하기]</a>
		<a href="${article.getDeleteLink(board.code)}">[삭제하기]</a>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>