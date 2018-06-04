<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
<script>
$(document).ready(function(){
	window.print();
//	setTimeout("window.close();",10000);
});
</script>
		<style>
			.A4Size {
				width: 167mm;
				/*width: 756px;*/
				/*height: 1150mm;*/
				/*width: 210mm;*/
				/*height: 297mm;*/
				height:147mm;
				border: solid hidden;
				font-size:0.9em;
			}

			@media print {
				.no-print span:not(.no-screen):not(.data-col) {
					display: none;
				}

				.no-print * {
					border-color: transparent;
				}
				input,span.no-print {
					display: none;
				}
				.btn-col {
					display: none;
				}

				.A4Size{
					border: hidden 1px;
					padding-bottom: 1.1mm;
					padding-left: 23mm;
					padding-right: 7mm;
				}

				table {
					border-right: 1px hidden;
					border-bottom: 1px hidden;
				}

				table td {
					border-left: 1px hidden;
					border-top: 1px hidden;
					text-align: center;
					/*height: 2.5em;*/
				}

				body{
					margin-top: 0;
				}
			}

			@media screen {
				.no-screen {
					display: none;
				}
				.be-print {
					background-color: greenyellow;
				}

				table {
					border-right: 1px solid;
					border-bottom: 1px solid;
				}

				table td {
					border-left: 1px solid;
					border-top: 1px solid;
					text-align: center;
				}
			}
		</style>
	</head>
	<body>
		<%! int year = new java.util.Date().getYear()+1900;%>
		<%! int month = new java.util.Date().getMonth()+1;%>
		<%! int day = new java.util.Date().getDate();%>
		<s:iterator value="%{#request.list}" var="v">
		<div class="A4Size">
			<table border="0">
			<tr style="height:8mm">
				<td>&nbsp;</td>
				<td><strong><%=year%></strong></td>
				<td colspan="2"><strong>大众</strong></td>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr style="height:5mm">
				<td><span class="no-print">审验日期：</span></td>
				<td colspan="2" style="font-size: 0.8em;text-align:left;"><strong><%=year%>年<%=month<10?"0":""%><%=month%>月<%=day%>日</strong></td>
				<td colspan="5"><strong>&nbsp;</strong></td>
			</tr>
			<tr style="height:8mm">
				<s:set name="p_carMode" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.VehicleMode',#v.carMode)}"></s:set>
				<td width="18%"><span class="no-print">车辆管理（委托）单位</span></td>
				<td width="15%"><strong>大众<s:property value="%{@org.apache.commons.lang3.StringUtils@left(#v.dept,1)}"/>公司</strong></td>
				<td width="15%"><span class="no-print">车牌号</span></td>
				<td width="12%"><strong>&nbsp;<s:property value="%{#v.licenseNum}"/></strong></td>
				<td width="9%"><span class="no-print">燃油种类</span></td>
				<td width="12%"><strong><nobr><s:property value="%{#p_carMode.fuel}"/></nobr></strong></td>
				<td width="7%"><span class="no-print">车型</span></td>
				<td width="12%"><strong>捷达</strong></td>
			</tr>
			<tr style="height:8mm">
				<td ><span class="no-print">发动机号</span></td>
				<td><strong><s:property value="%{#v.engineNum}"/></strong></td>
				<td ><span class="no-print">车架号</span></td>
				<td colspan="2"><strong>&nbsp;<s:property value="%{#v.carframeNum}"/></strong></td>
				<td><span class="no-print">营运证牌号</span></td>
				<td colspan="2"><strong><s:property value="%{#v.operateCard}"/></strong></td>
			</tr>
		</table>
		</div>
		</s:iterator>
	</body>
</html>
