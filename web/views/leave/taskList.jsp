<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<title>申请待办任务列表</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />
    <link href="${ctx }/js/common/plugins/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />
    <%@ include file="/common/include-custom-styles.jsp" %>
    <style type="text/css">
    /* block ui */
	.blockOverlay {
		z-index: 1004 !important;
	}
	.blockMsg {
		z-index: 1005 !important;
	}
    </style>

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/jui/extends/i18n/jquery-ui-date_time-picker-zh-CN.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/blockui/jquery.blockUI.js" type="text/javascript"></script>
	<script src="${ctx }/js/module/activiti/workflow.js" type="text/javascript"></script>
	<script src="${ctx }/js/module/oa/leave/leave-todo.js" type="text/javascript"></script>
</head>

<body>
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success">${message}</div>
	</c:if>
	<table width="100%" class="need-border">
		<thead>
			<tr>
				<th>申请类型</th>
				<th>申请人</th>
				<th>申请时间</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th>原课程信息</th>
				<th>申请课程</th>
				<th>当前节点</th>
				<th>任务创建时间</th>
				<!-- <th>流程记录</th> -->
				<th>流程状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${results}" var="leave">
				<c:set var="task" value="${leave['task']}" />
				<c:set var="pi" value="${leave['processInstance'] }" />
				<tr id="${leave['leave'].id }" tid="${task.id }">
					<td>${leave['leave'].leaveType }</td>
					<td>${leave['leave'].userId }</td>
					<td>${leave['leave'].applyTime }</td>
					<td>${leave['leave'].startTime }</td>
					<td>${leave['leave'].endTime }</td>
					<td>${leave['leave'].oldCourse }</td>
					<td>${leave['leave'].applyCourse }</td>
					<td>
						<a class="trace" href='#' pid="${pi.id }" pdid="${pi.processDefinitionId}" title="点击查看流程图">${task.name }</a>
					</td>
					
					<td>${task.createTime }</td>
					
					<td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${leave["processDefinition"].processDefinition.version }</b></td>
					<td>
						<c:if test="${empty task.assignee && task.name !='更新业务'}">
							<a class="claim" href="${ctx }/oa/leave/task/claim/${task.id}">签收</a>
						</c:if>
						<c:if test="${task.name eq '更新业务'}">
							<a class="claim" href="${ctx }/oa/leave/complete/${task.id}">更新</a>
						</c:if>								
						<c:if test="${not empty task.assignee && task.name !='更新业务'}">
							<!-- 此处用tkey记录当前节点的名称 -->
							<a class="handle" tkey='${task.taskDefinitionKey }' tname='${task.name }' href="#">办理</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 下面是每个节点的模板，用来定义每个节点显示的内容 -->
	<!-- 使用DIV包裹，每个DIV的ID以节点名称命名，如果不同的流程版本需要使用同一个可以自己扩展（例如：在DIV添加属性，标记支持的版本） -->


</body>
</html>
