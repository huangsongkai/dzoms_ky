<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8"%><!DOCTYPE html>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
		<title>查看购置税信息</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script src="/DZOMS/res/js/itemtool.js"></script>
	<jsp:include page="/common/msg_info.jsp"></jsp:include>
	</head>
	<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>查看</li>
                <li>查看购置税信息</li>
        </ul>
</div>
	
	<div class="xm5 xm2-move">
		<div class="padding">
		<div class="panel">
			<div class="panel-head">
				查看购置税信息
			</div>
			<div class="panel-body">
					<form action="/DZOMS/vehicle/tax_add" method="post" class="form-x form-tips">
			<input type="hidden" name="url" value="/vehicle/vehicle/tax_add.jsp" />
			<div class="form-group">
				<div class="label"><label>车架号</label></div>
				<div class="field"><s:textfield cssClass="input" id="carframe_num"  cssStyle="width: 95%;float: left;"  name="vehicle.carframeNum" />
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>核发日期</label></div>
				<div class="field"><s:textfield cssClass="input" name="vehicle.taxDate" cssStyle="width: 95%;float: left;" />
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>购置税号</label></div>
				<div class="field"><s:textfield cssClass="input" name="vehicle.taxNumber"  cssStyle="width: 95%;float: left;" />
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>购置税应收</label></div>
				<div class="field"><s:textfield cssClass="input" name="vehicle.taxMoney"  cssStyle="width: 95%;float: left;"  />
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>发证机关</label></div>
				<div class="field">
					<s:textfield cssClass="input" name="vehicle.taxFrom" cssStyle="width: 95%;float: left;"/>
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>登记人</label></div>
				<div class="field">
					<s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',vehicle.taxRegister).uname}" />
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>登记时间</label></div>
				<div class="field">
					<s:textfield cssClass="input" name="vehicle.taxRegistTime" cssStyle="width: 95%;float: left;"/>
			</div>
		
			
		</form>
			
			</div>
		</div>
	
	</div>
	</body>
</html>

