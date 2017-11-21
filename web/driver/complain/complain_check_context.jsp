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
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission any="true" role="投诉落实,投诉回访,投诉完结,投诉补充登记">
<jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>

<!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>投诉处理</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
$(document).ready(function(){
	$("#search_form").find(".input").change(function(){
		beforeSubmit();
	});
	beforeSubmit();
});
		
function beforeSubmit(){
	$("#search_form").submit();
}

/*
$(document).ready(function(){
		$("[name='carNum']").bigAutocomplete({
			url:"/DZOMS/select/vehicleByLicenseNum",
			callback:beforeSubmit()
		});
		$("[name='idNum']").bigAutocomplete({
			url:"/DZOMS/select/driverById",
			callback:beforeSubmit()
		});
});
*/

</script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<!--<style>
	.label {
		width: 80px;
		text-align: right;
	}
	.form-group {
		width: 380px;
		margin-top: 5px;
	}
	
</style>	-->
</head>
<body>
	<jsp:include page="/common/load_to_top.jsp"></jsp:include>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>投诉</li>
        </ul>
</div>
<div class="line">
	<div class="panel  margin-small">
		<form method="post" class="form-inline" id="search_form" action="/DZOMS/driver/complain/searchComplain" target="result_form">
			<s:hidden name="states" value="%{#parameters.state}"/>
			<input type="hidden" name="url" value="/driver/complain/complain_check.jsp" />
			<div class="form-group">
				<div class="label">
					<label>开始时间</label>
				</div>
				<div class="field">
					<input type="text" id="beginDate" name="beginDate" class="datetimepicker input" />
				</div>
			</div>

			<div class="form-group">
				<div class="label">
					<label>结束时间</label>
				</div>
				<div class="field">
					<input type="text" id="endDate" name="endDate" class="datetimepicker input" />
				</div>
			</div>

			<div class="form-group">
				<div class="label">
					<label>部门</label>
				</div>
				<div class="field">
					<select name="dept" id="dept" class="input" style="width: 100px;">
						<option value="" selected="selected">全部</option>
						<option value="一部">一部</option>
						<option value="二部">二部</option>
						<option value="三部">三部</option>
					</select>
				</div>
			</div>

			<div class="form-group">
				<div class="label">
					<label>排序方式</label>
				</div>
				<div class="field">
					<input type="radio" name="order" value="licenseNum" checked="checked" />按车号
					<input type="radio" name="order" value="complainTime" />按投诉日期
				</div>
			</div>

			<div class="form-button">
				<input type="submit" class="button bg-yellow" value="查询"></input>
				<input type="reset" class="button bg-yellow" value="清空条件"></input>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript" >
	$('.datetimepicker').datetimepicker({
    	lang:"ch",           //语言选择中文
		format:"Y/m/d",      //格式化日期
		timepicker:false,    //关闭时间选项
		yearStart:2000,     //设置最小年份
		onClose:function(){
			$("#complain_search").submit();
		}
    });
</script>

<!-- 主页面 -->
<div>
    <iframe name="result_form" width="100%" height="1800px" id="result_form" scrolling="no">

    </iframe>

</div>
    
</body>
</html>
