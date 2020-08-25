<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 수정" />
<%@ include file="../part/head.jspf"%>
<script>
	var ArticleModifyForm__submitDone = false;
	function ArticleModifyForm__submit(form) {
		if (ArticleModifyForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			form.title.focus();
			alert('제목을 입력해주세요.');
			return;
		}
		
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			form.body.focus();
			alert('내용을 입력해주세요.');
			return;
		}
	
		ArticleModifyForm__submitDone = true;
		form.submit();
	
	}
</script>
<div class="con">
	<form method="POST" class="form1" action="${board.code}-doModify" onsubmit="ArticleModifyForm__submit(this); return false;">
		<input type="hidden" name="redirectUrl" value="/usr/article/${board.code}-detail?id=${article.id}">
		<input type="hidden" name="id" value="${article.id}">
		<input type="hidden" name="fileIdsStr" />
		<table class="write-table" border="1">
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="제목을 입력해주세요." value="${article.title}" name="title" maxlength="100" />
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea placeholder="내용을 입력해주세요." name="body" maxlength="2000">${article.body}</textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<div class="form-control-box">
							<c:set var="fileNo" value="${String.valueOf(1)}" />
							<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
							<c:if test="${file != null}">					
								<img src="/usr/file/showImg?id=${file.id}&updateDate=${file.updateDate}" alt="" />
							</c:if>
							<input type="file" accept="image/gif,image/jpeg,image/png" name="file__article__${article.id}__common__attachment__1">
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부파일 삭제</th>
					<td>
						<div class="form-control-box">
							<label><input type="checkbox" name="deleteFile__article__${article.id}__common__attachment__1" value="Y" /> 삭제 </label>
						</div>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td>
						<button type="submit">작성</button> 
						<a href="${listUrl}">리스트</a> 
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>