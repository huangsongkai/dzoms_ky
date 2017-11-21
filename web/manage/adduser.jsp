<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
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
                <li>新增用户</li>
        </ul>
</div>
<form method="post" action="/DZOMS/manage/addUser" class="form-auto">
    	  <div class="panel xm6 xm2-move">
    	  	 <div class="panel-head">
    	  	 	请输入用户账号信息
    	  	 </div>
    	  	 <div class="panel-body">
    	  	 	
	<div class="form-group">
		<div class="field field-icon">
			<input  class="input" name="user.uname"   size="30" placeholder="账号"  data-validate="required:请填写账号" />
			<span class="icon icon-user"></span>
		</div>
	</div>
	<div class="form-group">
		<div class="field field-icon">
			<input type="password" class="input" name="user.upwd" size="30" placeholder="请输入密码"  data-validate="required:请填写密码" />
			<span class="icon icon-key"></span>
		</div>
	</div>
	<div class="form-group">
		<div class="field field-icon">
			<input  class="input"  type="password" size="30" placeholder="确认密码" data-validate="required:请填写密码,repeat#user.upwd:两次输入的密码不一致，请检查"/>
			<span class="icon icon-key"></span>
		</div>
	</div>
	<div class="form-group">
		<div class="field field-icon">
			<input type="text" class="input" name="user.department" size="30"  placeholder="部门" />
		</div>
	</div>
	<div class="form-group">
		<div class="field field-icon">
			<input type="text" class="input" name="user.position" size="30"  placeholder="职位" />
		</div>
	</div>
	
	<div class="form-button">
		<button class="button" type="submit">注册</button>
		<a  href="/DZOMS/manage/selectAllUsers" class="button">返回</a>
	</div>
	</div>
</form>
    	  	 	
    		
    		
 	</body>
</html>