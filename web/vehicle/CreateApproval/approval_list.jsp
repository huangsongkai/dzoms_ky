<%@taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.dz.common.test.DataTrackFilter"%>
<%@page import="com.dz.common.global.*"%>
<%@page import="org.springframework.context.ApplicationContext" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page language="java"
	import="java.util.*,java.util.HashMap,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%@ page import="com.dz.module.vehicle.VehicleApprovalService" %>
<%@ page import="com.dz.module.user.Role" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
//  	WaitDealController waitDealController = ctx.getBean(WaitDealController.class);
//  	request.setAttribute("waitDealMap", waitDealController.getWaitDealMap());
	VehicleApprovalService vehicleApprovalService = ctx.getBean(VehicleApprovalService.class);

	List<Role> roles = (List<Role>) session.getAttribute("roles");
	Map<String,List<ToDo>> map = new TreeMap<String,List<ToDo>>();

	for(Role role:roles){
		Map<String,List<ToDo>> tmp = vehicleApprovalService.waitToDo(role);
		for(String key:tmp.keySet()){
			if(map.containsKey(key)){
				map.get(key).addAll(tmp.get(key));
			}else{
				map.put(key, tmp.get(key));
			}
		}
	}

	request.setAttribute("waitDealMap",map);
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>车辆审批</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<jsp:include page="/common/msg_info.jsp"></jsp:include>
<script>
	$(document).ready(function(){
		$(".wait_deal a").click(function(){
			$("#body-right",window.parent.document).height([1850]);
			$('[name="body"]',window.parent.parent.document).height([1850]);
		});
	});
</script>
</head>

<body>
<jsp:include page="/common/load_to_top.jsp"></jsp:include>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>审批</li>
                <li>开业审批</li>
    </ul>
</div>
<div class="line">
	<div class="panel  margin-small" >
          	<div class="panel-head">
          		开业审批
          	</div>
          	<div class="panel-body">
          		<table id="wait_deal" class="table table-bordered table-hover table-striped wait_deal">
                		<tr>
                			<th width="20%">待办类别</th><th width="60%">消息</th><th width="20%">事项</th>
                		</tr>
                		<s:iterator var="v" value="%{#request.waitDealMap['开业审批']}">
                			<tr>
                			<td>开业审批</td>
                			<td><s:property value="%{#v.msg}"/></td>
                			<td><a href="<s:property value="%{#v.url}"/>"><s:property value="%{#v.state}"/></a></td>
                			</tr>
                		</s:iterator>
                	</table>
          	</div>
    </div>
</div>

</body>

</html>