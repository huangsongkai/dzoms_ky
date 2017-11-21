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
    <title>个人历史绩效</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/kpStyle.css"/>
</head>
<body>
<div class="container">
    <div id="header">
        <h2>历史绩效</h2>
    </div>
    <div id="kpHistoryInfor"></div>
</div>
</body>
<script type="text/javascript">
    var pageUrls ={
        selfEvaluateUrl : "/DZOMS/ky/duty/history" , //get 请求最后所有人都评完的结果
        everyMonthHistorykp:"/DZOMS/ky/duty/jumpHistory",   //查看详细考评信息jump
    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/kpAll-bundle.js"></script>
</html>
