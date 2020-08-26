<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 상세보기" />
<%@ include file="../part/head.jspf"%>
<style>
	.hide {
		display:none;
	}
</style>
<div class="con body-box">
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
	<script>
		var ReplyWriteForm__submitDone = false;
		function ReplyWriteForm__submit(form) {
			if (ReplyWriteForm__submitDone) {
				alert('처리중입니다.');
				return;
			}
			
			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				form.body.focus();
				alert('내용을 입력해주세요.');
				return;
			}
			
			ArticleWriteForm__submitDone = true;
			form.submit();
		}
	</script>
	<c:if test="${isLogined}">
		<h3>댓글 작성</h3>
		<form method="POST" class="form1" action="./../reply/doReplyWrite" onsubmit="ReplyWriteForm__submit(this); return false;">
		<input type="hidden" name="redirectUrl" value="/usr/article/${board.code}-detail?id=#id">
		<input type="hidden" name="articleId" value="${article.id}" />
		<input type="hidden" name="memberId" value="${loginedMemberId}" />
		<table class="table1" border="1">
			<tbody>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea class="reply-textarea" placeholder="내용을 입력해주세요." name="body" maxlength="2000"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td>
						<button type="submit">작성</button> 
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	</c:if>
	
	<h3>댓글목록</h3>
	<table class="table1" border="1">
		<colgroup>
			<col width="100"/>
			<col width="200"/>
			<col />
			<col width="100"/>
			<col width="100"/>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>내용</th>
				<th>작성자</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${replies}" var="reply">
				<tr>
					<td>${reply.id}</td>
					<td>${reply.regDate}</td>
					<td>${reply.body}</td>
					<td>${reply.extra.writer}</td>
					<td>
						<button type="button" onclick="ReplyModify__showModifyForm(this);">수정</button>
						<button type="button">삭제</button>
					</td>
				</tr>
				<tr class="hide">
					<td>${reply.id}</td>
					<td>${reply.regDate}</td>
					<td>${reply.body}</td>
					<td>${reply.extra.writer}</td>
					<td>
						<button type="button" onclick="ReplyModify__hideModifyForm(this);">취소</button>
						<button type="button">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<script>
	function ReplyModify__showModifyForm(el) {
		var $tr = $(el).closest('tr');
		$tr.addClass('hide');
	}
	
	function ReplyModify__hideModifyForm() {
		var $tr = $(el).closest('tr');
		$tr.removeClass('hide');
	}
</script>
<%@ include file="../part/foot.jspf"%>