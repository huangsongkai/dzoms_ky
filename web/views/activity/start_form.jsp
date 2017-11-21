<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2017/6/9
  Time: 上午11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>启动项目</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/style.css"/>
</head>
<body>
    <div class="container">
        <div id="header">
            <h2>流程列表</h2>
        </div>
    <div id="startForm"></div>
</div>
</body>
<script type="text/javascript">
    var pageUrls ={
        startFormUrl : "/DZOMS/ky/activity/process/getStartFormProperties/" , //get
        startFormSubmitUrl:"/DZOMS/ky/activity/process/startForm/" //post
    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/processAll-bundle.js"></script>
</html>
