<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<title>楽し荘 에 오신 것을 환영합니다.</title>
<!-- JQuery 와 Bootstrap -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
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
</head>
<script type="text/javascript">
	/*$(function() {
		$('#submitId').on('click', function() {
			$.ajax({
				method : 'post',
				url : 'findId',
				data : {
					'member_name' : $('#member_name').val(),
					'member_phone' : $('#member_phone').val()
				},
				success : function(resp) {
					if (resp != null || resp != '') {
						$('#infoId').html('고객님의 아이디는 :' + resp + '입니다.');
					}
				}
			})
		})
	})*/
</script>
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
	<div class="box-wrap">
					<div class="container" style="margin: auto; text-align: center;">
				<div class="col-md-8 col-md-offset-2 animate-box">
					<div class="title-align" >
						<h3>아이디 찾기</h3>
						<!-- table 형태로 수정 -->
						<form action="findId" method="post">
							<table style="margin: auto;">
								<tr>
									<td><c:if test="${idResult == 'fail'}">
											<div class="alert alert-info alert-dismissable fade in">
												<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>Fail!</strong> 이름이나 전화번호를 다시 확인해주세요.
											</div>
										</c:if></td>
								</tr>
								<tr>
									<th>이름을 적어주세요.</th>
								</tr>
								<tr>
									<td><input type="text" id="member_name" name="member_name" class="form-control" size="60" width="50"></td>
								</tr>
								<tr>
									<th>핸드폰 번호를 적어주세요.</th>
								</tr>
								<tr>
									<td><input type="text" id="member_phone" name="member_phone" class="form-control" size="60" width="50"></td>
								</tr>
							</table>
							<br> <input type="submit" id="submitId" class="btn btn-primary" value="아이디 찾기">
							<input type="button" id="gohome" class="btn btn-primary" value="홈으로" onclick="location.href=${pageContext.request.contextPath}/">
							<div id="infoId"></div>
						</form>

						<br><hr > <br>
						<div>
						<h3>비밀번호 찾기</h3>
						<form action="findEmail" method="post" style="margin: auto;">
							<table style="margin: auto;">
								<tr>
									<td><c:if test="${findResult == 'fail'}">
											<div class="alert alert-info alert-dismissable fade in">
												<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> 
												<strong>Fail!</strong> 이메일이나 비밀번호 질문, 답을 다시 확인해주세요.
											</div>
										</c:if> <br></td>
								</tr>
								<tr>
									<th>ID를 입력해주세요.</th>
								</tr>
								<tr>
									<td><input type="text" id="member_id" name="member_id" class="form-control" size="60" width="50" required>
									</td>
								</tr>
								<tr>
									<th>비밀번호 찾기 질문</th>
								</tr>
								<tr>
									<td><select id="member_password_check_q" name="member_password_check_q" class="form-control">
											<option selected="selected" value="">선택</option>
											<option value="1">중학교 선생님 이름?</option>
											<option value='2'>나의 별명은?</option>
									</select></td>
								</tr>

								<tr>
									<th>비밀전호 찾기 답</th>
								</tr>
								<tr>
									<td><input type="text" id="member_password_check_a" name="member_password_check_a" class="form-control" required></td>
								</tr>
							</table>
							<br> <input type="submit" id="submit" class="btn btn-primary" value="비밀번호찾기">
							<input type="button" id="gohome" class="btn btn-primary" value="홈으로" onclick="location.href=${pageContext.request.contextPath}/">
						</form>
						</div>
					</div>
				</div>
			</div>

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