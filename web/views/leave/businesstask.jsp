<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>业务任务列表</title> 
</head>
<body>
	<table width="100%" class="need-border">
		<thead>
			<tr>
				<th>申请类型</th>
				<th>申请人</th>		
				<th>开始时间</th>
				<th>结束时间</th>				
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${results}" var="leave">
				<tr id="${leave['leave'].id }">
					<td>${leave['leave'].leaveType }</td>
					<td>${leave['leave'].userId }</td>					
					<td>${leave['leave'].startTime }</td>
					<td>${leave['leave'].endTime }</td>
					<td>										
					<a class="handle" href="#">办理</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 下面是每个节点的模板，用来定义每个节点显示的内容 -->
	<!-- 使用DIV包裹，每个DIV的ID以节点名称命名，如果不同的流程版本需要使用同一个可以自己扩展（例如：在DIV添加属性，标记支持的版本） -->


</body>
</html>
