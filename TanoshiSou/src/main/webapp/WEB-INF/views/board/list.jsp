<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>게시판</title>
<!-- JQuery 와 Bootstrap -->
<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
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
   $(function() {
      $('#insertBoard').on('click', insertBoard);
      $('#search').on('click', searchBoard);
   });
   function insertBoard() {
      location.href = "${pageContext.request.contextPath}/board/insert?category=${category}";
   }
   function boardlist(category, page) {
      location.href = "${pageContext.request.contextPath}/board??category="
            + category + "&page=" + page;
   }
   function searchBoard() {
      var searchType = document.getElementById('searchType');
      var searchText = document.getElementById("searchText");
      if (searchType.value == '') {
         alert('검색단위를 선택해주세요');
         searchType.focus();
      } else if (searchText.value == '') {
         alert('검색어를 입력해주세요.');
         searchText.focus();
      } else {
         location.href = "${pageContext.request.contextPath}/board?category=${category}"
               + "&page=${page}"
               + "&searchType="
               + searchType.value
               + "&searchText=" + searchText.value;
      }
   }
</script>
<style>
select {
   width: 13%;
   height: 42px;
   padding: 5px 10px;
   border: 3px solid #ccc;
   background-color: transparent;
}

select:focus {
   color: #000;
   outline: none;
   border: 3px solid #52d3aa;
}

.centeralize {
   text-align: justify;
}

.nohover:hover {
   background: white;
}

table th {
   background: #efefef;
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
            <div>
               <div style="margin-left: 15%; padding: 1px 16px;">
                  <div class="intro animate-box">
                     <!-- section 안에 내용을 넣고 위에 것으로 인클루드 시키면 쉬움  -->
                     <section id="content">
                        <br>
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
                        <br>
                        <table class="table table-hover">
                           <tr>
                              <th>글번호</th>
                              <th>글제목</th>
                              <th>글쓴이</th>
                              <th>글쓴 날짜</th>
                              <th>조회수</th>
                              <c:forEach var="item" items="${boards }">
                                 <tr>
                                    <td>${item.board_id }</td>
                                    <td><a
                                       href="${pageContext.request.contextPath}/board/getBoard?board_id=${item.board_id}&category=${item.board_category}">
                                          ${item.board_title }</a><span class="badge">${item.board_reply_num }</span>
                                       <c:if test="${item.board_hits<=10 }">
                                          <span class="label label-danger">New</span>
                                       </c:if></td>
                                    <td>${item.board_nickname }</td>
                                    <td>${item.board_inputdate }</td>
                                    <td>${item.board_hits }</td>
                                 </tr>
                              </c:forEach>
                           <tr>
                              <td colspan="5" class="nohover"><c:if
                                    test="${category!='notice' }">
                                    <button class="write-btn pull-right" id="insertBoard"
                                       name="insertBoard" style="vertical-align: middle">
                                       <span>글쓰기</span>
                                    </button>
                                 </c:if> 
                                 <!-- 공지사항은 Host만 글 쓸 수 있도록 수정, 버튼 위치 수정 --> 
                                 <c:if test="${category=='notice'&&loginInfo.member_type=='Host' }">
                                    <button class="write-btn pull-right" id="insertBoard"
                                       name="insertBoard" style="vertical-align: middle">
                                       <span>글쓰기</span>
                                    </button>
                                 </c:if> <br> <br>
                                 <hr></td>
                           </tr>
                        </table>
                        <div class="centeralize"
                           style="margin-left: 15%; padding: 1px 16px;">
                           <select id="searchType">
                              <option value="" selected="selected"></option>
                              <option value="board_title">글제목</option>
                              <option value="board_nickname">글쓴이</option>
                              <option value="board_content">글내용</option>
                           </select> <input type="text" id="searchText" class="reply_text"
                              style="width: 40%;"> <input type="button" value="검색"
                              id="search" class="btn btn-primary">
                        </div>
                        <div class="paginationIndex">
                           <c:if test="${empty searchCombo }">
                              <a
                                 href="${pageContext.request.contextPath}/board?category=${category}&page=${page-1}">&laquo;</a>
                              <c:forEach var="curpage" begin="1" end="${totalPages }">
                                 <c:if test="${page==curpage }">
                                    <a class="active"
                                       href="${pageContext.request.contextPath}//board?category=${category}&page=${curpage}">${curpage}</a>
                                 </c:if>
                                 <c:if test="${page!=curpage }">
                                    <a
                                       href="${pageContext.request.contextPath}/board?category=${category}&page=${curpage}">${curpage}</a>
                                 </c:if>
                              </c:forEach>
                              <a
                                 href="${pageContext.request.contextPath}/board?category=${category}&page=${page+1}">&raquo;</a>
                           </c:if>
                           <c:if test="${!empty searchCombo }">
                              <a
                                 href="${pageContext.request.contextPath}/board?category=${category}&page=${page-1}&searchCombo=${searchCombo }&searchText=${searchText }">&laquo;</a>
                              <c:forEach var="page" begin="1" end="${totalPages }">
                                 <a
                                    href="${pageContext.request.contextPath}/board?category=${category}&page=${page}&searchCombo=${searchCombo }&searchText=${searchText }">${page}</a>
                              </c:forEach>
                              <a
                                 href="${pageContext.request.contextPath}/board?category=${category}&page=${page+1}&searchCombo=${searchCombo }&searchText=${searchText }">&raquo;</a>
                           </c:if>
                        </div>
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
      src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.min.js"></script> -->
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