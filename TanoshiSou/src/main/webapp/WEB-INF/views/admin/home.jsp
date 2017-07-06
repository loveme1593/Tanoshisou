<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>楽し荘</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	//내용수정시 꼭 디버깅해주세요-문경
	$(function() {
		init();
	});
	function init() {
		$.ajax({
			method : "post",
			success : list,
			url : "${pageContext.request.contextPath}/admin/getHouses"
		});
	}

	function list(house) {
		//변수명 수정, button이 아닌 a태그로 연결
		var list = "";
		var tableHeader = "<div class='col-md-15'><table class='table-hover'><tr><!--<th>아이디</th>--><th>이름</th><th>주소</th><th>전화번호</th><th style='width:100px;'>가능한 방</th><th>집 소개</th><th>이메일</th><th>소유자</th><th>상태</th><th>작업</th></tr>";
		list += tableHeader;
		$(house)
				.each(
						function(index, house) {
							list += "<tr>"
							/* list += "<td id='houseHaed'>" + house.house_id + "</td>"; */
							list += "<td><a href='${pageContext.request.contextPath}/house/?id="
									+ house.house_id
									+ "'>"
									+ house.house_name
									+ "</a></td>";
							list += "<td>" + house.house_address + "</td>";
							list += "<td>" + house.house_phone + "</td>";
							list += "<td>" + house.house_available_room
									+ "</td>";
							list += "<td>" + house.house_introduce + "</td>";
							list += "<td>" + house.house_available_email
									+ "</td>";
							list += "<td><a id='ownerinfo' class='ownerinfo' href='#'>"
									+ house.house_owner + "</a></td>";
							list += "<td>" + house.house_status + "</td>";
							list += "<td>";
							if (house.house_status == 'PENDING') {
								list += "<a href='#' class='accept' house_id='"+house.house_id+"' house_owner='"+house.house_owner+"'>수락</a>/";
							}
							list += "<a href='#' class='update' house_id="+house.house_id+">수정</a>";
							list += "/";
							list += "<a href='#' class='delete' house_id="+house.house_id+">삭제</a>";
							list += "</tr>";
						});
		list += "</table></div>";
		$("#page").html(list);
		$(".accept").on('click', acceptHouse);
		$(".update").on('click', updateHouse);
		$(".delete").on('click', deleteHouse);
		$('.ownerinfo').on('click', showPopup);
	}

	// 회원 정보 띄우기
	function showPopup() {
		var id = $(this).text();
		$
				.ajax({
					method : 'get',
					url : '${pageContext.request.contextPath}/member/ShowProfile',
					data : {
						'id' : id
					},
					success : function(resp) {
						if (resp != null) {
							var content = '<span class="dialog__close">&#x2715;</span><div class="dialog__content"><table id="a">';
							content += '<tr><td id="c"><h4 class="dialog__title">회원정보</h4></td><td id="c" style="border-bottom: 1px solid #ccc;" ></td></tr>';
							content += '<tr><th id="b">프로필 사진</th><td id="c">';
							content += '<img src="${pageContext.request.contextPath}/member/getPhoto?file_id='
									+ resp.memberP.member_file_id
									+ '"width="100" height="150" onError="javascript:this.src=\'${pageContext.request.contextPath}/resources/images/person-icon.png\'"'
									+ '" /></td></tr>';
							content += '<tr><th id="b">이름</th><td id="c">'
									+ resp.memberA.member_name
									+ '</td></tr><tr><th id="b">아이디</th><td id="c">'
									+ resp.memberA.member_id + '</td >';
							content += '</tr><tr><th id="b">전화번호</th><td id="c">'
									+ resp.memberA.member_phone
									+ '</td></tr><tr>';
							content += '<th id="b">이메일</th><td id="c">'
									+ resp.memberA.member_email
									+ '</td></tr><tr >';
							content += '<th  id="b">성별</th><td id="c">';
							if (resp.memberD.detail_gender == 'Male')
								content += "남자";
							else
								content += "여자";
							content += '</td></tr><tr><th id="b">직업</th><td id="c"> ';
							if (resp.memberD.detail_job_title == null)
								content += '미등록';
							else
								content += resp.memberD.detail_job_title;
							content += '</td></tr><tr><th id="b">생일 </th><td id="c"> ';
							if (resp.memberD.detail_birthday == null)
								content += '미등록';
							else
								content += resp.memberD.detail_birthday;
							content += '</td></tr><tr><th id="b">취미</th><td id="c"> ';
							if (resp.memberD.detail_hobby == null)
								content += '미등록';
							else
								content += resp.memberD.detail_hobby;
							content += '</td></tr><tr><th id="b">혈액형</th><td id="c"> ';
							if (resp.memberD.detail_bloodtype == null)
								content += '미등록';
							else
								content += resp.memberD.detail_bloodtype;
							content += '</td></tr><tr><th  id="b">개인성</th><td id="c"> ';
							if (resp.memberD.score_personal == 0)
								content += '미등록';
							else
								content += resp.memberD.score_personal;
							content += '</td></tr><tr><th id="b">청결도</th><td id="c"> ';
							if (resp.memberD.score_clean == 0)
								content += '미등록';
							else
								content += resp.memberD.score_clean;
							content += '</td></tr><tr><th id="b">적극성</th><td id="c"> ';
							if (resp.memberD.score_active == 0)
								content += '미등록';
							else
								content += resp.memberD.score_active;
							content += '</td></tr><tr><th id="b">종교</th><td id="c"> ';
							if (resp.memberD.detail_religion == null)
								content += '미등록';
							else
								content += resp.memberD.detail_religion;
							content += '</td></tr><tr><th id="b">자기소개</th><td id="c"> ';
							if (resp.memberD.detail_introduce == null)
								content += '미등록';
							else
								content += resp.memberD.detail_introduce;
							content += '</td></tr></table></div>';

							var dialog = $('#dialog').html(content);

							var dialogBox = $('.dialog'), dialogTrigger = $('#ownerinfo'), dialogClose = $('.dialog__close'), dialogTitle = $('.dialog__title'), dialogContent = $('.dialog__content');
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

	function acceptHouse() {
		var num = $(this).attr('house_id');
		var owner = $(this).attr('house_owner');
		if (confirm('승인하시겠습니까?')) {
			$.ajax({
				url : "${pageContext.request.contextPath}/admin/accept",
				data : {
					"house_id" : num,
					"house_owner" : owner
				},
				type : "post",
				success : function(house) {
					alert(num + "을 승인처리했습니다");
					list(house);
				}
			});
		}
	}
	function deleteHouse() {
		var num = $(this).attr('house_id');
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				url : "${pageContext.request.contextPath}/admin/delete",
				data : {
					"house_id" : num
				},
				type : "post",
				success : function(house) {
					alert(num + "을 삭제했습니다");
					list(house);
				}
			});
		}
	}
	function insertHouse() {
		//그냥 페이지 하나로 빼버림
		location.href = "${pageContext.request.contextPath}/house/insert";
	}
	function updateHouse() {
		var num = $(this).attr('house_id');
		location.href = "${pageContext.request.contextPath}/house/update?id="
				+ num;
	}
</script>
<style type="text/css">
#a {
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1;
	border-top: 1px solid #ccc;
}

table {
	text-align: center;
}

#b {
	width: 150px;
	padding: 5px;
	font-weight: bold;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
	background: #efefef;
	vertical-align: middle;
}

#c {
	width: 300px;
	padding: 5px;
	vertical-align: middle;
	border-bottom: 1px solid #ccc;
}

table {
	border-collapse: separate;
	border-spacing: 1px;
	line-height: 1.5;
	border-top: 1px solid #ccc;
}

table th {
	padding: 10px;
	font-weight: bold;
	vertical-align: middle;
	border-bottom: 1px solid #ccc;
	background: #efefef;
	text-align: center;
}

table td {
	padding: 10px;
	border-bottom: 1px solid #ccc;
	vertical-align: middle;
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

#ownerinfo {
	font-size: 1.1rem;
	text-transform: uppercase;
	display: block;
	-webkit-transition: all 150ms ease-out;
	transition: all 150ms ease-out;
	-webkit-transform: translateY(0px);
	transform: translateY(0px);
}

#ownerinfo:focus {
	outline: 0;
}

#ownerinfo:active {
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
<body style="margin: auto;">
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
							${loginInfo.member_id }님 (${loginInfo.member_type}) <span
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
		<br>
		<h3>ShareHouse Management</h3>
		<br>
		<button class="btn btn-primary" style="vertical-align: middle"
			onclick="insertHouse();">
			<span>생성</span>
		</button>
		<button onclick="location.href ='../'"
			class="btn btn-primary pull-right">돌아가기</button>
		<div id="page"></div>
		<div class="clearfix"></div>
		<hr>
		<%@ include file="../footer.jsp"%>
	</div>
	<div class="dialog" id="dialog"></div>
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