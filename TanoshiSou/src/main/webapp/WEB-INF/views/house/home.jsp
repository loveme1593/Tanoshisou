<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="url"
	value="${pageContext.request.remoteAddr}${pageContext.request.contextPath}/house/?id=${houseInfo.house_id}" />
<html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=n5qAlCbyktbD6mXy_z0q&callback=initMap"></script>
<meta property="og:url" content="http://${url}" />
<meta property="og:type" content="article" />
<meta property="og:title" content="楽し荘: ${houseInfo.house_name}" />
<meta property="og:description" content="${houseInfo.house_introduce}" />
<meta property="og:image" content="${houseFileList[0].house_file_id}" />

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
<style type="text/css">
#map {
	display: inline-block;
	float: left;
}

#info {
	display: inline-block;
	float: left;
}

#table {
	position: absolute;
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
}

#table th {
	background-color: silver;
	width: 200px;
	padding: 10px;
	font-weight: bolder;
	vertical-align: middle;
	border-bottom: 1px solid #ccc;
	background: #efefef;
	text-align: center;
}

#table td {
	width: 700px;
	padding: 10px;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
}

#info {
	display: inline-block;
	width: 1000px;
}

#buttonMember {
	display: inline-block;
}

#HouseHeader {
	width: 850px;
	display: inline-block;
}

#myCarousel {
	top: 10px;
}
</style>
<script>
	$(function() {
		$("#btnFacebook").on('click', openFacebook);
		$("#btnTwitter").on('click', openTwitter);
		$("#apply").on('click', gotoRegister);
	})
	function openFacebook(){
		window.open("https://www.facebook.com/sharer/sharer.php"
		+"?u="+encodeURIComponent("http://tanoshi.com/house/id?=${houseInfo.house_id}"),"FaceBook",'width=500,height=500,left=200,top=200');
	};
	function openTwitter(){
		window.open("https://twitter.com/intent/tweet?text=${houseInfo.house_id}&url="
		+encodeURIComponent("http://tanoshi.com/house/id?=${houseInfo.house_id}"),"Twitter",'width=500,height=500,left=200,top=200');
	};

	var HOME_PATH = window.HOME_PATH || '.';
	function initMap(){
	var house = new naver.maps.LatLng(${houseInfo.house_GPS_Y}, ${houseInfo.house_GPS_X}),
	    map = new naver.maps.Map('map', { center: house.destinationPoint(0, 500), zoom: 7 }),
	    marker = new naver.maps.Marker({
	        map: map,
	        position: house
	    });
	}
	
	function gotoRegister(){
		var loginIn = '${loginInfo.member_id}1';
		if(loginIn == '1') location.href="${pageContext.request.contextPath}/member/login";
		else if(loginIn != '1'){ 
			if(confirm('${houseInfo.house_name}에 입주를 신청하시겠습니까?')){
				//alert('입주를 신청했습니다');
				$("#form").attr('action', '${pageContext.request.contextPath}/house/apply');
				$("#form").submit();	
			}
		}
	}
	
</script>
<script>
	if("${applyResult}"=='success'){
		alert('입주 신청에 성공하였습니다.');
	}
</script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
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
		<ul class="verticalNav">
			<li><a class="verticalNav active"
				href="${pageContext.request.contextPath}/house/?id=${loginInfo.member_belongto}">
					<img
					src="${pageContext.request.contextPath}/resources/images/home-icon.png"
					alt="홈으로" width="30" align=left> Home
			</a></li>
			<!-- General 의 경우 공지사항 이하 모든 것 못보도록 처리 -->
			<c:if
				test="${loginInfo.member_type!='General'&& loginInfo.member_type!='Pending' && loginInfo.member_belongto==houseInfo.house_id }">
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
					href="${pageContext.request.contextPath}/planning/"> <img
						src="${pageContext.request.contextPath}/resources/images/calendar-icon.png"
						alt="일정" width="30" align=left>일정 관리
				</a></li>
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
					href="${pageContext.request.contextPath}/photo/"> <img
						src="${pageContext.request.contextPath}/resources/images/photo-icon.png"
						alt="일정" width="30" align=left>사진첩
				</a></li>
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
				<div class="row" style="height: 1000px;">
					<div style="margin-left: 15%; padding: 1px 16px;">
						<div class="intro animate-box">
							<!-- section 안에 내용을 넣고 위에 것으로 인클루드 시키면 쉬움  -->
							<div id="info">
								<h1 id="HouseHeader">${houseInfo.house_name}
									<!-- 공유 기능 링크 http://dev.epiloum.net/916 -->
									<a href="#" id="btnFacebook"><img
										src="${pageContext.request.contextPath}/resources/images/icons/facebook.png"
										width="30px" height="30px"></a> <a href="" id="btnTwitter"><img
										src="${pageContext.request.contextPath}/resources/images/icons/Twitter.png"
										width="30px" height="30px"></a>
								</h1>
								<span id="buttonMember"> <c:if
										test="${loginInfo.member_type=='General'|| empty loginInfo.member_type}">
										<input type="button" id="apply" class="button-input"
											value="하우스 멤버 신청">
									</c:if>
								</span>
								<table id="table">
									<tr>
										<th>전화번호</th>
										<td>${houseInfo.house_owner} : ${houseInfo.house_phone}</td>
									</tr>
									<tr>
										<th>최대 수용 인원</th>
										<td>${houseInfo.house_available_room}</td>
									</tr>
									<tr>
										<th>E-mail</th>
										<td>${houseInfo.house_available_email}</td>
									</tr>
									<tr>
										<th>면적</th>
										<td>${houseInfo.house_area }㎡</td>
									</tr>
									<tr>
										<th>옵션</th>
										<td id="options"><script type="text/javascript">
                                 var str = '${houseInfo.house_option}';
                                 var options = str.split(",");
                                 var array='';
                                 
                                 var icons = 
                                 [{name: 'onlyMan',message:'남성 전용', file: 'onlyMan-home.png'},
								{name:'pet', message : '애완동물 가능', file: 'pet-home.png'},                 	 
								{name:'noSmoker', message:'금연', file:'noSmoker-home.png'},
								{name: 'noDrink', message:'금주', file: 'noDrink-home.png'},
								{name:'parkingLot', message:'주차 가능', file: 'parkingLot-home.png'},
                                {name:'onlyWoman', message:'여성 전용', file: 'onlyWoman-home.png'},
								{name: 'study', message:'스터디 그룹', file: 'study-home.png'},
								{name : 'WiFi',	message : 'WiFi', file : '5G-home.png'} ];
                                // 해당 하우스의 option 데이터와 비교하여 배열의 name 속성과 값이 맞으면 이미지를 출력
                                 $.each(options, function(index, item){
                                	$.each(icons, function(i, icon){
                                		if(item==icon.name)
                                			array +='<img src="${pageContext.request.contextPath}/resources/images/'+icon.file+'" width="30">'+icon.message+'&nbsp;';
                                	});
                                });
                                $('#options').html(array);
                                 </script></td>
									</tr>
									<tr>
										<th>점수</th>
										<td>
											<div
												style="display: inline-block; float: left; width: 31%; padding: 1px;">
												<c:if test="${houseInfo.house_score_personal>=50}">
													<span><img
														src="${pageContext.request.contextPath}/resources/images/personal_image.png"
														width="20px;"></span>
												</c:if>
												<c:if test="${houseInfo.house_score_personal<50 }">
													<span>&nbsp;</span>
													<span style="float: right;"><img
														src="${pageContext.request.contextPath}/resources/images/personal_image1.png"
														width="20px;"></span>
												</c:if>
												<div class="progress">
													<fmt:formatNumber var="score" type="number"
														maxFractionDigits="0"
														value="${houseInfo.house_score_personal }" />
													<div class="progress-bar progress-bar-success"
														role="progressbar"
														style="vertical-align:bottom; width: ${score}%">${score}점</div>
													<div class="progress-bar progress-bar-warning"
														role="progressbar"
														style="vertical-align:bottom; width: ${100-score}%">${100-score}점</div>
												</div>
											</div>
											<div
												style="display: inline-block; float: left; width: 33%; padding: 5;">
												<c:if test="${houseInfo.house_score_clean>=50}">
													<span><img
														src="${pageContext.request.contextPath}/resources/images/clean_image.png"
														width="20px;"></span>
												</c:if>
												<c:if test="${houseInfo.house_score_clean<50 }">
													 <span>&nbsp;</span> 
													<span class="pull-right"><img
														src="${pageContext.request.contextPath}/resources/images/clean_image1.png"
														width="20px;"></span>
												</c:if>
												<div class="progress"
													style="position: absolute; top: 272px; width: 23.5%;">
													<fmt:formatNumber var="score" type="number"
														maxFractionDigits="0"
														value="${houseInfo.house_score_clean }" />
													<div class="progress-bar progress-bar-success"
														role="progressbar" style="width: ${score}%">${score}점</div>
													<div class="progress-bar progress-bar-warning"
														role="progressbar" style="width: ${100-score}%">${100-score}점</div>
												</div>
											</div>
											<div
												style="display: inline-block; float: left; width: 33%; padding: 5;">
												<c:if test="${houseInfo.house_score_active>=50}">
													<span><img
														src="${pageContext.request.contextPath}/resources/images/active_image.png"
														width="20px;"></span>
												</c:if>
												<c:if test="${houseInfo.house_score_active<50 }">
													<span>&nbsp;</span>
													<span style="float: right;"><img
														src="${pageContext.request.contextPath}/resources/images/active_image1.png"
														width="20px;"></span>
												</c:if>
												<div class="progress"
													style="position: absolute; top: 272px; width: 23.5%;">
													<fmt:formatNumber var="score" type="number"
														maxFractionDigits="0"
														value="${houseInfo.house_score_active }" />
													<div class="progress-bar progress-bar-success"
														role="progressbar" style="width: ${score}%">${score}점</div>
													<div class="progress-bar progress-bar-warning"
														role="progressbar" style="width: ${100-score}%">${100-score}점</div>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th>연령대</th>
										<td><c:choose>
												<c:when
													test="${houseInfo.house_age >= 10 && houseInfo.house_age <=19}">
												10대				
											</c:when>
												<c:when
													test="${houseInfo.house_age >= 20 && houseInfo.house_age <=20}">
												20대					
											</c:when>
												<c:when
													test="${houseInfo.house_age >= 30 && houseInfo.house_age <=39}">
												30대						
											</c:when>
												<c:otherwise>
												연령대 제한 없음						
											</c:otherwise>
											</c:choose></td>
									</tr>
									<tr>
										<th>집 위치</th>
										<td><a>${houseInfo.house_address}</a> <span id="map"
											style="width: 700px; height: 200px;"></span></td>
									</tr>
									<tr>
										<th>집 소개</th>
										<td><textarea rows="5" cols="50" style="width: 700px;"
												readonly>${houseInfo.house_introduce}</textarea></td>
									</tr>
									<tr>
										<td colspan="2">
											<div id="myCarousel" class="carousel slide"
												data-ride="carousel"
												style="width: 1000px; display: inline-block;">
												<div class="carousel-inner">
													<div class="item active">
														<c:forEach var="fileList" begin="0" end="0"
															items="${houseFileList}" varStatus="status">
															<img
																src="${pageContext.request.contextPath}/house/houseImage?fileNameList=${fileList.house_file_id}"
																style="width: 1000px; height: 500px;" alt="이미지 없음"
																onError="javascript:this.src='${pageContext.request.contextPath}/resources/images/mainLogo.png'">
														</c:forEach>
													</div>
													<ol class="carousel-indicators">
														<c:forEach var="fileList" items="${houseFileList}"
															varStatus="status">
															<li data-target="#myCarousel"
																data-slide-to="${status.index}" class="active"></li>
														</c:forEach>
													</ol>
													<c:forEach var="fileList" begin="1"
														items="${houseFileList}" varStatus="status">
														<div class="item">
															<img id="img${status.count}"
																src="${pageContext.request.contextPath}/house/houseImage?fileNameList=${fileList.house_file_id}"
																style="width: 1000px; height: 500px;" data-src=""
																alt="이미지 없음"
																onError="javascript:this.src='${pageContext.request.contextPath}/resources/images/mainLogo.png'">
														</div>
													</c:forEach>
													<a class="left carousel-control" href="#myCarousel"
														data-slide="prev"><span
														class="glyphicon glyphicon-chevron-left"></span></a> <a
														class="right carousel-control" href="#myCarousel"
														data-slide="next"><span
														class="glyphicon glyphicon-chevron-right"></span></a>
												</div>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<!-- 사진 슬라이드 부분 -->
					</div>
				</div>
				<div class="clearfix" style="height: 400px;"></div>
				<hr>
				<%@ include file="../footer.jsp"%>
			</div>
		</section>
	</div>
	<form id="form" action="" method="post">
		<input type="hidden" value="">
	</form>

	<!-- jQuery 
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>-->
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
