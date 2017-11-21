<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2017/6/9
  Time: 下午3:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>流程列表</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/style.css"/>
</head>
<body>
<div class="container">
    <div id="header">
        <h2>流程列表</h2>
    </div>
    <div id="processesList"></div>
</div>
</body>
<script type="text/javascript">
    var pageUrls ={
        processesListUrl : "/DZOMS/ky/repository/process-definitions" , //get 流程列表
        executeStartForm:"/DZOMS/ky/activity/process/startForm/"   //跳转到startForm页
    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/processAll-bundle.js"></script>
</html>
