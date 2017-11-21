<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2017/6/9
  Time: 上午10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>职责分配</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/kpStyle.css"/>
</head>
<body>
<div class="container">
    <div id="header">
        <h2>职责分配</h2>
    </div>
    <div id="assignResponsibility"></div>
</div>
</body>
<script type="text/javascript">
    var pageUrls ={
        url:"/DZOMS/ky/duty",  //get请求职责列表
        userJobUrl:"/DZOMS/ky/duty/userJob",   //post 保存分配信息
        userUrl : "/DZOMS/ky/duty/user",  //get请求职员信息表
    }

</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/kpAll-bundle.js"></script>
</html>
