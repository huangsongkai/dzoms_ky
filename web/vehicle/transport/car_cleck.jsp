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
		<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
		<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
<script>
$(document).ready(function(){
	window.print();
	setTimeout("window.close();",10000);
});
</script>
	</head>
	<body>
		<%! java.util.Calendar calender = java.util.Calendar.getInstance();%>
		<% calender.setTime(new Date());
		   calender.add(Calendar.DATE, 1);
		 %>
		<%! int year = calender.get(Calendar.YEAR);%>
		<%! int month = calender.get(Calendar.MONTH)+1;%>
		<%! int day = calender.get(Calendar.DATE);%>
		<s:iterator value="%{#request.list}" var="v" status="L">
			<s:if test="%{#L.index%2==0}">
			<%{%>
			<div cssStyle="width:756px;height:1123px;">
			<table  border="0">
			<%}%>
			</s:if>
			
			  <tr>
			    <td width="300px" rowspan="3"><p class="left">大众</p>
			    <p class="left"><s:property value="%{#v.licenseNum}"/></p></td>
			    <td style="text-align: left;"><p><s:property value="%{#v.licenseNum}"/></p></td>
			  </tr>
			  <tr>
			    <td style="text-align: left;"><p>时间：<%=month<10?"0":""%><%=month%>月<%=day%>号；&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7：30</p></td>
			  </tr>
			  <tr>
			    <td style="text-align: left;">
			    <p>地点：中顺二手车市场；先锋路</p>
			    <p>价格贴、顶灯、门标、钣金、保险杠</p>
			    <p>车灯、后备箱、灭火灯、运营手续；</p>
			    <p>电子营运证、GPS完好有效，可刷卡。</p>
			    <p>车辆必须达到营运标准；</p>
			    <p>改装双燃料车将燃气罐拆除。原装双</p>
			    <p>燃料车需带特种设备使用证</p></td>
			  </tr>
			  <tr style="height: 200px;">
			  	<td></td>
			  	<td></td>
			  </tr>
			  
		<s:if test="%{#L.index%2==1}">
		<%{%>
			</table>
		</div>
		<%}%>
		</s:if>
	</s:iterator>
	</body>
</html>
