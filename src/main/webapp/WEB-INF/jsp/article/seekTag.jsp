<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 태그검색" />
<%@ include file="../part/head.jspf"%>
<div class="con">
	<h1 class="page-title-box">${pageTitle}</h1>
</div>
<script>
	var TagSeekForm__submitDone = false;
	function TagSeekForm__submit(form) {
		if (TagSeekForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		form.searchKeyword.value = form.searchKeyword.value.trim();
		if (form.searchKeyword.value.length == 0) {
			form.searchKeyword.focus();
			alert('검색어를 입력해주세요.');
			return;
		}

		form.submit();
		TagSeekForm__submitDone = true;
	}
</script>
<div class="con body-box">
	<form class="form1" action="?searchTag=${searchTag}" onsubmit="TagSeekForm__submit(this); return false;">
		<table class="table1" border="1">
			<colgroup>
				<col width=200 />
			</colgroup>
			<tbody>
				<tr>
					<th>태그</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="검색어를 입력해주세요." name="searchTag" maxlength="30" value="${param.searchTag}"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>찾기</th>
					<td>
						<button type="submit">찾기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<h4>검색 결과</h4>
	<c:if test="${articleCount == 0}">
		결과를 찾을 수 없습니다.
	</c:if>
	<c:if test="${articleCount != 0}">
		<c:if test="${articleCount == null}">
			검색어를 입력해보세요.
		</c:if>
		<c:if test="${articleCount != null}">
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
						<th>번호</th>
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
							<td>${article.id}</td>
							<td class="title">
								<c:if test="${article.sortId == 2}"><div class="buy">[삽니다]</div></c:if>
								<c:if test="${article.sortId == 1}"><div class="sell">[팝니다]</div></c:if>
								<c:if test="${article.sortId == 0}"><div class="dealComplete">[거래완료]</div></c:if>
								<a href="deal-detail?id=${article.id}&page=1">${article.title}</a>
							</td>
							<td><a href="./../member/memberPage?id=${article.memberId}">${article.extra.writer}</a></td>
							<td>${article.regDate}</td>
							<td>${article.hit}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</c:if>
</div>
<%@ include file="../part/foot.jspf"%>