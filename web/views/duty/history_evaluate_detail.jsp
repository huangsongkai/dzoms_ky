<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2017/6/15
  Time: 下午8:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="/DZOMS/ky/css/kpStyle.css"/>
</head>
<body>
<div class="container">
    <div id="header">
        <h2>考评详情</h2>
    </div>
    <div id="historykp"></div>
</div>
</body>
<script type="text/javascript">
    var pageUrls ={
        managerEvaluate : "/DZOMS/ky/duty/historyDetail/${id}" , //get 请求最后所有人都评完的结果
    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/kpAll-bundle.js"></script>
</html>
