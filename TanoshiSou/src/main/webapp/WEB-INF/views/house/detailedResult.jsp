<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>楽し荘</title>
<!-- JQuery 와 Bootstrap -->
<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	function toList() {
		history.go(-1);
	}
</script>
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
<!-- FOR IE9 below -->
<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
<style type="text/css">
#table {
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
}
#table th {
	background-color: silver;
	width: 250px;
	padding: 10px;
	font-weight: bolder;
	vertical-align: middle;
	border-bottom: 1px solid #ccc;
	background: #efefef;
}

#table td {
	width: 700px;
	padding: 10px;
	vertical-align: middle;
	border-bottom: 1px solid #ccc;
}
#option{
	font-weight: bold;
}
#text{
	font-weight: bolder;
	color: black;
}

#pa{
	/*font-weight: bold;*/
	font-size: large;
	color: black;
}
#options{
	font-weight: bolder;
	color: black;
	font-size: large;
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
					<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> 
						<img src="${pageContext.request.contextPath}/member/getPhoto?file_id=${memberProfile.member_file_id}" width="30" height="30" onError="javascript:this.src='${pageContext.request.contextPath}/resources/images/person-icon.png'" /> ${loginInfo.member_id }님 (${loginInfo.member_type})
						<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
							<li><a href="${pageContext.request.contextPath}/member/update">기본 정보 수정</a></li>
							<li><a href="${pageContext.request.contextPath}/member/detail">상세 정보 수정</a></li>
							<c:if test="${loginInfo.member_type=='General' }">
							<li><a href="${pageContext.request.contextPath}/house/insert">하우스 등록</a>
							</c:if>
						</ul></li>
				</ul>
			</c:if>
		</div>
	</nav>
	<div class="box-wrap" >
		<div class="Mainwrap">
			<div class="col-md-11 animate-box">
				<!-- <div class="form-group row"> -->
				<h1>쉐어하우스 검색하기</h1>
				<!-- ajax 방식으로 바꿀꺼면 이부분 수정해야 -->
				<p id="pa" style="text-align: left;">
				검색조건<br>
				면적: ${keyword.house_area}
				연령대: ${keyword.house_age}
				<!-- 면&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;적&nbsp;&nbsp;:&nbsp;<input type="text" readonly="readonly" value="${keyword.house_area}"><br>
				연&nbsp;령&nbsp;대&nbsp;&nbsp;:&nbsp;<input type="text" readonly="readonly" value="${keyword.house_age}"> -->
				<p>
				<div id="options">
					<script type="text/javascript">
						var str = '${keyword.house_option }';
						var options = str.split(",");
						var array = '희망사항 : ';
						var icons = [ {
							name : 'onlyMan',
							message : '남성 전용',
							file : 'onlyMan-home.png'
						}, {
							name : 'pet',
							message : '애완동물 가능',
							file : 'pet-home.png'
						}, {
							name : 'noSmoker',
							message : '금연',
							file : 'noSmoker-home.png'
						}, {
							name : 'noDrink',
							message : '금주',
							file : 'noDrink-home.png'
						}, {
							name : 'onlyWoman',
							message : '여성 전용',
							file : 'onlyWoman-home.png'
						}, {
							name : 'parkingLot',
							message : '주차 가능',
							file : 'parkingLot-home.png'
						}, {
							name : 'study',
							message : '스터디 그룹',
							file : 'study-home.png'
						},{
							name : 'WiFi',
							message : 'WiFi',
							file : '5G-home.png'
						} ];
						$.each(options,function(index, item) {
							$.each(icons,function(i, icon) {
								if (item == icon.name) array += '<img src="${pageContext.request.contextPath}/resources/images/'+icon.file+'" width="30">'
									+ icon.message
									+ '&nbsp;';
											});
										});
						$('#options').html(array);
					</script>
				</div>
				<br>
				<input type="button" onclick="toList();" value="메인화면" class="button-input pull-right" style="height: 50px;">
				<div class="result">
					<c:if test="${!empty keyword&&results.size()!=0}">
						<div class="alert alert-info">
							<strong>Success!</strong> 결과: ${results.size()}
						</div>
					</c:if>
					<c:if test="${!empty keyword&&results.size()==0 }">
						<div class="alert alert-info">
							<strong>Warning!</strong> 결과값이 없습니다.
						</div>
					</c:if>
					<table id="table" class="table-hover" style="display: inline-table;">
						<tr>
							<th style="width:150px; text-align: center;">이름</th>
							<th  style="width:500px; ">소개</th>
							<th style="width:100px; text-align: center;">관리자</th>
							<th id="room" style="width:100px; text-align: center;">방 개수</th>
							<th style="width:400px;">주소</th>
						</tr>
						<c:forEach var="result" items="${results}">
							<!-- 	<div class="form-group row"> -->
							<tr>
								<td style="width:150px; text-align: center;"><a
									href="${pageContext.request.contextPath}/house/?id=${result.house_id}">${result.house_name}</a></td>
								<td style="width:500px;">${result.house_introduce}</td>
								<td style="width:100px; text-align: center;">${result.house_owner}</td>
								<td style="width:100px; text-align: center;">${result.house_available_room}</td>
								<td style="width:400px;">${result.house_address}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	<div class="clearfix"></div><hr>
				<%@ include file="../footer.jsp" %>
	</div>
	<!-- END: box-wrap -->
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
	<!-- jQuery Easing -->
	<script
		src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script
		src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>

	<!-- Main JS (Do not remove) -->
	<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>