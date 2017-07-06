<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<!-- JQuery 와 Bootstrap -->
<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<head>
<title>상세 회원 정보</title>
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
<style type="text/css">
#headerNavi {
	position: absolute;
	top: 45px;
}
</style>
<script>
function goPopup() { // 주소검색을 수행할 팝업 페이지를 호출합니다. 소스 경로는 사용자 시스템에 맞게 수정하시기 바람니다.    
   var pop = window.open(
         "${pageContext.request.contextPath}/house/jusoPopup", "pop",
         "width=700,height=650, top=200, left=400 , scrollbars=yes, resizable=yes");
}
	
	function check(){
		//null 처리 위한 함수->ifNeedDetail이 true 일 때 처리
		if("${ifNeedDetail}"){
			var gender= $("input[type=radio][name=detail_gender]:checked").val();
			var detail_birthday=$("#detail_birthday").val();
			var detail_job_title=$("#detail_job_title").val();
			var detail_bloodtype=$("#detail_bloodtype").val();
			var house_address=$('#house_address').val();
			var detail_religion=$("#detail_religion").val();
			var detail_hobby=$("#detail_hobby").val();
			var detail_introduce=$("#detail_introduce").val();
			if(gender==''||detail_birthday==''||detail_job_title==''||
					detail_bloodtype==''||house_address==''||
					detail_religion==''||detail_hobby==''||detail_introduce==''){
				alert('빈 칸 없이 작성해주세요.');
				return false;
			}
			return true;
		}else{
			return true;
		}
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
					<div class="col-lg-6 col-lg-offset-3 col-md-offset-2 text-center">
						<div class="intro animate-box">
							<h1>상세 정보 수정</h1>
						</div>
					</div>
				</div>
			</div>
		</section>

		<div class="container">
			<div class="col-md-8 col-md-offset-2 animate-box">
				<c:if test="${result == 'success'}">
					<div class="alert alert-info alert-dismissable fade in">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong>Success!</strong> 회원 정보 수정에 성공하였습니다.
					</div>
				</c:if>
				<c:if test="${ifNeedDetail}">
					<div class="alert alert-info">
						<strong>Warning!</strong> 회원 상세 정보 등록 이후 이용이 가능합니다.
					</div>
				</c:if>
				<c:if test="${detailNullCheck=='null' }">
					<div class="alert alert-info">
						<strong>Warning!</strong> 회원 상세 정보 등록 이후 이용이 가능합니다.
					</div>
				</c:if>
				<form
					action="${pageContext.request.contextPath}/member/memberDetailUpdate"
					method="post" id="memberDetailForm" onsubmit="return check();">
					<input type="hidden" name="member_id"
						value="${loginInfo.member_id}">
					<div class="form-group row">
						<div class="col-md-6 field">
							<label for="lastname">성별 &nbsp;&nbsp;</label><br>
							남성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio"
								id="detail_gender" name="detail_gender"
								${detailInfo.detail_gender=='남자'?'checked':'' } value="남자" />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							여성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio"
								id="detail_gender" name="detail_gender"
								${detailInfo.detail_gender=='여자'?'checked':'' } value="여자" />
						</div>
						<div class="col-md-6 field">
							<label for="lastname" style="display: inline-block;">생일&nbsp;&nbsp;</label>
							<input type="date" id="detail_birthday" name="detail_birthday"
								class="form-control" width="150px;"
								${detailInfo.detail_birthday!= null?'checked':'' }
								<c:if test="${ not empty detailInfo.detail_birthday}"> value="${detailInfo.detail_birthday}"</c:if> />
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-6 field">
							<label for="lastname">직업</label> <select id="detail_job_title"
								name="detail_job_title" class="form-control">
								<option value="">선택</option>
								<option value="회사원"
									${detailInfo.detail_job_title=='회사원'?'selected':'' }>회사원</option>
								<option value="자영업"
									${detailInfo.detail_job_title=='자영업'?'selected':'' }>자영업</option>
								<option value="전문직"
									${detailInfo.detail_job_title=='전문직'?'selected':'' }>전문직</option>
								<option value="학생"
									${detailInfo.detail_job_title=='학생'?'selected':'' }>학생</option>
								<option value="운동선수"
									${detailInfo.detail_job_title=='운동선수'?'selected':'' }>운동선수</option>
								<option value="연예인"
									${detailInfo.detail_job_title=='연예인'?'selected':'' }>연예인</option>
								<option value="군인"
									${detailInfo.detail_job_title=='군인'?'selected':'' }>군인</option>
								<option value="무직"
									${detailInfo.detail_job_title=='무직'?'selected':'' }>무직</option>
								<option value="농/어업"
									${detailInfo.detail_job_title=='농/어업'?'selected':'' }>농/어업</option>
								<option value="기타"
									${detailInfo.detail_job_title=='기타'?'selected':'' }>기타</option>
							</select>
						</div>
						<div class="col-md-6 field">
							<label for="lastname">혈액형</label> <select class="form-control"
								id="detail_bloodtype" name="detail_bloodtype"
								class="form-control">
								<option value="">선택</option>
								<option value="A"
									${detailInfo.detail_bloodtype=='A'?'selected':'' }>A</option>
								<option value="B"
									${detailInfo.detail_bloodtype=='B'?'selected':'' }>B</option>
								<option value="O"
									${detailInfo.detail_bloodtype=='O'?'selected':'' }>O</option>
								<option value="AB"
									${detailInfo.detail_bloodtype=='AB'?'selected':'' }>AB</option>
								<option value="기타"
									${detailInfo.detail_bloodtype=='기타'?'selected':'' }>기타
								</option>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12 field" style="text-align: left;">
							<label for="lastname" style="float: left; margin: 0px;">주소</label>
							<br> <input type="text" id="house_address"
								name="detail_address" required
								style="width: 650px; float: left; margin: 0px; padding: 0px; position: relative;"
								class="form-control"
								value="${not empty detailInfo.detail_address ? detailInfo.detail_address:''}"
								disabled="disabled" placeholder="검색 버튼을 이용해주세요." /> <input
								type=button value="검색" onClick="goPopup()"
								style="float: left; height: 55px;; position: relative;"
								class="btn btn-primary">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-6 field">
							<label for="lastname">종교</label> <select class="form-control"
								name="detail_religion" id="detail_religion">
								<option value="">선택</option>
								<option value="None"
									${detailInfo.detail_religion=='무교'?'selected':'' }>무교
								</option>
								<option value="기독교"
									${detailInfo.detail_religion=='기독교'?'selected':'' }>기독교
								</option>
								<option value="천주교"
									${detailInfo.detail_religion=='천주교'?'selected':'' }>천주교
								</option>
								<option value="불교"
									${detailInfo.detail_religion=='불교'?'selected':'' }>불교
								</option>
								<option value="기타"
									${detailInfo.detail_religion=='기타'?'selected':'' }>기타
								</option>
							</select>
						</div>
						<div class="col-md-6 field">
							<label for="lastname">취미</label> <select id="detail_hobby"
								name="detail_hobby" class="form-control">
								<option value="">선택</option>
								<option value="음악"
									${detailInfo.detail_hobby=='음악'?'selected':'' }>음악</option>
								<option value="운동"
									${detailInfo.detail_hobby=='운동'?'selected':'' }>운동</option>
								<option value="영화"
									${detailInfo.detail_hobby=='영화'?'selected':'' }>영화</option>
								<option value="여행"
									${detailInfo.detail_hobby=='여행'?'selected':'' }>여행</option>
								<option value="낚시"
									${detailInfo.detail_hobby=='낚시'?'selected':'' }>낚시</option>
								<option value="스포츠"
									${detailInfo.detail_hobby=='스포츠'?'selected':'' }>스포츠</option>
								<option value="독서"
									${detailInfo.detail_hobby=='독서'?'selected':'' }>독서</option>
								<option value="게임"
									${detailInfo.detail_hobby=='게임'?'selected':'' }>게임</option>
								<option value="휴식"
									${detailInfo.detail_hobby=='휴식'?'selected':'' }>휴식</option>
								<option value="기타"
									${detailInfo.detail_hobby=='기타'?'selected':'' }>기타</option>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12 field">
							<label for="lastname">자기 소개</label>
							<textarea name="detail_introduce" id="detail_introduce" cols="30"
								rows="10" class="form-control">${detailInfo.detail_introduce}</textarea>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12 field" style="text-align: center;">
							<input type="submit" value="저장하기" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value="초기화" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="HOME" class="btn btn-primary"
								onclick="location.href='../'">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>


<!-- END: box-wrap -->
<!-- jQuery -->
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.min.js"></script>
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
</html>