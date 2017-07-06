<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쉐어하우스 검색</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=n5qAlCbyktbD6mXy_z0q"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/markerClustering.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						<c:if test="${not empty keyword}">
						$("#search").val("${keyword}");
						</c:if>
						//search 버튼
						$("#search-btn").on('click', function() {
							init();
							//css때문에 class->id로 바꿔줌
						});
						//이동버튼!!!	
						$("#to-jeju").on("click", function(e) {
							e.preventDefault();
							map.setZoom(9);
							map.panTo(jeju);//지정한 지점 중심으로 이동
						});

						$("#to-1").on("click", function(e) {
							e.preventDefault();
							map.setZoom(1, true); //줌지정
						});

						$("#to-daegu").on("click", function(e) {
							e.preventDefault();
							map.panTo(daegu); // 일단 daegu, daejeon으로 생성만해놓음 연결하면됌
						});

						$("#to-daejeon").on("click", function(e) {
							e.preventDefault();
							map.panTo(daejeon); //
						});

						$("#to-busan").on("click", function(e) {
							e.preventDefault();
							map.panTo(busan);
						});

						$("#to-seoul").on("click", function(e) {
							e.preventDefault();

							map.panToBounds(seoul);//지정한 지점 경계로 이동
						});

						$("#panBy").on("click", function(e) {
							e.preventDefault();

							map.panBy(new naver.maps.Point(10, 10));
						});

						//지도를 삽입할 HTML 엘리먼트 또는 HTML 엘리먼트의 id를 지정합니다.
						var mapDiv = document.getElementById('map'); // 'map' 으로 선언해도 동일
						
						//옵션 셋팅
						var mapOptions = {
							zoom : 7,
							mapTypeControl : true,
							mapTypeControlOptions : {
								style : naver.maps.MapTypeControlStyle.BUTTON,
								position : naver.maps.Position.TOP_RIGHT
							},
							zoomControl : true,
							zoomControlOptions : {
								style : naver.maps.ZoomControlStyle.NORMAL,
								position : naver.maps.Position.TOP_LEFT
							},
							scaleControl : true,
							scaleControlOptions : {
								position : naver.maps.Position.BOTTOM_RIGHT
							},
							mapDataControl : true,
							mapDataControlOptions : {
								position : naver.maps.Position.BOTTOM_LEFT
							},
							logoControl : false, //로고 띄우기
							logoControlOptions : {
								position : naver.maps.Position.TOP_LEFT
							}
						};
						
						//지도생성
						var map = new naver.maps.Map(mapDiv, mapOptions);
						
						//현재위치[0001]
						function onSuccessGeolocation(position) {
						    var location = new naver.maps.LatLng(position.coords.latitude,
						    		position.coords.longitude);
						    map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
						    map.setZoom(11); // 지도의 줌 레벨을 변경합니다.
							<c:if test="${not empty keyword}">
							map.setZoom(3);
							</c:if>
						}
					 //현재위치 못가져올때 기본 설정값(코엑스)
					 function onErrorGeolocation() {
							map.setCenter(new naver.maps.LatLng(37.5118239,127.0591591))
					}
						if (navigator.geolocation) {
							navigator.geolocation.getCurrentPosition(
									onSuccessGeolocation, onErrorGeolocation);
						} else {
							var center = map.getCenter();
						}

						//사용자임의버튼
						//버튼2
						var locationBtnHtml2 = '<a href="#" class="btn_mylct"><input type="button" value="현재위치" class="button-input"></a>';
						var customControl2 = new naver.maps.CustomControl(
								locationBtnHtml2, {
									position : naver.maps.Position.TOP_LEFT
								});
						customControl2.setMap(map);
						//버튼1 ->1레벨로 줌인 아웃으로 자리 바꾸겠음
						var locationBtnHtml = '<a href="#" class="btn_mylct"><input type="button" id="to-1"  class="button-input" value="전체보기"></a>';
						var customControl = new naver.maps.CustomControl(
								locationBtnHtml, {
									position : naver.maps.Position.TOP_LEFT
								});
						customControl.setMap(map);
						/* 지역 이동 [0000] */
						//제주
						var locationJeJu = '<a href="#" class="btn_mylct"><input type="button" id="to-jeju" class="button-input" value="제주"></a>';
						var customControl7 = new naver.maps.CustomControl(
								locationJeJu, {
									position : naver.maps.Position.LEFT_BOTTOM
								});
						customControl7.setMap(map);
						var domEventListener7 = naver.maps.Event
								.addDOMListener(customControl7.getElement(),
										'click', function() {
											map.panTo(jeju);
										});
						//부산
						var locationBuSan = '<a href="#" class="btn_mylct"><input type="button" id="to-busan" class="button-input" value="부산"></a>';
						var customControl6 = new naver.maps.CustomControl(
								locationBuSan, {
									position : naver.maps.Position.LEFT_BOTTOM
								});
						customControl6.setMap(map);
						var domEventListener6 = naver.maps.Event
								.addDOMListener(customControl6.getElement(),
										'click', function() {
											map.panTo(busan);
										});
						//대구 
						var locationDaeGu = '<a href="#" class="btn_mylct"><input type="button" id="to-daegu" class="button-input" value="대구"></a>';
						var customControl5 = new naver.maps.CustomControl(
								locationDaeGu, {
									position : naver.maps.Position.LEFT_BOTTOM
								});
						customControl5.setMap(map);
						var domEventListener5 = naver.maps.Event
								.addDOMListener(customControl5.getElement(),
										'click', function() {
											map.panTo(daegu);
										});
						//광주이동
						var locationGwangju = '<a href="#" class="btn_mylct"><input type="button" id="to-gwangju" class="button-input" value="광주"></a>';
						var customControl9 = new naver.maps.CustomControl(
								locationGwangju, {
									position : naver.maps.Position.LEFT_BOTTOM
								});
						customControl9.setMap(map);
						var domEventListener9 = naver.maps.Event
								.addDOMListener(customControl9.getElement(),
										'click', function() {
											map.panTo(gwangju);
										});
						//대전이동
						var locationDaeJeon = '<a href="#" class="btn_mylct"><input type="button" id="to-daejeon" class="button-input" value="대전"></a>';
						var customControl4 = new naver.maps.CustomControl(
								locationDaeJeon, {
									position : naver.maps.Position.LEFT_BOTTOM
								});
						customControl4.setMap(map);
						var domEventListener4 = naver.maps.Event
								.addDOMListener(customControl4.getElement(),
										'click', function() {
											map.panTo(daejeon);
										});
						//인천이동
						var locationIncheon = '<a href="#" class="btn_mylct"><input type="button" id="to-incheon" class="button-input" value="인천"></a>';
						var customControl8 = new naver.maps.CustomControl(
								locationIncheon, {
									position : naver.maps.Position.LEFT_BOTTOM
								});
						customControl8.setMap(map);
						var domEventListener8 = naver.maps.Event
								.addDOMListener(customControl8.getElement(),
										'click', function() {
											map.panTo(incheon);
										});
						//서울이동
						var locationSeoul = '<a href="#" class="btn_mylct"><input type="button" id="to-seoul" class="button-input" value="서울"></a>';
						var customControl3 = new naver.maps.CustomControl(
								locationSeoul, {
									position : naver.maps.Position.LEFT_BOTTOM
								});
						customControl3.setMap(map);
						var domEventListener3 = naver.maps.Event
								.addDOMListener(customControl3.getElement(),
										'click', function() {
											map.panToBounds(seoul);
										});
						/* 지역 이동 끝   */

						//사용자임의버튼 이동! =>버튼1: 1레벨로 줌인/아웃
						var domEventListener = naver.maps.Event.addDOMListener(
								customControl.getElement(), 'click',
								function() {
									map.setCenter(new naver.maps.LatLng(
											37.5118239, 127.0591591));
									//map.setZoom(11);
									//e.preventDefault();
									map.setZoom(1, true); //줌지정
								});
						//사용자임의버튼 이동! =>버튼2
						var domEventListener2 = naver.maps.Event
								.addDOMListener(
										customControl2.getElement(),
										'click',
										function() {
											if (navigator.geolocation) {
												navigator.geolocation
														.getCurrentPosition(
																onSuccessGeolocation,
																onErrorGeolocation);
											} else {
												var center = map.getCenter();
											}
										});
						//마커 만들기 
						var markers = new Array();
						var infoWindows = new Array();

						//마커생성 메소드
						function init() {
							var text = $("#search").val();
							var data = {
								"keyword" : text
							};
							$.ajax({
								type : "post",
								url : "find",
								data : data,
								success : output
							});
						}

						//마커 출력
						function output(resp) {
							var html = '<table class="table table-hover"><tr><th>이름</th><th>주소</th><th>방(개)</th><th>면적(㎡)</th></tr>';
							$(resp)
									.each(
											function(index, item) {
												//마커 만들기 
												var marker = new naver.maps.Marker(
														{
															position : new naver.maps.LatLng(
																	item.house_GPS_Y,
																	item.house_GPS_X),
															map : map
														});
												
												//정보창 내용 
												var contentString = [
													'<div style="background-color:rgba(120, 213, 237, 0.5); padding:10px;"><span><a href="${pageContext.request.contextPath}/house/?id='+item.house_id+'">'+
									                '<h3 style ="font-size:small; font-weight: bold; padding-left:10px; padding:2px; margin:0;"> <img src="${pageContext.request.contextPath}/resources/images/home-search.png" width="30" style="margin-right:10px;"/>'+item.house_name+'</h3>' +
									                '<hr style="border-width:medium;">'+
									                '<div>' +
									                '<p style ="font-size:small; ">'+ item.house_introduce+'</p>' +
									                '</div>' +
									                '</a></span></div>'].join('');
												
												var infoWindow = new naver.maps.InfoWindow(
														{
															content : contentString,
															id : item.house_id,
															maxWidth: 400
														});
												
												var styles = [{"featureType": "landscape", "stylers": [{"saturation": -100}, {"lightness": 65}, {"visibility": "on"}]}, {"featureType": "poi", "stylers": [{"saturation": -100}, {"lightness": 51}, {"visibility": "simplified"}]}, {"featureType": "road.highway", "stylers": [{"saturation": -100}, {"visibility": "simplified"}]}, {"featureType": "road.arterial", "stylers": [{"saturation": -100}, {"lightness": 30}, {"visibility": "on"}]}, {"featureType": "road.local", "stylers": [{"saturation": -100}, {"lightness": 40}, {"visibility": "on"}]}, {"featureType": "transit", "stylers": [{"saturation": -100}, {"visibility": "simplified"}]}, {"featureType": "administrative.province", "stylers": [{"visibility": "off"}]}, {"featureType": "water", "elementType": "labels", "stylers": [{"visibility": "on"}, {"lightness": -25}, {"saturation": -100}]}, {"featureType": "water", "elementType": "geometry", "stylers": [{"hue": "#ffff00"}, {"lightness": -25}, {"saturation": -97}]}];

												map.set('styles', styles);
												
												markers.push(marker);
												infoWindows.push(infoWindow);
												html += '<tr>';
												html += "<td><a href='${pageContext.request.contextPath}/house/?id="
														+ item.house_id
														+ "'>"
														+ item.house_name
														+ "</a></td>";
												html += "<td>"
														+ "<a href='#' class='gps' gps_x='"+item.house_GPS_X+"', gps_y='"+item.house_GPS_Y+"' house_id='"+item.house_id+"'>"
														+ item.house_address
														+ "</a>" + "</td>";
												html += "<td>"
														+ item.house_available_room
														+ "</td>";
												html += "<td>"
														+ item.house_area
														+ "</td>";
												html += "</tr>";
											});
							html += "</table>";
							$("#result").html(html);
							$("a.gps").on('click', moveToLocation);
							naver.maps.Event.addListener(map, 'idle',
									function() {
										updateMarkers(map, markers);
									});

							function moveToLocation(e) {
								e.preventDefault();
								var id = $(this).attr("house_id");
								var gpsx = $(this).attr("gps_x");
								var gpsy = $(this).attr("gps_y");
								var position = {
									"y" : gpsy,
									"x" : gpsx
								};
								var marker;
								var info;
								map
										.setCenter(new naver.maps.LatLng(gpsy,
												gpsx));//지정한 지점 경계로 이동
								$(markers).each(function(index, item) {
									var t = item.getPosition();
									if (t.equals(position))
										marker = item;
								});
								$(infoWindows).each(function(index, item) {
									var t = item.getOptions('id');
									if (t == id)
										info = item;
								});
								info.open(map, marker);

							}
							function updateMarkers(map, markers) {
								var mapBounds = map.getBounds();
								var marker, position;
								for (var i = 0; i < markers.length; i++) {

									marker = markers[i]
									position = marker.getPosition();

									if (mapBounds.hasLatLng(position)) {
										showMarker(map, marker);
									} else {
										hideMarker(map, marker);
									}
								}
							}
							function showMarker(map, marker) {

								if (marker.setMap())
									return;
								marker.setMap(map);
							}
							function hideMarker(map, marker) {

								if (!marker.setMap())
									return;
								marker.setMap(null);
							}
							// 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
							function getClickHandler(seq) {
								return function(e) {
									var marker = markers[seq], infoWindow = infoWindows[seq];
									if (infoWindow.getMap()) {
										infoWindow.close();
									} else {
										infoWindow.open(map, marker);
									}
								}
							}
							for (var i = 0, ii = markers.length; i < ii; i++) {
								//console.log(i);
								naver.maps.Event.addListener(markers[i],
										'click', getClickHandler(i));
							}
							//마커클러스터 
							var markerClustering = new MarkerClustering(
									{
										minClusterSize : 2,
										maxZoom : 8,
										map : map,
										markers : markers,
										disableClickZoom : false,
										gridSize : 120,
										icons : [ htmlMarker1, htmlMarker2,
												htmlMarker3, htmlMarker4,
												htmlMarker5 ],
										indexGenerator : [ 10, 100, 200, 500,
												1000 ],
										stylingFunction : function(
												clusterMarker, count) {
											$(clusterMarker.getElement()).find(
													'div:first-child').text(
													count);
										}
									});
						}//output function - init success에서 사용

						//마커생성 메소드 호출
						init();
					});
	var htmlMarker1 = {
		content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(${pageContext.request.contextPath}/images/map/cluster-marker-3.png);background-size:contain;"></div>',
		size : N.Size(40, 40),
		anchor : N.Point(20, 20)
	}, htmlMarker2 = {
		content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(${pageContext.request.contextPath}/images/map/cluster-marker-2.png);background-size:contain;"></div>',
		size : N.Size(40, 40),
		anchor : N.Point(20, 20)
	}, htmlMarker3 = {
		content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(${pageContext.request.contextPath}/images/map/cluster-marker-1.png);background-size:contain;"></div>',
		size : N.Size(40, 40),
		anchor : N.Point(20, 20)
	}, htmlMarker4 = {
		content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(${pageContext.request.contextPath}/images/map/cluster-marker-4.png);background-size:contain;"></div>',
		size : N.Size(40, 40),
		anchor : N.Point(20, 20)
	}, htmlMarker5 = {
		content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(${pageContext.request.contextPath}/img/cluster-marker-5.png);background-size:contain;"></div>',
		size : N.Size(40, 40),
		anchor : N.Point(20, 20)
	};

	//이동!!!	[0000]
	var jeju = new naver.maps.LatLng(33.4890113, 126.4983023)
		, busan = new naver.maps.LatLng(35.1797865, 129.0750194)
		, daegu = new naver.maps.LatLng(35.8714354,128.601445)
		, daejeon = new naver.maps.LatLng(36.3504119,127.3845475)
		, incheon = new naver.maps.LatLng(37.4562557,126.7052062)
		, gwangju = new naver.maps.LatLng(35.1595454,126.8526012)
		 
	
	//지정한 지점만큼 바운드 넣어주기             
	seoul = new naver.maps.LatLngBounds(new naver.maps.LatLng(
			37.42829747263545, 126.76620435615891), new naver.maps.LatLng(
			37.7010174173061, 127.18379493229875));
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
<style>
p {
	text-align: center;
}

.text-search {
	width: 40%;
}

.btn-search {
	background-color: #008CBA; /* Green */
	border: none;
	color: white;
	padding: 5px 10px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	margin: 4px 2px;
	-webkit-transition-duration: 0.4s; /* Safari */
	transition-duration: 0.4s;
	cursor: pointer;
	background-color: white;
	color: black;
	border: 2px solid #52d3aa;
}

.btn-search:hover {
	background-color: #52d3aa;
	color: white;
}

.centeralization {
	/**margin: 0 auto;*/
	text-align: center;
}

.fontSize {
	font-size: 33px;
	vertical-align: middle;
}

.typed-cursor {
	vertical-align: middle;
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
	<!-- END: header -->
	<section id="intro">
		<div class="container">
			<div class="row">
				<br>
				<div class="centeralization">
					<span class="fontSize">楽し荘</span> <span class="typed-cursor">|</span>
					<input type="text" class="text-search" id="search"
						placeholder="검색어를 입력하세요.(하우스명, 주소)"> <input type="button"
						class="btn-search" id="search-btn" value=" 검색 " width="700">
				</div>
				<!-- 지역버튼 [0000] -->
				<!-- <input type="button" id="to-seoul" class="button-input" value="서울">
				<input type="button" id="to-daejeon" class="button-input" value="대전">
				<input type="button" id="to-daegu" class="button-input" value="대구">
				<input type="button" id="to-busan" class="button-input" value="부산">
				<input type="button" id="to-jeju" class="button-input" value="제주"> -->
			</div>
		</div>
		<br> <br>
		<div>
			<!--map과 result 위치 붙여버림-->
			<div id="map" style="width: 70%; height: 600px; position: absolute;"></div>
			<div id='result'
				style="margin-left: 70%; height: 600px; overflow: auto;"></div>
		</div>
	</section>
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