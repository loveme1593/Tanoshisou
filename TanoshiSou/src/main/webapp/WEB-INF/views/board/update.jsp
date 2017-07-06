<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Free HTML5 Template by FREEHTML5.CO" />
<meta name="keywords"
	content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
<meta name="author" content="FREEHTML5.CO" />

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

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
	charset="utf-8"></script>
<title>[ 게시글 수정 ]</title>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script>
	$(function() {
		var board_title = document.getElementById("board_title");
		board_title.focus();
		/* 에디터부분 */
		var oEditors = [];
		nhn.husky.EZCreator
				.createInIFrame({
					oAppRef : oEditors,
					elPlaceHolder : "board_content",
					sSkinURI : "${pageContext.request.contextPath}/resources/se2/SmartEditor2Skin.html",
					fCreator : "createSEditor2"

				});
		$("#updateBoardB").click(
				function() {
					oEditors.getById["board_content"].exec(
							"UPDATE_CONTENTS_FIELD", []);
					updateBoard();
				});
		/* 에디터부분 */
		function toList() {
			location.href = "${pageContext.request.contextPath}/board";
		}
		function updateBoard() {
			$
					.ajax({
						method : "post",
						url : "updateBoard",
						data : {
							"board_id" : $('#board_id').val(),
							"board_title" : $('#board_title').val(),
							"board_content" : $('#board_content').val()
						},
						success : function() {
							alert('성공적으로 수정되었습니다.');
							location.href = "${pageContext.request.contextPath}/board?category=${category}";
						}
					});
		}
	})
</script>
<style>
th, td {
	padding: 10;
	height:60px;
}
#table {
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
}

#table th {
	width: 200px;
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
	background: #efefef;
}

#table td {
	width: 700px;
	padding: 10px;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
}

#tablewrap {
	text-align: right;
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
	<div class="box-wrap">
		<!-- navi bar -->
		<ul class="verticalNav">
			<li><a class="verticalNav"
				href="${pageContext.request.contextPath}/house/?id=${loginInfo.member_belongto}">
					<img
					src="${pageContext.request.contextPath}/resources/images/home-icon.png"
					alt="홈으로" width="30" align=left> Home
			</a></li>
			<c:if
				test="${loginInfo.member_type=='General' and loginInfo.member_belongto=='General'}">
				<li><a class="verticalNav"
					href="${pageContext.request.contextPath}/house/apply"> <img
						src="${pageContext.request.contextPath}/resources/images/applyto-icon.png"
						alt="홈으로" width="30" align=left> 입주신청
				</a></li>
			</c:if>
			<c:if
				test="${loginInfo.member_type!='General'&&loginInfo.member_type!='Pending' && loginInfo.member_belongto==houseInfo.house_id }">
				<c:if test="${category=='notice' }">
					<li><a class="verticalNav"
						href="${pageContext.request.contextPath}/board/?category=notice&page=1">
							<img
							src="${pageContext.request.contextPath}/resources/images/notice-icon.png"
							alt="공지사항" width="30" align=left> 공지사항
					</a></li>
				</c:if>
				<c:if test="${category!='notice' }">
					<li><a class="verticalNav"
						href="${pageContext.request.contextPath}/board/?category=notice&page=1">
							<img
							src="${pageContext.request.contextPath}/resources/images/notice-icon.png"
							alt="공지사항" width="30" align=left>공지사항
					</a></li>
				</c:if>
				<c:if test="${loginInfo.member_type=='Host' }">
					<li><a class="verticalNav"
						href="${pageContext.request.contextPath}/resident/"> <img
							src="${pageContext.request.contextPath}/resources/images/resident-icon.png"
							alt="공지사항" width="30" align=left> 입주자 관리
					</a></li>
				</c:if>
				<li><a class="verticalNav "
					href="${pageContext.request.contextPath}/payment/"> <img
						src="${pageContext.request.contextPath}/resources/images/payment-icon.png"
						alt="공지사항" width="30" align=left> 운영비 관리
				</a></li>
				<li><a class="verticalNav"
					href="${pageContext.request.contextPath}/planning/"><img
						src="${pageContext.request.contextPath}/resources/images/calendar-icon.png"
						alt="일정" width="30" align=left>일정 관리</a></li>
				<c:if test="${category=='free' }">
					<li><a class="verticalNav active"
						href="${pageContext.request.contextPath}/board/?category=free&page=1">
							<img
							src="${pageContext.request.contextPath}/resources/images/freeboard-icon.png"
							alt="일정" width="30" align=left> 자유게시판
					</a></li>
				</c:if>
				<c:if test="${category!='free' }">
					<li><a class="verticalNav"
						href="${pageContext.request.contextPath}/board/?category=free&page=1">
							<img
							src="${pageContext.request.contextPath}/resources/images/freeboard-icon.png"
							alt="일정" width="30" align=left> 자유게시판
					</a></li>
				</c:if>
				<li><a class="verticalNav"
					href="${pageContext.request.contextPath}/photo/"><img
						src="${pageContext.request.contextPath}/resources/images/photo-icon.png"
						alt="일정" width="30" align=left>사진첩</a></li>
				<c:if test="${category!='vote' }">
					<li><a class="verticalNav"
						href="${pageContext.request.contextPath}/board/?category=vote&page=1">
							<img
							src="${pageContext.request.contextPath}/resources/images/vote-icon.png"
							alt="일정" width="30" align=left> 투표게시판
					</a></li>
				</c:if>
				<c:if test="${category=='vote' }">
					<li><a class="verticalNav active"
						href="${pageContext.request.contextPath}/board/?category=vote&page=1">
							<img
							src="${pageContext.request.contextPath}/resources/images/vote-icon.png"
							alt="일정" width="30" align=left> 투표게시판
					</a></li>
				</c:if>
			</c:if>
		</ul>
		<div class="box-wrap">
			<!-- contents -->
			<section id="intro">
				<div class="container">
					<div class="row">
						<div style="margin-left: 15%; padding: 1px 16px; height: 1000px;">
							<div class="intro animate-box">
								<!-- section 안에 내용을 넣고 위에 것으로 인클루드 시키면 쉬움  -->
								<section id="content">
								<h3>게시물 수정</h3>
									<input type="hidden" id="board_id" name="board_id"
										value="${boards.board_id }">
									<table id="table">
										<tr>
											<th>작성인</th>
											<td>${boards.board_nickname}</td>
										</tr>
										<tr>
											<th>작성 날짜</th>
											<td>${boards.board_inputdate}</td>
										</tr>
										<tr>
											<th>글 제목</th>
											<td><input type="text" style="width: 750px;"
												id="board_title" name="board_title"
												value="${boards.board_title}"></td>
										</tr>
										<tr>
											<th >내용</th>
											<td style="height: 450px;"><textArea rows="15" cols="62" style="width: 748px; height: 450px;"
													id="board_content" name="board_content" required>${boards.board_content}</textArea></td>
										</tr>
										<tr style="text-align: center;">
											<td colspan="2"><input type="button" class="btn btn-primary" id="updateBoardB" value="수정">
											<input type="button" class="btn btn-primary" id="cancleUP" value="취소" onclick="history.back()"></td>
										</tr>
									</table>
								</section>
							</div>
						</div>
					</div>
					<div class="clearfix"></div><hr >
								<%@ include file="../footer.jsp" %>
				</div>
			</section>
		</div>

	</div>
</body>
<!-- END: box-wrap -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<!-- jQuery Easing -->
<script src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<!-- Waypoints -->
<script
	src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>

<!-- Main JS (Do not remove) -->
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</html>