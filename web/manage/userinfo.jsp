<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/layer-v2.1/layer/layer.js" ></script>
	<script type="text/javascript" src="/DZOMS/res/js/window.js" ></script>
    </head>
    <body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>个人管理</li>
                <li>个人信息</li>
        </ul>
</div>
    	  <div class="panel xm6 xm2-move">
    	  	 <div class="panel-head">
    	  	 	用户个人信息
    	  	 </div>
    	  	 <div class="panel-body">
    	  	 	
	<div class="form-group">
		<div class="field field-icon">
			<s:textfield cssClass="input" disabled="true" value="%{#session.user.uname}"/>
			<span class="icon icon-user"></span>
		</div>
	</div>
	<div class="form-group">
		<div class="field field-icon">
			<s:textfield cssClass="input" disabled="true" value="%{#session.user.department}"/>
		</div>
	</div>
	<div class="form-group">
		<div class="field field-icon">
			<s:textfield cssClass="input" disabled="true" value="%{#session.user.position}"/>
		</div>
	</div>
	</div>
</div>
 	</body>
</html>