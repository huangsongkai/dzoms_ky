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
	<%
	List list = (List)request.getAttribute("list");
	for(int i=0;i<list.size();i++){
		request.setAttribute("v", list.get(i));
	%>
	<%if(i%3==0){ %> 
	<div style="width:756px;height:1150px;">
		<table border="0">
	<%} %>
	
			<tr style="width: 700px;height:50px ;">
				<td style="width: 350px;text-align: center;"><strong>大众<s:property value="%{@org.apache.commons.lang3.StringUtils@left(#request.v.dept,1)}"/>公司</strong></td>
				<td style="width: 350px;text-align: center;"><strong><s:property value="%{#request.v.licenseNum}"/></strong></td>
			</tr>
			<tr style="width: 700px;height: 300px;">
				<td style="width: 350px;text-align: center;"><strong><s:property value="%{#request.v.operateCard}"/></strong></td>
				<td style="width: 350px;text-align: center;"><strong><s:property value="%{#request.v.carframeNum}"/></strong></td>
			</tr>
			
	<%if(i%3==2){ %> 
		</table>
	</div>
	<%} %>
	 
	<%} %>
	</body>
</html>
