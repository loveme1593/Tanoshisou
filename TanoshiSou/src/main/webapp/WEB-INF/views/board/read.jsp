<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<title>[ 게시글 읽기 ]</title>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript"
 src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
 charset="utf-8"></script>
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
<!-- FOR IE9 below -->
<script>
 $(function() {
  replyList();
  if ("${category}" == 'vote') {
   //category 가 vote인 경우 불러옴, 수정
   voteList();
  }

  $("#insertComment").on('click', insertReply);

 });
 function voteList() {
  var temp = '';
  $
    .ajax({
     method : "post",
     url : "${pageContext.request.contextPath}/voteShow",
     data : {
      "data_type" : "board",
      "pid" : "${boards.board_id}",
     },
     success : function(list) {
      temp += "<tr><th>투표 제목</th>";
      temp += "<td>" + list[0].votetitle + "</td></tr>";
      temp += '<tr><th>찬성</th>';
      temp += '<td>'
      $.each(list, function(index, item) {
       if (item.decision == "yes") {
        temp += item.member_id + "님&nbsp;";
       }
      });
      temp += "</td>";
      temp += "<tr><th>반대</th>";
      temp += '<td>'
      $.each(list, function(index, item) {
       if (item.decision == "no") {
        temp += item.member_id + "님&nbsp;";
       }
      });
      temp += "</td></tr>";
      temp += "<tr><td colspan='2'><input type='radio' name='decision' value='yes' checked>찬성";
      temp += "<input type='radio' name='decision' value='no'>반대";
      temp += "<input type='button' id='voteSave' class='button-input' value='투표하기' votetitle="+list[0].votetitle+"></td></tr>";
      $("#voteResult").html(temp);
      $('#voteSave').on('click', voteSave);
     }
    });
 }
 function voteSave() {
  var decision = $("input[type=radio][name=decision]:checked").val();
  var votetitle = $(this).attr('votetitle');
  $.ajax({
   method : "post",
   url : "${pageContext.request.contextPath}/voteSave",
   data : {
    "data_type" : "board",
    "pid" : "${boards.board_id}",
    "decision" : decision,
    "votetitle" : votetitle
   },
   success : function(list) {
    alert("해당 건에 대하여 " + decision + ' 를 선택하셨습니다.');
    voteList();
   }
  });
 }
 function deleteBoard(board_id) {
  if (confirm('삭제하시겠습니까?')) {
   //post 방식으로 바꾸기 위한것
   //location.href = "${pageContext.request.contextPath}/board/deleteBoard?board_id="
   //  + board_id;
   var deleteForm = document.getElementById("deleteForm");
   deleteForm.submit();
  }
 }
 function updateBoard(board_id) {
  location.href = "${pageContext.request.contextPath}/board/updateBoard?board_id="
    + board_id;
 }

 function insertReply() {
  var board_id = "${boards.board_id}";
  var reply_nickname = "${reply_nickname}";
  var reply_text=document.getElementById('reply_text');
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
    reply_text.value=temp;
    $("#insertReply").html(temp);
   }
  });
 }
 function replyList() {
  var board_id = "${boards.board_id}";
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
  temp+='<table class="table-reply">';
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
        temp += "<td><span class="+item.reply_num+"><a href='#' class='updateWindow' reply_num="+item.reply_num;
       temp+= ">수정</a></span></td>";
        temp += "<td><a href='#' class='deleteReply' reply_num="+item.reply_num+">삭제</a>";
       } else {
        temp += "<td></td>";
        temp += "<td></td>";
       }
       temp += "</td>";
       temp += "</tr>";
      });
  temp+="</table>";
  $('#getReplies').html(temp);
  $('.updateWindow').on('click', updateWindow);
  $('.deleteReply').on('click', deleteReply);
 }

 function updateWindow() {
  var temp = '';
  var reply_num = $(this).attr('reply_num');
  //수정
  $.ajax({
	method:"post",
	url:"getReply",
	data:{
		"reply_num": reply_num
	},
	success:function(resp){
		temp += "<input type='text' id='reply_update' class='reply_text' value="+resp+">";
		  $('div.' + reply_num).html(temp);
		  $('span.' + reply_num)
		    .html(
		      "<a href='#' class='updateReplyBtn' reply_num="+reply_num+">수정</a>");
		  $('.updateReplyBtn').on('click', updateReply);	
	}  
  });
  
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
  location.href = "${pageContext.request.contextPath}/board?category=${category}";
 }
</script>
<style>
.table-reply {
 border-collapse: collapse;
 width: 100%;
}

.table-reply th, td {
 text-align: left;
 border-bottom: 1px solid #ddd;
 padding: 10;
}

.table-reply th {
 width: 200px;
 padding: 10px;
 font-weight: bold;
 border-bottom: 1px solid #ccc;
 background: #efefef;
 vertical-align: super;
 text-align: center;
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
    test="${loginInfo.member_type=='General' and loginInfo.member_belongto=='General'}">
    <li><a class="verticalNav"
     href="${pageContext.request.contextPath}/house/apply"> <img
      src="${pageContext.request.contextPath}/resources/images/applyto-icon.png"
      alt="홈으로" width="30" align=left> 입주신청
    </a></li>
   </c:if>
   <c:if
    test="${loginInfo.member_type!='General'&&loginInfo.member_type!='Pending' && loginInfo.member_belongto==houseInfo.house_id }">
    <c:if test="${category=='notice' }">
     <li><a class="verticalNav active"
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
     <div style="margin-left: 15%; padding: 1px 16px;">
      <div class="intro animate-box">
       <!-- section 안에 내용을 넣고 위에 것으로 인클루드 시키면 쉬움  -->
       <section id="content">
        <div>
         <c:if test="${category=='notice' }">
          <h3>공지사항</h3>
         </c:if>
         <c:if test="${category=='free' }">
          <h3>자유게시판</h3>
         </c:if>
         <c:if test="${category=='vote' }">
          <h3>투표게시판</h3>
         </c:if>
         <c:if test="${!empty searchCombo }">
          <h5>${searchText }로검색된값::총${getBoards.size() }개</h5>
         </c:if>
        </div>
        <table class="table-reply">
         <tr>
          <th>작성인</th>
          <td>${boards.board_nickname}</td>
         </tr>
         <tr>
          <th>작성 날짜</th>
          <td>${boards.board_inputdate}</td>
         </tr>
         <tr>
          <th>조회수</th>
          <td>${boards.board_hits}</td>
         </tr>
         <tr>
          <th>글제목</th>
          <td>${boards.board_title}</td>
         </tr>
         <tr>
          <th>내&nbsp;&nbsp;용</th>
          <td style="width: 748px; height: 450px; vertical-align: top;">
           <div id="voteResult"></div> ${boards.board_content }
          </td>
         </tr>
        </table>
        <br>
        <c:if test="${loginInfo.member_id==boards.board_member_id }">
         <input type='button' id='updateBoard' class="write-btn"
          value='수정' onclick="updateBoard('${boards.board_id}')">
         <input type='button' id='deleteBoard' class="write-btn"
          value='삭제' onclick="deleteBoard('${boards.board_id}')">
        </c:if>
        <button class="write-btn pull-right" onclick="toList()"
         style="vertical-align: middle">
         <span>리스트</span>
        </button>
        <br> <br>
        <hr>
        <!-- post 방식으로 삭제 위한 form -->
        <form id="deleteForm" action="deleteBoard" method="post">
         <input type="hidden" id="board_id" name="board_id"
          value="${boards.board_id }"> <input type="hidden"
          id="category" name="category" value="${category }">
        </form>
        <input type='text' id='reply_text' class='reply_text' style="width: 830px;">
        <input type='button' value='comment' class='btn btn-primary'
         id='insertComment'>
        <!-- <div id="insertReply"></div> -->
        <div id="getReplies"></div>
        <div class="clearfix"></div>

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