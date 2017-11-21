<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>运营部领用</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/style.css"/>
</head>
<body>
<div id="container">
    <div id="header">
        <h2>运营部领用</h2>
    </div>
    <div id="yunyingbuIssue"></div>
</div>
</body>
<script type="text/javascript">
        var pageUrls ={
            goodsInfoUrl:"/DZOMS/ky/item/listpurchase/1",  //获取页面信息
            chepaihao:"/chepaihaoA",     //车牌号后缀
            submitUrl:"/DZOMS/ky/item/lingYong"     //运营部物品发放提交路径

    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/goodsAll-bundle.js"></script>
</html>