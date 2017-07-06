<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사진첩 보기</title>
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
<script>
 function deletePhoto(board_id) {
  if (confirm("정말로 삭제하시겠습니까?")) {
   location.href = "${pageContext.request.contextPath}/photo/deletePhoto?board_id="
     + board_id;
  }
 }
 function updatePhoto(board_id) {
  location.href = "${pageContext.request.contextPath}/photo/updatePhoto?board_id="
    + board_id;
 }
 $(function() {
  replyList();
  $('#insertReplyOpen').on('click', insertReply);
  $('#updateWindow').on('click', updateWindow);
  $('#deleteReply').on('click', deleteReply);
 })
 function insertReply() {
  var board_id = "${getPhoto.board_id}";
  var reply_nickname = "${reply_nickname}";
  var reply_text = document.getElementById('reply_text');
  $.ajax({
   method : "post",
   url : "insertReply",
   data : {
    "board_id" : board_id,
    "reply_nickname" : reply_nickname,
    "reply_text" : $('#reply_text').val()
   },
   success : function() {
    replyList();
    var temp = '';
    //$("#reply_text").html(temp);
    reply_text.value=temp;
   }
  });
 }

 function replyList() {
  var board_id = "${getPhoto.board_id}";
  $.ajax({
   method : "get",
   url : "getReplies",
   data : {
    "board_id" : board_id
   },
   success : output,
   error : function() {
    alert('error');
   }
  });
 }
 function output(resp) {
  $("#getReplies").empty();
  var temp = '';
  temp += '<table class="table-reply">';
  $
    .each(
      resp,
      function(index, item) {
       temp += "<tr>";
       temp += "<td>" + item.reply_nickname + "</td>";
       temp += "<td><div class="+item.reply_num+">"
         + item.reply_text + "</div></td>";
       temp += "<td>" + item.reply_inputdate + "</td>";
       //댓글 수정, 삭제버튼 나타나는 것 처리
       if ("${loginInfo.member_nickname}" == item.reply_nickname) {
        temp += "<td><span class="+item.reply_num+"><a href='#' id='updateWindow' reply_num="+item.reply_num;
       temp+= ">수정</a></span></td>";
        temp += "<td><a href='#' id='deleteReply' reply_num="+item.reply_num+">삭제</a>";
       } else {
        temp += "<td></td>";
        temp += "<td></td>";
       }
       temp += "</tr>";
      });
  temp += "</table>";
  $('#getReplies').html(temp);
  $('#updateWindow').on('click', updateWindow);
  $('#deleteReply').on('click', deleteReply);
 }
 function updateWindow() {
  var temp = '';
  var reply_num = $(this).attr('reply_num');
  temp += "<input type='text' id='reply_update' class='reply_text'>";
  $('div.' + reply_num).html(temp);
  //$('span.' + reply_num)
  //  .html(
  //    "<input type='button' id='updateReply' class='btn btn-primary' value='수정' reply_num="+reply_num+">");
  $('span.' + reply_num).html(
    "<a href='#' id='updateReply' reply_num="+reply_num+">수정</a>");
  $('#updateReply').on('click', updateReply);
 }
 function updateReply() {
  var reply_num = $(this).attr("reply_num");
  $.ajax({
   method : "post",
   url : "updateReply",
   data : {
    "reply_num" : reply_num,
    "reply_text" : $("#reply_update").val()
   },
   success : replyList
  });
 }
 function deleteReply() {
  var reply_num = $(this).attr("reply_num");
  if (confirm('삭제하시겠습니까?')) {
   $.ajax({
    method : "post",
    url : "deleteReply",
    data : {
     "reply_num" : reply_num
    },
    success : replyList
   });
  }
 }
 function toList() {
  location.href = "${pageContext.request.contextPath}/photo/?page=1";
 }
</script>
<style>
/*reply table*/
.table-reply {
 border-collapse: collapse;
 width: 100%;
}

.table-reply th, td {
 padding: 8px;
 text-align: left;
 border-bottom: 1px solid #ddd;
}

/*input type css*/
.reply_text {
 width: 80%;
 padding: 5px 10px;
 margin: 8px 0;
 box-sizing: border-box;
 border: 3px solid #ccc;
 -webkit-transition: 0.5s;
 transition: 0.5s;
 outline: none;
}

.reply_text:focus {
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
       <section id="content">

        <!-- <input type="button" value="리스트로" onclick="toList()"
         class="btn btn-primary"> -->
        <table class="table-reply">
         <tr>
          <th>제목</th>
          <td>${getPhoto.board_content}의일상::${getPhoto.board_title }</td>
         </tr>
         <tr>
          <th>글쓴이</th>
          <td>${getPhoto.board_nickname }</td>
         </tr>
         <tr>
          <th>글쓴 날짜</th>
          <td>${getPhoto.board_inputdate }</td>
         </tr>
         <tr>
          <th>조회수</th>
          <td>${getPhoto.board_hits }</td>
         </tr>
         <tr>
          <td colspan="2" style="border-bottom: 1px soild #ccc"><c:forEach
            var="photo" items="${photoPath}">
            <img
             src="download?catofposts='uploadPath'&board_file_id=${photo}"
             border="0" style="width: 700px; height: 400px;">
            <p></p>
           </c:forEach></td>
         </tr>
        </table>
        <br> <input type="button" value="수정"
         onclick="updatePhoto('${getPhoto.board_id}')"
         class="btn btn-primary"> <input type="button"
         value="삭제" onclick="deletePhoto('${getPhoto.board_id}')"
         class="btn btn-primary">
        <button class="write-btn pull-right" onclick="toList()"
         style="vertical-align: middle">
         <span>리스트</span>
        </button>
        <br> <br> <input type='text' id='reply_text'
         class='reply_text' style="width: 826px;"> <input
         type='button' value='comment' class='btn btn-primary'
         id='insertReplyOpen'> <br> <br>
        <div id="insertReply"></div>
        <div id="getReplies"></div>
       </section>
      </div>
     </div>
    </div>
    <div class="clearfix"></div>
    <hr>
    <%@ include file="../footer.jsp"%>
   </div>
  </section>

 </div>
 <!-- end row -->

 <!-- END: box-wrap -->

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