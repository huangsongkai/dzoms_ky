<%--
  Created by IntelliJ IDEA.
  User: Wang
  Date: 2017/12/20
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        table {
            border-right: 1px solid;
            border-bottom: 1px solid;
        }

        table td {
            border-left: 1px solid;
            border-top: 1px solid;
            text-align: center;
        }

        .A4Size {
            width: 175mm;
            height: 262mm;
            border: solid hidden;
            text-align: center;
        }

        .text-bigger {
            font: "arial black";
            font-size: larger;
            font-weight: bold;
        }
    </style>
    <title>车辆管理档案卡</title>
</head>
<body>
<%
    Vehicle v = ObjectAccess.getObject(Vehicle.class,request.getParameter("id"));
    request.setAttribute("v", v);
%>
<div class="A4Size">
    <h1>车辆管理档案卡</h1>
    <table width="100%">
        <tbody>
        <tr>
            <td>部门</td>
            <td>${v.dept}</td>
            <td>车牌号</td>
            <td>${v.licenseNum}</td>
            <td>车辆注册日期</td>
            <td><s:date name="#request.v.licenseNumRegDate" format="yyyy-MM-dd"></s:date></td>
        </tr>
        <tr>
            <td>车架号</td>
            <td>${v.carframeNum}</td>
            <td>发动机号</td>
            <td>${v.engineNum}</td>
            <td>营运证初次发日期</td>
            <td><s:date name="#request.v.operateCardTime" format="yyyy-MM-dd"></s:date></td>
        </tr>
        <tr>
            <td colspan="3">客运审验</td>
            <td colspan="3">二级维护检测</td>
        </tr>
        <tr>
            <td>审验时间</td>
            <td>审验结果</td>
            <td>经办人</td>
            <td>检测时间</td>
            <td>下次检测时间</td>
            <td>经办人</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="3">计价器检定</td>
            <td colspan="3">气瓶检测</td>
        </tr>
        <tr>
            <td>检定时间</td>
            <td>检定结果</td>
            <td>经办人</td>
            <td>检测时间</td>
            <td>下次检测时间</td>
            <td>经办人</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="3">安全技术检验</td>
            <td colspan="3">GPS安装情况</td>
        </tr>
        <tr>
            <td>检验时间</td>
            <td>检验结果</td>
            <td>经办人</td>
            <td>安装时间</td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td rowspan="11"  colspan="3"  style="text-align:initial;">
                维修记录：
                <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
                <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
                <br>&nbsp;<br>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</div>
</body>
</html>