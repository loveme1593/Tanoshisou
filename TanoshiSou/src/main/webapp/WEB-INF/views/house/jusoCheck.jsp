<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<c:if test="${not empty juso}">
	<script type="text/javascript">
		// 변수명 수정 
		$("#house_address", opener.document).removeAttr('disabled');
		$("#house_address", opener.document).val("${juso}");
		this.window.close();
	</script>
</c:if>
</head>
<body>

</body>
</html>