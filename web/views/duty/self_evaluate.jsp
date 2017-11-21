<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2017/6/15
  Time: 下午7:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人绩效考评</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/kpStyle.css"/>
</head>
<body>
<div class="container">
        <div id="personalPerformance" style="height: 20000px;"></div>
    </div>
</body>
<script type="text/javascript">
    var pageUrls ={
        selfEvaluateUrl : "/DZOMS/ky/duty/selfEvaluate/"+"${taskId}", //get 个人绩效请求数据
        jumpUrl:"/DZOMS/ky/activity/task/list"
    }
</script>
    <script src="/DZOMS/ky/js/commonV3.js"></script>
    <script src="/DZOMS/ky/js/kpAll-bundle.js"></script>
</html>
