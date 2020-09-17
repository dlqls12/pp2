<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>
<div class="con body-box">
	<form class="form1" action="listSortByTag" onsubmit="TagSeekForm__submit(this); return false;">
		<input type="hidden" name="sortId" value="0" />
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
	<div class="party-menu">
		<section class="party-menu-item"><a href="/usr/article/notice-list?page=1&sortId=0">공지사항</a></section>
		<section class="party-menu-item"><a href="/usr/article/free-list?page=1&sortId=0">자유게시판</a></section>
		<section class="party-menu-item"><a href="/usr/article/deal-list?page=1&sortId=0">거래게시판</a></section>
	</div>
	<div class="party-menu">
		<section class="party-menu-item"><a href="./../party/createParty">파티 생성</a></section>
		<section class="party-menu-item"><a href="./../party/seekParty">파티 찾기</a></section>
		<section class="party-menu-item"><a href="./../article/seekTag">게시물 태그 검색</a></section>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>