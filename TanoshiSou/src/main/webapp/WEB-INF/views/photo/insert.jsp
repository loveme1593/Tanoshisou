<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>일상 공유하기</title>
<!-- JQuery 와 Bootstrap -->
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicons/favicon.ico">

<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,300,700|Roboto:300,400' rel='stylesheet' type='text/css'>
<!-- Animate.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animate.css">
<!-- Icomoon Icon Fonts-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/icomoon.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<script src="${pageContext.request.contextPath}/resources/js/modernizr-2.6.2.min.js"></script>
<script>
   function toList() {
      location.href = "${pageContext.request.contextPath}/photo/main";
   }
   function fileClear(obj) {
      obj.value = "";
      // -->이렇게 되어있는건 인터넷소스. 파일폼이 너무길면 소스가 지저분해진다.
      //  document.form.file1.outerHTML = '<input type="file" name="file1">';
      //-->이건 응용한 소스. 기존의 obj의 outerHTML에서 value를 지우고 새로 만들었다.
      obj.outerHTML = obj.outerHTML;
   }
   function readURL(input, num) {
      if (input.files && input.files[0]) {
         if (input.files[0].size > 5120 * 5120) {
            alert('5MB를 초과한 파일 첨부는 불가합니다.');
            //파일 첨부 실패했을 때 file 내 값 초기화
            fileClear(document.getElementById('photo' + num));
            return;
         } else if (input.files[0].type.indexOf('image') < 0) {
            alert('이미지 파일만 첨부 가능합니다.');
            fileClear(document.getElementById('photo' + num));
            return;
         } else {
            var reader = new FileReader();
            reader.onload = function(e) {
               $('#' + num).attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
         }
      } else {
         //선택된 파일이 없을 땐 미리보기에 떠 있던 파일이 사라지도록 함
         $('#' + num).attr('src', '../images/noimage.png');
      }
   }
   function checkInsertP() {
      var board_title = document.getElementById('board_title');
      if (board_title.value.charAt(0) == ' ') {
         alert('제목은 공백으로 시작할 수 없습니다.');
         board_title.value = '';
         board_title.focus();
         return false;
      }
      var photo1 = document.getElementById('photo1');
      var photo2 = document.getElementById('photo2');
      var photo3 = document.getElementById('photo3');
      var photo4 = document.getElementById('photo4');
      var photo5 = document.getElementById('photo5');
      var photo6 = document.getElementById('photo6');
      if (photo1.value == '' && photo2.value == '' && photo3.value == ''
            && photo4.value == '' && photo5.value == ''
            && photo6.value == '') {
         alert('사진 파일은 하나 이상 업로드가 되어야 합니다.');
         return false;
      }
      return true;
   }
   function toList() {
      location.href = "${pageContext.request.contextPath}/photo/?page=1";
   }
   
</script>
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
         <li><a class="verticalNav"
            href="${pageContext.request.contextPath}/house/?id=${loginInfo.member_belongto}">
               <img src="${pageContext.request.contextPath}/resources/images/home-icon.png" alt="홈으로" width="30" align=left> Home
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
            <li><a class="verticalNav"
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
            <li><a class="verticalNav active"
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
                        <form action="insertPhoto" method="post"
                           enctype="multipart/form-data" onsubmit="return checkInsertP();">
                           <input type="hidden" id="board_category" name="board_category" value="photo">
                           <h3>사진 올리기</h3>
                           <table>
                              <tr>
                                 <td colspan="3"><input type="text" id="board_title" name="board_title" class="text-search" placeholder="일상 제목을 입력하세요." style="width: 500px;" required>
                                 <input type="date" id="board_content"  name="board_content"  class="text-search" required="required" style="width: 250px;"></td>
                              </tr>
                              <tr>
                                 <td><input type='file'  onchange='readURL(this,1);' id='photo1' name='photo1' class="button-input" style="display: none;" />
                                 <img src='../images/add_image.png' width='350px' height='290px' id='1' name='upload' alt='그림파일이 아닙니다' class="button-input" onclick="$('#photo1').trigger('click');"></td>
                                 <td><input type='file' id='photo2' name='photo2' onchange='readURL(this,2);' class="button-input" style="display: none;"  />
                                 <img src='../images/add_image.png' width='350px' height='290px' id='2' alt='그림파일이 아닙니다' class="button-input" onclick="$('#photo2').trigger('click');"></td>
                                 <td><input type='file' id='photo3' name='photo3' onchange='readURL(this,3);' class="button-input" style="display: none;" />
                                 <img src='../images/add_image.png' width='350px' id='3' height='290px' alt='그림파일이 아닙니다' class="button-input" onclick="$('#photo3').trigger('click');"> </td>
                              </tr>
                              <tr><td><br></td></tr>
                              <tr>
                                 <td><input type='file' id='photo4' name='photo4' onchange='readURL(this,4);' class="button-input" style="display: none;" /> 
                                 <img src='../images/add_image.png' width='350px' id='4' height='290px' alt='그림파일이 아닙니다' class="button-input" onclick="$('#photo4').trigger('click');"></td>
                                 <td><input type='file' id='photo5' name='photo5' onchange='readURL(this,5);' class="button-input" style="display: none;" />
                                 <img src='../images/add_image.png' width='350px' id='5' height='290px' alt='그림파일이 아닙니다' class="button-input" onclick="$('#photo5').trigger('click');"> </td>
                                 <td><input type='file' id='photo6' name='photo6' onchange='readURL(this,6);' class="button-input" style="display: none;" /> 
                                 <img src='../images/add_image.png' width='350px' id='6' height='290px' alt='그림파일이 아닙니다' class="button-input" onclick="$('#photo6').trigger('click');"> </td>
                              </tr>
                           </table>
                           <input type="submit" value="등록" class="button-input"> 
                           <input type="button" value="취소" onclick="toList();" class="button-input">
                        </form>
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
   </div>
</body>
</html>