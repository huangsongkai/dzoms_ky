<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2017/6/7
  Time: 下午5:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>工作项管理</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/kpStyle.css"/>
</head>
<body>
<div class="container">
    <div id="header">
        <h2>工作职责表</h2>
    </div>
    <div id="proManagement"></div>
</div>
</body>
<script type="text/javascript">
    var pageUrls ={
        url : "/DZOMS/ky/duty",  //增删改
        userUrl : "/DZOMS/ky/duty/user",  //get请求职员信息表
        regectUrl:"/DZOMS/ky/duty/managerRegect",
    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/kpAll-bundle.js"></script>
</html>
