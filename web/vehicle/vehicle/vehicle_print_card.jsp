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
    <title></title>
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
            text-align: center;
        }

        .text-bigger {
            font-size: larger;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="A4Size">
    <h1 style="text-align: center;">
        <span style=" border-bottom:3pt double black;">驾驶员档案卡</span>
    </h1>
    <table width="100%">
        <tr>
            <td width="18%">承包人照片</td>
            <td width="18%">副驾驶照片</td>
            <td width="18%">临时驾驶员照片</td>
            <td  rowspan="3"   style="text-align:center;">
                副驾驶照片
            </td>
        </tr>
        <tr>
            <td >&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br><br><br></td>
            <td >&nbsp;</td>
            <td >&nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">车辆照片</td>
        </tr>
        <tr>
            <td  colspan="3"  style="text-align:center;">
                <br><br><br><br><br>
                承包人照片
                <br><br><br><br><br>&nbsp;
            </td>
            <td  style="text-align:center;">临时驾驶员照片</td>
        </tr>
    </table>
</div>
</body>
</html>
