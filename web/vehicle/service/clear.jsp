<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.common.other.*,com.dz.module.charge.ClearTime" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>营运数据清理</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<jsp:include page="/common/msg_info.jsp"></jsp:include>

</head>
<body>
<div>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>运营数据清理</li>
        </ul>
</div>
<form action="/DZOMS/vehicle/serviceClear" method="post" id="ipform">
<input type="hidden" name="url" value="/vehicle/service/search_daily.jsp" />
<div class="line">
	<div class="xm6" id="left-area">
		 <div class="panel  margin-small" style="height: 930px;">
		 	<%
		 	Date beginDate = ((ClearTime)ObjectAccess.getObject("com.dz.module.charge.ClearTime",5)).getCurrent();
		 	
		 	Calendar beginDateCalendar = Calendar.getInstance();
		 	beginDateCalendar.setTime(beginDate);
		 	beginDateCalendar.add(Calendar.DATE, 1);
		 	
		 	request.setAttribute("beginDate", beginDateCalendar.getTime());
		 	%>
		 	<s:property value="#request.beginDate"/><br/>
       		<a class="button bg-green addbtn1">结算运营数据</a>
       </div>
   </div>
</div>
<input type="submit" id="submitbutton1" style="display: none;" />
</form>

<script>
	button_bind(".addbtn1","确定提交?","$('#submitbutton1').click();");
</script>
</body>
</html>
