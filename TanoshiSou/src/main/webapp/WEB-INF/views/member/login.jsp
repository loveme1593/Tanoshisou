<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<title>로그인</title>
<script type="text/javascript">
	/*로그인 처리  */
	function workingOnLogin() {
		var login_id = document.getElementById('login_id');
		var login_password = document.getElementById('login_password');
		if (login_id.val == '' || login_password == '') {
			alert('아이디와 비밀번호가 입력되지 않았습니다.');
			login_id.focus();
		}
	}
	//회원가입화면
	function joinMemberView() {
		location.href = '${pageContext.request.contextPath}/member/join';
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
	<script src="${pageContext.request.contextPath}/js/respond.min.js"></script>
	<![endif]-->
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
	<div class="box-wrap">
		<section id="intro">
			<div class="container">
				<div class="col-md-8 col-md-offset-2 animate-box">
					<div class="title-align">
						<h1>楽し荘 에 오신 것을 환영합니다.</h1>
						<h2>Login</h2>
					</div>
					<br>
					<c:if test="${loginResult == 'fail'}">
						<div class="alert alert-info alert-dismissable fade in">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Fail!</strong> 아이디나 비밀번호를 확인해주세요.
						</div>
					</c:if>
					<c:if test="${joinResult == 'success'}">
						<div class="alert alert-info alert-dismissable fade in">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Success!</strong> 회원가입에 성공했습니다. 로그인해주세요.
						</div>
					</c:if>
					<c:if test="${findResult == 'success'}">
						<div class="alert alert-info alert-dismissable fade in">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Success!</strong> 비밀번호가 이메일로 전송되었습니다.
						</div>
					</c:if>
					<c:if test="${!empty idResult&&idResult != 'fail'}">
						<div class="alert alert-info alert-dismissable fade in">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Success!</strong> 아이디는 ${idResult } 입니다.
						</div>
					</c:if>
					<br>

					<form action="${pageContext.request.contextPath}/member/login"
						method="post" onsubmit="workingOnLogin()">

						<label for="firstname">ID</label> <input type="text" id="login_id"
							name="login_id" class="form-control" size="60" width="50">
						<br> <label for="lastname">Password</label> <input
							type="password" id="login_password" name="login_password"
							class="form-control" size="60" width="50"> <br>
						<div class="form-group row">
							<div class="col-md-12 field">
								<input type="submit" id="submit" class="btn btn-primary" value="Login"> <br> <br> 아직 회원이 아니신가요? 
									<a	href="javascript:void(0)" onclick="joinMemberView();" style="text-decoration: underline;">회원가입 바로가기</a> <br> 아이디 혹은 비밀번호를 잊으셨나요? 
									<a href="${pageContext.request.contextPath}/member/findInfo" style="text-decoration: underline;">아이디/비밀번호 찾기</a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</section>
		<footer id="footer" role="contentinfo">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center ">
						<div class="footer-widget border">
							<p class="pull-left">
								<small>&copy; Tanoshishou. All Rights Reserved.</small>
							</p>
							<p class="pull-right">
								<small> 조장: 정요한 , 조원: 고주환, 김길섭, 박문경</small>
							</p>
						</div>
					</div>
				</div>
			</div>
		</footer>
		<!-- END: box-wrap -->

		<!-- jQuery -->
		<script
			src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
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
	</div>
</body>
</html>