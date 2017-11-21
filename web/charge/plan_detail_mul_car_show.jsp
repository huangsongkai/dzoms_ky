<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-5-22
  Time: 下午12:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
</head>
<body>
	<div class="panel bg-white">
		<div class="panel-head">
			查询结果
		</div>
		<div class="panel-body">
			<table class="table table-bordered table-striped">
        <tr>
            <td>车牌号</td>
            <td>司机</td>
            <td>部门</td>
            <td>时间</td>
            <td>合同费用</td>
            <td>保险变更</td>
            <td>其他变更</td>
            <td>计划总额</td>
        </tr>
        <s:iterator value="%{#request.table}" var="xx">
        <tr>
            <td><s:property value="%{#xx.carNumber}"/></td>
            <td><s:property value="%{#xx.driverName}"/></td>
            <td><s:property value="%{#xx.dept}"/></td>
            <td><s:property value="%{#xx.time}"/> </td>
            <td><s:property value="%{#xx.heton}"/></td>
            <td><s:property value="%{#xx.baoxian}"/></td>
            <td><s:property value="%{#xx.other}"/></td>
            <td><s:property value="%{#xx.total}"/></td>
        </tr>
        </s:iterator>
    </table>
  
  
		</div>
	</div>
    
</body>
</html>
