<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 상세보기" />
<%@ include file="../part/head.jspf"%>
<style>
textarea.autosize { min-height: 50px; }
.autosize {
	padding:30px;
}
</style>

<script>
function resize(obj) {
  obj.style.height = "1px";
  obj.style.height = (12+obj.scrollHeight)+"px";
}
</script>
<style>
.modify-mode-on {
	display: none;
}
.modify-mode-actived .modify-mode-off {
	display: none;
}
.modify-mode-actived .modify-mode-on {
	display: inline-block;
}
.reply-list>tbody>tr>td>div>form>textarea {
	width: 100%;
	padding: 0;
	box-sizing: border-box;
	resize:none;
}
pre {
	width:100%;
	min-height:300px;
	word-wrap: break-word;      /* IE 5.5-7 */
	white-space: pre-wrap;      /* current browsers */
	background-color:white;
	border:1px solid #F55139;
	box-sizing: border-box;
	margin:0;
	padding:10px;
	text-align:left;
}
.reply-info {
	display:flex;
	justify-content:flex-end;
}
.reply-sumbit {
	text-align:center;
}
.tag-box {
	display:flex;
}
.tag-box > div {
	font-weight:bold;	
}
.tag-box > a {
	text-decoration:underline;
}
</style>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<div class="con body-box">
	<table class="table1">
		<tbody>
			<tr>
				<td class="article-box">
					<div>${article.title}</div>
					<div>
						작성자:<a href="/usr/member/memberPage?id=${article.memberId}"><strong>${article.extra.writer}</strong></a>&nbsp| 날짜:${article.regDate} | 조회수:${article.hit}
					</div>
				</td>
			</tr>
			<tr>
				<td><pre>${article.body}</pre></td>
			</tr>
			<c:set var="fileNo" value="${String.valueOf(1)}" />
			<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
			<c:if test="${file != null}">
				<tr>
					<td><img src="/usr/file/showImg?id=${file.id}&updateDate=${file.updateDate}" /></td>
				</tr>
			</c:if>
			<c:if test="${tagList.size() != 0}">
				<tr>
					<td class="tag-box">
						<div>Tag&nbsp:&nbsp</div>
						<c:forEach items="${tagList}" var="tag">
							<a href="allSearchResult?page1=1&page2=1&page3=1&searchKeyword=${tag.body}">#${tag.body}</a>&nbsp
						</c:forEach>
					</td>
				</tr>
			</c:if>
			<tr>
				<td class="${board.id == 3 ? "crud-box":"crud-box2" }">
					<c:if test="${board.id == 3}">
						<c:if test="${article.sortId != 0 && article.memberId == loginedMemberId}">
							<a href="doDealComplete?articleId=${article.id}" onclick="if ( confirm('거래완료 후에는 되돌릴 수 없습니다. 정말 완료하시겠습니까?') == false ) return false;">[거래완료?]</a>
						</c:if>
						<c:if test="${article.sortId == 0}">거래가 완료된 게시물입니다.</c:if>
					</c:if>
					<c:if test="${loginedMemberId == article.memberId}">
						<div>
							<a href="${article.getModifyLink(board.code)}">[수정]</a>
							<a href="${article.getDeleteLink(board.code)}" onclick="if ( confirm('정말로 삭제하시겠습니까?') == false ) return false;">[삭제]</a>
							<a href="${board.code}-list?page=1&sortId=0">[리스트로 돌아가기]</a>
						</div>
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
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
			ReplyWriteForm__submitDone = true;
			$.post('./../reply/doReplyWriteAjax', {
				articleId : form.articleId.value,
				memberId : form.memberId.value,
				body : form.body.value
			}, function(data) {
				ReplyWriteForm__submitDone = false;
				if (data.msg) {
					alert(data.msg);
				}
				if (data.resultCode.substr(0, 2) == 'S-') {
					form.body.value = '';
				}
			}, 'json');
		}
		function ReplyModify__showModifyForm(el) {
			var $tr = $(el).closest('tr');
			$tr.addClass('modify-mode-actived');
		}
		function ReplyModify__hideModifyForm(el) {
			var $tr = $(el).closest('tr');
			$tr.removeClass('modify-mode-actived');
		}
		var ReplyModifyForm__submitDone = false;
		function ReplyModifyForm__submit(form) {
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
			ReplyModifyForm__submitDone = true;
			$.post('./../reply/doReplyModifyAjax', {
				id : form.id.value,
				articleId : form.articleId.value,
				body : form.body.value
			}, function(data) {
				ReplyWriteForm__submitDone = false;
				if (data.msg) {
					alert(data.msg);
				}
				if (data.resultCode.substr(0, 2) == 'S-') {
					form.body.value = '';
				}
			}, 'json');
		}
		function ReplyDelete__submit(el) {
			$.post('./../reply/doReplyDeleteAjax', {
				id: el
			}, function(data) {
				if (data.msg) {
					alert(data.msg);
				}
			},'json');
		}
	</script>
	<c:if test="${isLogined}">
		<h3>댓글 작성</h3>
		<form method="POST" class="form1" onsubmit="ReplyWriteForm__submit(this); return false;">
			<input type="hidden" name="articleId" value="${article.id}" />
			<input type="hidden" name="memberId" value="${loginedMemberId}" />
			<table class="table1" border="1">
				<colgroup>
					<col />
					<col width="10%" />
				</colgroup>
				<tbody>
					<tr>
						<td>
							<div class="form-control-box">
								<textarea style="min-height: 100px;" placeholder="내용을 입력해주세요." name="body" maxlength="2000"></textarea>
							</div>
						</td>
						<td class="reply-sumbit">
							<button type="submit">등록</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</c:if>

	<h3>댓글목록</h3>
	<c:if test="${fullPage == 0}">
		<div>댓글이 없습니다. ㅠㅠ</div>
	</c:if>
	<c:if test="${fullPage != 0}">
		<table border="1" class="table2 reply-list">
			<colgroup>
				<col />
				<col width="10%"/>
			</colgroup>
			<tbody>
				<c:forEach items="${replies}" var="reply">
					<tr>
						<td>
							<div class="modify-mode-off"><pre style="min-height:50px;">${reply.body}</pre></div>
							<div class="modify-mode-on" style="width:100%;">
								<form method="POST" onsubmit="ReplyModifyForm__submit(this); return false;" style="width:100%;">
									<input type="hidden" name="id" value="${reply.id}" />
									<input type="hidden" name="articleId" value="${article.id}" />
									<textarea class="autosize" name="body" maxlength="2000" onkeydown="resize(this)" onkeyup="resize(this)" rows="10">${reply.body}</textarea>
									<input type="submit" value="완료" />
								</form>
							</div>
							<div class="reply-info">작성자 :&nbsp<a href="/usr/member/memberPage?id=${reply.memberId}"><strong>${reply.extra.writer}</strong></a>&nbsp| 날짜 : ${reply.regDate}</div>
						</td>
						<c:if test="${isLogined}">
							<td>
								<c:if test="${loginedMemberId == reply.memberId}">
									<button type="button" class="modify-mode-off" onclick="ReplyModify__showModifyForm(this);">수정</button>
									<button type="button" class="modify-mode-on" onclick="ReplyModify__hideModifyForm(this);">취소</button>
									<button type="button" onclick="if ( confirm('정말로 삭제하시겠습니까?') == false ) return false; ReplyDelete__submit(${reply.id})">삭제</button>
								</c:if>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="paging-box2">
			<c:forEach var="cnt" begin="1" end="${fullPage}">
				<li class="${cnt==page ? "current" : "" }">
					<a href="?id=${article.id}&page=${cnt}" class="block">${cnt}</a>
				</li>
			</c:forEach>
		</div>
	</c:if>
</div>
<%@ include file="../part/foot.jspf"%>