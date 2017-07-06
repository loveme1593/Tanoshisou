<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>쉐어하우스 만들기</title>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	//파일 처리 
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
		$("#house_id").on('focusout', checkID);
		$("#files").on('change', checkFile);
	});
	function insertHouse() {
		var email = $("#house_available_email").val();
		var emailFormat = /\w+@{1}.+/ig;
		if (emailFormat.test(email)) {
			return true;
		} else {
			alert('이메일 주소가 잘못되었습니다!');
			return false;
		}
	}
	function goPopup() { // 주소검색을 수행할 팝업 페이지를 호출합니다. 소스 경로는 사용자 시스템에 맞게 수정하시기 바람니다. 
		//window open 경로 수정
		var pop = window.open(
				"${pageContext.request.contextPath}/house/jusoPopup", "pop",
				"width=700,height=650, scrollbars=yes, resizable=yes");
	}
	function checkID() {
		var id = $("#house_id");
		if (id.val() != '') {
			$.ajax({
				method : "post",
				url : "${pageContext.request.contextPath}/house/checkHouseID",
				data : {
					"house_id" : id.val()
				},
				success : function(result) {
					if (result) {
						$("#idCheckResult").html('사용할 수 있는 ID입니다');
					} else {
						$("#idCheckResult").html('중복된 ID입니다');
						id.val('');
					}
				}
			});
		}
	}
	function checkFile() {
		var ext = $(this).val().substr($(this).val().lastIndexOf('.') + 1)
				.toLowerCase();
		if ($.inArray(ext, vaildArray) == -1)
			alert('잘못된 확장자입니다!');
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

<style>
.centeralize {
	text-align: center;
}

.insertTitle {
	text-align: center;
	font-size: 20px;
	font-weight: bold;
}

.reply-text {
	width: 50%;
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
					<li><a href="${pageContext.request.contextPath}/house/?id=${loginInfo.member_belongto}">My ShareHouse</a></li>
				</c:if>
				<c:if test="${loginInfo.member_type=='Host' }">
					<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#">My ShareHouse 
					<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${pageContext.request.contextPath}/house/update?id=${loginInfo.member_belongto}">하우스 정보 수정</a></li>
							<li><a href="${pageContext.request.contextPath}/house/?id=${loginInfo.member_belongto}">내 쉐어하우스</a></li>
						</ul></li>
				</c:if>
				<c:if test="${loginInfo.member_type=='Manager' }">
					<li><a href="${pageContext.request.contextPath}/admin/">House Management</a></li>
				</c:if>
				<c:if test="${loginInfo.member_type=='General' }">
					<li><a href="${pageContext.request.contextPath}/recommend/">House Recommend</a></li>
				</c:if>
			</ul>
			<c:if test="${empty loginInfo||loginInfo=='fail' }">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="${pageContext.request.contextPath}/member/join">
					<span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
					<li><a href="${pageContext.request.contextPath}/member/login">
					<span class="glyphicon glyphicon-log-in"> </span> Login</a></li>
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
	<div class="box-wrap" style=" margin: auto; text-align: center;" >
		<!-- END: header -->
				<div class="col-md-8 text-center animate-box" style="float: none; margin: auto;">
							<form method="post" action="insert" id="form" enctype="multipart/form-data" onsubmit="return insertHouse();">
								<span class="insertTitle">하우스 생성하기</span>
								<table class="table table-hover">
									<tr>
										<c:if test="${insertResult == 'success'}">
											<td colspan="2">
												<div class="alert alert-info alert-dismissable fade in">
													<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>Success!</strong>
													하우스 등록에 성공했습니다.
												</div>
											</td>
										</c:if>
										<c:if test="${insertResult== 'fail'}">
											<td colspan="2">
												<div class="alert alert-info alert-dismissable fade in">
													<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>Fail!</strong> 하우스
													등록에 실패했습니다.
												</div>
											</td>
										</c:if>
									</tr>
									<tr>
										<th>하우스 아이디</th>
										<td><input type="text" name="house_id" id="house_id" class="reply_text">
											<div id="idCheckResult"></div></td>
									</tr>
									<tr>
										<th>하우스 이름</th>
										<td><input type="text" name="house_name" id="house_name" class="reply_text"></td>
									</tr>
									<tr>
										<th>하우스 주소</th>
										<td><input type="text" name="house_address" id="house_address" disabled="disabled" class="reply_text" placeholder="검색 버튼을 이용해주세요."> 
										<input type=button id="goJuso" value="검색" class="button-input" onclick="goPopup()"></td>
									</tr>
									<tr>
										<th>하우스 전화번호</th>
										<td><input type="text" name="house_phone"
											id="house_phone" class="reply_text"></td>
									</tr>
									<tr>
										<th>하우스 방 갯수</th>
										<td><input type="text" name="house_available_room" id="house_available_room" class="reply_text"></td>
									</tr>
									<tr>
										<th>쉐어 하우스 면적</th>
										<td><input type="text" name="house_area" id="house_area" class="reply_text" placeholder="숫자로 기입해주세요."> <label>㎡</label></td>
									</tr>
									<tr>
										<th>하우스 소개글</th>
										<!-- 변수명은 vo 내의 변수명과 일치시켜주세요(대소문자 구분) 안그러면 값인식이 안됌 -->
										<td><textarea rows="10" cols="30" name="house_introduce" id="house_introduce" class="reply_text"></textarea></td>
									</tr>
									<tr>
										<th>하우스 옵션</th>
										<td><input type="checkbox" id="house_option" name="house_option" value="pet">애완동물 가능&nbsp;&nbsp;
											<input type="checkbox" id="house_option" name="house_option" value="parkinglot">주차 가능&nbsp;&nbsp; 
											<input type="checkbox" id="house_option" name="house_option" value="onlyWoman">여성&nbsp;전용&nbsp; <br> 
											<input type="checkbox" id="house_option" name="house_option" value="onlyMan">남성&nbsp;전용
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="checkbox" id="house_option" name="house_option" value="noSmoker">금연&nbsp;&nbsp; 
											<input type="checkbox" id="house_option" name="house_option" value="noDrink">금주 
											<input type="checkbox" id="house_option" name="house_option" value="study">스터디&nbsp;그룹
											<input type="checkbox" id="house_option" name="house_option" value="WiFi">WiFi
											</td>
									</tr>
									<tr>
										<th>하우스 이메일</th>
										<td><input type="text" name="house_available_email" id="house_available_email" class="reply_text"></td>
									</tr>
									<tr>
										<th>하우스 소개 사진</th>
										<td>업로드 가능한 확장자는 <script>
											document.write(vaildArray.join(", "));
										</script> 입니다.<br> 
										<input type="file" name="files" id="files" multiple="multiple" onclick="proFileShow()">
										</td>
									</tr>
									<tr>
										<td colspan="2" id="input"></td>
									</tr>
								</table>
								<input type="submit" id="submit" value="전송" class="button-input">
								<input type="button" id="home" value="취소" class="button-input" onclick="location.href='${pageContext.request.contextPath}/'">
							</form>
						</div>
					<div class="clearfix"></div><hr>
				<%@ include file="../footer.jsp" %>
					</div>
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