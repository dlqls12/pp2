<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="통합검색" />
<%@ include file="../part/head.jspf"%>

<div class="con body-box">
	<form class="form1 main-form" action="allSearchResult" onsubmit="SearchForm__submit(this); return false;">
		<table class="table1" border="1">
			<colgroup>
				<col width=200 />
			</colgroup>
			<tbody>
				<tr>
					<th>검색</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="검색어를 입력해주세요." name="searchKeyword" maxlength="30" value="${param.searchTag}"/>
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
	<c:if test="${articlesSize == 0}">
		<div>"${searchKeyword}" [게시물] 검색 결과를 찾을 수 없습니다.</div>
	</c:if>
	<c:if test="${articlesSize != 0}">
		<div class="pageTitle">
			<div>"${searchKeyword}" [게시물] 검색 결과입니다.</div>
			<div>게시물 수 : ${articlesSize}</div>
		</div>
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
					<th>카테고리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>생성날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${articleList}" var="article">
					<tr>
						<td>${article.extra.name}</td>
						<td class="title">
							<c:if test="${article.sortId == 2}"><div class="buy">[삽니다]</div></c:if>
							<c:if test="${article.sortId == 1}"><div class="sell">[팝니다]</div></c:if>
							<c:if test="${article.boardId == 3 && article.sortId == 0}"><div class="dealComplete">[거래완료]</div></c:if>
							<a href="${article.getDetailLink(article.extra.name)}">${article.title}</a>
						</td>
						<td>
							<a href="./../member/memberPage?id=${article.memberId}">
								<c:forEach items="${memberList}" var="member">
									<c:if test="${member.id == article.memberId}">${member.nickname}</c:if>
								</c:forEach>
							</a>
						</td>
						<td>${article.regDate}</td>
						<td>${article.hit}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>

	<c:if test="${partySize == 0}">
		<div>"${searchKeyword}" [파티] 검색 결과를 찾을 수 없습니다.</div>
	</c:if>
	<c:if test="${partySize != 0}">
		<div class="pageTitle">
			<div>"${searchKeyword}" [파티] 검색 결과입니다.</div>
			<div>파티 수 : ${partySize}</div>
		</div>
		<table class="table2">
			<colgroup>
				<col width="100" />
				<col />
				<col width="200" />
				<col width="100" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>파티명</th>
					<th>생성날짜</th>
					<th>회원수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${partyList}" var="party">
					<tr>
						<td>${party.id}</td>
						<td><a href="partyPage?id=${party.id}">${party.name}</a></td>
						<td>${party.regDate}</td>
						<td>${party.memberCount}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	
	<c:if test="${articlesSize2 == 0}">
		<div>"${searchKeyword}" [태그] 검색 결과를 찾을 수 없습니다.</div>
	</c:if>
	<c:if test="${articlesSize2 != 0}">
	<div class="pageTitle">
		<div>"${searchKeyword}" [태그] 검색 결과입니다.</div>
		<div>게시물 수 : ${articlesSize2}</div>
	</div>
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
				<c:forEach items="${articleList2}" var="article">
					<tr>
						<td>${article.id}</td>
						<td class="title">
							<c:if test="${article.sortId == 2}"> <div class="buy">[삽니다]</div></c:if>
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
</div>

<%@ include file="../part/foot.jspf"%>