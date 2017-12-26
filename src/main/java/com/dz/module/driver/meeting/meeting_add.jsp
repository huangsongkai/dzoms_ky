<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8" %>
<%@page import="org.springframework.web.context.support.*" %>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<% String path=request.getContextPath(); String basePath=request.getScheme()+ "://"+request.getServerName()+ ":"+request.getServerPort()+path+ "/"; %>

<!DOCTYPE html>
<html lang="zh-cn">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0, maximum-scale=1.2, user-scalable=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="renderer" content="webkit" />
<title> 例会登记 </title> 
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"> </script> 
<script src="/DZOMS/res/js/pintuer.js"> </script> 
<script src="/DZOMS/res/js/respond.js"> </script> 
<script type="text/javascript" src="/DZOMS/res/js/itemtool.js"></script> 
<script src="/DZOMS/res/js/admin.js"> </script> 
<script>
	var i=0;
var dept1=0;
var dept2=0;
var dept3=0;
var deptall=0;
var time1=1;
var time2=2;
var time3=3;
var timeall=4;

function addfilename() {
	var txt=$("<option class='filename'></option>").text($(".addFile:first").val());
	$("#filename").append(txt)
}

function addfile() {
	var txt='<input size="100" name="fileUploads" type="file" class="addFile" onchange="addfilename()" style="display:none"/>';
	$(add).after(txt);
	$(".addFile:first").click();
	i=i + 1;
}

function delefile() {
	for (j=0; j <= i; j++) {
		if ($(".filename:selected").val() == $("input.addFile").eq(i).val()) {
			$(".filename:selected").remove();
			$("input.addFile").eq(i).remove();
		} else {
			file=$("file").next();
			i=i-1;
		}
	}
}



function tianjia() {
	if ($("#table1 :checked:first").parent().parent().html() == undefined)
		alert("您没有勾选任何数据");
	while ($("#table1 :checked:first").parent().parent().html() != undefined) {
		var txt='<tr>' + $("#table1 :checked:first").parent().parent().html() + '</tr>';
		$("#table2").append(txt);
		$("#table1 :checked:first").parent().parent().remove();
	}
}

function shanchu() {
	if ($("#table2 :checked:first").parent().parent().html() == undefined)
		alert("您没有勾选任何数据");
	while ($("#table2 :checked:first").parent().parent().html() != undefined) {
		var txt='<tr>' + $("#table2 :checked:first").parent().parent().html() + '</tr>';
		$("#table1").append(txt);
		$("#table2 :checked:first").parent().parent().remove();
	}
}

function quanxuan() {
	$("#table1 :checkbox").prop("checked", true);
	tianjia();
}

function qingkong() {
	$("#table2 :checkbox").prop("checked", true);
	shanchu();
	$("#table1 :checkbox").prop("checked", false);
}

var reg=new RegExp("/", "g");

function meeting_time() {

	var time=$("#meetingTime").val();
	var type=$("#meetingClass").val();
	var dept=$("#meetingDept").val();
	if (time == time1 || time == time2 || time == time3 || time == timeall) {
		alert(time + "该日期 已经存在");
	} else {

		if (dept == "一部" && dept1 == 1) {
			alert(dept + "例会已经被创建");
		} else if (dept == "二部" && dept2 == 1) {
			alert(dept + "例会已经被创建");
		} else if (dept == "三部" && dept3 == 1) {
			alert(dept + "例会已经被创建");
		} else if (dept == "全部" && deptall == 1) {
			alert("例会已经被创建");
		} else {


			if (time == "") {
				alert("请填入例会时间！");
			} else {

				if (dept == "全部") {

					if (type == "例会") {
						alert("请选择公司");
					} else {

						var starttime=time + ' ' + '00:00:00';
						var endtime=time + ' ' + '00:00:00';
						var startabletime=time + ' ' + '00:00:00';
						var startlatertime=time + ' ' + '00:00:00';
						var endabletime=time + ' ' + '00:00:00';
						var endlatertime=time + ' ' + '00:00:00';
						var txt=$(
							'<tr><td>' + '全部' + '</td><td>' + type + '</td><td>' + starttime + '</td><td>' + endtime + '</td><td>' + startabletime + '</td><td>' + endabletime + '</td><td>' + startlatertime + '</td><td>' + endlatertime + '</td></tr>').addClass(('time' + time).replace(reg, '-'));

						$("#meeting-time-detail").append(txt);
						var $hiddenTime=$('<input type="hidden" name="time"></input>').val(time).addClass(('time' + time).replace(reg, '-'));
						var $hiddenDept=$('<input type="hidden" name="dept"></input>').val('一部').addClass(('time' + time).replace(reg, '-'));
						var $hiddenType=$('<input type="hidden" name="type"></input>').val(type).addClass(('time' + time).replace(reg, '-'));
						$('#meeting-time-hidden').append($hiddenTime);
						$('#meeting-time-hidden').append($hiddenDept);
						$('#meeting-time-hidden').append($hiddenType);
						var $hiddenTime=$('<input type="hidden" name="time"></input>').val(time).addClass(('time' + time).replace(reg, '-'));
						var $hiddenDept=$('<input type="hidden" name="dept"></input>').val('二部').addClass(('time' + time).replace(reg, '-'));
						var $hiddenType=$('<input type="hidden" name="type"></input>').val(type).addClass(('time' + time).replace(reg, '-'));
						$('#meeting-time-hidden').append($hiddenTime);
						$('#meeting-time-hidden').append($hiddenDept);
						$('#meeting-time-hidden').append($hiddenType);
						var $hiddenTime=$('<input type="hidden" name="time"></input>').val(time).addClass(('time' + time).replace(reg, '-'));
						var $hiddenDept=$('<input type="hidden" name="dept"></input>').val('三部').addClass(('time' + time).replace(reg, '-'));
						var $hiddenType=$('<input type="hidden" name="type"></input>').val(type).addClass(('time' + time).replace(reg, '-'));
						$('#meeting-time-hidden').append($hiddenTime);
						$('#meeting-time-hidden').append($hiddenDept);
						$('#meeting-time-hidden').append($hiddenType);

						if (dept == "全部") {
							deptall=1;
							timeall=time;
						}
					}
				} else {

					var starttime=time + ' ' + '13:00:00';
					var endtime=time + ' ' + '14:00:00';
					var startabletime=time + ' ' + '12:00:01';
					var startlatertime=time + ' ' + '13:05:00';
					var endabletime=time + ' ' + '14:00:00';
					var endlatertime=time + ' ' + '14:00:00';
					var txt1=$('<tr><td>' + dept + '</td><td>' + type + '</td><td>' + starttime + '</td><td>' + endtime + '</td><td>' + startabletime + '</td><td>' + endabletime + '</td><td>' + startlatertime + '</td><td>' + endlatertime + '</td></tr>').addClass(('time' + time).replace(reg, '-'));

					$("#meeting-time-detail").append(txt1);
					var $hiddenTime=$('<input type="hidden" name="time"></input>').val(time).addClass(('time' + time).replace(reg, '-'));
					var $hiddenDept=$('<input type="hidden" name="dept"></input>').val(dept).addClass(('time' + time).replace(reg, '-'));
					var $hiddenType=$('<input type="hidden" name="type"></input>').val(type).addClass(('time' + time).replace(reg, '-'));
					$('#meeting-time-hidden').append($hiddenTime);
					$('#meeting-time-hidden').append($hiddenDept);
					$('#meeting-time-hidden').append($hiddenType);
					starttime=time + ' ' + '14:30:00';
					endtime=time + ' ' + '15:30:00';
					startabletime=time + ' ' + '14:00:01';
					startlatertime=time + ' ' + '14:35:00';
					endabletime=time + ' ' + '15:30:00';
					endlatertime=time + ' ' + '15:30:00';
					var txt2=$(
						'<tr><td>' + dept + '</td><td>' + type + '</td><td>' + starttime + '</td><td>' + endtime + '</td><td>' + startabletime + '</td><td>' + endabletime + '</td><td>' + startlatertime + '</td><td>' + endlatertime + '</td></tr>').addClass(('time' + time).replace(reg, '-'));
					$("#meeting-time-detail").append(txt2);


					starttime=time + ' ' + '16:00:00';
					endtime=time + ' ' + '17:00:00';
					startabletime=time + ' ' + '15:30:01';
					startlatertime=time + ' ' + '16:05:01';
					endabletime=time + ' ' + '17:30:00';
					endlatertime=time + ' ' + '17:30:00';
					var txt3=$(
						'<tr><td>' + dept + '</td><td>' + type + '</td><td>' + starttime + '</td><td>' + endtime + '</td><td>' + startabletime + '</td><td>' + endabletime + '</td><td>' + startlatertime + '</td><td>' + endlatertime + '</td></tr>').addClass(('time' + time).replace(reg, '-'));
					$("#meeting-time-detail").append(txt3);

					if (dept == "一部") {
						dept1=1;
						time1=time;
					}
					if (dept == "二部") {
						dept2=1;
						time2=time;
					}
					if (dept == "三部") {
						dept3=1;
						time3=time;
					}


				}

			}
		}
	}


}

function dele_meeting_time() {
	var time=$('#meetingTime').val();
	if(time==time1){
		time1=1;
		dept1=0
	}
	if(time==time2){
		time2=2;
		dept2=0
	}
	if(time==time3){
		time3=3;
		dept3=0
	}
	if(time==timeall){
		timeall=4;
		deptall=0
	}

	$(('.time' + time).replace(reg, '-')).remove();
	$('#meetingTime').val("");

}




var $tableHead=$('<tr><th style="width:5%;">选择</th>' +
	'<th style="width:15%;">车牌号</th>' +
	'<th style="width:10%;">驾驶员</th>' +
	'<th style="width:25%;">身份证号</th>' +
	'<th style="width:5%;">性别</th>' +
	'<th style="width:10%;">属性</th>' +
	'<th style="width:15%;">车队名称</th>' +
	'<th style="width:15%;">分公司归属</th>' +
	'<tr>');

$(document).ready(function() {
	$("#search_but").click(function() {
		$.post("/DZOMS/driver/searchDriverToHtml", {
			"driver.dept": $("#department").val(),
			"driver.team": $("#driverTeam").val(),
			"driver.isInCar": "true"
		}, function(html) {
			$("#table1").html("").append($tableHead).append(html);
		});
	});

});



function meeting_submit() {
	var index = 0;
	$("#driverlist").html("");
	$("#table2 :checkbox").each(function() {
		var hidden = document.createElement("input");
		var $hidden = $(hidden);
		$hidden.attr("type","hidden").attr("name","driverlist["+(index++)+"]").val($(this).val());
		$("#driverlist").append($hidden);
	});
	
	index = 0;
	$("#meeting-time-hidden input").each(function() {
		var name = $(this).attr("name");
		$(this).attr("name",name+"["+index+"]");
		
		if(name=="type"){
			index++;
		}
	});
	//alert($('#driverlist').val());
	document.addMeeting.submit();
} 
</script>

<style>
	.label {
		width: 80px;
		text-align: right;
	}
	.form-group {
		width: 300px;
		margin-top: 5px;
	}
	.changecolor {
		background-color: #0099CC;
								}
							
</style>
</head>
<body>
	<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>例会</li>
                <li>例会添加</li>
              
        </ul>
</div>			
</div>		
	
	
<form method="post" action="addMeeting" name="addMeeting" class="form-inline form-tips">
	<div class="panel">
		<div class="panel-head">
			
					新增例会
			
		</div>
		<div class="panel-boby">
			<div class="form-group">
				<div class="label">
					<label>
						例会名称
					</label>
				</div>
				<div class="field">
					<input class="input input-auto" size="20" name="meeting.meetingName" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>
						录入人
					</label>
				</div>
				<div class="field">
					<input class="input" type="text" readonly="readonly" value="<%=((User)session.getAttribute("user")).getUname()%>">
					<input type="hidden" name="meeting.registrant" value="<%=((User)session.getAttribute("user")).getUid()%>" />
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label>
						录入时间
					</label>
				</div>
				<div class="field">
					<input class="input" readonly="readonly" name="meeting.registTime" value="<%=(new java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>" />
				</div>
			</div>
			<br>
			<div style="margin-top: 5px;">
				<div style="width: 600px; ">
					<div class="float-left" style="width: 80px; text-align: right;">
						<strong>
							例会内容
						</strong>
					</div>
					<div class="field">
						<textarea style="width: 500px;" rows="5" class="input" placeholder="多行文本"
						name="meeting.meetingContext"></textarea>
					</div>
				</div>
			</div>
			<br>
			<div style="margin-top: 5px;">
				<div style="width: 100%">
					<div class="float-left" style="width: 80px; text-align: right;">
						<strong>
							添加文件
						</strong>
					</div>
					<div class="float-left">
						<select id="filename" size="5" style="width: 400px;border: 1px solid rgb(221, 221, 221); border-image: none;" class="float-left">
						</select>
					</div>
				</div>
				<div class="form-group margin-small">
					<div class="margin-small">
						<a id="add" class="button input-file bg-green" href="javascript:addfile();">
							添加
						</a>
					</div>
					<div class="margin-small">
						<a class="button input-file bg-blue" href="javascript:void(0);" onclick="delefile()">
							删除
						</a>
					</div>
				</div>
			</div>
			<br>
			<blockquote>
				<strong>
					例会时间设置
				</strong>
				<div class="form-group" style="width: 200px;">
					<div class="label" style="width: 80px;">
						<label>
							例会日期
						</label>
					</div>
					<div class="field" style="width: 100px;">
						<input class="datepick input " type="text" id="meetingTime" style="width: 100px;">
					</div>
				</div>
				<div class="form-group" style="width: 150px;">
					<div class="label" style="width: 80px;">
						<label>
							类别
						</label>
					</div>
					<div class="field" style="width: 70px;">
						<select class="input" id="meetingClass" style="width: 70px;">
							<option>
								例会
							</option>
							<option>
								补会
							</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>
							公司
						</label>
					</div>
					<div class="field">
						<select class="input" id="meetingDept">
							<option>
								全部
							</option>
							<option>
								一部
							</option>
							<option>
								二部
							</option>
							<option>
								三部
							</option>
						</select>
					</div>
				</div>
				<input type="button" class="button bg-green" value="添加时间" onclick="meeting_time()"
				/>
				<input type="button" class="button bg-green" value="删除时间" onclick="dele_meeting_time()"
				/>
				<br>
				<div class="panel">
					<div class="panel-head">
						例会时间
					</div>
					<div class="panel-boby">
						<table class="table table-bordered" id="meeting-time-detail">
							<tr>
								<th>
									分公司归属
								</th>
								<th>
									类别
								</th>
								<th>
									起始时间
								</th>
								<th>
									终止时间
								</th>
								<th>
									可以签到时间
								</th>
								<th>
									可以签到时间终止
								</th>
								<th>
									迟到时间
								</th>
								<th>
									迟到时间终止
								</th>
							</tr>
						</table>
					</div>
				</div>
				<div id="meeting-time-hidden">
				</div>
			</blockquote>
			<br>
		</div>
	</div>
	<div class="line">
		<div class="xm5">
			<div class="panel">
				<div class="panel-head">
					
							全部驾驶员
					
				</div>
				<div class="panel-body">
					<div style="height: 50px" id="selectDiv">
						<div class="form-group" style="width: auto;">
							<div class="label" style="width: auto">
								<label>
									公司
								</label>
							</div>
							<div class="field" style="width: auto;">
								<select class="input" style="width: 70px;" id="department" onfocus="getList1('department','department')">
								</select>
							</div>
						</div>
						<div class="form-group" style="width: auto;">
							<div class="label" style="width: auto">
								<label>
									车队
								</label>
							</div>
							<div class="field" style="width: auto;">
								<select id="driverTeam" style="width: 150px;" class="input" onfocus="getList1('driverTeam','driverTeam')">
								</select>
							</div>
						</div>
						<input class="button bg-green" type="button" value="查找" id="search_but">
					</div>
					<div style="height: 500px;overflow: scroll">
						<table class="table table-bordered table-striped" id="table1">
							<tr>
								<th style="width:5%;">
									选择
								</th>
								<th style="width:15%;">
									车牌号
								</th>
								<th style="width:10%;">
									驾驶员
								</th>
								<th style="width:25%;">
									身份证号
								</th>
								<th style="width:5%;">
									性别
								</th>
								<th style="width:10%;">
									属性
								</th>
								<!--<th>手机</th>-->
								<th style="width:15%;">
									车队名称
								</th>
								<th style="width:15%;">
									分公司归属
								</th>
							</tr>
						</table>
					</div>
				</div>
				<div class="panel-foot">
					<strong>
						合计:
					</strong>
				</div>
			</div>
		</div>
		<div class="xm1 margin-small">
			<div class="panel">
            	<div class="panel-head"> <strong>操作</strong></div>
               <div class="panel-body">
               	 <div class="form-group">
                    <div style="height: 50px"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="添加" onclick="tianjia()"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="删除" onclick="shanchu()"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="全选" onclick="quanxuan()"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="清空" onclick="qingkong()"></div>
                </div>
               </div>
               

            </div>
		</div>
		<div class="xm5 margin-small">
			<div class="panel">
				<div class="panel-head">
					
							选择驾驶员
					
				</div>
				<div class="panel-body">
					<div style="height: 50px">
					</div>
					<div style="height:500px; overflow: scroll">
						<table class="table table-bordered table-striped" id="table2">
							<tr>
								<th style="width:5%;">
									选择
								</th>
								<th style="width:15%;">
									车牌号
								</th>
								<th style="width:10%;">
									驾驶员
								</th>
								<th style="width:25%;">
									身份证号
								</th>
								<th style="width:5%;">
									性别
								</th>
								<th style="width:10%;">
									属性
								</th>
								<!--<th>手机</th>-->
								<th style="width:15%;">
									车队名称
								</th>
								<th style="width:15%;">
									分公司归属
								</th>
								<tr>
						</table>
					</div>
				</div>
				<div class="panel-foot">
					<strong>
						合计：
					</strong>
				</div>
			</div>
		</div>
	</div>
	<div class="xm10-move">
		<button type="button" class="button bg-main button-big" onclick="meeting_submit()">
			提交
		</button>
	</div>
	<div id="driverlist">
	</div>
</form>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js">
	 
</script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js">
	 
</script>

</html>