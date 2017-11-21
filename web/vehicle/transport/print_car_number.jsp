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
		<title>打印车号</title>
		
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
		<table border="1" style="width: 700px;">
			<tr>
				<th>序号</th>
				<th>车号</th>
				<th>车型</th>
				<th>发动机号</th>
				<th>车架号</th>
				<th>参营时间</th>
				<th>营运证号</th>
				<th>燃油种类</th>
			</tr>
<s:iterator value="%{#request.list}" var="v"  status="L">
<tr>
<td><s:property value="%{#L.index+1}"/></td>
<td><s:property value="%{#v.licenseNum}"/></td>
<td><s:property value="%{#v.carMode}"/></td>
<td><s:property value="%{#v.engineNum}"/></td>
<td><s:property value="%{#v.carframeNum}"/></td>
<td><s:property value="%{#v.operateCardTime}"/></td>
<td><s:property value="%{#v.operateCard}"/></td>
<s:set name="p_carMode" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.VehicleMode',#v.carMode)}"></s:set>
<td><s:property value="%{#p_carMode.fuel}"/></td>
</tr>
</s:iterator>
		</table>
	</body>
</html>
