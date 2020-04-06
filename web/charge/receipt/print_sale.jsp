<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%@page import="com.dz.common.convertor.DateTypeConverter"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
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
	<title>免费出租汽车机打发票发放流向明细表</title>

	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
	<script>
		$(document).ready(function(){
			window.print();
			//setTimeout("window.close();",10000);
		});
	</script>
	<style type="text/css">
		table{
			font-size:12px;
		}
		table,table tr th, table tr td {
			border:1px solid #000;
		}
	</style>
</head>
<body>
<s:iterator value="%{#request.list}" var="v" status="L">
<s:if test="%{#L.index%60==0}">
<%{ %>
<div style="width:195mm;height:262mm;">
	<h2 style="text-align:center">免费出租汽车机打发票发放流向明细表</h2>
	<div><span style="padding-left:5%">公司名称：      （印鉴）</span><span style="float:right;padding-right:20%">企业票据发放人： 尹丽波</span></div>
	<table border="1" style="width: 700px;">
		<tr>
			<th>车号</th>
			<th>车主姓名</th>
			<th>票据起始号</th>
			<th>领购人</th>
			<th>领购日期</th>
			<th>备注</th>
		</tr>
		<%} %>
		</s:if>
		<tr>
			<td><s:property value="%{#v.carId}"/></td>
			<td><s:property value="%{#v.renter}"/></td>
			<td><s:property value="%{#v.startFullNum}"/> - <s:property value="%{#v.endFullNum}"/></td>
			<td><s:property value="%{#v.taker}"/></td>
			<td><s:date name="%{#v.recordTime}" format="yyyy-MM-dd HH:mm:ss"/></td>
			<td><s:property value="%{#v.comment}"/></td>
		</tr>
		<s:if test="%{#L.index%60==59}">
	</table>
	<div>
		<span style="padding-left:10%">共计：<s:property value="%{#request.list.size()}"/></span>
		<span style="padding-left:10%">本页：60条</span>
		<span style="padding-left:10%">打印日期：<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %></span>
		<span style="padding-left:10%">第<s:property value="%{#L.index/60+1}"/>页</span></div>
	<!--<p>&nbsp;</p>-->
	</s:if>
	</s:iterator>
	</table>
	<div>
		<span style="padding-left:10%">共计：<s:property value="%{#request.list.size()}"/></span>
		<span style="padding-left:10%">本页：<s:property value="%{#request.list.size()%60}"/></span>
		<span style="padding-left:10%">打印日期：<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %></span>
		<span style="padding-left:10%">第<s:property value="%{#request.list.size()/60+1}"/>页</span>
		<!--<p>&nbsp;</p>-->
	</div>
</body>
</html>
