<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 정보</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	type="text/css" rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
</head>
<body>

	<div>이름: ${memberInfo.member_name }</div>
	<div>아이디: ${memberInfo.member_id }</div>
	<div>이름:</div>
	<div>이름:</div>
</body>
</html>