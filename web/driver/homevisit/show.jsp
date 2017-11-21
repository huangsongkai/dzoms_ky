<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
	uri="/struts-tags" prefix="s"%><%@ page language="java"
	import="java.util.*, com.dz.module.vehicle.VehicleApproval,com.dz.module.user.User"
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
<title>查看家访信息</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
<script src="/DZOMS/res/js/itemtool.js"></script>

    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
    <style>
						.label{
							width: 80px;
							text-align: right;
						}
						.form-group{
							width: 300px;
						}
					</style>
	
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>家访</li>
                <li>家访查看</li>
              
        </ul>
        </div>
</div>
<form class="form-inline form-tips" name="addPraise" action="/DZOMS/driver/homevisit/addHomeVisit" method="post" enctype="multipart/form-data">
            <div class="panel bored-main">
							<div class="panel-head bg-main">
								<h3><strong>家访登记</strong></h3>
							</div>
							<div class="panel-boby">
								<div class="form-group margin-small">
									<div class="label">
										<label>
											家访时间</label>
									</div>
									<div class="field">
										<s:textfield cssClass="input" type="text" value="%{bean[0].time}"></s:textfield>
									</div>
								</div>
								
								
								<br>

								<div class="form-group margin-small">
									<div class="label">
										<label>车牌号</label>
									</div>
									<div class="field">
										<s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',bean[0].carframeNum).licenseNum}"></s:textfield>
									</div>
								</div>
								<div class="form-group margin-small">
									<div class="label">
										<label>司机姓名</label>
									</div>
									<div class="field">
										<s:set name="t_driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',bean[0].idNum)}"/>
										<s:textfield cssClass="input" value="%{#t_driver.name}"></s:textfield>
									</div>
								</div>
								
								<div class="form-group margin-small">
									<div class="label">
										<label>身份证号</label>
									</div>
									<div class="field">
										<s:textfield cssClass="input" value="%{#t_driver.idNum}"></s:textfield>
									</div>
								</div>
								
								<div class="form-group margin-small">
									<div class="label">
										<label>家庭住址</label>
									</div>
									<div class="field">
										<s:textfield cssClass="input" value="%{#t_driver.address}"></s:textfield>
									</div>
								</div>

								<br>
					            <div style="width: 600px;">
								
										<div class="float-left" style="width: 80px; text-align: right;">
											<strong>家访记录</strong>
										</div>
									
									<div class="field">
										<s:textarea cssStyle="width: 500px;" rows="5" cssClass="input" placeholder="多行文本" value="%{bean[0].record}"></s:textarea>
									</div>
								</div>
								<div style="width: 600px;">
								
										<div class="float-left" style="width: 80px; text-align: right;">
											<strong>备注</strong>
										</div>
									
									<div class="field">
										<s:textarea cssStyle="width: 500px;" rows="5" cssClass="input" placeholder="多行文本" value="%{bean[0].comment}"></s:textarea>
									</div>
								</div>
								
					<br>
					
					          <div class="form-group margin-small">
									<div class="label">
										<label>家访人</label>
									</div>
									<div class="field">
										<s:textfield cssClass="input" type="text" readonly="readonly" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',bean[0].register).uname}"></s:textfield>
									</div>
								</div>
								
							</div>
							<br>
						</div>		
    </form>
   <script src="/DZOMS/res/js/DateTimeHelper.js"></script>
</body>
</html>
