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
	
	$.post('/DZOMS/driver/metting',{"beginDate":$("#beginDate").val(),"endDate":$("#endDate").val()},showAll);
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
				
                    <td colspan="2"><input type="button" value="查询" onclick="search()"></td>
				</tr>
			</table>
			<table class="table table-striped table-bordered table-condensed" id="context">
				<tr>
                    		<th>活动名称</th>
                    		<th>活动时间</th>
                    		<th>活动内容</th>
                    		<th>类型</th>
                    		<th>驾驶员数量</th>
                    		<th>录入人</th>
                    		<th>录入时间</th>
                    	</tr>
			</table>
			<input type="hidden" id="searchcondition"/>
		</form>
	
    <script>
   	 $('.datetimepicker').datetimepicker();
	</script>
</body>
</html>
