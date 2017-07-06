<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>하우스 수정하기</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		checkOptions();
	});
	function proFileShow() {
		$("#files").on('change',function() {
							var fileList = this.files;
								$('#input').html("");
							for (var i = 0; i < fileList.length; i++) {
								var t = window.URL || window.webkitURL;
								var objectUrl = t.createObjectURL(fileList[i]);
								$('#input').append("<img src=" + objectUrl + " style='width:150px; height:200px;' />");
								j = i + 1;
							}
							if (j % 4 == 0) {
								$('#input').append('<br>');
							}
						});
	}

	var vaildArray = [ 'jpg', 'png', 'gif' ];
	$(document).ready(function() {
		$("#goJuso").on('click', goPopup);
	});
	function goPopup() { // 주소검색을 수행할 팝업 페이지를 호출합니다. 소스 경로는 사용자 시스템에 맞게 수정하시기 바람니다. 	
		var pop = window.open(
				"${pageContext.request.contextPath}/house/jusoPopup", "pop",
				"width=700,height=650, scrollbars=yes, resizable=yes");
	}
	function checkOptions() {
		var str = "${house.house_option}";
		var options = str.split(",");
		var checkBoxes = $("input[name=house_option]")
		$(options).each(function(i, option) {
			$(checkBoxes).each(function(i2, box) {
				if (option == box.value)
					box.checked = true;
			});
		});
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
		<!-- END: header -->
		<section id="intro">
			<div class="container">
				<div class="row">
					<div
						class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
						<div class="intro animate-box">
							<h2>하우스 정보 수정</h2>
							<c:if test="${!empty result&&result=='success' }">
								<div class="alert alert-info">
									<strong>Success! </strong> 하우스 정보 수정에 성공하였습니다.
								</div>
							</c:if>
							<form method="post" action="update" enctype="multipart/form-data">
								<table class="table table-hover">
									<tr>
										<td>하우스 아이디</td>
										<td>${house.house_id}<input type=hidden name="house_id"
											class="reply_text" id="house_id" value="${house.house_id}"></td>
									</tr>
									<tr>
										<td>하우스 이름</td>
										<td><input type="text" name="house_name" id="house_name"
											class="reply_text" value="${house.house_name}"></td>
									</tr>
									<tr>
										<td>하우스 주소</td>
										<td><input type="text" name="house_address"
											id="house_address" value="${house.house_address}"
											class="reply_text"> <input type=button id="goJuso"
											class="button-input" value="검색"></td>
									</tr>
									<tr>
										<td>하우스 전화번호</td>
										<td><input type="text" id="house_phone"
											name="house_phone" class="reply_text"
											value="${house.house_phone}"></td>
									</tr>
									<tr>
										<td>하우스 방 갯수</td>
										<td><input type="text" id="house_available_room"
											name="house_available_room" class="reply_text"
											value="${house.house_available_room}"></td>
									</tr>
									<tr>
										<td>하우스 평균 면적(㎡)</td>
										<td><input type="text" id="house_area"
											name="house_area" class="reply_text"
											value="${house.house_area}"></td>
									</tr>
									<tr>
										<td>하우스 소개글</td>
										<!-- <td><input type="text" id="house_introduce"
											name="house_introduce" value="${house.house_introduce}"></td> -->
										<td><textArea id="house_introduce" name="house_introduce">${house.house_introduce }</textArea></td>
									</tr>
									<tr>
										<td>하우스 주인 이메일</td>
										<td><input type="text" id="house_available_email"
											name="house_available_email" class="reply_text"
											value="${house.house_available_email}"></td>
									</tr>
									<tr>
										<td>하우스 소개 사진</td>
										<td>업로드 가능한 확장자는 <script>
											document.write(vaildArray
													.join(", "));
										</script> 입니다.<br> <c:if test="${not empty house.house_file_id}">
												<a href="getImage?id=${house.house_id}">${house.house_upload_file_name}</a>
												<input type="hidden" name="${house.house_file_id}">
											</c:if> <input type=file name="files" id="files" multiple="multiple"
											onclick="proFileShow()">
										</td>
									</tr>
									<tr>
										<td>하우스 옵션</td>
										<td><input type="checkbox" id="pet" name="house_option"
											value="pet">애완동물 가능&nbsp;&nbsp; <input
											type="checkbox" id="parkingLot" name="house_option"
											value="parkingLot">주차 가능&nbsp;&nbsp; <input
											type="checkbox" id="onlyWoman" name="house_option"
											value="onlyWoman">여성&nbsp;전용&nbsp; <br> <input
											type="checkbox" id="onlyMan" name="house_option"
											value="onlyMan">남성&nbsp;전용
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="checkbox" id="noSmoker" name="house_option"
											value="noSmoker">금연&nbsp;&nbsp; <input
											type="checkbox" id="house_option" name="house_option"
											value="noDrink">금주&nbsp;&nbsp; <input type="checkbox"
											id="study" name="house_option" value="study">스터디&nbsp;그룹
											<input type="checkbox" id="house_option" name="house_option" value="WiFi">WiFi
											</td>
									</tr>
									<tr>
										<td colspan="2" id="input"></td>
									</tr>
								</table>
								<input type="submit" value="수정" class="button-input">
							</form>
						</div>
					</div>
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
	</div>
	<!-- END: box-wrap -->

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