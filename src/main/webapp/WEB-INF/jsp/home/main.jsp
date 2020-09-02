<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>
<div class="con body-box">
	<div><a href="./../group/createGroup">[그룹 만들기]</a></div>
	<div><a href="./../group/seekGroup">[그룹 찾기]</a></div>
	<div><a href="./../article/${groupOfLoginedMember.code}-list?page=1">[우리그룹 게시판이동]</a></div>
</div>
<%@ include file="../part/foot.jspf"%>