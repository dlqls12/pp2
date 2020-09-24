<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="쪽지 상세보기" />
<%@ include file="../part/head.jspf"%>
<style>
pre {
	width:100%;
	min-height:300px;
	word-wrap: break-word;      /* IE 5.5-7 */
	white-space: pre-wrap;      /* current browsers */
	background-color:white;
	border:1px solid #F55139;
	box-sizing: border-box;
	margin:0;
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
					<div>${message.title}</div>
					<div>
						작성자:<a href="/usr/member/memberPage?id=${message.writerId}"><strong>${message.extra.writer}</strong></a>&nbsp| 날짜:${message.regDate}
					</div>
				</td>
			</tr>
			<tr>
				<td><pre>${message.body}</pre></td>
			</tr>
			<tr class="crud-box2">
				<td>
					<a href="/usr/message/sendMessage?getterId=${message.writerId}">[답장]</a>
					<a href="/usr/message/deleteMessage?id=${message.id}" onclick="if ( confirm('정말로 삭제하시겠습니까?') == false ) return false;">[삭제]</a>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<%@ include file="../part/foot.jspf"%>