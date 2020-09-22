<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>
<script>@import url(https://fonts.googleapis.com/css?family=Raleway:400,700);</script>
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
		      <h2>파티 찾기</h2>
		      <h4>seek-party</h4>
		    </div>
		  </figcaption>
		  <a href="./../party/seekParty"></a>
		</figure>
		<figure class="snip1445">
		  <img src="/resource/img/main-item.png" alt="main-item" />
		  <figcaption>
		    <div>
		      <h2>게시물 태그 검색</h2>
		      <h4>search-tag</h4>
		    </div>
		  </figcaption>
		  <a href="./../article/seekTag"></a>
		</figure>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>