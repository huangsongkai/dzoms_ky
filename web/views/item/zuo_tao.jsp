<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>座套发放管理</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/style.css"/>
</head>
<body>
<div id="seatcontainer">
    <div id="header">
        <h2>座套发放管理</h2>
    </div>
    <div id="seatingIssue"></div>
</div>
</body>
<script type="text/javascript">
    var pageUrls ={
        employeeInfoUrl : "/employeeJobNumber", //get 员工的id和name
        chepaihao:"/chepaihaoA",  //get 车牌号
        submitUrl:"/DZOMS/ky/item/zuotao"     //post 提交
    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/insuranceAll-bundle.js"></script>
</html>