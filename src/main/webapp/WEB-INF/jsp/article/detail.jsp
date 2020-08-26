<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 상세보기" />
<%@ include file="../part/head.jspf"%>
<div class="con">
	<table border="1" class="table1">
		<colgroup>
			<col width="100" />
		</colgroup>
		<tbody>
			<tr>
				<th>번호</th>
				<td>${article.id}</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${article.regDate}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${article.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${article.body}</td>
			</tr>
			<c:set var="fileNo" value="${String.valueOf(1)}" />
			<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
			<c:if test="${file != null}">
				<tr>
					<th>첨부파일</th>
					<td>
						<div class="img-box img-box-auto">
							<img src="/usr/file/showImg?id=${file.id}&updateDate=${file.updateDate}" alt="" />
						</div>
					</td>
				</tr>
			</c:if>
			<tr>
				<th>작성자</th>
				<td>${article.extra.writer}</td>
			</tr>
		</tbody>
	</table>
	<div>
		<a href="${article.getModifyLink(board.code)}">[수정]</a>
		<a href="${article.getDeleteLink(board.code)}" onclick="if ( confirm('정말로 탈퇴하시겠습니까?') == false ) return false;">[삭제]</a>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>