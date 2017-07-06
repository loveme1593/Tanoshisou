<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쉐어하우스에 대한 모든 것, 楽し荘</title>
<script type="text/javascript"
   src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
   function gotoLoc() {
      location.href = "${pageContext.request.contextPath}/house/map";
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
<script type="text/javascript">
   function goPopup() { // 주소검색을 수행할 팝업 페이지를 호출합니다. 소스 경로는 사용자 시스템에 맞게 수정하시기 바람니다.    
      var pop = window.open(
            "{pageContext.request.contextPath}/house/jusoPopup", "pop",
            "width=700,height=650, scrollbars=yes, resizable=yes");
   }
   function searchDetail() {
      location.href = "${pageContext.request.contextPath}/house/detail";
   }
   
   function toList() {
		location.href = "${pageContext.request.contextPath}/";
	}
   
   $(function(){
	   $('#detailSearch').on('click',showPopup);
   })
   
// 회원 정보 띄우기
	function showPopup() {
		$.ajax({
					method : 'get',
					url : '${pageContext.request.contextPath}/house/detail',
					success : function() {
							var content = '<span class="dialog__close">&#x2715;</span><div class="dialog__content"><form id="form" method="post" action="${pageContext.request.contextPath}/house/detail" style="text-align: center;"><table class="table-reply">';
							content += '<tr><td><h4 class="dialog__title" style="font-weight: bolder;">상세 정보 검색</h4></td></tr>';
							content += '<tr><tdcolspan="2"><div class="alert alert-info" style="font-size: large;"><strong>Info! </strong> 상세 정보 검색을 위해 옵션을 선택해주세요.</div></td></tr>';
							content += '<tr><th>희망 평균 면적<br>(1인당)</th><td><select id="house_area" name="house_area">'
										+'<option value="0"></option>'
										+'<option value="10">10㎡ 이하</option>'
										+'<option value="15">10~15㎡</option>'
										+'<option value="16">15㎡ 이상</option></select></td></tr>';
							content +=	'<tr><th>희망 평균 연령</th><td><select id="house_age" name="house_age">'
										+'<option value="0"></option>'
										+'<option value="20">20~29세</option>'
										+'<option value="30">30~39세</option>'
										+'<option value="40">40세 이상</option></select></td></tr>';
							content += '<tr><th>선택사항</th><td>'
  										//+'<input type="checkbox" id="house_option" name="house_option" value="pet">애완동물 가능&nbsp;&nbsp;'
										+'<input style="MARGIN: 0px 3px 1px 0px; WIDTH: 13px; HEIGHT: 13px" type="checkbox" id="house_option" name="house_option" value="pet">애완동물 가능'
										//+'<input type="checkbox" id="house_option" name="house_option" value="onlyWoman">여성전용&nbsp;&nbsp;'
										+'<input style="MARGIN: 0px 3px 1px 10px; WIDTH: 13px; HEIGHT: 13px" type="checkbox" id="house_option" name="house_option" value="onlyWoman">여성전용'
										//+'<input type="checkbox" id="house_option" name="house_option" value="onlyMan">남성전용'
										+'<input style="MARGIN: 0px 3px 1px 10px; WIDTH: 13px; HEIGHT: 13px" type="checkbox" id="house_option" name="house_option" value="onlyMan">남성전용'
										//+'<br><input type="checkbox" id="house_option" name="house_option" value="noSmoker">금연&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' 
										+'<br><input style="MARGIN: 0px 3px 1px 0px; WIDTH: 13px; HEIGHT: 13px" type="checkbox" id="house_option" name="house_option" value="noSmoker">금연' 
										//+'<input type="checkbox" id="house_option" name="house_option" value="noDrink">금주<br>'
										+'<input style="MARGIN: 0px 3px 1px 80px; WIDTH: 13px; HEIGHT: 13px" type="checkbox" id="house_option" name="house_option" value="noDrink">금주<br>'
										//+'<input type="checkbox" id="house_option" name="house_option" value="study">스터디 그룹&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
										+'<input style="MARGIN: 0px 3px 1px 0px; WIDTH: 13px; HEIGHT: 13px" type="checkbox" id="house_option" name="house_option" value="study">스터디 그룹'
										//+'<input type="checkbox" id="house_option" name="house_option" value="WiFi">WiFi</td></tr></table>';
										+'<input style="MARGIN: 0px 3px 1px 26px; WIDTH: 13px; HEIGHT: 13px" type="checkbox" id="house_option" name="house_option" value="WiFi">WiFi</td></tr></table>';
							content += '<br> <input type="submit" value="상세검색" class="button-input">'
										+'<input type="button" id="closeWin" value="닫기" class="button-input">'
							content += '</form>';
						
							
							var dialog = $('#dialog').html(content);

							var dialogBox = $('.dialog'), dialogTrigger = $('#detailSearch'), dialogClose = $('.dialog__close'), dialogTitle = $('.dialog__title'), dialogContent = $('.dialog__content');
							var dialogClosebutton = $('#closeWin')
				
							dialogBox.toggleClass('dialog--active');
				
							dialogClose.on('click', function() {
								dialogBox.removeClass('dialog--active');
							});
							dialogClosebutton.on('click', function() {
								dialogBox.removeClass('dialog--active');
							}); 
					}
				})
	}
   
</script>

<style type="text/css">
   
td, th {
	padding: 6;
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
	width: 40%;
	height: 55%;
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
select {
	width: 80%;
	height: 36px;
	padding: 5px 10px;
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
}

.centeralize {
	text-align: center;
	width: 500px; /* 정렬하려는 요소의 넓이를 반드시 지정 */
	margin: 0 auto;
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
      <!-- END: header -->
      <section id="intro">
         <div class="container">
            <div class="row">
               <div
                  class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
                  <div class="intro animate-box">
                     <h1 class="headerTitle">
                        楽し荘 <span class="typed-cursor">|</span>
                     </h1>
                     <form id="search" action="house/search" method="get">
                        <input type=text id="keyword" name="keyword" class="text-search"
                           placeholder="쉐어하우스 검색" size="50" width="50"> <input
                           type="submit" id="submit" value="검색" class="button-input">
                        <input type="button" id="detailSearch" value="상세검색"
                           class="button-input">

                     </form>
                     <br>
                     <c:if test="${loginInfo.member_type=='General' }">
                        <a href="${pageContext.request.contextPath}/house/insert">
                           지금 쉐어하우스를 등록해보세요! </a>

                     </c:if>
                  </div>
               </div>
            </div>
         </div>
      </section>

      <section id="work">
         <div class="container">
            <div class="col-md-12">
               <div class="fh5co-grid animate-box"
                  style="background-image: url(images/sharehouse1.jpg);">
                  <a class="image-popup text-center" href="#">
                     <div class="work-title">
                        <h3>楽し荘(타노시소우)</h3>
                        <span style="font-size: 20px;">쉐어하우스 생활을 보다 편리하게, 楽し荘</span>
                     </div>
                  </a>

               </div>
            </div>
            <div class="col-md-8">
               <div class="fh5co-grid animate-box"
                  style="background-image: url(images/sharehouse2.jpg);"></div>
            </div>
            <div class="col-md-4">
               <div class="fh5co-grid animate-box"
                  style="background-image: url(images/sharehouse3.jpg);"></div>
            </div>
         </div>
      </section>

      <section id="services">
         <div class="container">
            <div class="row">
               <div class="col-md-4 animate-box">
                  <div class="service">
                     <div class="service-icon">
                        <i class="icon-command"></i>
                     </div>
                     <h2>About Us</h2>
                     <p>
                        회원 등급<br> 1) Host: 쉐어하우스 관리자<br> 2) Resident: 일반 입주민<br>
                        3) General: 일반 회원<br>
                     </p>
                  </div>
               </div>
               <div class="col-md-4 animate-box">
                  <div class="service">
                     <div class="service-icon">
                        <i class="icon-drop2"></i>
                     </div>
                     <h2>Contact Us</h2>
                     <p>
                        TEL: 02-1234-5678<br> E-MAIL: tanoshisou@aaaa.com
                     </p>
                  </div>
               </div>
               <div class="col-md-4 animate-box">
                  <div class="service">
                     <div class="service-icon">
                        <i class="icon-anchor"></i>
                     </div>
                     <h2>Used tools</h2>
                     <p>Java, Spring, Html, servlet/jsp, bootstrap</p>
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
   <div class="dialog" id="dialog"></div>
   <!-- END: box-wrap -->

   <!-- jQuery -->
   <script src="js/jquery-3.1.1.min.js"></script>
   <!-- jQuery Easing -->
   <script src="js/jquery.easing.1.3.js"></script>
   <!-- Bootstrap -->
   <script src="js/bootstrap.min.js"></script>
   <!-- Waypoints -->
   <script src="js/jquery.waypoints.min.js"></script>

   <!-- Main JS (Do not remove) -->
   <script src="js/main.js"></script>


</body>
</html>