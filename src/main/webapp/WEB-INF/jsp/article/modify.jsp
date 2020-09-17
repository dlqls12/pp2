<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 수정" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastUiEditor.jspf"%>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
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

		var fileInput1 = form["file__article__" + ${article.id} + "__common__attachment__1"];

		var deleteFileInput1 = form["deleteFile__article__" + ${article.id} + "__common__attachment__1"];

		if (fileInput1 && deleteFileInput1) {
			if (deleteFileInput1.checked) {
				fileInput1.value = '';
			}
		}

		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 //50MB

		if (fileInput1 && fileInput1.value) {
			if (fileInput1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}
		
		var startUploadFiles = function(onSuccess) {
			var needToUpload = false;

			if (!needToUpload) {
				needToUpload = fileInput1 && fileInput1.value.length > 0;
			}

			if (!needToUpload) {
				needToUpload = deleteFileInput1 && deleteFileInput1.checked;
			}

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

		ArticleModifyForm__submitDone = true;
		startUploadFiles(function(data) {
			var fileIdsStr = '';

			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}

			form.fileIdsStr.value = fileIdsStr;

			if (fileInput1) {
				fileInput1.value = '';
			}

			form.submit();
		});
	}
</script>
<div class="con body-box">
	<form method="POST" class="form1" action="${board.code}-doModify" onsubmit="ArticleModifyForm__submit(this); return false;">
		<input type="hidden" name="fileIdsStr" />
		<input type="hidden" name="redirectUrl" value="/usr/article/${board.code}-detail?id=${article.id}&page=1">
		<input type="hidden" name="id" value="${article.id}">
		<table class="table1" border="1">
			<colgroup>
				<col width="200"/>
			</colgroup>
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
				<c:set var="fileNo" value="${String.valueOf(1)}" />
				<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
				<tr>
					<th>첨부파일</th>
					<td>
						<div class="form-control-box">
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
							<label>
								<input type="checkbox" name="deleteFile__article__${article.id}__common__attachment__1" value="Y" /> 삭제
							</label>
						</div>
					</td>
				</tr>
				<tr>
					<th>태그</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="태그를 입력해주세요. ex) #강아지" name="tag" maxlength="100" />
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