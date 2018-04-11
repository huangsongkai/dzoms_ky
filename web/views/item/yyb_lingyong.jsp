<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>运营部（驾驶员）物品领用</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/style.css"/>
</head>
<body>
<div id="container">
    <div id="header">
        <h2>运营部（驾驶员）物品领用</h2>
    </div>
    <div id="yunyingbuIssue"></div>
</div>
</body>
<script type="text/javascript">
        var pageUrls ={
            goodsList:"/DZOMS/ky/item/goodsList",  //获取页面信息
            chepaihao:"/DZOMS/ky/item/chepaihaoA",     //车牌号后缀
            submitUrl:"/DZOMS/ky/item/submit",     //运营部物品发放提交路径
            driversAndHistory:"/DZOMS/ky/item/driversAndHistory"
        }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/goodsAll-bundle.js"></script>
</html>