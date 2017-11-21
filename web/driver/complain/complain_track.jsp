<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
	uri="/struts-tags" prefix="s"%><%@ page language="java"
	import="java.util.*, com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>查询投诉信息</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>

<script>
function search() {
	$("#context").html("");
	var $selected_option = $("#target").find("option:selected");
	var fn;
	switch ($selected_option.val()) {
		case "all":
			fn = showAll;
			break;
		case "0":
			fn = showAllWaitForConfirm;
			break;
		case "1":
			fn = showAllWaitForDeal;
			break;
		case "2":
			fn = showAllWaitForVisitBack;
			break;
		case "3":
			fn = showAllWaitForHandled;
			break;
		case "4":
			fn = showAllHandled;
			break;
		case "-1":
			fn = showAllNotTrue;
			break;
		default:
			fn = showAll;
	}
	if($selected_option.val()=="all")
		$.post('/DZOMS/driver/complain/selectAll',{"beginDate":$("#beginDate").val(),"endDate":$("#endDate").val()},fn);
	else
		$.post('/DZOMS/driver/complain/selectAllByState',{"beginDate":$("#beginDate").val(),"endDate":$("#endDate").val(),"complain.state":$selected_option.val()},fn);
}

var stateMap = {
	"0":"待确认","1":"待落实","2":"待回访","3":"待完结","4":"已完结","-1":"不属实"
}

function showAll(objs) {
	var list =  objs["complains"];
	
	var title_tr = '<tr><td>投诉日期</td><td>投诉类别</td><td>投诉类型</td><td>车牌号</td>'
					+'<td>违规项目</td><td>登记人</td><td>登记日期</td><td>当前状态</td>'
					+'<td>是否属实</td><td>确认人</td><td>确认时间</td>'
					+'<td>落实人</td><td>落实时间</td><td>处理情况</td>'
					+'<td>回访人</td><td>回访时间</td><td>回访结果</td>'
					+'<td>完结处理人</td><td>完结时间</td>'
					+'</tr>';
	$("#context").append(title_tr);
	for(var i=0;i<list.length;i++){
		var context_tr='<tr>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["complainTime"])+'</td>'
				+'<td>'+list[i]["complainClass"]+'</td>'
				+'<td>'+list[i]["complainType"]+'</td>'
				+'<td>'+list[i]["licenseNum"]+'</td>'
				
				+'<td>'+list[i]["complainObject"]+'</td>'
				+'<td>'+list[i]["registrant"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["registTime"])+'</td>'
				+'<td>'+stateMap[""+list[i]["state"]]+'</td>'
				
				+'<td>'+(list[i]["state"]==-1?"是":"否")+'</td>'
				+'<td>'+list[i]["confirmPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["confirmTime"])+'</td>'
				
				+'<td>'+list[i]["dealPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["dealTime"])+'</td>'
				+'<td>'+list[i]["dealReault"]+'</td>'
				
				+'<td>'+list[i]["visitBackPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["visitBackTime"])+'</td>'
				+'<td>'+list[i]["visitBackResult"]+'</td>'
				
				+'<td>'+list[i]["finishPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["finishTime"])+'</td>'				
				
				+'</tr>';
		$("#context").append(context_tr);
	}
}

function showAllWaitForConfirm(objs) {
	var list =  objs["complains"];
	
	var title_tr = '<tr><td>投诉日期</td><td>投诉类别</td><td>投诉类型</td><td>车牌号</td>'
					+'<td>违规项目</td><td>登记人</td><td>登记日期</td><td>当前状态</td>'
					+'<td>确认</td></tr>';
	$("#context").append(title_tr);
	for(var i=0;i<list.length;i++){
		var context_tr='<tr>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["complainTime"])+'</td>'
				+'<td>'+list[i]["complainClass"]+'</td>'
				+'<td>'+list[i]["complainType"]+'</td>'
				+'<td>'+list[i]["licenseNum"]+'</td>'
				
				+'<td>'+list[i]["complainObject"]+'</td>'
				+'<td>'+list[i]["registrant"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["registTime"])+'</td>'
				+'<td>'+stateMap[""+list[i]["state"]]+'</td>'
				
				+'<td><a href="complain/preconfirmComplain.action?complain.id='+list[i]["id"]+'">确认</a></td>'
				+'</tr>';
		$("#context").append(context_tr);
	}
}

function showAllWaitForDeal(objs) {
	var list =  objs["complains"];
	var title_tr = '<tr><td>投诉日期</td><td>投诉类别</td><td>投诉类型</td><td>车牌号</td>'
					+'<td>违规项目</td><td>登记人</td><td>登记日期</td><td>当前状态</td>'
					+'<td>是否属实</td><td>确认人</td><td>确认时间</td>'
					+'<td>落实</td></tr>';
	$("#context").append(title_tr);
	for(var i=0;i<list.length;i++){
		var context_tr='<tr>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["complainTime"])+'</td>'
				+'<td>'+list[i]["complainClass"]+'</td>'
				+'<td>'+list[i]["complainType"]+'</td>'
				+'<td>'+list[i]["licenseNum"]+'</td>'
				
				+'<td>'+list[i]["complainObject"]+'</td>'
				+'<td>'+list[i]["registrant"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["registTime"])+'</td>'
				+'<td>'+stateMap[""+list[i]["state"]]+'</td>'
				
				+'<td>'+(list[i]["state"]==-1?"是":"否")+'</td>'
				+'<td>'+list[i]["confirmPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["confirmTime"])+'</td>'
				
				+'<td><a href="complain/predealComplain.action?complain.id='+list[i]["id"]+'">落实</a></td>'
				+'</tr>';
		$("#context").append(context_tr);
	}
}

function showAllWaitForVisitBack(objs) {
	var list =  objs["complains"];
	var title_tr = '<tr><td>投诉日期</td><td>投诉类别</td><td>投诉类型</td><td>车牌号</td>'
					+'<td>违规项目</td><td>登记人</td><td>登记日期</td><td>当前状态</td>'
					+'<td>是否属实</td><td>确认人</td><td>确认时间</td>'
					+'<td>落实人</td><td>落实时间</td><td>处理情况</td>'
					+'<td>回访</td>'
					+'</tr>';
	$("#context").append(title_tr);
	for(var i=0;i<list.length;i++){
		var context_tr='<tr>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["complainTime"])+'</td>'
				+'<td>'+list[i]["complainClass"]+'</td>'
				+'<td>'+list[i]["complainType"]+'</td>'
				+'<td>'+list[i]["licenseNum"]+'</td>'
				
				+'<td>'+list[i]["complainObject"]+'</td>'
				+'<td>'+list[i]["registrant"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["registTime"])+'</td>'
				+'<td>'+stateMap[""+list[i]["state"]]+'</td>'
				
				+'<td>'+(list[i]["state"]==-1?"是":"否")+'</td>'
				+'<td>'+list[i]["confirmPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["confirmTime"])+'</td>'
				
				+'<td>'+list[i]["dealPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["dealTime"])+'</td>'
				+'<td>'+list[i]["dealReault"]+'</td>'
				
				+'<td><a href="complain/previsit_backComplain.action?complain.id='+list[i]["id"]+'">回访</a></td>'
				+'</tr>';
		$("#context").append(context_tr);
	}
}

function showAllWaitForHandled(objs) {
	var list =  objs["complains"];
	
	var title_tr = '<tr><td>投诉日期</td><td>投诉类别</td><td>投诉类型</td><td>车牌号</td>'
					+'<td>违规项目</td><td>登记人</td><td>登记日期</td><td>当前状态</td>'
					+'<td>是否属实</td><td>确认人</td><td>确认时间</td>'
					+'<td>落实人</td><td>落实时间</td><td>处理情况</td>'
					+'<td>回访人</td><td>回访时间</td><td>回访结果</td>'
					+'<td>完结</td>'
					+'</tr>';
	$("#context").append(title_tr);
	for(var i=0;i<list.length;i++){
		var context_tr='<tr>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["complainTime"])+'</td>'
				+'<td>'+list[i]["complainClass"]+'</td>'
				+'<td>'+list[i]["complainType"]+'</td>'
				+'<td>'+list[i]["licenseNum"]+'</td>'
				
				+'<td>'+list[i]["complainObject"]+'</td>'
				+'<td>'+list[i]["registrant"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["registTime"])+'</td>'
				+'<td>'+stateMap[""+list[i]["state"]]+'</td>'
				
				+'<td>'+(list[i]["state"]==-1?"是":"否")+'</td>'
				+'<td>'+list[i]["confirmPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["confirmTime"])+'</td>'
				
				+'<td>'+list[i]["dealPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["dealTime"])+'</td>'
				+'<td>'+list[i]["dealReault"]+'</td>'
				
				+'<td>'+list[i]["visitBackPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["visitBackTime"])+'</td>'
				+'<td>'+list[i]["visitBackResult"]+'</td>'
				
				+'<td><a href="complain/prefinishComplain.action?complain.id='+list[i]["id"]+'">完结</a></td>'			
				
				+'</tr>';
		$("#context").append(context_tr);
	}
}

function showAllHandled(objs) {
	var list =  objs["complains"];
	var title_tr = '<tr><td>投诉日期</td><td>投诉类别</td><td>投诉类型</td><td>车牌号</td>'
					+'<td>违规项目</td><td>登记人</td><td>登记日期</td><td>当前状态</td>'
					+'<td>是否属实</td><td>确认人</td><td>确认时间</td>'
					+'<td>落实人</td><td>落实时间</td><td>处理情况</td>'
					+'<td>回访人</td><td>回访时间</td><td>回访结果</td>'
					+'<td>完结处理人</td><td>完结时间</td>'
					+'</tr>';
	$("#context").append(title_tr);
	for(var i=0;i<list.length;i++){
		var context_tr='<tr>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["complainTime"])+'</td>'
				+'<td>'+list[i]["complainClass"]+'</td>'
				+'<td>'+list[i]["complainType"]+'</td>'
				+'<td>'+list[i]["licenseNum"]+'</td>'
				
				+'<td>'+list[i]["complainObject"]+'</td>'
				+'<td>'+list[i]["registrant"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["registTime"])+'</td>'
				+'<td>'+stateMap[""+list[i]["state"]]+'</td>'
				
				+'<td>'+(list[i]["state"]==-1?"是":"否")+'</td>'
				+'<td>'+list[i]["confirmPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["confirmTime"])+'</td>'
				
				+'<td>'+list[i]["dealPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["dealTime"])+'</td>'
				+'<td>'+list[i]["dealReault"]+'</td>'
				
				+'<td>'+list[i]["visitBackPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["visitBackTime"])+'</td>'
				+'<td>'+list[i]["visitBackResult"]+'</td>'
				
				+'<td>'+list[i]["finishPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["finishTime"])+'</td>'				
				
				+'</tr>';
		$("#context").append(context_tr);
	}
}

function showNotTrue(objs) {
	var list =  objs["complains"];
	var title_tr = '<tr><td>投诉日期</td><td>投诉类别</td><td>投诉类型</td><td>车牌号</td>'
					+'<td>违规项目</td><td>登记人</td><td>登记日期</td><td>当前状态</td>'
					+'<td>是否属实</td><td>确认人</td><td>确认时间</td>'
					+'<td>操作</td>'
					+'</tr>';
	$("#context").append(title_tr);
	for(var i=0;i<list.length;i++){
		var context_tr='<tr>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["complainTime"])+'</td>'
				+'<td>'+list[i]["complainClass"]+'</td>'
				+'<td>'+list[i]["complainType"]+'</td>'
				+'<td>'+list[i]["licenseNum"]+'</td>'
				
				+'<td>'+list[i]["complainObject"]+'</td>'
				+'<td>'+list[i]["registrant"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["registTime"])+'</td>'
				+'<td>'+stateMap[""+list[i]["state"]]+'</td>'
				
				+'<td>'+(list[i]["state"]==-1?"是":"否")+'</td>'
				+'<td>'+list[i]["confirmPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["confirmTime"])+'</td>'
				
				+'<td><a href="complain/deleteComplain.action?complain.id='+list[i]["id"]+'">删除</a></td>'				
				
				+'</tr>';
		$("#context").append(context_tr);
	}
}

</script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
	
</head>
<body>
		<!-- 主页面 -->
		<form method="post" class="definewidth m20">
			<table class="table">
				<tr>
                    <td class="tableleft">开始日期</td>
                    <td><input type="text" id="beginDate" name="beginDate" class="datetimepicker"/></td>
                    
                    <td class="tableleft">结束日期</td>
                    <td><input type="text" id="endDate" name="endDate" class="datetimepicker"/></td>   
				</tr>
				<tr>
                    <td colspan="6" style="text-align:right">
                    	<select id="target">
                    		<option value="all">查询全部</option>
                    		<!--<option value="0">查询待确认</option>
                    		<option value="1">查询待落实</option>
                    		<option value="2">查询待回访</option>
                    		<option value="3">查询待完结</option>-->
                    		<option value="4">查询已完结</option>
                    		<option value="-1">查询不属实</option>
                    	</select>
                    </td>
                    <td colspan="2"><input type="button" value="查询" onclick="search()"></td>
				</tr>
			</table>
			<table class="table table-striped table-bordered table-condensed" id="context">
				
			</table>
			<input type="hidden" id="searchcondition"/>
		</form>
	
    <script>
   	 $('.datetimepicker').datetimepicker();
	</script>
</body>
</html>
