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
	<title>添加营运数据</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<jsp:include page="/common/msg_info.jsp"></jsp:include>

<link rel="stylesheet" href="/DZOMS/res/jquery-ui/jquery-ui.min.css" />
<script type="text/javascript" src="/DZOMS/res/jquery-ui/jquery-ui.js" ></script>

<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
$(document).ready(function(){
	if ($('[name="serviceDetail.carframeNum"]').val().length>0) {
		$.post("/DZOMS/common/doit",{"condition":"select licenseNum from Vehicle where carframeNum='"+$('[name="serviceDetail.carframeNum"]').val()+"'"},function(data){
			$("#licenseNum").val(data["affect"]);
		});
	}
	
	$("#licenseNum").bigAutocomplete({
		url:"/DZOMS/select/vehicleByLicenseNum",
		condition:" state=1 ",
		callback:function(){
			$.post("/DZOMS/common/doit",{"condition":"select carframeNum from Vehicle where state=1 and licenseNum='"+$("#licenseNum").val()+"'"},function(data){
				$('[name="serviceDetail.carframeNum"]').val(data["affect"]);
			});
		}
	});
});
</script>
</head>
<body>
<div>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
                <li>车辆管理</li>
                <li>添加营运数据</li>
        </ul>
</div>
<form action="/DZOMS/vehicle/serviceSave" method="post" id="ipform">
<input type="hidden" name="url" value="/vehicle/service/search.jsp" />
<div class="line">
	<div class="xm6" id="left-area">
		 <div class="panel  margin-small" style="height: 930px;">
<div class="form-group">
	<div class="label"><label>部门</label></div>
	<div class="field">
		<s:textfield name="serviceDetail.dept" list="{'一部','二部','三部'}"></s:textfield>
	</div>
</div>
<div class="form-group">
	<div class="label"><label>起始时间</label></div>
	<div class="field">
		<s:textfield name="serviceDetail.serviceBegin" ></s:textfield>
	</div>
</div>
<div class="form-group">
	<div class="label"><label>结束时间</label></div>
	<div class="field">
		<s:textfield name="serviceDetail.serviceEnd" ></s:textfield>
	</div>
</div>
<div class="form-group">
	<div class="label"><label>车牌号</label></div>
	<div class="field">
		<s:textfield id="licenseNum" ></s:textfield>
		<s:hidden name="serviceDetail.carframeNum"></s:hidden>
	</div>
</div>
<div class="form-group"><div class="label"><label>营运金额</label></div><div class="field"><s:textfield name="serviceDetail.money" ></s:textfield></div></div>
<div class="form-group"><div class="label"><label>行驶里程</label></div><div class="field"><s:textfield name="serviceDetail.allDistance" ></s:textfield></div></div>
<div class="form-group"><div class="label"><label>营运次数</label></div><div class="field"><s:textfield name="serviceDetail.times" ></s:textfield></div></div>
<div class="form-group"><div class="label"><label>空驶里程</label></div><div class="field"><s:textfield name="serviceDetail.uselessDistance" ></s:textfield></div></div>
<div class="form-group"><div class="label"><label>营运里程</label></div><div class="field"><s:textfield name="serviceDetail.effectiveDistance" ></s:textfield></div></div>
<div class="form-group"><a class="button bg-green addbtn1">添加</a></div>
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
