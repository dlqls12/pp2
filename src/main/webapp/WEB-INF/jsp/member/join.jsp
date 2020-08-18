<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>
<h1>${pageTitle}</h1>

<form action="doJoin">
	<input type="text" />
</form>
<%@ include file="../part/foot.jspf"%>