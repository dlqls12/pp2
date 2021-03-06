<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="통합검색" />
<%@ include file="../part/head.jspf"%>
<div class="con body-box">
	<form class="form1 main-form" action="../article/allSearchResult" onsubmit="SearchForm__submit(this); return false;">
		<input type="hidden" name="page1" value="1" />
		<input type="hidden" name="page2" value="1" />
		<input type="hidden" name="page3" value="1" />
		<table class="table1">
			<colgroup>
				<col width=10%/>
				<col />
				<col width=10% />
			</colgroup>
			<tbody>
				<tr>
					<td style="text-align:center; font-weight:bold;">통합검색</td>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="검색어를 입력해주세요." name="searchKeyword" maxlength="30" value="${param.searchTag}" required/>
						</div>
					</td>
					<td style="text-align:center;">
						<button class="button2" type="submit"><img src="/resource/img/search.png" alt="search" /></button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<c:if test="${articlesSize == 0}">
		<div style="margin-top:20px;">"${searchKeyword}" [게시물] 검색 결과를 찾을 수 없습니다.</div>
	</c:if>
	<c:if test="${articlesSize != 0}">
		<div class="pageTitle" style="margin-top:20px;">
			<div>"${searchKeyword}" [게시물] 검색 결과입니다.</div>
			<div>게시물 수 : ${articlesSize}</div>
		</div>
		<table class="table2">
			<colgroup>
				<col width="15%" />
				<col />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
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
			<c:set var="cnt" value="0" />
			<tbody>
				<c:forEach items="${articleList}" var="article">
					<c:set var="cnt" value="${cnt+1}"/>
					<c:if test="${((page1-1) * 10) < cnt && cnt <= ((page1-1)*10) + 10}">
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
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${articlesSize % 10 == 0}">
			<c:set var="fullPage" value = "${articlesSize/10}" />
		</c:if>
		<c:if test="${articlesSize % 10 != 0}">
			<c:set var="fullPage" value = "${articlesSize / 10 + 1}" />
		</c:if>
		<div class="paging-box2">
			<c:forEach var="cnt2" begin="1" end="${fullPage}">
				<li>
					<c:if test="${cnt2==page1}"><div class="current"><a href="?searchKeyword=${param.searchKeyword}&page1=${cnt2}&page2=${page2}&page3=${page3}" class="block">${cnt2}</a></div></c:if>
					<c:if test="${cnt2!=page1}"><a href="?searchKeyword=${param.searchKeyword}&page1=${cnt2}&page2=${page2}&page3=${page3}" class="block">${cnt2}</a></c:if>
				</li>
			</c:forEach>
		</div>
	</c:if>

	<c:if test="${partySize == 0}">
		<div style="margin-top:20px;">"${searchKeyword}" [파티] 검색 결과를 찾을 수 없습니다.</div>
	</c:if>
	<c:if test="${partySize != 0}">
		<div class="pageTitle" style="margin-top:20px;">
			<div>"${searchKeyword}" [파티] 검색 결과입니다.</div>
			<div>파티 수 : ${partySize}</div>
		</div>
		<table class="table2">
			<colgroup>
				<col width="15%" />
				<col />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>파티명</th>
					<th>생성날짜</th>
					<th>회원수</th>
				</tr>
			</thead>
			<c:set var="cnt" value="0" />
			<tbody>
				<c:forEach items="${partyList}" var="party">
					<c:set var="cnt" value="${cnt+1}"/>
					<c:if test="${((page2-1) * 10) < cnt && cnt <= ((page2-1)*10) + 10}">
					<tr>
						<td>${party.id}</td>
						<td><a href="../party/partyPage?id=${party.id}">${party.name}</a></td>
						<td>${party.regDate}</td>
						<td>${party.memberCount}</td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${articlesSize % 10 == 0}">
			<c:set var="fullPage" value = "${partySize / 10}" />
		</c:if>
		<c:if test="${articlesSize % 10 != 0}">
			<c:set var="fullPage" value = "${partySize / 10 + 1}" />
		</c:if>
		<div class="paging-box2">
			<c:forEach var="cnt2" begin="1" end="${fullPage}">
				<li>
					<c:if test="${cnt2==page2}"><div class="current"><a href="?searchKeyword=${param.searchKeyword}&page1=${page1}&page2=${cnt2}&page3=${page3}" class="block">${cnt2}</a></div></c:if>
					<c:if test="${cnt2!=page2}"><a href="?searchKeyword=${param.searchKeyword}&page1=${page1}&page2=${cnt2}&page3=${page3}" class="block">${cnt2}</a></c:if>
				</li>
			</c:forEach>
		</div>
	</c:if>
	
	<c:if test="${articlesSize2 == 0}">
		<div style="margin-top:20px;">"${searchKeyword}" [태그] 검색 결과를 찾을 수 없습니다.</div>
	</c:if>
	<c:if test="${articlesSize2 != 0}">
	<div class="pageTitle" style="margin-top:20px;">
		<div>"${searchKeyword}" [태그] 검색 결과입니다.</div>
		<div>게시물 수 : ${articlesSize2}</div>
	</div>
		<table class="table2">
			<colgroup>
				<col width="15%" />
				<col />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
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
			<c:set var="cnt" value="0" />
			<tbody>
				<c:forEach items="${articleList2}" var="article">
					<c:set var="cnt" value="${cnt+1}"/>
					<c:if test="${((page3-1) * 10) < cnt && cnt <= ((page3-1)*10) + 10}">
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
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${articlesSize % 10 == 0}">
			<c:set var="fullPage" value = "${articlesSize2 / 10}" />
		</c:if>
		<c:if test="${articlesSize % 10 != 0}">
			<c:set var="fullPage" value = "${articlesSize2 / 10 + 1}" />
		</c:if>
		<div class="paging-box2">
			<c:forEach var="cnt2" begin="1" end="${fullPage}">
				<li>
					<c:if test="${cnt2==page3}"><div class="current"><a href="?searchKeyword=${param.searchKeyword}&page1=${page1}&page2=${page2}&page3=${cnt2}" class="block">${cnt2}</a></div></c:if>
					<c:if test="${cnt2!=page3}"><a href="?searchKeyword=${param.searchKeyword}&page1=${page1}&page2=${page2}&page3=${cnt2}" class="block">${cnt2}</a></c:if>
				</li>
			</c:forEach>
		</div>
	</c:if>
</div>

<%@ include file="../part/foot.jspf"%>