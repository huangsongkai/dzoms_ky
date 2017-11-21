<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
	uri="/struts-tags" prefix="s"%><%@ page language="java"
	import="java.util.*, com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%><!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>查询表扬信息</title>
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
		case "selectAll":
			fn = showAll;
			break;
		case "selectAllWaitForDeal":
			fn = showAllWaitForDeal;
			break;
		case "selectAllHandled":
			fn = showAllHandled;
			break;
		default:
			fn = showAll;
	}
	
	$.post('/DZOMS/driver/praise/'+$selected_option.val(),{"beginDate":$("#beginDate").val(),"endDate":$("#endDate").val()},fn);
}

function showAll(objs) {
	var list =  objs["praises"];
	
	var title_tr = '<tr><td>表扬日期</td><td>表扬类别</td><td>表扬类型</td><td>车牌号</td>'
					+'<td>表扬项目</td><td>登记人</td><td>登记日期</td> '
					+'<td>落实人</td><td>落实时间</td><td>处理情况</td>'
					+'<td>回访人</td><td>回访时间</td><td>回访结果</td>'
					+'</tr>';
	$("#context").append(title_tr);
	for(var i=0;i<list.length;i++){
		var context_tr='<tr>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["praiseTime"])+'</td>'
				+'<td>'+list[i]["praiseClass"]+'</td>'
				+'<td>'+list[i]["praiseType"]+'</td>'
				+'<td>'+list[i]["licenseNum"]+'</td>'
				
				+'<td>'+list[i]["praiseObject"]+'</td>'
				+'<td>'+list[i]["registrant"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["registTime"])+'</td>'
				 
			
				+'<td>'+list[i]["dealPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["dealTime"])+'</td>'
				+'<td>'+list[i]["dealReault"]+'</td>'
				
			
				+'</tr>';
		$("#context").append(context_tr);
	}
}

function showAllWaitForDeal(objs) {
	var list =  objs["praises"];
	var title_tr = '<tr><td>表扬日期</td><td>表扬类别</td><td>表扬类型</td><td>车牌号</td>'
					+'<td>表扬项目</td><td>登记人</td><td>登记日期</td> '
					+'<td>落实</td></tr>';
	$("#context").append(title_tr);
	for(var i=0;i<list.length;i++){
		var context_tr='<tr>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["praiseTime"])+'</td>'
				+'<td>'+list[i]["praiseClass"]+'</td>'
				+'<td>'+list[i]["praiseType"]+'</td>'
				+'<td>'+list[i]["licenseNum"]+'</td>'
				
				+'<td>'+list[i]["praiseObject"]+'</td>'
				+'<td>'+list[i]["registrant"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["registTime"])+'</td>'
				 
				
				+'<td><a href="praise/predealpraise.action?praise.id='+list[i]["id"]+'">落实</a></td>'
				+'</tr>';
		$("#context").append(context_tr);
	}
}

function showAllHandled(objs) {
	var list =  objs["praises"];
	var title_tr = '<tr><td>表扬日期</td><td>表扬类别</td><td>表扬类型</td><td>车牌号</td>'
					+'<td>表扬项目</td><td>登记人</td><td>登记日期</td> '
					
					+'<td>落实人</td><td>落实时间</td><td>处理情况</td>'
					
					+'</tr>';
	$("#context").append(title_tr);
	for(var i=0;i<list.length;i++){
		var context_tr='<tr>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["praiseTime"])+'</td>'
				+'<td>'+list[i]["praiseClass"]+'</td>'
				+'<td>'+list[i]["praiseType"]+'</td>'
				+'<td>'+list[i]["licenseNum"]+'</td>'
				
				+'<td>'+list[i]["praiseObject"]+'</td>'
				+'<td>'+list[i]["registrant"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["registTime"])+'</td>'
			
				+'<td>'+list[i]["dealPerson"]+'</td>'
				+'<td>'+dateToString("yyyy/MM/dd",list[i]["dealTime"])+'</td>'
				+'<td>'+list[i]["dealReault"]+'</td>'
				
				+'</tr>';
		$("#context").append(context_tr);
	}
}



</script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
	
</head>
<body>
	<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>表扬</li>
                <li>表扬查询</li>
              
        </ul>
        </div>
</div>
		<!-- 主页面 -->
		<form method="post" class="definewidth m20">
			<table class="table table-bordered">
				<tr>
                    <td class="tableleft">开始日期</td>
                    <td><input type="text" id="beginDate" name="beginDate" class="datetimepicker"/></td>
                    
                    <td class="tableleft">结束日期</td>
                    <td><input type="text" id="endDate" name="endDate" class="datetimepicker"/></td>   
				</tr>
				<tr>
                    <td colspan="6" style="text-align:right;">
                    	<select id="target">
                    		<option value="selectAll">查询全部</option>
                    		<option value="selectAllWaitForDeal">查询待落实</option>
                    		<option value="selectAllHandled">查询已落实</option>
                    	</select>
                    </td>
                    <td colspan="2"><input type="button" value="查询" onclick="search()"></td>
				</tr>
			</table>
			<table class="table  table-bordered table-condensed" id="context">
				
			</table>
			<input type="hidden" id="searchcondition"/>
		</form>
	
    <script>
   	 $('.datetimepicker').datetimepicker();
	</script>
</body>
</html>
