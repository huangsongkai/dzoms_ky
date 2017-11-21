<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.*" pageEncoding="UTF-8"%>
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
	<title>营运数据导入</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/fileUpload.js" ></script>
<jsp:include page="/common/msg_info.jsp"></jsp:include>

<script>
function doSubmit(){
	$("#ipform").submit();
}
	
</script>
</head>
<body>
<div>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>运营数据导入</li>
        </ul>
</div>
<form action="/DZOMS/vehicle/serviceImport" method="post" id="ipform">
	<input type="hidden" name="url" value="/vehicle/service/search.jsp" />
<div class="line">
	<div class="xm6" id="left-area">
		 <div class="panel  margin-small" style="height: 930px;">
          <input class="dz-file" name="input" data-toggle="click" data-target=".addbtn1" sessuss-function="doSubmit();"/>
       		<a class="button input-file bg-green addbtn1">上传</a>
       </div>
   </div>
</div>
</form>
</body>
</html>
