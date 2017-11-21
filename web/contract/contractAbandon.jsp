<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="javax.swing.text.Document"%>
<%@ page language="java"
	import="java.util.*, com.dz.module.contract.Contract,com.dz.module.user.User,com.dz.common.other.TimeComm"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>合同废除</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script type="text/javascript">

</script>
</head>

<body>
	<div class="adminmin-bread">
		<ul class="bread">
			<li><a href="" class="icon-home"> 开始</a></li>
			<li>合同废止</li>
		</ul>
	</div>

	<div>
		<!-- 主页面 -->
		<form action="contractAbandon" method="post" class="definewidth m20">
			<s:hidden name="contract.id"></s:hidden>
			<table class="table table-bordered table-hover m10">
				<tr>
					<td class="tableleft">实际废止日期</td>
					<td><input type="input" class="input datepick" name="contract.abandonedTime"/></td>
					<td class="tableleft">废止种类</td>
					<td>
						<s:textfield name="contract.abandonReason"></s:textfield>
					</td>
				</tr>
				<tr>
					<td class="tableleft">经手人</td>
					<td><input type="text"  value="<%=((User)session.getAttribute("user")).getUname()%>" readonly="readonly"/>
						<input type="hidden" name="contract.abandonedUser" value="<%=((User)session.getAttribute("user")).getUid()%>" />
					</td>
					<td class="tableleft">经手时间</td>
					<td><s:textfield name="contract.abandonedTimeControl" maxlength="20" value="%{@com.dz.common.other.TimeComm@getDate()}" readonly="readonly"/></td>
				</tr>
				
				<tr>
					<td class="tableleft">承租人照片</td>
					<td><img src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/photo.jpg"></td>

					<td class="tableleft">车架号</td>
					<td><s:textfield name="contract.carframeNum" readonly="readonly" /></td>

					<td class="tableleft">车牌号</td>
					<td>黑A<s:textfield name="contract.carNum" readonly="readonly" /></td>
				</tr>
				<tr>
					<td class="tableleft">档案号</td>
					<td><s:textfield name="contract.contractId" readonly="readonly" /></td>

				</tr>
				
				</table>
			
			<table class="table table-bordered table-hover m10">
				<tr>
					<td class="tableleft"></td>
					<td colspan="6" style="text-align:right;">
						<button type="submit" class="btn btn-primary">提交</button>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-success" name="backid"
							id="backid">取消</button>
					</td>
				</tr>
			</table>
		</form>
	</div>

<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</body>
</html>