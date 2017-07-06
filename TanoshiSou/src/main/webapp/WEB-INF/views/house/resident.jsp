<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쉐어하우스 입주자 관리</title>
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
<script type="text/javascript">
	$(function() {
		$("a.accept").on('click', acceptMember);
		$("a.decline").on('click', declineMember);
		$("a.member").on('click', showPopup);
		$("a.leave").on('click', leaveMember);
	});
	function acceptMember() {
		var item =$(this).parent().parent().children("td:eq(0)").children("span").attr("pendingId");
		if (confirm('수락하시겠습니까?')) {
			$.ajax({
				method : "post",
				url : "${pageContext.request.contextPath}/resident/grant",
				data : {
					"member_id" : item
				},
				success : function(resp) {
					if (resp == "success") {
						alert('입주 수락 완료');
						location.href = './';
					} else
						alert('실패');
				}
			});
			//$('#form').submit();
		}
	}
	function declineMember() {
		var item =$(this).parent().parent().children("td:eq(0)").children("span").attr("pendingId");
		if (confirm('거절하시겠습니까?')) {
			$.ajax({
				method : "post",
				url : "${pageContext.request.contextPath}/resident/decline",
				data : {
					"member_id" : item
				},
				success : function(resp) {
					if (resp == "success") {
						alert('입주 거절 완료');
						location.href = './';
					} else
						alert('실패');
				}
			});
		
		}
	}
	function insertHouse() {
		window.open('${pageContext.request.contextPath}/house/insert',
				'insert', 'width=500,height=500,left=200,top=200');
	}

	// 회원 정보 띄우기
	function showPopup() {
		var id = $(this).text();
		$.ajax({
					method : 'get',
					url : '${pageContext.request.contextPath}/member/ShowProfile',
					data : {
						'id' : id
					},
					success : function(resp) {
						if (resp != null) {
							var content = '<span class="dialog__close">&#x2715;</span><div class="dialog__content"><table>';
							content += '<tr><td><h4 class="dialog__title">회원정보</h4></td><td style="border-bottom: 1px solid #ccc;" ></td></tr>';
							content += '<tr><th>프로필 사진</th><td>';
							content += '<img src="${pageContext.request.contextPath}/member/getPhoto?file_id='
									+ resp.memberP.member_file_id
									+ '"width="100" height="150" onError="javascript:this.src=\'${pageContext.request.contextPath}/resources/images/person-icon.png\'"'
									+ '" /></td></tr>';
							content += '<tr><th>이름</th><td>'
									+ resp.memberA.member_name
									+ '</td></tr><tr><th>아이디</th><td>'
									+ resp.memberA.member_id + '</td>';
							content += '</tr><tr><th>전화번호</th><td>'
									+ resp.memberA.member_phone
									+ '</td></tr><tr>';
							content += '<th>이메일</th><td>'
									+ resp.memberA.member_email
									+ '</td></tr><tr>';
									content += '<th>성별</th><td>';
								if(resp.memberD.detail_gender=='Male')
									content += "남자";
								else
									content += "여자";	
							content += '</td></tr><tr><th>직업</th><td> ';
									if(resp.memberD.detail_job_title == null)
										content += '미등록';
									else content += resp.memberD.detail_job_title;
							content += '</td></tr><tr><th>생일 </th><td> ';
									if(resp.memberD.detail_birthday == null)
										content += '미등록';
									else content += resp.memberD.detail_birthday;
							content += '</td></tr><tr><th>취미</th><td> ';
									if(resp.memberD.detail_hobby==null)
										content += '미등록';
									else content += resp.memberD.detail_hobby;
							content += '</td></tr><tr><th>혈액형</th><td> ';
									if(resp.memberD.detail_bloodtype==null)
										content += '미등록';
									else content += resp.memberD.detail_bloodtype;
							content += '</td></tr><tr><th>개인성</th><td> ';
									if(resp.memberD.score_personal==0)
										content += '미등록';
									else content += resp.memberD.score_personal;
							content += '</td></tr><tr><th>청결도</th><td> ';
									if(resp.memberD.score_clean==0)
										content += '미등록';
									else content+= resp.memberD.score_clean;
							content += '</td></tr><tr><th>적극성</th><td> ';
									if(resp.memberD.score_active==0)
										content += '미등록';
									else content +=resp.memberD.score_active;
							content += '</td></tr><tr><th>종교</th><td> ';
									if(resp.memberD.detail_religion==null)
										content += '미등록';
									else content += resp.memberD.detail_religion;
							content += '</td></tr><tr><th>자기소개</th><td> ';
									if(resp.memberD.detail_introduce==null)
										content += '미등록';
									else content += resp.memberD.detail_introduce;
							content +='</td></tr></table></div>';

							var dialog = $('#dialog').html(content);

							var dialogBox = $('.dialog'), dialogTrigger = $('#memberShow'), dialogClose = $('.dialog__close'), dialogTitle = $('.dialog__title'), dialogContent = $('.dialog__content');
							// Open the dialog
							/*   dialogTrigger.on('click', function(e) { */
							dialogBox.toggleClass('dialog--active');
							/* e.stopPropagation(); */
							/* }); */

							// Close the dialog - click close button
							dialogClose.on('click', function() {
								dialogBox.removeClass('dialog--active');
							});

							// Close the dialog - press escape key // key#27
							$(document).keyup(function(e) {
								if (e.keyCode === 27) {
									dialogBox.removeClass('dialog--active');
								}
							});
							// Close dialog - click outside
							$(document)
									.on(
											"click",
											function(e) {
												if ($(e.target).is(dialogBox) === false
														&& $(e.target).is(
																dialogTitle) === false
														&& $(e.target).is(
																dialogContent) === false) {
													dialogBox
															.removeClass("dialog--active");
												}
											});
						}
					}
				})
	}
	function leaveMember() {
		var item = $(this).attr('residentId');
		if (confirm('이 입주자를 퇴거시키겠습니까?')) {
			$.ajax({
				method : "post",
				url : "${pageContext.request.contextPath}/resident/leave",
				data : {
					"member_id" : item
				},
				success : function(resp) {
					if (resp == "success") {
						alert('퇴거가 완료되었습니다');
						location.href = './';
					} else
						alert('실패');
				}
			});
		
		}
	}
</script>
<style type="text/css">
table {
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1;
	border-top: 1px solid #ccc;
}

table th {
	width: 150px;
	padding: 5px;
	font-weight: bold;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
	background: #efefef;
	vertical-align: middle;
}

table td {
	width: 300px;
	padding: 5px;
	vertical-align: middle;
	border-bottom: 1px solid #ccc;
}

.dialog {
	box-sizing: border-box;
}

.dialog {
	background: #f1f1f1;
	color: #333333;
	font-family: 'Cairo', sans-serif;
	font-size: 10px;
	height: 100vh;
	display: -webkit-box;
	display: -webkit-flex;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-align: center;
	-webkit-align-items: center;
	-ms-flex-align: center;
	align-items: center;
	-webkit-box-pack: center;
	-webkit-justify-content: center;
	-ms-flex-pack: center;
	justify-content: center;
}

#memberShow {
	font-size: 1.1rem;
	text-transform: uppercase;
	display: block;
	-webkit-transition: all 150ms ease-out;
	transition: all 150ms ease-out;
	-webkit-transform: translateY(0px);
	transform: translateY(0px);
}

#memberShow:focus {
	outline: 0;
}

#memberShow:active {
	-webkit-transform: translateY(-3px);
	transform: translateY(-3px);
}

.dialog {
	background: white;
	width: 45%;
	height: 85%;
	position: absolute;
	left: calc(65% - 35%);
	top: 0;
	padding: 30px;
	box-shadow: 0 10px 30px rgba(51, 51, 51, 0.4);
	border: 3px solid #333333;
	visibility: hidden;
	opacity: 0;
	-webkit-transition: all 180ms ease-in;
	transition: all 180ms ease-in;
}

@media ( max-width : 600px) {
	.dialog {
		width: 90%;
		left: calc(50% - 45%);
	}
}

.dialog.dialog--active {
	top: 20%;
	visibility: visible;
	opacity: 1;
	-webkit-transition: all 250ms ease-out;
	transition: all 250ms ease-out;
}

.dialog .dialog__close {
	font-size: 2rem;
	line-height: 2rem;
	position: absolute;
	right: 15px;
	top: 15px;
	cursor: pointer;
	padding: 15px;
	-webkit-transition: color 150ms ease;
	transition: color 150ms ease;
}

.dialog .dialog__close:hover {
	color: #E74C3C;
}

.dialog .dialog__content {
	font-size: 1.1rem;
	line-height: 2rem;
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
			<li><a class="verticalNav "
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
				<li><a class="verticalNav active"
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
		</ul>
		<section id="intro">
			<div class="container">
				<div class="row">
					<div style="margin-left: 15%; padding: 1px 16px; height: 1000px;">
						<div class="intro animate-box">
							<!-- section 안에 내용을 넣고 위에 것으로 인클루드 시키면 쉬움  -->
							<section id="content">
								<br>
								<h3>${loginInfo.member_belongto}의&nbsp;입주자&nbsp;관리</h3>
								현재 입주 신청자
								<div>
									<!-- table 형태로 바꾸겠음 -->
									<table class="table table-hover">
										<tr>
											<th>멤버ID</th>
											<th>멤버이름</th>
											<th>수락여부</th>
										</tr>
										<c:forEach var="member" items="${pendingMembers}">
											<tr>
												<td><span id="pendingAccept" pendingId="${member.member_id }"> 
												<a href="#" id="memberShow" class=member>${member.member_id }</a></span></td>
												<td>${member.member_name }</td>
												<td><a href="#" class="accept">수락</a>
												| <a href="#" class="decline">거절</a></td>
											</tr>
										</c:forEach>
									</table>
									<br>
									<!-- 기존 거주자 -->
									<h3>${loginInfo.member_belongto}의&nbsp;기존거주자&nbsp;관리</h3>
									기존 거주자
									<table class="table table-hover">
										<tr>
											<th>멤버ID</th>
											<th>멤버이름</th>
											<th>기타</th>
										</tr>
										<c:forEach var="member" items="${residents }">
											<tr>
												<td><span id="residents"> <a href="#"
														id="memberShow" class=member>${member.member_id }</a></span></td>
												<td>${member.member_name }</td>
												<td><a href="#" class="leave" residentId="${member.member_id}">퇴거</a></td>
											</tr>
										</c:forEach>
									</table>
								</div>
								<form id="form" action="member/showProfile" method="get">
									<input type="hidden" name="id">
								</form>
							</section>
							<div class="dialog" id="dialog"></div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<!-- end row -->

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