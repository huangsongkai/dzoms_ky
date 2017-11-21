<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-4-20
  Time: 下午4:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
</head>
<body>
<table class="table table-hover table-bordered bg-white">
    <tr>
        <th>开始时间</th>
        <th>结束时间</th>
        <th>费用类型</th>
        <th>费用</th>
        <th>录入时间</th>
        <th>录入人</th>
        <th>备注</th>
    </tr>
    <s:if test="#request.bps != null">
        <s:iterator value="#request.bps" var="bp">
            <tr>
                <td><s:property value="#bp.startTime"/></td>
                <td>
                    <s:if test="%{#bp.isToEnd()!=true}">
                        <s:property value="#bp.endTime"/>
                    </s:if>
                    <s:else>
                        <s:property value="#request.contract.contractEndDate"/>
                    </s:else>
                </td>
                <td><s:property value="#bp.feeType"/></td>
                <td><s:property value="#bp.fee"/></td>
                <td><s:property value="#bp.inTime"/></td>
                <td><s:property value="#bp.register"/></td>
                <td><s:property value="#bp.comment"/></td>
            </tr>
        </s:iterator>
    </s:if>
    <s:else>
        null
    </s:else>
</table>
</body>
</html>
