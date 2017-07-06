<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>성향검사</title>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script type="text/javascript">
	function gotoTest() {
		var question = [ $("input[type=radio][name=Q1]:checked").val(),
				$("input[type=radio][name=Q2]:checked").val(),
				$("input[type=radio][name=Q3]:checked").val(),
				$("input[type=radio][name=Q4]:checked").val(),
				$("input[type=radio][name=Q5]:checked").val(),
				$("input[type=radio][name=Q6]:checked").val(),
				$("input[type=radio][name=Q7]:checked").val(),
				$("input[type=radio][name=Q8]:checked").val(),
				$("input[type=radio][name=Q9]:checked").val(),
				$("input[type=radio][name=Q10]:checked").val(),
				$("input[type=radio][name=Q11]:checked").val(),
				$("input[type=radio][name=Q12]:checked").val(),
				$("input[type=radio][name=Q13]:checked").val(),
				$("input[type=radio][name=Q14]:checked").val(),
				$("input[type=radio][name=Q15]:checked").val() ];
		document.getElementById("answers").value = question;
		return true;
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
<style>
th, td {
	padding: 10px;
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
		<!-- END: header -->
		<section id="intro">
			<div class="container">
				<div class="row">
					<div class="intro animate-box">
						<div style="text-align: center;">
							<h3>성향테스트</h3>
							<p>테스트에 기반하여 성향이 맞는 쉐어하우스를 추천해 드립니다.</p>
							<c:if test="${detailNullCheck=='null' }">
								<div class="alert alert-info alert-dismissable fade in">
									<a href="#" class="close" data-dismiss="alert"
										aria-label="close">&times;</a> <strong>Info! </strong> 성향테스트를
									먼저 해주세요.
								</div>
							</c:if>
						</div>
						<form
							action="${pageContext.request.contextPath}/recommend/getResult"
							id="testForm" method="post" onsubmit="return gotoTest();">
							<input type="hidden" id="answers" name="answers" value="">
							<table class="table" style="width: 100%;">
								<tr>
									<th>문제번호</th>
									<th>질문</th>
									<th>매우 그렇다</th>
									<th>그렇다</th>
									<th>보통</th>
									<th>그렇지 않다</th>
									<th>매우 그렇지 않다</th>
								</tr>
								<tr>
									<th>1</th>
									<td>조용한 분위기가 좋다</td>
									<td>매우 그렇다<input type="radio" name="Q1" value=0
										required="required"></td>
									<td>그렇다<input type="radio" name="Q1" value=1
										required="required"></td>
									<td>보통<input type="radio" name="Q1" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q1" value=3
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q1" value=4
										required="required"></td>
								</tr>
								<tr>
									<th>2</th>
									<td>방청소는 원래 한달에 한번 하는 것이다</td>
									<td>매우 그렇다<input type="radio" name="Q2" value=0
										required="required"></td>
									<td>그렇다<input type="radio" name="Q2" value=1
										required="required"></td>
									<td>보통<input type="radio" name="Q2" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q2" value=3
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q2" value=4
										required="required"></td>
								</tr>
								<tr>
									<th>3</th>
									<td>조용히 내가 맡은 역할만 하는 것이 좋다</td>
									<td>매우 그렇다<input type="radio" name="Q3" value=0
										required="required"></td>
									<td>그렇다<input type="radio" name="Q3" value=1
										required="required"></td>
									<td>보통<input type="radio" name="Q3" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q3" value=3
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q3" value=4
										required="required"></td>
								</tr>
								<tr>
									<th>4</th>
									<td>파티는 사람이 많으면 많을수록 좋다</td>
									<td>매우 그렇다<input type="radio" name="Q4" value=4
										required="required"></td>
									<td>그렇다<input type="radio" name="Q4" value=3
										required="required"></td>
									<td>보통<input type="radio" name="Q4" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q4" value=1
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q4" value=0
										required="required"></td>
								</tr>
								<tr>
									<th>5</th>
									<td>샤워는 매일매일 목욕은 일주일에 1번해야한다</td>
									<td>매우 그렇다<input type="radio" name="Q5" value=4
										required="required"></td>
									<td>그렇다<input type="radio" name="Q5" value=3
										required="required"></td>
									<td>보통<input type="radio" name="Q5" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q5" value=1
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q5" value=0
										required="required"></td>
								</tr>
								<tr>
									<th>6</th>
									<td>빨래는 매일 매일 하는 것이 좋다</td>
									<td>매우 그렇다<input type="radio" name="Q6" value=4
										required="required"></td>
									<td>그렇다<input type="radio" name="Q6" value=3
										required="required"></td>
									<td>보통<input type="radio" name="Q6" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q6" value=1
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q6" value=0
										required="required"></td>
								</tr>
								<tr>
									<th>7</th>
									<td>그룹활동에서 리더가 되는 것을 좋아한다</td>
									<td>매우 그렇다<input type="radio" name="Q7" value=4
										required="required"></td>
									<td>그렇다<input type="radio" name="Q7" value=3
										required="required"></td>
									<td>보통<input type="radio" name="Q7" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q7" value=1
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q7" value=0
										required="required"></td>
								</tr>

								<tr>
									<th>8</th>
									<td>남이 내물건에 만지는 것이 싫다</td>
									<td>매우 그렇다<input type="radio" name="Q8" value=0
										required="required"></td>
									<td>그렇다<input type="radio" name="Q8" value=1
										required="required"></td>
									<td>보통<input type="radio" name="Q8" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q8" value=3
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q8" value=4
										required="required"></td>
								</tr>
								<tr>
									<th>9</th>
									<td>사용한 것은 바로바로 제자리에 둔다</td>
									<td>매우 그렇다<input type="radio" name="Q9" value=4
										required="required"></td>
									<td>그렇다<input type="radio" name="Q9" value=3
										required="required"></td>
									<td>보통<input type="radio" name="Q9" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q9" value=1
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q9" value=0
										required="required"></td>
								</tr>
								<tr>
									<th>10</th>
									<td>친구가 많으면 많을 수록 좋다고 생각한다</td>
									<td>매우 그렇다<input type="radio" name="Q10" value=4
										required="required"></td>
									<td>그렇다<input type="radio" name="Q10" value=3
										required="required"></td>
									<td>보통<input type="radio" name="Q10" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q10" value=1
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q10" value=0
										required="required"></td>
								</tr>
								<tr>
									<th>11</th>
									<td>주말엔 혼자 여유롭게 있고 싶다</td>
									<td>매우 그렇다<input type="radio" name="Q11" value=0
										required="required"></td>
									<td>그렇다<input type="radio" name="Q11" value=1
										required="required"></td>
									<td>보통<input type="radio" name="Q11" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q11" value=3
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q11" value=4
										required="required"></td>
								</tr>
								<tr>
									<th>12</th>
									<td>음식을 먹어도 다 함께 먹는 것이 좋다</td>
									<td>매우 그렇다<input type="radio" name="Q12" value=4
										required="required"></td>
									<td>그렇다<input type="radio" name="Q12" value=3
										required="required"></td>
									<td>보통<input type="radio" name="Q12" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q12" value=1
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q12" value=0
										required="required"></td>
								</tr>

								<tr>
									<th>13</th>
									<td>여럿이 말하는 것 보다 단 둘이 이야기 하는 것이 편하다</td>
									<td>매우 그렇다<input type="radio" name="Q13" value=0
										required="required"></td>
									<td>그렇다<input type="radio" name="Q13" value=1
										required="required"></td>
									<td>보통<input type="radio" name="Q13" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q13" value=3
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q13" value=4
										required="required"></td>
								</tr>
								<tr>
									<th>14</th>
									<td>설거지는 먹는 즉시 그때 그때 한다</td>
									<td>매우 그렇다<input type="radio" name="Q14" value=4
										required="required"></td>
									<td>그렇다<input type="radio" name="Q14" value=3
										required="required"></td>
									<td>보통<input type="radio" name="Q14" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q14" value=1
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q14" value=0
										required="required"></td>
								</tr>
								<tr>
									<th>15</th>
									<td>낯선 사람과 금방 친해진다</td>
									<td>매우 그렇다<input type="radio" name="Q15" value=4
										required="required"></td>
									<td>그렇다<input type="radio" name="Q15" value=3
										required="required"></td>
									<td>보통<input type="radio" name="Q15" value=2
										required="required"></td>
									<td>그렇지 않다<input type="radio" name="Q15" value=1
										required="required"></td>
									<td>매우 그렇지 않다<input type="radio" name="Q15" value=0
										required="required"></td>
								</tr>
							</table>
							<div style="text-align: center;">
								<input type="submit" value="제출하기" class="button-input">
							</div>
						</form>
					</div>
				</div>
			</div>
		</section>
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