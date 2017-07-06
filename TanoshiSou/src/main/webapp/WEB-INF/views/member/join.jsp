<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<!-- JQuery 와 Bootstrap -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<title>회원가입</title>
<script type="text/javascript">
$(function(){
   $("#uploadFile").on('click',proFileShow); 
});

   // 파일 처리 
function proFileShow() { 
   var upload = document.getElementsByName('uploadFile')[0],
      holder = $("#holder");
   
   upload.onchange = function (e) {
      e.preventDefault();
      var file = upload.files[0],
         reader = new FileReader();
      reader.onload = function (event) {
         var img = new Image();
         img.src = event.target.result;
         img.width = 150;
         img.height = 200;
         holder.innerHTML = '';
         //appendChild is not a function 에러 수정
         //holder.appendChild(img);
         var div=document.createElement("div");
         div.appendChild(img);
         document.getElementById('holder').appendChild(div);
      };
      reader.readAsDataURL(file);
      return false;
   };
}
   function memberChecking(){
      //값 불러오는 부분 수정 ajax-> javascript
      var memberId=document.getElementById('member_id');
      //회원 아이디                   
      //회원 이름
      var memberName=document.getElementById('member_name');
      //회원 별칭
      var memberNickname=document.getElementById('member_nickname');
      //회원 전화번호
      var memberPhone=document.getElementById('memberPhone');
      //회원 이메일
      var memberEmail=document.getElementById('member_email');
      //회원 이메일 목록
      var memberemailLIst=document.getElementById('member_emailLIst');
      //회원 소속(집 - 일반회원 - general)
      var memberBelongto=document.getElementById('member_belongto');
      //회원 비밀번호 찾기 질문(콤보박스에 질문 번호로 저장)
      var memberPasswordCheckQ=document.getElementById('member_password_check_q');
      //회원 비밀번호 찾기 답
      var memberPasswordCheckA=document.getElementById('member_password_check_a');
   
      if(memberId.value=='' || memberId.value.length>= 20 || memberId.value.length <= 3 || !isNaN(memberId.value)){
         alert('아이디를 숫자로 쓸수 없으며, 4자이상 20자 이하로 입력해주십시오.');
         memberId.focus();
         return false;
      }
       if(memberName.value=='' || memberName.value.length<= 1 || memberName.value.length >= 11 || !isNaN(memberId.value)){
         alert('이름을 입력해주세요.\n최소2자이상 최대 10자 이하로 입력해 주십시오.');
         memberName.focus();
         return false;
      }
       if(memberNickname.value=='' || memberNickname.value.length<= 1 || memberNickname.value.length >= 21){
         alert('별명을 입력해주세요.\n최소2자이상 최대 20자 이하로 입력해 주십시오.');
         memberNickname.focus();
         return false;
      }
       if(memberPhone.value=='' || memberPhone.value.length<= 10 || memberPhone.value.length >= 15 || isNaN(memberPhone.value)){
         alert('전화번호를 잘못 입력하셨거나, 문자가 포함되어 있습니다.');
         memberPhone.focus();
         return false;
      }
    
       if(memberBelongto.value==''){
         alert('소속지를 선택해 주십시오.');
         memberBelongto.focus();
         return false;
      }
       if(memberPasswordCheckQ.value==''){
         alert('질문을 선택해 주십시오.');
         memberPasswordCheckQ.focus();
         return false;
      }
       if(memberPasswordCheckA.value==''){
         alert('질문의 답을 입력해주세요.');
         memberPasswordCheckA.focus();
         return false;
      }
       return true;
   }
   
   // 아이디 체크
$(function(){
       $('#member_id').on('change',function(){
         $.ajax({
            method : 'post', 
            url : '${pageContext.request.contextPath}/member/checkMemberID', 
            data : {'member_id' : $('#member_id').val()}, 
            success : function(resp){
               if(resp == '')$('#checkingBox').html('사용가능한 아이디 입니다.');
               if(resp != '')$('#checkingBox').html('이미 아이디가 존재합니다.');
            }
         });
      });
   })
   
   //이 메일 체크
   $(function(){
      var member_emailLIst=document.getElementById('member_emailLIst');
      if(member_emailLIst.value!='notSelected'){   
      $('#member_email').on('change',function(){
         var flag = true;
         $.ajax({
            method : 'post', 
            url : '${pageContext.request.contextPath}/member/checkMemberEmail', 
            data : {'memberEmail' : $('#member_email').val() , 'emailLIst' : $('#member_emailLIst').val()}, 
            success : function(resp){
               $('#checkingEmail').html('');
               if(resp == '')$('#checkingEmail').html('사용가능한 이메일 입니다.');
               if(resp != '')$('#checkingEmail').html('이미 이메일이 존재합니다.');
            }
         });   
      });
      }
   }); 
 //이 메일 체크
   $(function(){   
      $('#member_emailLIst').on('change',function(){
         var flag = true;
         $.ajax({
            method : 'post', 
            url : '${pageContext.request.contextPath}/member/checkMemberEmail', 
            data : {'memberEmail' : $('#member_email').val() , 'emailLIst' : $('#member_emailLIst').val()}, 
            success : function(resp){
               $('#checkingEmail').html('');
               if(resp == ''){
                  $('#checkingEmail').html('사용가능한 이메일 입니다.');
                  $('#checkingEmail').attr('style','color: blue');
               }
               if(resp != ''){
                  $('#checkingEmail').html('이미 이메일이 존재합니다.');
                  $('#checkingEmail').attr('style','color: red');
                  }
              }
         });  
      });
    $('#member_emailLIst').blur(function(){
       $.ajax({
          method : 'post', 
          url : '${pageContext.request.contextPath}/member/checkMemberEmail', 
          data : {'memberEmail' : $('#member_email').val() , 'emailLIst' : $('#member_emailLIst').val()}, 
          success : function(resp){
        	  $('#checkingEmail').html('');
             if(resp == ''){
                $('#checkingEmail').html('사용가능한 이메일 입니다.');
                $('#checkingEmail').attr('style','color: blue');
             }
             if(resp != ''){
                $('#checkingEmail').html('이미 이메일이 존재합니다.');
                $('#checkingEmail').attr('style','color: red');
             }
          }
       })
    })
    $('#member_emailLIst0').blur(function(){
       $.ajax({
          method : 'post', 
          url : '${pageContext.request.contextPath}/member/checkMemberEmail', 
          data : {'memberEmail' : $('#member_email').val() , 'emailLIst' : $('#member_emailLIst').val()}, 
          success : function(resp){
        	  $('#checkingEmail').html('');
             if(resp == ''){
                $('#checkingEmail').html('사용가능한 이메일 입니다.');
                $('#checkingEmail').attr('style','color: blue');
             }
             if(resp != ''){
                $('#checkingEmail').html('이미 이메일이 존재합니다.');
                $('#checkingEmail').attr('style','color: red');
             }
          }
       })
    })
   if($('#member_email').val().langth != 0){
    $('#member_email').blur(function(){
       $.ajax({
          method : 'post', 
          url : '${pageContext.request.contextPath}/member/checkMemberEmail', 
          data : {'memberEmail' : $('#member_email').val() , 'emailLIst' : $('#member_emailLIst').val()}, 
          success : function(resp){
             if(resp == ''){
                $('#checkingEmail').html('사용가능한 이메일 입니다.');
                $('#checkingEmail').attr('style','color: blue');
             }
             if(resp != ''){
                $('#checkingEmail').html('이미 이메일이 존재합니다.');
                $('#checkingEmail').attr('style','color: red');
             }
          }
       })   
    })
    }
   //전화번호 체크
      $('#member_phone').on('change',function(){
         $.ajax({
            method : 'post', 
            url : '${pageContext.request.contextPath}/member/checkMemberPhone', 
            data : {'memberPhone' : $('#member_phone').val()}, 
            success : function(resp){
               if(resp == ''){
                  $('#checkingPhone').html('사용가능한 전화번호 입니다.');
                  $('#checkingPhone').attr('style','color: blue');
               }
               if(resp != ''){
                  $('#checkingPhone').html('이미 전화번호가 존재합니다.');
                  $('#checkingPhone').attr('style','color: red');
               }
            }
         });
      })
   // 비밀번호 확인
      $('#member_password').keyup(function(){
          if($('#member_password').val()=='' || $('#member_password').val().length<= 8 || $('#member_password').val().length >= 21){
             $('#passwordCheck').html('비밀번호를 입력해 주십시오.8자 이상 20자 이하로 작성해주세요.');
             $('#passwordCheck').attr('style','color: red');
          }else{
             $('#passwordCheck').html('비밀번호 확인란을 작성해 주십시오.');
             $('#passwordCheck').attr('style','color: blue');
          }
   })
      $('#member_password_C').keyup(function(){
        if($('#member_password').val()!=$('#member_password_C').val()){
           $('#passwordCheck').html('비밀번호가 같지 않습니다.');
           $('#passwordCheck').attr('style','color: red');
          }else{
             $('#passwordCheck').html('사용가능한 비밀번호 입니다..');
             $('#passwordCheck').attr('style','color: blue');
          }
   })
   
   // 이메일 직접처리
   $('#member_emailLIst0').hide();
   $('#cancle').hide();
   $('#member_emailLIst').change(function() {
      if ($(this).val() === 'direct') {
         $('#member_emailLIst0').show();
         $('#cancle').show();
         $('#member_emailLIst').hide();
         $('#member_emailLIst0').attr('id', 'member_emailLIst');
         $('#member_emailLIst').attr('id', 'member_emailLIst0');
         $('#member_emailLIst').attr('name', 'member_emailLIst');
         $('#member_emailLIst0').attr('name', 'member_emailLIst0');
      }
      $('#cancle').on('click', function() {
         $('#member_emailLIst').attr('id', 'member_emailLIst0');
         $('#member_emailLIst0').attr('id', 'member_emailLIst');
         $('#member_emailLIst').attr('name', 'member_emailLIst');
         $('#member_emailLIst0').attr('name', 'member_emailLIst0');
         $('#cancle').hide();
         $('#member_emailLIst0').hide();
         $('#member_emailLIst').show();
      })
   })
   })
   
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
select {
	padding: 5px 10px;
	border: 3px solid #ccc;
	background-color: transparent;
}

select:focus {
	color: #000;
	outline: none;
	border: 3px solid #52d3aa;
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
		<div class="Mainwrap">
			<form id="joinForm" action="join" method="post"
				enctype="multipart/form-data" onsubmit="return memberChecking();">
				<div class="col-md-8 col-md-offset-2 animate-box">
					<h1>Join Us</h1>
					<!-- 선 없는 테이블 형태로 수정 -->
					<table>
						<tr>
							<th>ID</th>
							<td><input type="text" id="member_id" name="member_id"
								class='reply_text' placeholder="4자이상 20자 이하로 입력해주십시오." size="60"
								width="50"></td>
						</tr>
						<tr>
							<td></td>
							<td><p id="checkingBox"></p></td>
						</tr>
						<tr>
							<th>Name</th>
							<td><input type="text" id="member_name" name="member_name"
								size="60" width="50" class='reply_text'></td>
						</tr>
						<tr>
							<th>Nickname</th>
							<td><input type="text" id="member_nickname"
								name="member_nickname" size="60" width="50" class='reply_text'></td>
						</tr>
						<tr>
							<th>Password</th>
							<td><input type="password" id="member_password"
								name="member_password" size="60" width="50" class='reply_text'></td>
						<tr>
							<th>Password 확인</th>
							<td><input type="password" id="member_password_C"
								name="member_password_C" size="60" width="50" class='reply_text'></td>
						</tr>
						<tr>
							<td></td>
							<td><p id="passwordCheck"></p></td>
						</tr>
						<tr>
							<th>프로필 파일</th>
							<td><input type="file" id="uploadFile" name="uploadFile"
								accept=".gif, .jpg, .png"></td>
						</tr>
						<tr>
							<td></td>
							<td><div id='holder'></div></td>
						</tr>
						<tr>
							<th>PhoneNumber</th>
							<td><input type="text" id="member_phone" name="member_phone"
								placeholder="-없이 작성해 주십시오." size="60" width="50"
								class='reply_text'></td>
						<tr>
							<td></td>
							<td><p id="checkingPhone"></p></td>
						</tr>
						<tr>
							<th>E-MAIL</th>
							<td><input type="text" id="member_email" name="member_email"
								class='reply_text' style='width: 45%;'>@ <select
								id="member_emailLIst" name="member_emailLIst"
								style='width: 30%;'>
									<option selected="selected" value='notSelected'>선택</option>
									<option value="gmail.com">gmail.com</option>
									<option value="naver.com">naver.com</option>
									<option value="hanmail.com">hanmail.net</option>
									<option value="direct">직접입력</option>
							</select> <input type="text" id="member_emailLIst0" class='reply_text'
								name="member_emailLIst0"> <input type="button"
								class='reply_text' id="cancle" value="취소"></td>
						</tr>
						<tr>
							<td></td>
							<td><p id="checkingEmail">이메일은 비밀번호 찾기시 반드시 필요합니다.</p></td>
						</tr>
						<tr>
							<th>비밀번호 찾기 질문</th>
							<td><select name="member_password_check_q">
									<option selected="selected" value="">선택</option>
									<option value="1">중학교 선생님 이름?</option>
									<option value='2'>나의 별명은?</option>
							</select></td>
						</tr>
						<tr>
							<th>비밀전호 찾기 답</th>
							<td><input type="text" id="member_password_check_a"
								name="member_password_check_a" size="60" width="50"
								class='reply_text'></td>
					</table>
					<br>
					<div>
						<input type="submit" class="button-input" value="가입하기"> <input
							type="reset" class="button-input" value="다시쓰기"> <input
							type="button" class="button-input"
							onclick="location.href='${pageContext.request.contextPath}/'"
							value="처음으로">
					</div>
				</div>
			</form>
		</div>
	</div>
	<br>
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