<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<!-- JQuery 와 Bootstrap -->
<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<head>
<title>회원 정보 수정</title>
</head>
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
#headerNavi {
	position: absolute;
	top: 45px;
}

#buttons {
	text-align: center;
}

#member_emailLIst0 {
	position: relative;
	float: left;
}

#cancle {
	position: relative;
	float: left;
}

h1 {
	text-align: center;
}

.Mainwrap {
	margin: auto;
}

table {
	margin: auto;
	border-spacing: 0;
}

#holder {
	text-align: center;
}

input#member_emailLIst0 {
	float: left;
}
</style>
<script type="text/javascript">
function proFileShow() {
   var upload = document.getElementsByName('uploadFile')[0], holder = document
         .getElementById('holder');

   upload.onchange = function(e) {
      e.preventDefault();
      var file = upload.files[0], reader = new FileReader();
      reader.onload = function(event) {
         var img = new Image();
         img.src = event.target.result;
         img.width = 150;
         img.height = 200;
         holder.innerHTML = '';
         holder.appendChild(img);
      };
      reader.readAsDataURL(file);
      return false;
   };
}
$(function() {
$('#update').on('click',function () {
   var memberNickname = $('#member_nickname1').val(); //회원 별칭
   var memberPhone = $('#member_phone1').val(); //회원 전화번호
   
   if (memberNickname.length != 0) {
      if(memberNickname.length < 2 || memberNickname.length > 21){
         alert('별명을 입력해주세요.\n최소2자이상 최대 20자 이하로 입력해 주십시오.');
         memberNickname.focus();
         return false;
      }
   }
   if (memberPhone.length != 0) {
      if(memberPhone.length < 10 || memberPhone.length > 13 || isNaN(memberPhone)){
         alert('전화번호를 잘못 입력하셨거나, 문자가 포함되어 있습니다.');
         memberPhone.focus();
         return false;
      }
   }
   NonupdateDate();
})

//아무 정보 없이 입력했을때 보내기
function NonupdateDate(){
      if($('#member_nickname1').val().length !=0){
      $('#member_nickname').val($('#member_nickname1').val());
      }
      
      if($('#member_password1').val().length !=0){
      $('#member_password').val($('#member_password1').val());
      }
      
      if($('#member_phone1').val().length != 0){
      $('#member_phone').val($('#member_phone1').val());
      }
      /*
      if($('#member_email0').val().length !=0){
      $('#member_email').val($('#member_email1').val());
      $('#member_emailLIst').val('@'+$('#member_emailLIst1').val());
      }*/
      
      if($('#member_password_check_q1').val().length !=0){
      $('#member_password_check_q').val($('#member_password_check_q1').val());
      $('#member_password_check_a').val($('#member_password_check_a1').val());
      }
       $('#updatedata').submit();
}
//이 메일 체크
   $('#member_emailLIst1').blur(function() {
      var flag = true;
      if ($(this).val() != 'direct') {
         $.ajax({
            method : 'post',
            url : 'checkMemberEmail',
            data : {
               'memberEmail' : $('#member_email1').val(),
               'emailLIst' : $('#member_emailLIst1').val()
            },
            success : function(resp) {
               
               if (resp == ''){
                  $('#checkingEmail').css('color','blue');
                  $('#checkingEmail').html('   사용가능한 이메일 입니다.');
                  }
               if (resp != ''){
                  $('#checkingEmail').css('color','red');
                  $('#checkingEmail').html('   이미 이메일이 존재합니다.');
                  Emailchecking(); 
               }
            }
         })
      }
   })
})
function Emailchecking(){
   $('#member_email1').blur(function() {
      var flag = true;
      $.ajax({
         method : 'post',
         url : 'checkMemberEmail',
         data : {
            'memberEmail' : $('#member_email1').val(),
            'emailLIst' : $('#member_emailLIst1').val()
         },
         success : function(resp) {
            if (resp == ''){
               $('#checkingEmail').css('color','blue');
               $('#checkingEmail').html('   사용가능한 이메일 입니다.');
            }
            if (resp != ''&& $('#member_email1').val().length != 0){
               $('#checkingEmail').css('color','red');
               $('#checkingEmail').html('   사용 불가능한 이메일 입니다.');
            }
         }
      })
   })
}

$(function() {
   $('#member_emailLIst1').blur(function() {
      var flag = true;
      $.ajax({
         method : 'post',
         url : 'checkMemberEmail',
         data : {
            'memberEmail' : $('#member_email1').val(),
            'emailLIst' : $('#member_emailLIst1').val()
         },
         success : function(resp) {
            if( $('#member_email1').val().length !=0 && $('#member_emailLIst1').val().length != 0){
            if (resp == ''){
               $('#checkingEmail').css('color','blue');
               $('#checkingEmail').html('   사용가능한 이메일 입니다.');
            }
            if (resp != ''){
               $('#checkingEmail').css('color','red');
               $('#checkingEmail').html('   이미 이메일이 존재합니다.');
            }
            }
         }
      })
   })
//전화번호 체크
   $('#member_phone1').blur(function() {
      $.ajax({
         method : 'post',
         url : 'checkMemberPhone',
         data : {
            'memberPhone' : $('#member_phone1').val()
         },
         success : function(resp) {
            if (resp == ''){
               $('#checkingPhone').css('color','blue');
               $('#checkingPhone').html('   사용가능한 전화번호 입니다.');
            }
            if (resp != ''){
               $('#checkingPhone').css('color','red');
               $('#checkingPhone').html('   이미 전화번호가 존재합니다.');
            }
         }
      })
   })
// 비밀번호 확인
   $('#member_password1').keyup(
         function() {
            if ($('#member_password1').val() == ''
                  || $('#member_password1').val().length <= 8
                  || $('#member_password1').val().length >= 21) {
               $('#passwordCheck').css('color','red');
               $('#passwordCheck').html('   비밀번호를 입력해 주십시오.8자 이상 20자 이하로 작성해주세요.');
            } else {
               $('#passwordCheck').css('color','blue');
               $('#passwordCheck').html('   비밀번호 확인란을 작성해 주십시오.');
            }
         })
   $('#member_password_C').keyup(function() {
      if ($('#member_password1').val() != $('#member_password_C').val()) {
         $('#passwordCheck').css('color','red');
         $('#passwordCheck').html('   비밀번호가 같지 않습니다.');
      } else {
         $('#passwordCheck').css('color','blue');
         $('#passwordCheck').html('   사용가능한 비밀번호 입니다..');
      }
   })
// 이메일 직접처리
   $('#member_emailLIst0').hide();
   $('#cancle').hide();
   $('#member_emailLIst1').change(function() {
      if ($(this).val() === 'direct') {
         $('#member_emailLIst0').show();
         $('#cancle').show();
         $('#member_emailLIst1').hide();
         $('#member_emailLIst0').attr('id', 'member_emailLIst1');
         $('#member_emailLIst1').attr('id', 'member_emailLIst0');
         $('#member_emailLIst1').attr('name', 'member_emailLIst1');
         $('#member_emailLIst0').attr('name', 'member_emailLIst0');
      }
      $('#cancle').on('click', function() {
         $('#member_emailLIst1').attr('id', 'member_emailLIst0');
         $('#member_emailLIst0').attr('id', 'member_emailLIst1');
         $('#member_emailLIst1').attr('name', 'member_emailLIst1');
         $('#member_emailLIst0').attr('name', 'member_emailLIst0');
         $('#cancle').hide();
         $('#member_emailLIst0').hide();
         $('#member_emailLIst1').show();
      })
   })
})
   </script>
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
		<section id="intro">
			<div class="container">
				<div class="row">
					<div
						class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
						<div class="intro animate-box">
							<h1>회 원 정 보 수 정</h1>
						</div>
					</div>
				</div>
			</div>
		</section>
		<div class="container">
			<div class="col-md-8 col-md-offset-2 animate-box">
				<!-- update action 수정 -->
				<c:if test="${result == 'success'}">
					<div class="alert alert-info alert-dismissable fade in">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong>Success!</strong> 회원 정보 수정에 성공하였습니다.
					</div>
				</c:if>
				<form id="updatedata" action="update" method="post"
					enctype="multipart/form-data">
					<div class="form-group row">
						<div class="col-md-6 field">
							<label for="lastname">프로필 사진</label>
							<div id='holder' class="fh5co-grid animate-box"
								style="background-image: url(${pageContext.request.contextPath}/images/work-1.jpg); resize: vertical;">
								<c:if test="${not empty memberProfile }">
									<img
										src="${pageContext.request.contextPath}/member/getPhoto?file_id=${memberProfile.member_file_id}"
										width="180" height="295" />
								</c:if>
							</div>
							<input type="file" id="uploadFile" name="uploadFile"
								class="form-control" onclick="proFileShow();"
								accept=".gif, .jpg, .png">
						</div>
						<div class="col-md-6 field">
							<label for="lastname">소속</label> <select id="member_belongto1"
								class="form-control" name="member_belongto1" disabled="disabled">
								<c:if test="${memberIn.member_belongto =='General' }">
									<option value="null">소속없음</option>
								</c:if>
								<c:if test="${memberIn.member_belongto !='General' }">
									<c:forEach var="list" items="${houseList }">
										<option value="${list.house_id }"
											${memberIn.member_belongto==list.house_id ? 'selected':'' }>${list.house_name}</option>
									</c:forEach>
								</c:if>
							</select>
						</div>
						<div class="col-md-6 field">
							<label for="lastname">아이디</label> <input type="text"
								id="member_id1" name="member_id1" class="form-control"
								readonly="readonly" value="${memberIn.member_id}">
						</div>
						<div class="col-md-6 field">
							<label for="lastname">이름</label> <input type="text"
								id="member_name1" name="member_name1" class="form-control"
								readonly="readonly" value="${memberIn.member_name}">
						</div>
						<div class="col-md-6 field">
							<label for="lastname">닉네임</label> <input type="text"
								id="member_nickname1" name="member_nickname1"
								class="form-control" value="${memberIn.member_nickname}">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-6 field">
							<label for="lastname">비밀번호</label> <input type="password"
								id="member_password1" name="member_password1"
								class="form-control" value="" />
						</div>
						<div class="col-md-6 field">
							<label for="lastname">비밀번호 확인</label> <input type="password"
								id="member_password_C" name="member_password_C"
								class="form-control">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12 field">
							<p id="passwordCheck"></p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-6 field">
							<c:if test="${memberIn.member_type == 'General'}">
								<c:set var="Type_member" value="일반고객" />
							</c:if>
							<c:if test="${memberIn.member_type == 'Host'}">
								<c:set var="Type_member" value="집관리자" />
							</c:if>
							<c:if test="${memberIn.member_type == 'Resident'}">
								<c:set var="Type_member" value="입주민" />
							</c:if>
							<label for="lastname">고객 타입</label> <input type="text"
								id="member_type1" class="form-control" name="member_type1"
								value="${Type_member}" disabled="disabled">
						</div>
						<div class="col-md-6 field">
							<label for="lastname">전화번호</label> <input type="tel"
								id="member_phone1" class="form-control" name="member_phone1"
								value="" placeholder="-없이 작성해 주십시오.">
							<p id="checkingPhone"></p>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-6 field">
							<label for="email">이메일</label> <input type="text"
								id="member_email1" class="form-control" name="member_email1">
						</div>
						<p style="height: 11px;"></p>
						<div class="col-md-6 field">
							<select id="member_emailLIst1" class="form-control"
								name="member_emailLIst1">
								<option selected="selected" value='null'>이메일 선택</option>
								<option value="@gmail.com">@gmail.com</option>
								<option value="@naver.com">@naver.com</option>
								<option value="@hanmail.com">@hanmail.net</option>
								<option value="direct">직접입력</option>
							</select> <input type="text" class="form-control" id="member_emailLIst0"
								name="member_emailLIst0" style="width: 270px;"> <input
								type="button" class="btn btn-primary" id="cancle" value="취소"
								style="height: 55px;">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-6 field">
							<p id="checkingEmail" />
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12 field">
							<label for="lastname">비밀번호 찾기 질문</label> <select
								id="member_password_check_q1" class="form-control"
								name="member_password_check_q1">
								<option selected="selected" value="">선택</option>
								<option value="1">중학교 선생님 이름?</option>
								<option value="2">나의 별명은?</option>
								<option value="3">내가 존경하는 사람은?</option>
								<option value="4">나의 좌우명은?</option>
								<option value="5">가장 기억에 남는 장소는?</option>
								<option value="6">우리집 반려동물의 이름은?</option>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12 field">
							<label for="lastname">비밀번호 찾기 답</label> <input type="text"
								id="member_password_check_a1" class="form-control"
								name="member_password_check_a1" size="60" width="50">
						</div>
					</div>
					<input type="hidden" name="member_id" id="member_id"
						value="${memberIn.member_id }"> <input type="hidden"
						name="member_name" id="member_name"
						value="${memberIn.member_name }"> <input type="hidden"
						name="member_nickname" id="member_nickname"
						value="${memberIn.member_nickname}"> <input type="hidden"
						name="member_password" id="member_password"
						value="${memberIn.member_password}"> <input type="hidden"
						name="member_type" id="member_type"
						value="${memberIn.member_type}"> <input type="hidden"
						name="member_phone" id="member_phone"
						value="${memberIn.member_phone}"> <input type="hidden"
						name="member_email" id="member_email"
						value="${memberIn.member_email}"> <input type="hidden"
						name="member_emailLIst" id="member_emailLIst"
						value="${memberIn.member_emailLIst}"> <input type="hidden"
						name="member_belongto" id="member_belongto"
						value="${memberIn.member_belongto}"> <input type="hidden"
						name="member_password_check_q" id="member_password_check_q"
						value="${memberIn.member_password_check_q}"> <input
						type="hidden" name="member_password_check_a"
						id="member_password_check_a"
						value="${memberIn.member_password_check_a}"> <input
						type="hidden" id="member_file_name" name="member_file_name"
						value="${memberProfile.member_file_id}">
					<div class="form-group row">
						<div class="col-md-12 field" id="buttons">
							<input type="button" id="update" class="btn btn-primary"
								value="수정하기"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
								type="reset" class="btn btn-primary" value="다시쓰기">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="HOME" class="btn btn-primary" onclick="location.href='../'">
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>
	<!-- <div class="col-md-4"></div> -->
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