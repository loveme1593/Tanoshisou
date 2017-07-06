<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>사진첩</title>
<!-- JQuery 와 Bootstrap -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Free HTML5 Template by FREEHTML5.CO" />
<meta name="keywords"
	content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
<meta name="author" content="FREEHTML5.CO" />
<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicons/favicon.ico">

<link
	href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,300,700|Roboto:300,400'
	rel='stylesheet' type='text/css'>
<!-- Animate.css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/animate.css">
<!-- Icomoon Icon Fonts-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/icomoon.css">
<!-- Bootstrap  -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">


<!-- Modernizr JS -->
<script
	src="${pageContext.request.contextPath}/resources/js/modernizr-2.6.2.min.js"></script>
<!-- FOR IE9 below -->
<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

<script>
	function toInsert() {
		location.href = "${pageContext.request.contextPath}/photo/insertPhoto";
	}
</script>
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
					<li><a
						href="${pageContext.request.contextPath}/recommend/">House
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
				test="${loginInfo.member_type=='General' and loginInfo.member_belongto=='없음'}">
				<li><a class="verticalNav" href="#"> <img
						src="${pageContext.request.contextPath}/resources/images/applyto-icon.png"
						alt="홈으로" width="30" align=left id="movein"
						houseid="${houseInfo.house_id}"> 입주신청
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
				<li><a class="verticalNav"
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
				<li><a class="verticalNav active"
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
		<!-- contents -->
		<section id="intro">
			<div class="container">
				<div class="row">
					<div style="margin-left: 15%; padding: 1px 16px;">
						<div class="intro animate-box">
							<!-- section 안에 내용을 넣고 위에 것으로 인클루드 시키면 쉬움  -->
							<section id="content">
								<br>
								<h3>사진첩</h3>
								<button class="write-btn" onclick="toInsert()"
									style="vertical-align: middle">
									<span>글쓰기</span>
								</button>
								<table class="table table-hover">
									<tr>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
										<th>작성일</th>
									</tr>
									<c:forEach var="photos" items="${photos }">
										<tr>
											<td><a
												href="${pageContext.request.contextPath}/photo/getPhoto?board_id=${photos.board_id }">
													${photos.board_content}의일상::${photos.board_title } </a><span
												class="badge">${photos.board_reply_num }</span> <c:if
													test="${photos.board_hits<=10 }">
													<span class="label label-danger">New</span>
												</c:if></td>
											<td>${photos.board_nickname }</td>
											<td>${photos.board_hits }</td>
											<td>${photos.board_inputdate }</td>
										</tr>
										<tr>
											<td colspan="4"><c:if
													test="${thumbnails[photos.board_id].size()<=4 }">
													<c:forEach var="thumbnails"
														items="${thumbnails[photos.board_id] }">
														<img
															src="${pageContext.request.contextPath}/photo/download?board_file_id=${thumbnails}"
															border=0>
													</c:forEach>
												</c:if> <c:if test="${thumbnails[photos.board_id].size()>4 }">
													<img
														src="${pageContext.request.contextPath}/photo/download?board_file_id=${thumbnails[photos.board_id].get(0) }"
														border=0>
													<img
														src="${pageContext.request.contextPath}/photo/download?board_file_id=${thumbnails[photos.board_id].get(1) }"
														border=0>
													<img
														src="${pageContext.request.contextPath}/photo/download?board_file_id=${thumbnails[photos.board_id].get(2) }"
														border=0>
													<img
														src="${pageContext.request.contextPath}/photo/download?board_file_id=${thumbnails[photos.board_id].get(3) }"
														border=0>
												</c:if></td>
										</tr>
									</c:forEach>
								</table>

								<div class="paginationIndex">
									<a href="${pageContext.request.contextPath}/photo?page=${curpage-1}">&laquo;</a>
									<c:forEach var="curpage" begin="1" end="${totalPage }">
										<c:if test="${page==curpage }">
											<a class="active" href="${pageContext.request.contextPath}/photo?page=${curpage}">${curpage}</a>
										</c:if>
										<c:if test="${page!=curpage }">
											<a href="${pageContext.request.contextPath}/photo?page=${curpage}">${curpage}</a>
										</c:if>
									</c:forEach>
									<a href="${pageContext.request.contextPath}/photo?page=${curpage+1}">&raquo;</a>
								</div>
					
								<script
									src="${pageContext.request.contextPath}/resources/js/jquery.easing.1.3.js"></script>
								<!-- Bootstrap -->
								<script
									src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
								<!-- Waypoints -->
								<script
									src="${pageContext.request.contextPath}/resources/js/jquery.waypoints.min.js"></script>
								<!-- Main JS (Do not remove) -->
								<script
									src="${pageContext.request.contextPath}/resources/js/main.js"></script>
							</section>
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
								<small>&copy; 楽し荘. All Rights Reserved.</small>
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
</body>
</html>