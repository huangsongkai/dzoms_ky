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
		<title>查看发票信息</title>
		<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	<jsp:include page="/common/msg_info.jsp"></jsp:include>
<style>
	.tableleft{
		text-align: right;
	}
</style>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>查看</li>
                <li>查看发票信息</li>
        </ul>
</div>

	<div class="xm5 xm2-move">
		<div class="padding">
		<div class="panel">
			<div class="panel-head">
				查看发票信息
			</div>
			<div class="panel-body">
			<form action="/DZOMS/vehicle/invoice_add" method="post" class="form-x form-tips">
			<div class="form-group">
				<div class="label"><label>车架号</label></div>
				<div class="field"><s:textfield id="carframe_num" cssStyle="width: 95%;float: left;" name="vehicle.carframeNum" cssClass="input" />
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>开票日期</label></div>
				<div class="field"><s:textfield  name="vehicle.invoiceDate" cssClass="input datepick" cssStyle="width: 95%;float: left;" />
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>发票号码</label></div>
				<div class="field"><s:textfield  name="vehicle.invoiceNumber" cssStyle="width: 95%;float: left;" cssClass="input"/>
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>计税合计</label></div>
				<div class="field"><s:textfield  name="vehicle.invoiceMoney" cssClass="input" cssStyle="width: 95%;float: left;" />
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>销货单位名称</label></div>
				<div class="field">
				<s:textfield  cssClass="input" cssStyle="width: 95%;float: left;" name="vehicle.purseFrom" id="vehicle_purseFrom"  >
                	</s:textfield>
				</div>
			</div>
			<div class="form-group">
				<div class="label"><label>登记人</label></div>
				<div class="field">
					<s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',vehicle.invoiceRegister).uname}" /></div>
				</div>
			<div class="form-group">
				<div class="label"><label>登记时间</label></div>
				<div class="field"><s:textfield cssClass="input" readonly="readonly" name="vehicle.invoiceRegistTime" />
			</div>
			
		
		</form>
			</div>
			
		</div>
	
	</div>
	</body>
	<script src="/DZOMS/res/js/DateTimeHelper.js"></script>
</html>
