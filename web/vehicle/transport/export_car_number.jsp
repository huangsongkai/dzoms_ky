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
		<style>
			.A4Size {
				width: 175mm;
				/*width: 756px;*/
				/*height: 1150mm;*/
				/*width: 210mm;*/
				/*height: 297mm;*/
				height:147mm;
				border: solid hidden;
				font-size:1.1em;
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
					border: hidden;
					padding-bottom: 1.5mm;
					padding-left: 24mm;
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
		<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
			<script>
$(document).ready(function(){
	window.print();
	setTimeout("window.close();",10000);
});
		</script>
	</head>
	
	<body>
	<%
	List list = (List)request.getAttribute("list");
	for(int i=0;i<list.size();i++){
		request.setAttribute("v", list.get(i));
	%>
	<%--<%if(i%2==0){ %>--%>
	<div class="A4Size">
		<table border="0">
	<%--<%} %>--%>
			<tr style="height: 36mm">
				<td colspan="5" align="center"><span class="no-print">车架号拓印纸粘贴处、压盖车辆管理（委托）单位印章</span></td>
			</tr>
			<tr style="height:5mm">
				<td width="9%"><span class="no-print">车辆管理（委托）单位</span></td>
				<td width="24%"><strong>大众<s:property value="%{@org.apache.commons.lang3.StringUtils@left(#request.v.dept,1)}"/>公司</strong></td>
				<td width="15%"><span class="no-print">车牌号</span></td>
				<td width="18%"><strong><s:property value="%{#request.v.licenseNum}"/></strong></td>
				<td rowspan="3" align="center"><span class="no-print">检车现场打印票据粘贴处</span></td>
			</tr>
			<tr style="height: 5mm">
				<td ><span class="no-print">营运证牌号</span></td>
				<td><strong><s:property value="%{#request.v.operateCard}"/></strong></td>
				<td colspan="2"><strong><s:property value="%{#request.v.carframeNum}"/></strong></td>
			</tr>
			<tr style="height: 88mm;">
				<td colspan="4">&nbsp;</td>
			</tr>
	<%--<%if(i%2==1){ %>--%>
		</table>
	</div>
	<%--<%} %>--%>
	 
	<%} %>
	</body>
</html>
