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
	<title>车辆型号</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
	$(document).ready(function(){
		$("input").attr("readonly","readonly");
	});
	
</script>
  </head>
  
  <body class="bg-white">
		<form action="/DZOMS/vehicle/vehicleModeAdd" name="vehicleModeAdd" method="post"
			class="definewidth m20">
			<table class="table table-bordered table-hover m10">
				<tr>
					<td class="tableleft">车辆型号</td>
					
					<td>
						<s:textfield id="vehicleMode.carMode" name="vehicleMode.carMode" /></td>

					<td class="tableleft">发证日期</td>
					<td><s:textfield id="vehicleMode.licenseDate"  name="vehicleMode.licenseDate" /></td>
				</tr>
				<tr>
					<td class="tableleft">车辆制造企业名称</td>
					<td><s:textfield id="vehicleMode.company" name="vehicleMode.company" /></td>

					<td class="tableleft">车身颜色</td>
					<td><s:textfield id="vehicleMode.color" name="vehicleMode.color" /></td>
				</tr>
				<tr>
					<td class="tableleft">车辆品牌/车辆名称</td>
					<td><s:textfield id="vehicleMode.brand" name="vehicleMode.brand" /></td>

					<td class="tableleft">燃料种类</td>
					<td><s:textfield id="vehicleMode.fuel" name="vehicleMode.fuel" /></td>
				</tr>
				<tr>
					<td class="tableleft">排放标准</td>
					<td><s:textfield id="vehicleMode.emission" name="vehicleMode.emission" /></td>

					<td class="tableleft">轮胎规格</td>
					<td><s:textfield id="vehicleMode.tire" name="vehicleMode.tire" /></td>
					
					<td class="tableleft">排量和功率</td>
					<td><s:textfield id="vehicleMode,displacement" name="vehicleMode.displacement" />/<s:textfield id="vehicleMode.power" name="vehicleMode.power" /></td>
				</tr>
				<tr>
					<td class="tableleft">转向形式</td>
					<td><s:textfield id="vehicleMode.corneringAbility" name="vehicleMode.corneringAbility" /></td>

					<td class="tableleft">轮胎数（个）</td>
					<td><s:textfield id="vehicleMode.tireNum" name="vehicleMode.tireNum" /></td>
					
					<td class="tableleft">轮距（前/后）（mm）</td>
					<td><s:textfield id="vehicleMode.treadFront" name="vehicleMode.treadFront" />/<s:textfield id="vehicleMode.treadBack" name="vehicleMode.treadBack" /></td>
				</tr>
				<tr>
					<td class="tableleft">最高车速（km/h）</td>
					<td><s:textfield id="vehicleMode.fastest" name="vehicleMode.fastest" /></td>

					<td class="tableleft">总质量（kg）</td>
					<td><s:textfield id="vehicleMode.wholeWeight" name="vehicleMode.wholeWeight" /></td>
					
					<td class="tableleft">外廓尺寸（mm）</td>
					<td><s:textfield id="vehicleMode.sizeLong" name="vehicleMode.sizeLong" />/<s:textfield id="vehicleMode.sizeWide" name="vehicleMode.sizeWide" />/<s:textfield id="vehicleMode.sizeHigh" name="vehicleMode.sizeHigh" /></td>
				</tr>
				<tr>
					<td class="tableleft">额定载客（人）</td>
					<td><s:textfield id="vehicleMode.personNum" name="vehicleMode.personNum" /></td>

					<td class="tableleft">额定载质量（kg）</td>
					<td><s:textfield id="vehicleMode.norWeight" name="vehicleMode.norWeight" /></td>
					
					<td class="tableleft">轴距（mm）</td>
					<td><s:textfield id="vehicleMode.wheelBase" name="vehicleMode.wheelBase" /></td>
				</tr>
				<tr>
					<td class="tableleft">发动机型号</td>
					<td><s:textfield id="vehicleMode.engineMode" name="vehicleMode.engineMode" /></td>

					<td class="tableleft">整备质量（kg）</td>
					<td><s:textfield id="vehicleMode.allWeight" name="vehicleMode.allWeight" /></td>
					
					<td class="tableleft">轴数</td>
					<td><s:textfield id="vehicleMode.baseNum" name="vehicleMode.baseNum" /></td>
				</tr>
				<tr>
					<td class="tableleft">使用性质</td>
					<td><s:textfield id="vehicleMode.useway" name="vehicleMode.useway" /></td>

					<td class="tableleft">年平均行驶里程</td>
					<td><s:textfield id="vehicleMode.averageYearDistance" name="vehicleMode.distance" /></td>
				</tr>
				<tr>
					<td class="tableleft">行政区域</td>
					<td colspan="2"><s:textfield id="vehicleMode.distinct" name="vehicleMode.area" /></td>
				</tr>
				<tr>
					<td class="tableleft">发票金额</td>
					<td colspan="2"><s:textfield id="vehicleMode.invoiceAmount" name="vehicleMode.money" /></td>
					
					<td class="tableleft">购置税</td>
					<td colspan="2"><s:textfield id="vehicleMode.taxAmount" name="vehicleMode.tax" /></td>
				</tr>
				
			</table>
		</form>
	
	
		<script src="/DZOMS/res/js/DateTimeHelper.js"></script>
  </body>
</html>
