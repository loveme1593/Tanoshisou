<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>일정 관리</title>
<!-- JQuery 와 Bootstrap -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<!-- Calendar js -->
<script
	src="${pageContext.request.contextPath}/calendar/dhtmlxscheduler.js"
	type="text/javascript"></script>
<script
	src='${pageContext.request.contextPath}/calendar/ext/dhtmlxscheduler_minical.js'
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/calendar/ext/dhtmlxscheduler_recurring.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/calendar/locale/locale_ko.js"
	charset="utf-8"></script>
<!--    calendar -->
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


<!-- CALENDAR SCRIPT    -->
<script type="text/javascript">

	$(function() {
		$("#my_form").draggable();
	});
	//현재 연월 값!
	var todayDate = new Date();
	var todayDate2 = new Date();
	var nowHr = todayDate2.getHours();
	var nowMin = todayDate2.getMinutes();
	//이벤트창 현재시간으로 설정 
	function selectTime() {
		console.log(nowHr);
		if (nowHr == 0) {
			$("#Sam")[0].selected = true;
			$("#Eam")[0].selected = true;
			$("#SHour_" + nowHr+12)[0].selected = true;
			$("#EHour_" + nowHr+12)[0].selected = true;
		}else if (nowHr < 12) {
			$("#Sam")[0].selected = true;
			$("#Eam")[0].selected = true;
			$("#SHour_" + nowHr)[0].selected = true;
			$("#EHour_" + nowHr)[0].selected = true;
		} else if(nowHr == 12) {
			$("#Spm")[0].selected = true;
			$("#Epm")[0].selected = true;
			$("#SHour_" + nowHr)[0].selected = true;
			$("#EHour_" + nowHr)[0].selected = true;
		} else if(nowHr > 12) {
			$("#Spm")[0].selected = true;
			$("#Epm")[0].selected = true;
			$("#SHour_" + (nowHr - 12))[0].selected = true;
			$("#EHour_" + (nowHr - 12))[0].selected = true;
		}
		$("#SMin_" + nowMin)[0].selected = true;
		$("#EMin_" + nowMin)[0].selected = true;
	}

	// DB에서 넘어온 값으로 시간설정 세팅
	function selectTimeFromDB(sH, sM, eH, eM) {
		if (sH == 0) {
			$("#Sam")[0].selected = true;
			$("#SHour_" + (sH + 12))[0].selected = true;
		}else if (sH < 12) {
			$("#Sam")[0].selected = true;
			$("#SHour_" + sH)[0].selected = true;
		} else if (sH == 12){
			$("#Spm")[0].selected = true;
			$("#SHour_" + sH)[0].selected = true;
		} else if (sH > 12){
			$("#Spm")[0].selected = true;
			$("#SHour_" + (sH - 12))[0].selected = true;
		} 

		if (eH == 0) {
			$("#Eam")[0].selected = true;
			$("#EHour_" + (eH + 12))[0].selected = true;
		}else if (eH < 12) {
			$("#Eam")[0].selected = true;
			$("#EHour_" + eH)[0].selected = true;
		} else if (eH == 12){
			$("#Epm")[0].selected = true;
			$("#EHour_" + eH)[0].selected = true;
		} else if (eH > 12){
			$("#Epm")[0].selected = true;
			$("#EHour_" + (eH - 12))[0].selected = true;
		} 
		$("#SMin_" + sM)[0].selected = true;
		$("#EMin_" + eM)[0].selected = true;
	}

	// 초기화
	function init() {
		
		scheduler.config.xml_date = "%Y-%m-%d %H:%i";
		scheduler.config.details_on_dblclick = true;
		scheduler.config.details_on_create = true;
		scheduler.config.drag_move = false;
		scheduler.config.max_month_events = 8;//more event
		scheduler.xy.menu_width = 0; //옵션뜨는거 
		scheduler.attachEvent("onClick", function() {
	         return false;
	      });//없애면 큰일남!!!
		scheduler.init('scheduler_here', new Date(), "month");

		getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);

		//    scheduler.init('scheduler_here', todayDate, "month");
		// 월 변경
		$('.dhx_cal_prev_button').on('click', function() {
			todayDate.setMonth(todayDate.getMonth() - 1);
			getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
		});
		$('.dhx_cal_next_button').on('click', function() {
			todayDate.setMonth(todayDate.getMonth() + 1);
			getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
		});

		// 반복일정 체크박스 초기화
		fnc_e_date_init(true);
		
		selectTime();
	}

	//반복일정 체크박스 및 종료일자 세팅 초기화
	function fnc_e_date_init(status) {
		$("#check_end_date")[0].checked = !status;
		if (status)
			$("#end_date").val("");
		$("#end_date")[0].disabled = status;
	}

	var html = function(id) {
		return document.getElementById(id);
	}; //just a helper

	//이벤트창 [9999]
	scheduler.showLightbox = function(id) {
		fnc_e_date_init(true); //반복일정 체크박스 기한활성화
		e_dateInit(); //매일 반복시 날짜 픽스 종료날짜		
		var ev = scheduler.getEvent(id);
		scheduler.startLightbox(id, html("my_form"));
		html("description").focus();
		html("description").value = ev.text;
		html("author").value = ev.author || "${loginInfo.member_id }";
		html("content").value = ev.content || "";
		html("repeat").value = ev.repeat_type || "none";
		html("check_end_date").checked = ev.check_end_date;
		html("end_date").value = ev.repeat_end_date || "";

		$("#alarm").val(ev.alarm_val != null ? ev.alarm_val : "none");
		$("#category").val(ev.subject != null ? ev.subject : "none");

		/* //날짜입력창============================= */
		var sDate = ev.start_date;
		var eDate = ev.end_date;

		var sH = sDate.getHours();
		var sM = sDate.getMinutes();
		var eH = eDate.getHours();
		var eM = eDate.getMinutes();
		
		
		//참석 불참석 버튼설정 [0000]
		$("#voteyes").hide();
		$("#voteno").hide();
		$("#voteTable").hide();
		//db에서 가져 올때
		if (ev.is_dbdata == "T") {
			selectTimeFromDB(sH, sM, eH, eM);
			if(ev.author != "${loginInfo.member_id }"){
				//alert("다른사람");
				$("#save").hide();
				$("#delete").hide();	
				$("#alertTr").hide();	
				//alert(ev.subject);
				if(ev.subject == "meeting"){
				$("#voteyes").show();		
				$("#voteno").show();
				$('#voteTable').empty();
				$("#voteTable").show();
				//vote테이블이 뿌려지는 순간 이때 ajax를 넣어 놓자 !!!![0004]
				console.log(id);
					$.ajax({
						url : "${pageContext.request.contextPath}/voteShow",
						type : "post",
						data : {
							"data_type" : "planning"
							, "pid" : id
						},
						dataType : "json",
						success : function(s) {
							//alert(JSON.stringify(s));							
							var temp = '';
							temp += "<tr>";
							temp += "<th rowspan='2'>참여인원</th>";
							temp += "<th>참 석</th>";
							temp += "<td>";	
							$.each(s,function(index, item) {
								if(item.decision =="yes"){
										temp += item.member_id + "님&nbsp;";
								}
							});
							temp += "</td>";
							temp += "<tr><th>불참석</th><td>";
							$.each(s,function(index, item) {
								if(item.decision =="no"){
								temp += item.member_id + "님&nbsp;";
								}
							});
							temp += "</td></tr>";
							
					$('#voteTable').html(temp);
							
							},
						error : function(f) {
							alert(JSON.stringify(f));
							}
					});
				}
			}else{
				//alert("같은사람");
				$("#save").show();
				$("#delete").show();
				$("#voteyes").hide();
				$("#voteno").hide();
				$("#voteTable").hide();
			}
		}
		//이벤트창에 날짜설정
		else {
			$("#save").show();
			$("#delete").show();
			$("#alertTr").show();
			$("#voteyes").hide();
			$("#voteno").hide();
			$("#voteTable").hide();
			if (sDate.getDate() != eDate.getDate()) {
				//alert("날짜 다름");
				eDate = ev.end_date.setHours(ev.end_date.getHours() - 1);
				eDate = new Date(eDate);
			}
		}
		///
		var SYear = sDate.getFullYear();
		var SMonth = sDate.getMonth() + 1;
		if (SMonth < 10)
			SMonth = "0" + SMonth;
		var SDay = sDate.getDate();
		if (SDay < 10)
			SDay = "0" + SDay;
		$("#timeSetStart").val(SYear + "-" + SMonth + "-" + SDay);
		var EYear = eDate.getFullYear();
		var EMonth = eDate.getMonth() + 1;
		if (EMonth < 10)
			EMonth = "0" + EMonth;
		var EDay = eDate.getDate();
		if (EDay < 10)
			EDay = "0" + EDay;
		$("#timeSetEnd").val(EYear + "-" + EMonth + "-" + EDay);
		//새로 이벤트 입력할때 
		if (ev.is_dbdata == null)
			selectTime();

		/* //날짜입력창============================= */
		if (ev.is_dbdata == "T") {
			// 수정시 반복여부 체크
			
			ev.id = getRealId(ev, "update");
			
			// 반복등록시 종료일자 입력한 내용 체크박스와 함께 세팅.
			if (ev.repeat_end_date != null) {
				console.log("update & repeat status");
				fnc_e_date_init(false);
			}
		}
	};

	// 저장
	function save_form() {
		var ev = scheduler.getEvent(scheduler.getState().lightbox_id);
		console.log(ev);
		ev.plan_id = ev.id;
		ev.text = html("description").value;
		ev.author = html("author").value;
		ev.content = $("#content")[0].value;
		ev.alarm_val = $("#alarm").val();
		ev.check_end_date = $("#check_end_date")[0].checked;
		ev.repeat_type = $("#repeat").val()
		ev.repeat_end_date = $("#end_date").val();
		ev.category = $("#category").val();

		switch ($("#Sampm").val()) {
		case "AM":
			var hr12 = parseInt($("#SHour").val());
			if(hr12 == 12){
				hr12 =0;
			}
			ev.start_date = new Date($("#timeSetStart").val() + " "
					+ hr12 + ":" + $("#SMin").val());
			break;

		case "PM":
			var hr24 = parseInt($("#SHour").val()) + 12;
			if(hr24 == 24){ 
				hr24=12;
			}
			ev.start_date = new Date($("#timeSetStart").val() + " "
					+ hr24 + ":"
					+ $("#SMin").val());
			break;
		}

		switch ($("#Eampm").val()) {
		case "AM":
			var hr12 = parseInt($("#EHour").val());
			if(hr12 == 12){
				hr12 =0;
			}
			ev.end_date = new Date($("#timeSetEnd").val() + " "
					+ hr12 + ":" + $("#EMin").val());
			break;

		case "PM":
			var hr24 = parseInt($("#EHour").val()) + 12;
			if(hr24 == 24){ 
				hr24=12;
			}
			ev.end_date = new Date($("#timeSetEnd").val() + " "
					+ hr24 + ":"
					+ $("#EMin").val());
			break;
		}

		switch ($("#repeat").val()) {
		case "monthly": // 매월
			ev.repeat_detail = $("#mon_day").val();
			break;
		case "yearly": // 매년
			ev.repeat_detail = $("#yr_month").val() + "_" + $("#yr_day").val();
			break;
		}

		console.log(ev);

		$.ajax({
			url : "save",
			type : "post",
			data : ev,
			success : function() {
				console.log("success");
				getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
			},
			error : function() {
				alert("등록실패");
				getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
			}
		});

		scheduler.endLightbox(true, html("my_form"));

		if (ev.is_dbdata == null) {
			
			scheduler.deleteEvent(ev.id);
		}
	}

	// 창닫기
	function close_form() {
		scheduler.endLightbox(false, html("my_form"));
		
	}

	// 삭제
	function delete_event() {
		var event_id = scheduler.getState().lightbox_id;
		var ev = scheduler.getEvent(event_id);

		scheduler.endLightbox(false, html("my_form"));

		// 반복일정 삭제시
		event_id = getRealId(ev, "delete");
		console.log("after getRealId :: " + event_id);

		$.ajax({
			url : "del",
			method : "post",
			data : {
				"id" : event_id
			},
			success : function() {
				getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
				alert("deleted!!!");
			},
			error : function() {
				alert("Not deleted!!!")
			}
		});
		
		scheduler.deleteEvent(event_id);
	}
	// 투표이벤트[0001]
	function vote_event(dicision) {
		var event_id = scheduler.getState().lightbox_id;
		var ev = scheduler.getEvent(event_id);
		//alert("vote event");
		var answer = dicision;
		$.ajax({
			url : "${pageContext.request.contextPath}/voteSave",
			type : "post",
			data : {
				"data_type" : "planning"
				, "decision" : answer
				, "pid" : event_id
				, "votetitle" : "none"
			},
			dataType : "json",
			success : showEvents,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
		scheduler.endLightbox(false, html("my_form"));
		alert(answer+"을 선택하였습니다.");
		
	}
	// 반복일정 삭제/수정시 
	function getRealId(ev, type) {
		var ret = ev.id;
		console.log(ret);
		console.log(ev);

		if (ev.repeat_type != 'none') {
			console.log(ev.repeat_type);
			try {
				// 반복일정의 sub가 되는 id를 삭제할때
				// ex> repeat_0_8
				var sp_id = ret.split("_");
				if (sp_id.length == 1) {
					throw new error();
				}
				var org_id = sp_id[2];
				ret = org_id;
				if (type == "delete") {
					
					console.log(ret);
					var del_id_list = rept_id_map.get(ret);
					for (var i = 0; i < del_id_list.length; i++) {
						console.log(del_id_list[i]);
						scheduler.deleteEvent(del_id_list[i]);
					}
				}
			} catch (err) {
				// 반복일정의 main이 되는 id를 삭제할때
				console.log("exception!!");
				ret = ev.id;
				if (type == "delete") {
					console.log(ret);
					var del_id_list = rept_id_map.get(ret);
					for (var i = 0; i < del_id_list.length; i++) {
						console.log(del_id_list[i]);
						scheduler.deleteEvent(del_id_list[i]);
					}
				}
			}
		}
		console.log("getRealId :: " + ret);
		return ret;
	}

	// 반복 일정 셀렉트박스
	function repeatChanged() {
		e_dateInit();
		switch ($("#repeat").val()) {
		case "daily":
			$("#timeSetEnd")[0].disabled = true;
			// 매일 반복일때 날짜는 변경 못하되 시간은 수정가능하도록 함
			//          $("#Eampm")[0].disabled = true;
			//          $("#EHour")[0].disabled = true;
			//          $("#EMin")[0].disabled = true;
			break;

		}
	}

	// 시간설정 종료일자 초기화
	function e_dateInit() {
		$("#timeSetEnd")[0].disabled = false;
		$("#Eampm")[0].disabled = false;
		$("#EHour")[0].disabled = false;
		$("#EMin")[0].disabled = false;
	}

	//반복일정 체크박스 클릭시
	function fnc_end_date() {
		if ($("#check_end_date")[0].checked) {
			$("#end_date")[0].disabled = false;
		} else {
			$("#end_date").val("");
			$("#end_date")[0].disabled = true;
		}
	}

	// 미니캘린더 보이기
	function show_minical() {
		if (scheduler.isCalendarVisible()) {
			scheduler.destroyCalendar();
		} else {
			scheduler.renderCalendar({
				position : "dhx_minical_icon",
				date : scheduler._date,
				navigation : true,
				handler : function(date, calendar) {
					scheduler.setCurrentView(date);
					scheduler.destroyCalendar()
					getCalData(todayDate.getFullYear(),
							todayDate.getMonth() + 1);
				}
			});
		}
	}

	// 종료일자 textbox클릭시 미니캘린더 보이기
	function input_minical(id) {
		if (scheduler.isCalendarVisible()) {
			scheduler.destroyCalendar();
		} else {
			scheduler.renderCalendar({
				position : id,
				date : scheduler._date,
				navigation : true,
				handler : function(date, calendar) {
					var originDate = date;
					var tYear = originDate.getFullYear();
					var tMonth = originDate.getMonth() + 1;
					if (tMonth < 10)
						tMonth = "0" + tMonth;
					var tDay = originDate.getDate();
					if (tDay < 10)
						tDay = "0" + tDay;
					$("#" + id).val(tYear + "-" + tMonth + "-" + tDay);
					scheduler.destroyCalendar()
				}
			});
		}
	}

	// 스케쥴 목록을 얻어 화면에 보이기
	function getCalData(thisYear, thisMonth) {
		$.ajax({
			url : "show",
			type : "post",
			data : {
				"thisYear" : thisYear,
				"thisMonth" : thisMonth
			},
			dataType : "json",
			success : showEvents,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
		//하우스별 생일 데이타 가져오기 [1111]
		$.ajax({
			url : "bDay",
			type : "post",
			dataType : "json",
			success :makeBday,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
		
		
	}
	
	//생일 일정 생성 [1111]
	 function makeBday(memberDetail){
				var birthList = new Array();
				$.each(memberDetail,function(i,memberD){
				var bday = new Date(memberD.detail_birthday);
				var ebday = new Date(memberD.detail_birthday);
					bday.setFullYear(todayDate.getFullYear());
					ebday.setFullYear(todayDate.getFullYear()+5);
					
				console.log(bday);	
				console.log(ebday);	
					var calObj = {
							id : 9999+i,
							author : memberD.member_id,
							text : memberD.member_id+'생일!!',
							start_date : bday,
							end_date : bday,
							content : memberD.member_id+'생일!!',
							repeat_type : 'yearly',
							repeat_end_date : null,
							is_dbdata :'T',
							alarm_yn : 'F',
							alarm_val : null,
							subject : 'specialday',
							color : 'lightcoral'
						}
						birthList.push(calObj);
				});//each
				scheduler.parse(birthList, "json");
				
				//반복일정 뿌려주는 구간!!! repeat
				if (event.repeat_type != "none") {
					console.log("생일 반복 일정");
					$.each(birthList, function(i, event) {
						makeRepeat(event);
					});
				}
	}

	// 스케쥴 화면세팅
	function showEvents(ret) {
		var calArray = new Array();
		$.each(ret, function(i, event) {
			var selectedColor = 'lightgray';
			switch (event.category) {
			case "meeting":
				 selectedColor = 'lightgreen';
				break;
			case "notice":
				selectedColor = 'aqua';
				break;
			case "specialday":
				selectedColor = 'lightcoral';
				break;
			default:
				break;
			}
			var calObj = {
				id : event.plan_id,
				author : event.member_id,
				text : event.text,
				start_date : event.start_date,
				end_date : event.end_date,
				content : event.content,
				repeat_type : event.repeat_type,
				repeat_end_date : event.repeat_end_date,
				is_dbdata : event.is_dbdata,
				alarm_yn : event.alarm_yn,
				alarm_val : event.alarm_val,
				subject : event.category,
				color : selectedColor
			}
			calArray.push(calObj);
		});
		scheduler.parse(calArray, "json");

		//반복일정 뿌려주는 구간!!! repeat
		if (event.repeat_type != "none") {
			console.log("반복일정");
			$.each(calArray, function(i, event) {
				
				makeRepeat(event);
				
				console.log("event");
				console.log(event);
			});
		}
	}

	//반복 등록된 id들의 array를 original id를 key로 map형태로 저장
	var rept_id_map = new Map();

	function makeRepeat(ev) {
		console.log("ev");
		console.log(ev);
		console.log(ev);
		var rept_list_id = new Array();
		
		//시작날짜를 Date로 !
		var rStart = new Date(ev.start_date);
		console.log("반복 기한 시작날짜 : " + rStart);
		//종료날짜를 Date로!
		var rEnd = new Date(ev.repeat_end_date);
		console.log("반복 기한 종료날짜 : " + rEnd);
		//이벤트의 종료날짜
		var rEventEnd = new Date(ev.end_date);
		console.log("r이벤트 종료날짜 : " + rEventEnd);
		if (rStart.getTime() == rEventEnd.getTime()) {
			console.log("들어옴");
			rEventEnd.setMinutes(rEventEnd.getMinutes() + 5);
		}
		//시작날짜와 종료날짜의 시간텀!
		var diff = rEnd - rStart;
		var currDay = 24 * 60 * 60 * 1000;//시*분*초*밀리세컨
		var currMonth = currDay * 30;//월만듬
		var currYear = currMonth * 12;//년 만듬
		//반복일정 카테고리 색
		console.log(ev.subject);
		var selectedColor = 'lightgray';
			switch (ev.subject) {
			case "meeting":
				 selectedColor = 'lightgreen';
				break;
			case "notice":
				selectedColor = 'aqua';
				break;
			case "specialday":
				selectedColor = 'lightcoral';
				break;
			default:
				break;
			}
		//반복일정 만들기 view 딴에 뿌려주기 !!!! 
		var Repeat = ev.repeat_type;
		switch (Repeat) {
		case "daily":
			//console.log(ev);
			var dayDiff = parseInt(diff / currDay);
			for (var i = 0; i < dayDiff; i++) {
				var rSday = rStart.setDate(rStart.getDate() + 1);
				var rEday = rEventEnd.setDate(rEventEnd.getDate() + 1);
				scheduler.addEvent({
					id : "repeat_" + i + "_" + ev.id,
					author : ev.author,
					text : ev.text,
					start_date : new Date(rSday),
					end_date : new Date(rEday),
					content : ev.content,
					repeat_type : ev.repeat_type,
					repeat_end_date : ev.repeat_end_date,
					is_dbdata : ev.is_dbdata,
					subject : ev.subject,
					color : selectedColor
				});
				rept_list_id.push("repeat_" + i + "_" + ev.id);
			}
			break;
		case "monthly":
			var monthDiff = parseInt(diff / currMonth);
			for (var i = 0; i < monthDiff; i++) {
				var rSday2 = rStart.setMonth(rStart.getMonth() + 1);
				var rEday2 = rEventEnd.setMonth(rEventEnd.getMonth() + 1);
				scheduler.addEvent({
					id : "repeat_" + i + "_" + ev.id,
					author : ev.author,
					text : ev.text,
					start_date : new Date(rSday2),
					end_date : new Date(rEday2),
					content : ev.content,
					repeat_type : ev.repeat_type,
					repeat_end_date : ev.repeat_end_date,
					is_dbdata : ev.is_dbdata,
					subject : ev.subject,
					color : selectedColor
				});
				rept_list_id.push("repeat_" + i + "_" + ev.id);
			}
			break;
		case "yearly":
			var yearlyDiff = parseInt(diff / currYear);
			for (var i = 0; i < yearlyDiff; i++) {
				var rSday3 = rStart.setFullYear(rStart.getFullYear() + 1);
				var rEday3 = rEventEnd.setFullYear(rEventEnd.getFullYear() + 1);
				scheduler.addEvent({
					id : "repeat_" + i + "_" + ev.id,
					author : ev.author,
					text : ev.text,
					start_date : new Date(rSday3),
					end_date : new Date(rEday3),
					content : ev.content,
					repeat_type : ev.repeat_type,
					repeat_end_date : ev.repeat_end_date,
					is_dbdata : ev.is_dbdata,
					subject : ev.subject,
					color : selectedColor
				});
				rept_list_id.push("repeat_" + i + "_" + ev.id);
			}
			break;
		}
		rept_id_map.set(ev.id, rept_list_id);
		console.log(rept_id_map);
	}
</script>
<!-- CALENDAR SCRIPT    -->
<!-- CALENDAR CSS   스킨먹이는곳!!! -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/calendar/dhtmlxscheduler.css"
	type="text/css">
<style type="text/css" media="screen">
html, body {
	margin: 0px;
	padding: 0px;
	height: 100%;
	/*overflow: hidden;*/
}

#my_form {
	position: absolute;
	top: 100px;
	left: 200px;
	z-index: 15;
	display: none;
	background-color: white;
	border: 2px outset gray;
	padding: 20px;
	font-family: Tahoma;
	font-size: 10pt;
	opacity: 0.9;
}

.detail_sel {
	width: 65px;
	height: 20px;
	display: inline-block;
}

.sel {
	/*css 수정*/
	width: 95px;
	height: 25px;
}

.time_section {
	/*css 수정*/
	width: 100px;
	height: 21px;
}

p {
	color: red;
}

select {
	border: none;
	border-radius: 4px;
	background-color: #f1f1f1;
}


</style>
<!-- CALENDAR CSS    -->


<!-- FOR IE9 below -->
<!--[if lt IE 9]>
   <script src="js/respond.min.js"></script>
   <![endif]-->
</head>
<body onload="init();">
	<div id="fb-root"></div>
	<script>
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.8";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	</script>
	<!-- header -->
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
							${loginInfo.member_id }님 (${loginInfo.member_type}) <span
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
			<c:if test="${loginInfo.member_type=='General' }">
				<li><a class="verticalNav"
					href="${pageContext.request.contextPath}/house/introduce"> <img
						src="${pageContext.request.contextPath}/resources/images/applyto-icon.png"
						alt="홈으로" width="30" align=left> Apply to
				</a></li>
			</c:if>
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
			<li><a class="verticalNav active"
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
			<li><a class="verticalNav "
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
		</ul>
		<!-- contents 
      <section id="intro">
         <div class="container">
            <div class="row">
               <div class="intro animate-box">-->
		<div style="margin-left: 15%; padding: 1px 16px; height: 100%;">
			<!-- section 안에 내용을 넣고 위에 것으로 인클루드 시키면 쉬움  -->
			<!-- Calendar DIV -->

			<div id="my_form">
				<table>
					<tr id="">
						<th style="padding: 6;">카테고리</th>
						<!-- css 수정 (style부분 추가)-->
						<td width="300px;" style="padding:6;"><select id="category"
							style="width: 80px; height: 25px;">
								<option value="none">기본</option>
								<option value="notice">공지</option>
								<option value="meeting">모임</option>
								<option value="specialday">기념일</option>
						</select></td>
						<th style="padding: 6;">작성자</th>
						<td style="padding: 6;">
						<input type="text" readonly="readonly"
							disabled="disabled" id="author" value="${loginInfo.member_id }">
							</td>
					</tr>
					<tr>
						<th style="padding: 6;">제목</th>
						<td colspan="3" style="padding: 6;"><input type="text" id="description"></td>
					</tr>
					<tr>
					</tr>
					<tr>
						<th style="padding: 6;">내용</th>
						<td colspan="3" style="padding: 6;"><textarea id="content" rows="5" cols="50"></textarea></td>
					</tr>
					<tr>
						<th style="vertical-align: top; padding: 6;">시간설정</th>
						<td colspan="3" style="padding: 6;">
							<!-- 시간설정================================== --> <input
							class="time_section" type="text" id="timeSetStart"
							onclick="input_minical('timeSetStart')" readonly="readonly">
							<select id="Sampm">
								<option id="Sam">AM</option>
								<option id="Spm">PM</option>
						</select> <select id="SHour">
								<c:forEach var="i" begin="1" end="12">
									<option id="SHour_${i }">
										<c:if test="${i<10 }">
            0${i }
            </c:if>
										<c:if test="${i>=10 }">
            ${i }
            </c:if>
									</option>
								</c:forEach>
						</select> : <select id="SMin">
								<c:forEach var="i" begin="0" end="59">
									<option id="SMin_${i }">
										<c:if test="${i<10 }">
            0${i }
            </c:if>
										<c:if test="${i>=10 }">
            ${i }
            </c:if>
									</option>
								</c:forEach>
						</select> ~ <input class="time_section" type="text" id="timeSetEnd"
							onclick="input_minical('timeSetEnd')" readonly="readonly">
							<select id="Eampm">
								<option id="Eam">AM</option>
								<option id="Epm">PM</option>
						</select> <select id="EHour">
								<c:forEach var="i" begin="1" end="12">
									<option id="EHour_${i }">
										<c:if test="${i<10 }">
            0${i }
            </c:if>
										<c:if test="${i>=10 }">
            ${i }
            </c:if>
									</option>
								</c:forEach>
						</select> : <select id="EMin">
								<c:forEach var="i" begin="0" end="59">
									<option id="EMin_${i }">
										<c:if test="${i<10 }">
            0${i }
            </c:if>
										<c:if test="${i>=10 }">
            ${i }
            </c:if>
									</option>
								</c:forEach>
						</select> <br> <select class="sel" id="repeat"
							style="margin-top: 3px;" onchange="repeatChanged();">
								<option value="none">반복안함</option>
								<option value="daily">매일</option>
								<option value="monthly">매월</option>
								<option value="yearly">매년</option>
						</select> <input type="checkbox" id="check_end_date" value="date_of_end"
							onclick="fnc_end_date();" /> <input class="time_section"
							type="text" id="end_date" disabled="disabled" readonly="readonly"
							onclick="input_minical('end_date')" />까지 <br> <!-- 시간설정================================== -->
						</td>
					</tr>
					<tr id="alertTr">
						<th style="padding: 6;">알람</th>
						<td colspan="3" style="padding: 6;"><select class="sel" id="alarm"
							onchange="alarmChanged();">
								<option value="none">알람없음</option>
								<option value="0">시작시간</option>
								<option value="5">5분전</option>
								<option value="10">10분전</option>
								<option value="60">1시간전</option>
								<option value="180">3시간전</option>
						</select></td>
					</tr>
				</table>
				<!-- 참석 불참석 테이블 [0003] -->
				<table id="voteTable">
					<!-- <tr>
						<th rowspan="2">참여인원</th>
						<td>참석</td>
						<td>나 너 사람1</td>
					</tr>
					<tr>
						<td>불참석</td>
						<td>사람2 사람3 사람4</td>
					</tr> -->
					</table>
				<!-- 저장, 닫기, 삭제  -->
				<div style="text-align: center;">
						<!--모임의 참여 및 불참여 버튼 [0002] -->
						<input
						type="button" class="button-input" name="voteyes" value="모임 참여" id="voteyes"
						style='width: 100px;' onclick="vote_event('yes')">
						<input
						type="button" class="button-input" name="voteno" value="모임 불참" id="voteno"
						style='width: 100px;' onclick="vote_event('no')">
						<!--모임의 참여 및 불참여 버튼  -->
					<input type="button" class="button-input" name="save" value="저 장" id="save"
						style='width: 100px;' onclick="save_form()"> <input
						type="button" class="button-input" name="close" value="닫 기 " id="close"
						style='width: 100px;' onclick="close_form()"> <input
						type="button" name="delete" value="삭 제" id="delete"
						style='width: 100px;' class="button-input" onclick="delete_event()">
				</div>
			</div>

			<div id="scheduler_here" class="dhx_cal_container"
				style='width: 100%; height: 100%;'>
				<div class="dhx_cal_navline">
					<div class="dhx_cal_prev_button">&nbsp;</div>
					<div class="dhx_cal_next_button">&nbsp;</div>
					<div class="dhx_cal_today_button"></div>
					<div class="dhx_cal_date"></div>
					<!-- 미니캘린더 -->
					<div class="dhx_minical_icon" id="dhx_minical_icon"
						onclick="show_minical()">&nbsp;</div>
					<div class="dhx_cal_tab" name="day_tab" style="right: 140px;"></div>
					<!-- <div class="dhx_cal_tab" name="week_tab" style="right: 140px;"></div> -->
					<div class="dhx_cal_tab" name="month_tab" style="right: 76px;"></div>
				</div>
				<div class="dhx_cal_header"></div>
				<div class="dhx_cal_data"></div>
			</div>
			<!-- Calendar DIV -->
			<hr>
		</div>
	</div>
	<!-- </div>
         </div>
      </section>
   </div> -->
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