<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name} 게시판 글 작성" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastUiEditor.jspf"%>
<script>
	var ArticleWriteForm__submitDone = false;
	function ArticleWriteForm__submit(form) {
		if (ArticleWriteForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.sortId.value = form.sortId.value.trim();
		if (form.sortId.value == "none") {
			form.sortId.focus();
			alert('카테고리를 입력해주세요.');
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
		
		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 //50MB

		if (form.file__article__0__common__attachment__1.value) {
			if (form.file__article__0__common__attachment__1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		var startUploadFiles = function(onSuccess) {
			var needToUpload = form.file__article__0__common__attachment__1.value.length > 0;

			if (needToUpload == false) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

			$.ajax({
				url : './../file/doUploadAjax',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : onSuccess
			});
		}

		ArticleWriteForm__submitDone = true;
		startUploadFiles(function(data) {
			var fileIdsStr = '';

			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}

			form.fileIdsStr.value = fileIdsStr;
			form.file__article__0__common__attachment__1.value = '';

			form.submit();
		});
	}
</script>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<div class="con body-box">
	<form method="POST" class="form1" action="${board.code}-doWrite" onsubmit="ArticleWriteForm__submit(this); return false;">
		<input type="hidden" name="fileIdsStr" />
		<input type="hidden" name="redirectUrl" value="/usr/article/${board.code}-detail?id=#id&page=1">
		<c:if test="${board.id != 3}">
			<input type="hidden" name="sortId" value="0" />
		</c:if>
		<table class="table1" border="1">
			<colgroup>
				<col width="200"/>
			</colgroup>
			<tbody>
				<c:if test="${board.id == 3}">
				<tr>
					<th>카테고리 선택</th>
					<td>
						<div class="form-control-box">
							<select class="select" name="sortId">
							    <option value="none">=== select ===</option>
							    <option value="1">sell</option>
							    <option value="2">buy</option>
							</select>
						</div>
					</td>
				</tr>
				</c:if>
				<tr>
					<th>제목</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="제목을 입력해주세요." name="title" maxlength="100" />
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea placeholder="내용을 입력해주세요." name="body" maxlength="2000"></textarea>
						</div>
					</td> 
				</tr>
				<tr>
					<th>첨부 이미지</th>
					<td>
						<div class="form-control-box">
							<input type="file" accept="image/gif,image/jpeg,image/png" name="file__article__0__common__attachment__1">
						</div>
					</td>
				</tr>
				<c:if test="${board.id == 3}">
				<tr>
					<th>태그 추가하기</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="태그를 입력해주세요. ex) #강아지" name="tag" maxlength="100" />
						</div>
					</td>
				</tr>
				</c:if>
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