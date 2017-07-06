<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>운영비 작성(관리자용)</title>
<c:set var="date" value="<%=new Date()%>" />
<fmt:formatDate var="yearString" value="${date}" type="date"
	pattern="YYYY" />
<fmt:parseNumber var="thisYear" value="${yearString}" type="number" />
<fmt:formatDate var="monthString" value="${date}" type="date"
	pattern="MM" />
<fmt:parseNumber var="thisMonth" value="${monthString}" type="number" />
<c:set var="lastMonth" value="${thisMonth-1}" />
<!-- 메소드 개요:
1. 해당 쉐어하우스의 거주자를 불러옴
2. 해당 쉐어하우스의 전체 관리비를 불러옴(년월)
3. 쉐어하우스의 관리비 등록/삭제
4. 쉐어하우스의 전체 관리비 내역 엑셀로 출력
5. 이미 등록된 해당 이용자의 관리비 항목을 가져옴
 -->
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
		getPayments();
		getResidents();
		$("#year").change(getPayments);
		$("#month").change(getPayments);
		$("#insert").on('click', insertPayment);
		$("#update").on('click', updatePayment);
		$("#residents").change(getCategory);
		$("#toExcel").on('click', toExcel);
		$("#cancel").on('click', resetValue);
		$("#update").hide();
		$("#cancel").hide();
	});
	function getPayments() {
		var month = $("#month").val();
		var year = $("#year").val();
		var residents = $("#residents").val();
		if (residents != '')
			getCategory();
		$.ajax({
			method : "post",
			url : "get",
			data : {
				"pay_year" : year,
				"pay_month" : month
			},
			success : showPayments
		});
	}
	function showPayments(payments) {
		var text = "";
		var total = 0;
		if (payments == "fail") {
			alert('오류가 발생했습니다!');
			getPayment();
			return;
		}
		text += "<table class='table table-hover'>";
		//추가->테이블 형식으로 변경
		text += "<tr><th>거주자</th><th>분류</th><th>금액</th><th>입력일</th><th>변경</th></tr>";
		$(payments)
				.each(
						function(index, payment) {
							text += "<tr>";
							text += "<td><span class='pay_for' targetid='"+payment.pay_for+"'>";
							text += payment.member_name + "(" + payment.pay_for
									+ ") </td> </span>";
							text += "<td><span class=category>"
									+ payment.pay_category + "</span> </td> ";
							text += "<td><span class=amount>"
									+ payment.pay_amount + "</span> </td> ";
							text += "<td>" + payment.pay_inputdate + "</td>";
							text += "<td><a class='update' href='#' num='"+payment.pay_id+"'>수정</a> / <a href='#' class='delete' num='"+payment.pay_id+"''>삭제</a></td>";
							text += "</tr>";
							total += payment.pay_amount;
						});
		text += "<tr><td colspan='5'>총합: " + total + "</td></tr>";
		text += "</table>";
		$("#result").html(text);
		$("a.update").on('click', setValue);
		$("a.delete").on('click', deletePayment);
	}
	function insertPayment() {
		var month = $("#month").val();
		var year = $("#year").val();
		var pay_for = $("#residents").val();
		var amount = $("#amount").val();
		var category = $("#category").val();
		if (category == '' || amount == 0 || isNaN(amount) || pay_for == '') {
			alert('잘못된 입력입니다!');
			$("#amount").val(0);
			$("#amount").focus();
			return false;
		}
		var data = {
			"pay_category" : category,
			"pay_year" : year,
			"pay_month" : month,
			"pay_amount" : amount,
			"pay_for" : pay_for
		}
		$.ajax({
			method : "post",
			url : "insert",
			data : data,
			success : getPayments
		});
	}
	function deletePayment() {
		var num = $(this).attr('num');
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				method : "post",
				url : "delete",
				data : {
					"pay_id" : num
				},
				success : getPayments
			});
		}
	}
	function setValue() {
		var amount = $(this).parent().children(".amount").text();
		var cat = $(this).parent().children(".category").text();
		var pay_for = $(this).parent().children(".pay_for").attr('targetid');
		var pay_id = $(this).attr('num');
		$("#amount").val(amount);
		$("#category").val(cat).attr('selected', 'selected');
		$("#residents").val(pay_for).attr('selected', 'selected');
		$("#category").attr('disabled', 'true');
		$("#category").css('background-color', 'grey');
		$("#residents").css('background-color', 'grey');
		$("#update").attr('num', pay_id);
		$("#insert").hide();
		$("#update").show();
		$("#cancel").show();
	}
	function resetValue() {
		$("#amount").val(0);
		$("#category").val('').attr('selected', 'selected');
		$("#category").removeAttr('disabled');
		$("#residents").removeAttr('disabled');
		$("#category").css('background-color', '');
		$("#residents").css('background-color', '');
		$("#insert").show();
		$("#update").hide();
		$("#cancel").hide();
	}
	function updatePayment() {
		var num = $(this).attr('num');
		var amount = $("#amount").val();
		var cat = $("#category").val();
		var unpaid = $("#unpaid").val();
		var data = {
			"pay_id" : num,
			"pay_amount" : amount
		}
		if (confirm('수정하시겠습니까?')) {
			$.ajax({
				method : "post",
				url : "update",
				data : data,
				success : getPayments
			});
			$("#insert").show();
			$("#update").hide();
			$("#amount").val('');
			$("#category").val('').attr('selected', 'selected');
			$("#text").val('');
		}
	}
	function toExcel() {
		var month = $("#month").val();
		var year = $("#year").val();
		$("#value1").attr('name', 'year');
		$("#value1").val(year);
		$("#value2").attr('name', 'month');
		$("#value2").val(month);
		$("#form").submit();
	}
	function getResidents() {
		$.ajax({
			method : "post",
			url : "${pageContext.request.contextPath}/member/getResidents",
			data : {
				"house_id" : "${loginInfo.member_belongto}"
			},
			success : listResidents
		});
	}
	function listResidents(result) {
		$("#residents").find("option").remove();
		$(result).each(
				function(index, item) {
					$("#residents").append(
							"<option value='"+item.member_id+"'>"
									+ item.member_id + "</option>");
				});
	}
	function getCategory() {
		var month = $("#month").val();
		var year = $("#year").val();
		var id = $("#residents").val();
		$.ajax({
			method : "post",
			url : "${pageContext.request.contextPath}/payment/getCategory",
			data : {
				"pay_year" : year,
				"pay_month" : month,
				"pay_for" : id
			},
			success : setCategory
		});
	}
	function setCategory(result) {
		initCategory();

		$(result).each(function() {
			var option = this;
			$("#category option").each(function() {
				if ($(this).val() == option)
					$(this).remove();
			});
		});
		/* $("#category option").each(function() {
			var opt = $(this).val();
		}); */

	}
	function initCategory() {
		$("#category").find("option").remove();
		$("#category").append("<option value='' selected='selected'></option>");
		$("#category").append("<option value='전기'>전기</option>");
		$("#category").append("<option value='가스'>가스</option>");
		$("#category").append("<option value='난방'>난방</option>");
		$("#category").append("<option value='수도'>수도</option>");
		$("#category").append("<option value='시설'>시설</option>");
		$("#category").append("<option value='기타'>기타</option>");
		$("#category").append("<option value='미납액'>미납액</option>");
	}
</script>
<style>
select {
	width: 13%;
	height: 36px;
	padding: 5px 10px;
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
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
				<li><a class="verticalNav active"
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
					<div style="margin-left: 15%; padding: 1px 16px; height: 1000px;">
						<div class="intro animate-box">
							<!-- section 안에 내용을 넣고 위에 것으로 인클루드 시키면 쉬움  -->
							<section id="content">
								<h1>${loginInfo.member_belongto}의&nbsp;운영비&nbsp;입력</h1>
								<div>
									<select name=pay_year id="year">
										<c:forEach var="i" begin="${thisYear-3}" end="${thisYear}"
											step="1">
											<option value="${i}"
												<c:if test="${i eq thisYear}">selected="selected"</c:if>>
												${i}</option>
										</c:forEach>
									</select>년 <select name="pay_month" id="month">
										<c:forEach var="i" begin="1" end="${lastMonth}" step="1">
											<option value="${i}"
												<c:if test="${i eq lastMonth}">selected="selected"</c:if>>${i}
											</option>
										</c:forEach>
									</select>월의 운영비 내역 <input type="button" id="toExcel" value="엑셀로 보기"
										class="btn btn-primary" style="float: right;">
								</div>
								<br>
								<div id="result"></div>
								<div>
									거주자: &nbsp<select id="residents" class="payment">
										<option value="All">전원</option>
									</select>&nbsp 내역: &nbsp <select id="category" name="pay_category">
										<option value="" selected="selected"></option>
										<option value="전기">전기</option>
										<option value="가스">가스</option>
										<option value="수도">수도</option>
										<option value="시설">시설</option>
										<option value="기타">기타</option>
										<option value="미납액">미납액</option>
									</select>&nbsp금액: &nbsp <input type="text" id="amount" value="0">&nbsp<input
										type="button" value="추가" id="insert" class="btn btn-primary">
									<input type="button" value="수정" id="update"
										class="btn btn-primary"> <input type="button"
										value="취소" id="cancel" class="btn btn-primary">
								</div>
								<!-- <a href="#" id="toExcel">엑셀로 보내기</a> -->

								<form id="form" method="post"
									action="${pageContext.request.contextPath}/payment/toExcel">
									<input id="value1" type="hidden" value="" name=""> <input
										id="value2" type="hidden" value="" name="">
								</form>
							</section>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- end row -->

		<!-- END: box-wrap -->
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