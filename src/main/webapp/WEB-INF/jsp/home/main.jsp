<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>
<script>@import url(https://fonts.googleapis.com/css?family=Raleway:400,700);</script>
<style>
/* hover-action */
.snip1445 {
	font-family: 'Raleway', Arial, sans-serif;
	position: relative;
	overflow: hidden;
	margin: 10px 0;
	min-width: 275px;
	max-width: 400px;
	width: 100%;
	color: #EBE7D9;
	text-align: center;
	font-size: 16px;
	background-color: #0F222D;
	border:1px solid #F55139;
}

.snip1445 *, .snip1445 *:before, .snip1445 *:after {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	-webkit-transition: all 0.55s ease;
	transition: all 0.55s ease;
}

.snip1445 img {
	max-width: 100%;
	backface-visibility: hidden;
	vertical-align: top;
}

.snip1445 figcaption {
	position: absolute;
	bottom: 25px;
	right: 25px;
	padding: 5px 10px 10px;
}

.snip1445 figcaption:before, .snip1445 figcaption:after {
	height: 2px;
	width: 400px;
	position: absolute;
	content: '';
	background-color: #EBE7D9;
}

.snip1445 figcaption:before {
	top: 0;
	left: 0;
	-webkit-transform: translateX(100%);
	transform: translateX(100%);
}

.snip1445 figcaption:after {
	bottom: 0;
	right: 0;
	-webkit-transform: translateX(-100%);
	transform: translateX(-100%);
}

.snip1445 figcaption div:before, .snip1445 figcaption div:after {
	width: 2px;
	height: 300px;
	position: absolute;
	content: '';
	background-color: #EBE7D9;
}

.snip1445 figcaption div:before {
	top: 0;
	left: 0;
	-webkit-transform: translateY(100%);
	transform: translateY(100%);
}

.snip1445 figcaption div:after {
	bottom: 0;
	right: 0;
	-webkit-transform: translateY(-100%);
	transform: translateY(-100%);
}

.snip1445 h2, .snip1445 h4 {
	margin: 0;
	text-transform: uppercase;
}

.snip1445 h2 {
	font-weight: 400;
	color:#EBE7D9;
}

.snip1445 h4 {
	display: block;
	font-weight: 700;
	background-color: #EBE7D9;
	padding: 5px 10px;
	color: #0F222D;
}

.snip1445 a {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
}

.snip1445:hover img, .snip1445.hover img {
	zoom: 1;
	filter: alpha(opacity = 50);
	-webkit-opacity: 0.5;
	opacity: 0.5;
}

.snip1445:hover figcaption:before, .snip1445.hover figcaption:before,
	.snip1445:hover figcaption:after, .snip1445.hover figcaption:after,
	.snip1445:hover figcaption div:before, .snip1445.hover figcaption div:before,
	.snip1445:hover figcaption div:after, .snip1445.hover figcaption div:after
	{
	-webkit-transform: translate(0, 0);
	transform: translate(0, 0);
}

.snip1445:hover figcaption:before, .snip1445.hover figcaption:before,
	.snip1445:hover figcaption:after, .snip1445.hover figcaption:after {
	-webkit-transition-delay: 0.15s;
	transition-delay: 0.15s;
}
/* hover-action 끝 */
</style>
<div class="con body-box">
	<form class="form1 main-form" action="../article/allSearchResult" onsubmit="SearchForm__submit(this); return false;">
		<input type="hidden" name="page1" value="1" />
		<input type="hidden" name="page2" value="1" />
		<input type="hidden" name="page3" value="1" />
		<table class="table1" border="1">
			<colgroup>
				<col width=200 />
			</colgroup>
			<tbody>
				<tr>
					<th>통합검색</th>
					<td>
						<div class="form-control-box">
							<input type="text" placeholder="검색어를 입력해주세요." name="searchKeyword" maxlength="30" value="${param.searchTag}" required/>
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
	<div class="visible-on-md-up">
		<div class="main-item">
			<figure class="snip1445">
			  <img src="/resource/img/main-item.png" alt="main-item" />
			  <figcaption>
			    <div>
			      <h2>공지사항</h2>
			      <h4>notice</h4>
			    </div>
			  </figcaption>
			  <a href="/usr/article/notice-list?page=1&sortId=0"></a>
			</figure>
			<figure class="snip1445">
			  <img src="/resource/img/main-item.png" alt="main-item" />
			  <figcaption>
			    <div>
			      <h2>자유게시판</h2>
			      <h4>free-Board</h4>
			    </div>
			  </figcaption>
			  <a href="/usr/article/free-list?page=1&sortId=0"></a>
			</figure>
			<figure class="snip1445">
			  <img src="/resource/img/main-item.png" alt="main-item" />
			  <figcaption>
			    <div>
			      <h2>거래게시판</h2>
			      <h4>deal-board</h4>
			    </div>
			  </figcaption>
			  <a href="/usr/article/deal-list?page=1&sortId=0"></a>
			</figure>
		</div>
		<div class="main-item">
			<figure class="snip1445">
			  <img src="/resource/img/main-item.png" alt="main-item" />
			  <figcaption>
			    <div>
			      <h2>파티 생성</h2>
			      <h4>create-party</h4>
			    </div>
			  </figcaption>
			  <a href="./../party/createParty"></a>
			</figure>
			<figure class="snip1445">
			  <img src="/resource/img/main-item.png" alt="main-item" />
			  <figcaption>
			    <div>
			      <h2>파티 검색</h2>
			      <h4>search-party</h4>
			    </div>
			  </figcaption>
			  <a href="./../party/seekParty"></a>
			</figure>
			<figure class="snip1445">
			  <img src="/resource/img/main-item.png" alt="main-item" />
			  <figcaption>
			    <div>
			      <h2>건의사항</h2>
			      <h4>Suggestions</h4>
			    </div>
			  </figcaption>
			  <a href="./../article/suggestion-list?page=1&sortId=0"></a>
			</figure>
		</div>
	</div>
	<div class="visible-on-sm-down">
		<div class="mobile-main-item-box">
			<div class="mobile-main-item">
				<a href="/usr/article/notice-list?page=1&sortId=0">
					<span>
						<span>공지사항</span>
						<span>NOTICE</span>
					</span>
				</a>
			</div>
			<div class="mobile-main-item">
				<a href="/usr/article/free-list?page=1&sortId=0">
					<span>
						<span>자유게시판</span>
						<span>FREE-BOARD</span>
					</span>
				</a>
			</div>
			<div class="mobile-main-item">
				<a href="/usr/article/deal-list?page=1&sortId=0">
					<span>
						<span>거래게시판</span>
						<span>DEAL-BOARD</span>
					</span>
				</a>
			</div>
		</div>
		<div class="mobile-main-item-box">
			<div class="mobile-main-item">
				<a href="/usr/article/suggestion-list?page=1&sortId=0">
					<span>
						<span>건의사항</span>
						<span>SUGGESTIONS</span>
					</span>
				</a>
			</div>
			<div class="mobile-main-item">
				<a href="./../party/createParty">
					<span>
						<span>파티 생성</span>
						<span>CREATE-PARTY</span>
					</span>
				</a>
			</div>
			<div class="mobile-main-item">
				<a href="./../party/seekParty">
					<span>
						<span>파티 검색</span>
						<span>SEARCH-PARTY</span>
					</span>
				</a>
			</div>
		</div>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>