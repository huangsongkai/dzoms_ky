<%@taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.dz.common.test.DataTrackFilter"%>
<%@page import="com.dz.common.global.*"%>
<%@page import="org.springframework.context.ApplicationContext" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page language="java"
		 import="java.util.*,java.util.HashMap,com.dz.module.user.User,com.dz.module.user.message.*"
		 pageEncoding="UTF-8"%>
<%@page import="com.dz.common.other.ObjectAccess"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String clearAllStr = request.getParameter("clearAll");
	if(clearAllStr!=null&&clearAllStr.equals("1")){
		User user = (User) session.getAttribute("user");
		ObjectAccess.execute("update MessageToUser set alreadyRead=true where uid="+user.getUid());
	}
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>个人消息</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
	<script>
        function loadToUrl(url){
            window.open(url,"详情",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function clearAllMessage(){
            var url = "message.jsp?clearAll=1";
            document.location.href = url;
        }
	</script>
</head>

<body>
<div class="adminmin-bread" style="width: 100%;">
	<ul class="bread text-main" style="font-size: larger;">
		<li>个人消息</li>
	</ul>
</div>
<div class="line">
	<div class="panel margin-small" >
		<div class="panel-head">
			<button onclick="clearAllMessage()" class="button">清除所有消息记录</button>
		</div>
		<div class="panel-body">
			<table id="wait_deal" class="table table-striped table-hover table-bordered">
				<tr>
					<th>类型</th>
					<th>相关驾驶员</th>
					<th>相关车辆</th>
					<th>发起者</th>
					<th>发起时间</th>
					<th>详情</th>
				</tr>
				<s:set name="hql" value="%{' id in (select mid from MessageToUser where uid='+#session.user.uid+' and alreadyRead=false ) order by time,type'}"></s:set>
				<%
					request.setAttribute("mtuClass",Message.class);
				%>
				<s:set name="list" value="%{@com.dz.common.other.ObjectAccess@query(#request.mtuClass,#hql)}"></s:set>
				<s:iterator id="m" value="%{#list}">
					<tr>
						<td><s:property value="%{#m.type}"/></td>
						<td><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#m.idNum).name+'('+#m.idNum+')'}"/></td>
						<td><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#m.carframeNum).licenseNum+'('+#m.carframeNum+')'}"/></td>
						<td><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#m.fromUser).uname}"/></td>
						<td><s:date name="%{#m.time}" format="yyyy/MM/dd HH:mm:ss"/></td>
						<td><a href="javascript:loadToUrl('/DZOMS/messageInfo.jsp?id=<s:property value="%{#m.id}"/>')">详情</a></td>
					</tr>
				</s:iterator>
			</table>
		</div>
	</div>
</div>
</body>
</html>