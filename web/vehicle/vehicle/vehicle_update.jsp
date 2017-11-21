<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>车辆修改</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
<jsp:include page="/common/msg_info.jsp"></jsp:include>
  </head>
  
  <body>
   <div>
		<form name="vehicleUpdate" action="vehicleUpdate" method="post"
			class="definewidth m20">
			<input type="hidden" name="url" value="/vehicle/vehicle/vehicle_add.jsp" />
			<table class="table table-bordered table-hover m10">
				<tr>
					<td class="tableleft">车辆识别代码/车架号</td>
					<td><s:textfield id="vehicle.carframe_num" name="vehicle.carframeNum" /></td>

					<td class="tableleft">发动机号</td>
					<td><s:textfield id="vehicle.engine_num" name="vehicle.engineNum" /></td>
				</tr>
				<tr>
					<td class="tableleft">车辆型号</td>
					<td><s:textfield id="vehicle.car_mode" name="vehicle.carMode" /></td>

					<td class="tableleft">购入日期</td>
					<td><s:textfield id="vehicle.in_date" name="vehicle.inDate" /></td>
				</tr>
				<tr>
					<td class="tableleft">合格证编号</td>
					<td><s:textfield id="vehicle.certify_num" name="vehicle.certifyNum" /></td>

					<td class="tableleft">归属部门</td>
					<td><s:textfield id="vehicle.dept" name="vehicle.dept" /></td>
				</tr>
				<tr>
					<td class="tableleft">车辆制造日期</td>
					<td><s:textfield id="vehicle.pd" name="vehicle.pd" /></td>
					<td class="tableleft">承租人身份证号</td>
					<td><s:textfield id="vehicle.driver_id" name="vehicle.driverId" /></td>
					
				</tr>
				<tr>
					<s:set name="t_driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',vehicle.driverId)}"></s:set>
					<td class="tableleft">承租人</td>
					<td><s:textfield  value="%{#t_driver.name}"  /></td>
					<td class="tableleft">车牌号</td>
					<td><s:textfield id="vehicle.license_num" name="vehicle.licenseNum" /></td>
				</tr>
				<tr>
					<td class="tableleft"></td>
					<td colspan="3" align="right">
						<input type="submit" class="btn btn-primary" value="提交">
					</td>
				</tr>
			</table>
		</form>
	</div>
  </body>
</html>
