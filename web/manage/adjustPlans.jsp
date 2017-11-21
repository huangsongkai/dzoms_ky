<%@page contentType="text/html"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% String path=request.getContextPath(); 
	String basePath=request.getScheme()+ "://"+request.getServerName()+ ":"+request.getServerPort()+path+ "/"; 
%>
<!DOCTYPE html>
<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width,initial-scale=1.0, maximum-scale=1.2, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="renderer" content="webkit" />
		<base href="<%=basePath%>" />
		<title> 财务查错纠错 </title> 
		<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
		<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
		<link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css" />
		<script src="/DZOMS/res/js/jquery.js"> </script> 
		<script src="/DZOMS/res/js/pintuer.js"> </script> 
		<script src="/DZOMS/res/js/respond.js"> </script> 
		<script type="text/javascript" src="/DZOMS/res/js/itemtool.js"></script> 
		<script src="/DZOMS/res/js/admin.js"> </script> 
		<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
		<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
    	<style>
		.label {
			width: 80px;
			text-align:right;
		}
		.form-group { 
			width: 300px;
			margin-top: 5px;
		}
		.changecolor {
			background-color: #0099CC;
		}
		</style>
		<script>
$(document).ready(function(){	
	$("#licenseNum").bigAutocomplete({
		url:"/DZOMS/select/VehicleBylicenseNum",
		doubleClick:true,
		doubleClickDefault:'黑A',
		callback:function(){
			
		}
	});
	
	if($("#licenseNum").val().trim().length<7){
		$("#licenseNum").val('黑A');
	}
	
});
		</script>
    </head>
    <body>
    <div class="margin-big-bottom">
		<div class="adminmin-bread" style="width: 100%;">
			<ul class="bread text-main" style="font-size: larger;">
				<li> 系统管理 </li> <li> 财务查错纠错 </li>
			</ul> 
		</div>
		<div class="panel">
    		<div class="panel-head">财务查错纠错:</div>
    		<div class="panel-body">
    		   <form action="/DZOMS/adjustVehicle.action" method="post" class="form-inline" target="show">
				<input type="hidden" name="url" value="/manage/adjust_new_car.jsp" />
	            <div class="form-group">
	                <div class="label padding">
	                    <label>
	                        车牌号：
	                    </label>
	                </div>
	                <div class="field">
	                    <input type="text" class="input" value="黑A" name="licenseNum" id="licenseNum">
	                </div>
	            </div>
	            <input type="submit" value="查错" class="button bg-green"/>
	           </form>
	         <iframe name="show" id="show" width="100%" style="height: 500px;"></iframe>
    		</div> 
   		</div>
	</div>
 	</body>
</html>