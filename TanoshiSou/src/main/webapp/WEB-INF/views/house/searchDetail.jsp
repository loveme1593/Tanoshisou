<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세검색</title>
<style>
select {
	width: 80%;
	height: 36px;
	padding: 5px 10px;
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
}

.centeralize {
	text-align: center;
	width: 500px; /* 정렬하려는 요소의 넓이를 반드시 지정 */
	margin: 0 auto;
}

th, td {
	padding: 6px;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Free HTML5 Template by FREEHTML5.CO" />
<meta name="keywords"
	content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
<meta name="author" content="FREEHTML5.CO" />
<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicons/favicon.ico">
<link
	href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,300,700|Roboto:300,400'
	rel='stylesheet' type='text/css'>
<!-- Animate.css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/animate.css">
<!-- Icomoon Icon Fonts-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/icomoon.css">
<!-- Bootstrap  -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<!-- Modernizr JS -->
<script
	src="${pageContext.request.contextPath}/js/modernizr-2.6.2.min.js"></script>
<script>
	function toList() {
		location.href = "${pageContext.request.contextPath}/";
	}
</script>
<style>
td, th {
	padding: 6;
}
</style>
</head>
<body>
	<!-- 헤더 연습 -->
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="${pageContext.request.contextPath}/">楽し荘</a>
			</div>
			<ul class="nav navbar-nav navbar-center">
				<li><a href="${pageContext.request.contextPath}/">Home</a></li>
				<c:if test="${loginInfo.member_type=='Resident'}">
					<li><a
						href="${pageContext.request.contextPath}/house/?id=${loginInfo.member_belongto}">My
							ShareHouse</a></li>
				</c:if>
				<c:if test="${loginInfo.member_type=='Host' }">
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">My ShareHouse <span
							class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a
								href="${pageContext.request.contextPath}/house/update?id=${loginInfo.member_belongto}">하우스
									정보 수정</a></li>
							<li><a
								href="${pageContext.request.contextPath}/house/?id=${loginInfo.member_belongto}">내
									쉐어하우스</a></li>
						</ul></li>
				</c:if>
				<c:if test="${loginInfo.member_type=='Manager' }">
					<li><a href="${pageContext.request.contextPath}/admin/">House
							Management</a></li>
				</c:if>
				<c:if test="${loginInfo.member_type=='General' }">
					<li><a href="${pageContext.request.contextPath}/recommend/">House
							Recommend</a></li>
				</c:if>
			</ul>
			<c:if test="${empty loginInfo||loginInfo=='fail' }">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="${pageContext.request.contextPath}/member/join"><span
							class="glyphicon glyphicon-user"></span> Sign Up</a></li>
					<li><a href="${pageContext.request.contextPath}/member/login"><span
							class="glyphicon glyphicon-log-in"></span> Login</a></li>
				</ul>
			</c:if>
			<c:if test="${!empty loginInfo }">

				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <img
							src="${pageContext.request.contextPath}/member/getPhoto?file_id=${memberProfile.member_file_id}"
							width="30" height="30"
							onError="javascript:this.src='${pageContext.request.contextPath}/resources/images/person-icon.png'" />
							${loginInfo.member_id }님 (${loginInfo.member_type})<span
							class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a
								href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
							<li><a
								href="${pageContext.request.contextPath}/member/update">기본
									정보 수정</a></li>
							<li><a
								href="${pageContext.request.contextPath}/member/detail">상세
									정보 수정</a></li>
							<c:if test="${loginInfo.member_type=='General' }">
								<li><a
									href="${pageContext.request.contextPath}/house/insert">하우스
										등록</a>
							</c:if>
						</ul></li>
				</ul>
			</c:if>
		</div>
	</nav>
	<!-- 상세검색 띄워지는 창 -->
	<div class="box-wrap">
		<section id="intro">
			<div class="container">
				<div class="col-md-8 col-md-offset-2 animate-box">
					<div class="centeralize">
						<br>
						<h2>상세 정보 검색</h2>
						<form id="form" method="post"
							action="${pageContext.request.contextPath}/house/detail">
							<table class="table-reply">
								<tr>
									<td colspan="2"><div class="alert alert-info">
											<strong>Info! </strong> 상세 정보 검색을 위해 옵션을 선택해주세요.
										</div></td>
								</tr>
								<tr>
									<th>희망 평균 면적<br>(1인당)
									</th>
									<td><select id="house_area" name="house_area">
											<option value="0"></option>
											<option value="10">10㎡ 이하</option>
											<option value="15">10~15㎡</option>
											<option value="16">15㎡ 이상</option>
									</select></td>
								</tr>
								<tr>
									<th>희망 평균 연령</th>
									<td><select id="house_age" name="house_age">
											<option value="0"></option>
											<option value="20">20~29세</option>
											<option value="30">30~39세</option>
											<option value="40">40세 이상</option>
									</select></td>
								</tr>
								<tr>
									<th>선택사항</th>
									<td>
									<input type="checkbox" id="house_option" name="house_option" value="pet">
										애완동물 가능&nbsp;&nbsp;
									<input type="checkbox" id="house_option" name="house_option" value="onlyWoman">여성전용&nbsp;&nbsp; <br>
									<input type="checkbox" id="house_option" name="house_option" value="onlyMan">남성전용
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
									<input type="checkbox" id="house_option" name="house_option" value="noSmoker">금연&nbsp;&nbsp; 
									<input type="checkbox" id="house_option" name="house_option" value="noDrink">금주<br> 
									<input type="checkbox" id="house_option" name="house_option" value="study">스터디 그룹  &nbsp;&nbsp;
									<input type="checkbox" id="house_option" name="house_option" value="WiFi">WiFi</td>
								</tr>
							</table>
							<br> <input type="submit" value="상세검색" class="button-input">
							<input type="button" value="처음으로" onclick="toList();"
								class="button-input">
						</form>
					</div>
				</div>
			</div>
		</section>
	</div>
	<!-- jQuery -->
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.min.js"></script>
	<!-- jQuery Easing -->
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script
		src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.waypoints.min.js"></script>

	<!-- Main JS (Do not remove) -->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html>