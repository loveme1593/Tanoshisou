<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
	charset="utf-8"></script>
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
<title>${houseInfo.house_name}</title>

<!-- Modernizr JS -->
<script
	src="${pageContext.request.contextPath}/resources/js/modernizr-2.6.2.min.js"></script>
<!-- FOR IE9 below -->
<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[ 글쓰기 ]</title>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script>
	$(function() {
		var oEditors = [];
		var board_contentWithEditor;
		nhn.husky.EZCreator
				.createInIFrame({
					oAppRef : oEditors,
					elPlaceHolder : "board_content",
					sSkinURI : "${pageContext.request.contextPath}/resources/se2/SmartEditor2Skin.html",
					htParams : {
						bUseToolbar : true,
						bUseVerticalResizer : true,
						bUseModeChanger : true,
						fOnBeforeUnload : function() {
						}
					},
					fCreator : "createSEditor2"
				});
		/*-------------------------에디터에서 디비로 저장  */
		$("#insertBoard").click(
				function() {
					oEditors.getById["board_content"].exec(
							"UPDATE_CONTENTS_FIELD", []);
					insertBoard();
				});
		/*-------------------------에디터에서 디비로 저장  */
		$('#back').on('click', back);
		function back() {
			history.back();
		}
		function insertBoard() {
			//글 등록
			$
					.ajax({
						method : "post",
						url : "insertBoard",
						data : {
							"board_category" : $("#board_category").val(),
							"board_title" : $("#board_title").val(),
							// 텍스트 에어리어에서 값 끌고 와서 저장
							"board_content" : $("#board_content").val(),
						},
						success : function(board_id) {
							//게시글 등록 시 category가 vote라면 vote 등록까지 실행
							//투표글일 때 투표글 등록
							if ("${category}" == 'vote') {
								$
										.ajax({
											method : "post",
											url : "${pageContext.request.contextPath}/voteSave",
											data : {
												"data_type" : "board",
												"pid" : board_id,
												// 텍스트 에어리어에서 값 끌고 와서 저장
												"votetitle" : $('#votetitle')
														.val(),
												//글 쓰는 사람의 경우 아무런 선택도 하지 않음
												"decision" : "default"
											},
											success : function() {
												alert('글이 성공적으로 등록되었습니다.');
												location.href = "${pageContext.request.contextPath}/board?category=${category}";
											}
										});
							} else {
								//게시글 타입이 vote가 아닐 경우	
								alert('글이 성공적으로 등록되었습니다.');
								location.href = "${pageContext.request.contextPath}/board?category=${category}";
							}
						}
					});

		}
		function toList() {
			location.href = "${pageContext.request.contextPath}/board?category=${category}";
		}

	});
</script>
<style>
select {
	width: 15%;
	height: 36px;
	padding: 5px 10px;
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
}

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
	vertical-align:super;
	border-bottom: 1px solid #ccc;
	background: #efefef;
	
}

#table td {
	width: 700px;
	padding: 10px;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
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
					<li><a class="verticalNav active"
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

		<!-- contents -->
		<section id="intro">
			<div class="container">
				<div class="row">
					<div style="margin-left: 15%; padding: 1px 16px;">
						<div class="intro animate-box">
							<!-- section 안에 내용을 넣고 위에 것으로 인클루드 시키면 쉬움  -->
							<section id="content">
								<h2>글쓰기</h2>
								<input type="hidden" id="board_id" name="board_id"
									value="${boards.board_id }">
								<table id="table">
									<tr>
										<th>글 분류</th>
										<td><select id="board_category">
												<c:if test="${member_type=='Host'&&category=='notice' }">
													<option value="notice">공지</option>
												</c:if>
												<c:if test="${category=='free' }">
													<option value="free">자유</option>
												</c:if>
												<c:if test="${category=='vote' }">
													<option value="vote">투표</option>
												</c:if>
										</select>
											<div id="contents"></div></td>
									</tr>
									<tr>
										<th>글 제목</th>
										<td><input type="text" style="width:750px;" id="board_title" name="board_title"></td>
									</tr>
									<c:if test="${category=='vote' }">
										<tr>
											<th>투표 제목</th>
											<td><input type="text" style="width: 750px;"
												id="votetitle" name="votetitle"></td>
										</tr>
									</c:if>
									<tr>
										<th>내용</th>
										<td style="height: 450px;"><textArea rows="10" cols="55" style="width: 748px; height: 450px;"
												id="board_content" name="board_content"></textArea></td>
									</tr>
								</table>
								<br>
								<div style="text-align: center;">
									<input type="button" class="write-btn" id="insertBoard"
										name="insertBoardS" value="등록"> <input type="button"
										class="write-btn" value="취소" id="back" name="back">
								</div>
								<div class="clearfix"></div>
							</section>
						</div>
					</div>
				</div>
				<div class="clearfix"></div><hr>
								<%@ include file="../footer.jsp" %>
			</div>
		</section>
	</div>
</body>

<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<!-- jQuery Easing -->
<script src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<!-- Waypoints -->
<script
	src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>

<!-- Main JS (Do not remove) -->
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</html>