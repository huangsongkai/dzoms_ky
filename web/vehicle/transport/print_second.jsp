<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
		<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
<script>
$(document).ready(function(){
	window.print();
	setTimeout("window.close();",10000);
});
</script>
	</head>
	<body>
		<%! int year = new java.util.Date().getYear()+1900;%>
		<%! int month = new java.util.Date().getMonth()+1;%>
		<%! int day = new java.util.Date().getDate();%>
		<s:iterator value="%{#request.list}" var="v">
		<div style="width:756px;height:1150px;">
			<table border="0">
			<tr style="width: 700px;height:50px ;">
				<td cssStyle="width: 350px;text-align: center;"><strong><%=year%></strong></td>
				<td style="width: 350px;text-align: center;"><strong>大众</strong></td>
			</tr>
			<tr style="width: 700px;height:50px;">
				<td style="width: 350px;text-align: center;"><strong><%=year%>年<%=month<10?"0":""%><%=month%>月<%=day%>日</strong></td>
				<td style="width: 350px;text-align: center;"><strong></strong></td>
			</tr>
			<tr style="width: 700px;height:50px ;">
				<s:set name="p_carMode" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.VehicleMode',#v.carMode)}"></s:set>
				<td style="width: 175px;text-align: center;"><strong>大众<s:property value="%{@org.apache.commons.lang3.StringUtils@left(#v.dept,1)}"/>公司</strong></td>
				<td style="width: 175px;text-align: center;"><strong><s:property value="%{#v.licenseNum}"/></strong></td>
				<td style="width: 175px;text-align: center;"><strong><s:property value="%{#p_carMode.fuel}"/></strong></td>
				<td style="width: 175px;text-align: center;"><strong><s:property value="%{#v.carMode}"/></strong></td>
			</tr>
			<tr style="width: 700px;height: 50px;">
				<td style="width: 233px;text-align: center;"><strong><s:property value="%{#v.moneyCountor}"/></strong></td>
				<td style="width: 233px;text-align: center;"><strong><s:property value="%{#v.carframeNum}"/></strong></td>
				<td style="width: 233px;text-align: center;"><strong><s:property value="%{#v.operateCard}"/></strong></td>
			</tr>
		</table>
		</div>
		</s:iterator>
	</body>
</html>
