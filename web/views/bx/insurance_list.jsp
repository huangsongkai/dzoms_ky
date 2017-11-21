<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2017/7/25
  Time: 下午1:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>保险列表</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/style.css"/>
</head>
<body>
    <div id="container">
        <div id="header">
            <h2>保险列表</h2>
        </div>
        <div id="insuranceList"></div>
    </div>
</body>
<script type="text/javascript">
    var pageUrls ={
        insuranceListInfoUrl :"/DZOMS/ky/bx/querybx",
    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/insuranceAll-bundle.js"></script>
</html>
