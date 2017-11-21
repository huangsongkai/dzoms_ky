<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>客运检车</title>
	
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
		$(document).ready(function(){
			$("#search_form").find("input,select").change(function(){
				$("#search_form").submit();
			});
			
			$("#search_form").submit();
		});
		
</script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
  </head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>客运检车</li>
               
    </ul>
</div>

<form name="vehicleSele" style="width: 100%;" action="vehicleSele" method="post" id="search_form" class="form-inline" target="result_form">
   <div class="panel margin-small">
	   <input type="hidden" name="url" value="/vehicle/transport_search_result.jsp" />
	   <div class="panel-head">
	   	查询条件
	   </div>
	 <div class="panel-body">
	 
	 		<div class="form-group">
	 			<label>营运证发放日期</label>
	 			<div class="field"><input type="text" name="operateCardTime_begin" class="input datepick" /></div>
	 		</div>
	 		<div class="form-group">
	 			<label>营运证终止日期</label>
	 			<div class="field"><input type="text" name="operateCardTime_end"  class="input datepick"/></div>
	 		</div>
	 		

	 
  </div>
</div>
</form>

<iframe name="result_form" width="100%" height="900px" scrolling="no">

</iframe>

<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>

</body>
</html>




