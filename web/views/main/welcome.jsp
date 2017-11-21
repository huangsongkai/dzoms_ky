<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<%@ include file="/common/meta.jsp"%>

	<%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jui/extends/portlet/jquery.portlet.min.css?v=1.1.2" type="text/css" rel="stylesheet" />
    <link href="${ctx }/js/common/plugins/qtip/jquery.qtip.css?v=1.1.2" type="text/css" rel="stylesheet" />
    <%@ include file="/common/include-custom-styles.jsp" %>
    <style type="text/css">
    	.template {display:none;}
    	.version {margin-left: 0.5em; margin-right: 0.5em;}
    	.trace {margin-right: 0.5em;}
        .center {
            width: 1200px;
            margin-left:auto;
            margin-right:auto;
        }
    </style>

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/extends/portlet/jquery.portlet.pack.js?v=1.1.2" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script>
	<script src="${ctx }/js/module/activiti/workflow.js" type="text/javascript"></script>
    <script src="${ctx }/js/module/main/welcome-portlet.js" type="text/javascript"></script>
</head>
<body style="margin-top: 1em;">
	<a href="http://www.baidu.com" >baidu</a>  
	<a href='http://localhost:8080/activitiDemo/workflow/auto/process-list'>流程列表</a>
	
		<ul id="css3menu">
		<li>
			<a rel='#'>流程管理</a>
			<ul>
				<li><a href='http://localhost:8080/activitiDemo/workflow/auto/process-list'>流程列表</a></li>			
				<li><a href='http://localhost:8080/activitiDemo/workflow/process-list'>流程定义及部署管理</a></li>	
				<li><a href="http://localhost:8080/activitiDemo/workflow/auto/process-instance/finished/list">已结束流程(外置)</a></li>	
			</ul>
		</li>
		<li>
			<a rel='#'>业务操作</a>
			<ul>			
				<li><a href="http://localhost:8080/activitiDemo/index">纯流程页面显示</a></li>
				<li><a href="http://localhost:8080/activitiDemo/start">申请信息填写</a></li>			
			</ul>
		</li>
		
	</ul>
	
	
	
</body>
</html>
