<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>运营部物品采购</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/style.css"/>
</head>
<body>
<div id="container">
    <div id="header">
        <h2>运营部物品采购</h2>
    </div>
    <div id="yunyingbuPurchase"></div>
</div>
</body>
<script type="text/javascript">
    var pageUrls ={
        goodsInfoUrl : "/DZOMS/ky/item/listpurchase/1",
        jumpUrl:"/DZOMS/ky/item/yybstartprocess",
        updateStorageUrl:"/DZOMS/ky/item/yybupateStorage"
    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/goodsAll-bundle.js"></script>
</html>