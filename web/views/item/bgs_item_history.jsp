<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>办公室物品发放记录</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/style.css"/>
</head>
<body>
<div id="container">
    <div id="header">
        <h2>办公室物品发放记录</h2>
    </div>
    <div id="officeHistory"></div>
</div>
</body>
<script type="text/javascript">
    var pageUrls ={
        goodsIssueHisInfoUrl : "/DZOMS/ky/item/officeHistory",
        downloadUrl:"/download",
        agreeUrl : "/DZOMS/ky/item/agree",
        denyUrl : "/DZOMS/ky/item/deny",
    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/goodsAll-bundle.js"></script>
</html>