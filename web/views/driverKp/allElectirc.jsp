<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/22
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    pageContext.setAttribute("path",request.getContextPath());
%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
    <title>Title</title>
    <link href="https://cdn.bootcss.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>

</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1 align="center">违章项目管理</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 col-md-offset-8" >
            <a class="btn btn-primary" href="add">新增项目</a>
        </div>
    </div>



    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-striped">
                <tr>
                    <th>类型</th>
                    <th>分值</th>

                </tr>
                <c:forEach var="electrics"  items="${electrics}">
                    <tr>
                        <td>
                                ${electrics.act}
                        </td>
                        <td>
                                ${electrics.grade}
                        </td>
                        <td>
                            <a type="button"  href="toUpdateElectric?id=${electrics.id}">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑</a>
                            <a type="button" href="delElectric?id=${electrics.id}">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true" ></span>
                                删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>

</body>
</html>