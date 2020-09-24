<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name} 게시판" />
<%@ include file="../part/head.jspf"%>
<style>
select {
	width: 200px; /* 원하는 너비설정 */
    padding: .8em .5em; /* 여백으로 높이 설정 */
    font-family: inherit;  /* 폰트 상속 */
    background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%;
    border: 1px solid #999;
    border-radius: 0px; /* iOS 둥근모서리 제거 */
    -webkit-appearance: none; /* 네이티브 외형 감추기 */
    -moz-appearance: none;
    appearance: none;
    background-color:white;
}

/* IE 10, 11의 네이티브 화살표 숨기기 */
select::-ms-expand {
    display: none;
}

.search-box {
	display:flex;
	justify-content:center;
}

.search-form {
	width:50%;
}

.search-box-el {
	display:flex;
	justify-content:center;
	width:100%;
	background-color:#EBE7D9;
	border:1px solid #F55139;
	padding:5px;
}

.search-box-el>input {
	width:80%;
	margin: 0 10px;
	padding: 10px;
}

.button1 {
	width:20%;
	height:100%;
	border:1px solid #EBE7D9;
	background-color:#EBE7D9;
}
</style>
<div class="con body-box">
	<div class="con">
		<h1 class="page-title-box">${pageTitle}</h1>
	</div>
	<c:if test="${fullPage==0}">
		게시물이 존재하지 않습니다.
		<h4><button type="button" onclick="history.back();">돌아가기</button></h4>
	</c:if>
	<c:if test="${fullPage!=0}">
		<c:if test="${board.id == 3}">
			<select onchange="location.href = '?page=1&sortId=' + this.value;">
			    <option value="none">&nbsp&nbsp Select Box</option>
			    <option value="0">&nbsp&nbsp All</option>
			    <option value="1">&nbsp&nbsp Sell</option>
			    <option value="2">&nbsp&nbsp Buy</option>
			</select>
		</c:if>
		<div class="table1-box">
			<table class="table2 visible-on-md-up">
				<colgroup>
					<col width="10%"/>
					<col />
					<col width="15%"/>
					<col width="15%"/>
					<col width="15%"/>
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
					<c:set var="cnt" value="0" />
					<c:forEach items="${articles}" var="article">
						<c:set var="cnt" value="${cnt+1}"/>
						<tr>
							<td>${article.id}</td>
							<td class="title">
								<c:if test="${board.id == 3}">
									<c:if test="${article.sortId == 2}"><div class="buy">[삽니다]</div></c:if>
									<c:if test="${article.sortId == 1}"><div class="sell">[팝니다]</div></c:if>
									<c:if test="${article.sortId == 0}"><div class="dealComplete">[거래완료]</div></c:if>
								</c:if>
								<a href="${article.getDetailLink(board.code)}">${article.title}</a>
							</td>
							<td><a href="./../member/memberPage?id=${article.memberId}">${article.extra.writer}</a></td>
							<td>${article.regDate}</td>
							<td>${article.hit}</td>
						</tr>
					</c:forEach>
					<c:if test="${cnt < 9}">
						<c:forEach var="cnt2" begin="${cnt}" end="9">
						<tr>
							<td>&nbsp</td>
							<td>&nbsp</td>
							<td>&nbsp</td>
							<td>&nbsp</td>
							<td>&nbsp</td>
						</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="table1-box">
			<table class="table2 visible-on-sm-down">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="cnt" value="0" />
					<c:forEach items="${articles}" var="article">
						<c:set var="cnt" value="${cnt+1}"/>
						<tr>
							<td>${article.id}</td>
							<td class="title">
								<c:if test="${board.id == 3}">
									<c:if test="${article.sortId == 2}"><div class="buy">[삽니다]</div></c:if>
									<c:if test="${article.sortId == 1}"><div class="sell">[팝니다]</div></c:if>
									<c:if test="${article.sortId == 0}"><div class="dealComplete">[거래완료]</div></c:if>
								</c:if>
								<a href="${article.getDetailLink(board.code)}">${article.title}</a>
							</td>
							<td><a href="./../member/memberPage?id=${article.memberId}">${article.extra.writer}</a></td>
							<td>${article.hit}</td>
						</tr>
					</c:forEach>
					<c:if test="${cnt < 9}">
						<c:forEach var="cnt2" begin="${cnt}" end="9">
						<tr>
							<td>&nbsp</td>
							<td>&nbsp</td>
							<td>&nbsp</td>
							<td>&nbsp</td>
						</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="pageAndButton">
			<div class="fake"></div>
			<div class="paging-box">
				<c:if test="${page != 1}">
					<a href="?page=${page-1}&sortId=${sortId}" class="block">◀</a>
				</c:if>
				<c:forEach var="cnt" begin="1" end="${fullPage}">
					<li>
						<c:if test="${cnt==page}"><div class="current"><a href="?page=${cnt}&sortId=${sortId}" class="block">${cnt}</a></div></c:if>
						<c:if test="${cnt!=page}"><a href="?page=${cnt}&sortId=${sortId}" class="block">${cnt}</a></c:if>
					</li>
				</c:forEach>
				<c:if test="${page != fullPage}">
					<a href="?page=${page+1}&sortId=${sortId}" class="block">▶</a>
				</c:if>
			</div>
			<div class="writebutton">
				<c:if test="${board.id != 2}">
					<a href="${board.code}-write">글쓰기</a>
				</c:if>
				<c:if test="${board.id == 2 && loginedMemberId == 1}">
					<a href="${board.code}-write">글쓰기</a>
				</c:if>
			</div>
		</div>
		<div class="search-box">
			<form class="form2 search-form" action="${board.code}-list">
				<div class="search-box-el">
					<input type="hidden" name="page" value="1" />
					<input type="hidden" name="sortId" value="${param.sortId}" />
					<input type="text" name="searchKeyword" value="${param.searchKeyword}" />
					<button class="button1" type="submit"><img src="/resource/img/search.png" alt="search" /></button>
				</div>
			</form>
		</div>
	</c:if>
</div>

<%@ include file="../part/foot.jspf"%>