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
	</ul>
</div>
<%@ include file="../part/foot.jspf"%>